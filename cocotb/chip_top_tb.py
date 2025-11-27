# SPDX-FileCopyrightText: © 2025 Project Template Contributors
# SPDX-License-Identifier: Apache-2.0

import os
import random
import logging
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, Edge, RisingEdge, FallingEdge, ClockCycles
from cocotb_tools.runner import get_runner

proj_path = Path(__file__).resolve().parent
sim = os.getenv("SIM", "icarus")
pdk_root = os.getenv("PDK_ROOT", Path("~/.ciel").expanduser())
pdk = os.getenv("PDK", "gf180mcuD")
scl = os.getenv("SCL", "gf180mcu_fd_sc_mcu7t5v0")
gl = os.getenv("GL", False)
slot = os.getenv("SLOT", "1x1")
hdl_toplevel = "chip_top"
tb_toplevel = "chip_top_tb"

hello_world = {
    'flash1_slot0': proj_path / "../ip/fabric/user_designs/all_ones/all_ones.hex",
    'flash1_slot1': proj_path / "../ip/fabric/user_designs/all_zeros/all_zeros.hex",
}

enabled = hello_world

async def set_defaults(dut):
    dut.input_PAD.value = 0

async def enable_power(dut):
    dut.VDD.value = 1
    dut.VSS.value = 0

async def start_clock(clock, freq=50):
    """Start the clock @ freq MHz"""
    c = Clock(clock, 1 / freq * 1000, "ns")
    cocotb.start_soon(c.start())


async def reset(reset, active_low=True, time_ns=1000):
    """Reset dut"""
    cocotb.log.info("Reset asserted...")

    reset.value = not active_low
    await Timer(time_ns, "ns")
    reset.value = active_low

    cocotb.log.info("Reset deasserted.")


async def start_up(dut):
    """Startup sequence"""
    await set_defaults(dut)
    if gl:
        await enable_power(dut)
    await start_clock(dut.clk_PAD)
    await reset(dut.rst_n_PAD)


@cocotb.test()
async def test_counter(dut):
    """Run the counter test"""

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Setting defaults...")

    # FPGA config mode
    # if mode == 0: SPI controller
    # if mode == 1: SPI receiver
    dut.fpga_mode_i.value = 0

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut)

    logger.info("Running the test...")

    # Wait for a number of clock cycles
    await ClockCycles(dut.clk_PAD, 10000)
    
    # Wait for done
    await FallingEdge(dut.config_busy_o)

    assert (dut.fpga_io.value == (1<<48)-1)

    logger.info("Done!")


def chip_top_runner():

    sources = []
    defines = {f"SLOT_{slot.upper()}": True, "BITSTREAM_FLASH": True}
    includes = [proj_path / "../src/"]

    sources.append(proj_path / "chip_top_tb.v")
    sources.append(proj_path / "spiflash_powered.v")

    if gl:
        # SCL models
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v")
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / "primitives.v")

        # We use the powered netlist
        sources.append(proj_path / f"../final/pnl/{hdl_toplevel}.pnl.v")

        defines.update({"FUNCTIONAL": True, "USE_POWER_PINS": True})
    else:
        sources.append(proj_path / "../src/chip_top.sv")
        sources.append(proj_path / "../src/chip_core.sv")
        
        sources.append(proj_path / "../ip/fabric/rtl/fabric_wrapper.sv")
        
        sources.append(proj_path / "../ip/fabric_config/fabric_config.sv")
        sources.append(proj_path / "../ip/fabric_config/fabric_spi_controller.sv")
        sources.append(proj_path / "../ip/fabric_config/fabric_spi_receiver.sv")

    sources += [
        # IO pad models
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_io/verilog/gf180mcu_fd_io.v",
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_io/verilog/gf180mcu_ws_io.v",
        
        # SRAM macros
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram512x8m8wm1.v",
        
        # Custom IP
        proj_path / "../ip/gf180mcu_ws_ip__id/vh/gf180mcu_ws_ip__id.v",
        proj_path / "../ip/gf180mcu_ws_ip__logo/vh/gf180mcu_ws_ip__logo.v",
        proj_path / "../ip/gf180mcu_ws_ip__credits/vh/gf180mcu_ws_ip__credits.v",
        proj_path / "../ip/gf180mcu_ws_ip__logo_fabulous/vh/gf180mcu_ws_ip__logo_fabulous.v",
    ]

    # Add FPGA fabric
    sources.append(proj_path / f'../ip/fabric/macro/{pdk}/fabulous/eFPGA.v')

    # Paths
    TILES_ROOT = proj_path / '../ip/tile_library/tiles'
    PRIMITIVES_ROOT = proj_path / '../ip/tile_library/primitives/'
    
    # Primitives
    sources.append(f'{PRIMITIVES_ROOT}/GF_SRAM_512x8/GF_SRAM_512x8.v')
    sources.append(f'{PRIMITIVES_ROOT}/IO_1_bidirectional_frame_config_pass/IO_1_bidirectional_frame_config_pass.v')
    sources.append(f'{PRIMITIVES_ROOT}/LUT4c_frame_config_dffesr/LUT4c_frame_config_dffesr.v')
    sources.append(f'{PRIMITIVES_ROOT}/MULADD/MULADD.v')
    sources.append(f'{PRIMITIVES_ROOT}/MUX8LUT_frame_config_mux/MUX8LUT_frame_config_mux.v')
    sources.append(f'{PRIMITIVES_ROOT}/RegFile_32x4/RegFile_32x4.v')
    sources.append(f'{PRIMITIVES_ROOT}/WARMBOOT/WARMBOOT.v')
    sources.append(f'{PRIMITIVES_ROOT}/Config_access/Config_access.v')
    
    # DSP
    sources.append(f'{TILES_ROOT}/DSP/DSP.v')
    sources.append(f'{TILES_ROOT}/DSP/DSP_bot/DSP_bot.v')
    sources.append(f'{TILES_ROOT}/DSP/DSP_bot/DSP_bot_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/DSP/DSP_bot/DSP_bot_switch_matrix.v')
    sources.append(f'{TILES_ROOT}/DSP/DSP_top/DSP_top.v')
    sources.append(f'{TILES_ROOT}/DSP/DSP_top/DSP_top_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/DSP/DSP_top/DSP_top_switch_matrix.v')
    
    # LUT4AB
    sources.append(f'{TILES_ROOT}/LUT4AB/LUT4AB.v')
    sources.append(f'{TILES_ROOT}/LUT4AB/LUT4AB_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/LUT4AB/LUT4AB_switch_matrix.v')
    
    # N_term_DSP
    sources.append(f'{TILES_ROOT}/N_term_DSP/N_term_DSP.v')
    sources.append(f'{TILES_ROOT}/N_term_DSP/N_term_DSP_switch_matrix.v')
    
    # N_term_single
    sources.append(f'{TILES_ROOT}/N_term_single/N_term_single.v')
    sources.append(f'{TILES_ROOT}/N_term_single/N_term_single_switch_matrix.v')
    
    # N_term_single2
    sources.append(f'{TILES_ROOT}/N_term_single2/N_term_single2.v')
    sources.append(f'{TILES_ROOT}/N_term_single2/N_term_single2_switch_matrix.v')

    # RegFile
    sources.append(f'{TILES_ROOT}/RegFile/RegFile.v')
    sources.append(f'{TILES_ROOT}/RegFile/RegFile_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/RegFile/RegFile_switch_matrix.v')
    
    # S_term_DSP
    sources.append(f'{TILES_ROOT}/S_term_DSP/S_term_DSP.v')
    sources.append(f'{TILES_ROOT}/S_term_DSP/S_term_DSP_switch_matrix.v')
    
    # S_term_single
    sources.append(f'{TILES_ROOT}/S_term_single/S_term_single.v')
    sources.append(f'{TILES_ROOT}/S_term_single/S_term_single_switch_matrix.v')

    # S_term_single2
    sources.append(f'{TILES_ROOT}/S_term_single2/S_term_single2.v')
    sources.append(f'{TILES_ROOT}/S_term_single2/S_term_single2_switch_matrix.v')

    # W_IO4
    sources.append(f'{TILES_ROOT}/W_IO4/W_IO4.v')
    sources.append(f'{TILES_ROOT}/W_IO4/W_IO4_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/W_IO4/W_IO4_switch_matrix.v')

    # S_WARMBOOT
    sources.append(f'{TILES_ROOT}/S_WARMBOOT/S_WARMBOOT.v')
    sources.append(f'{TILES_ROOT}/S_WARMBOOT/S_WARMBOOT_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/S_WARMBOOT/S_WARMBOOT_switch_matrix.v')

    # GF_SRAM
    sources.append(f'{TILES_ROOT}/GF_SRAM/GF_SRAM.v')
    sources.append(f'{TILES_ROOT}/GF_SRAM/GF_SRAM_bot/GF_SRAM_bot.v')
    sources.append(f'{TILES_ROOT}/GF_SRAM/GF_SRAM_bot/GF_SRAM_bot_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/GF_SRAM/GF_SRAM_bot/GF_SRAM_bot_switch_matrix.v')
    sources.append(f'{TILES_ROOT}/GF_SRAM/GF_SRAM_top/GF_SRAM_top.v')
    sources.append(f'{TILES_ROOT}/GF_SRAM/GF_SRAM_top/GF_SRAM_top_ConfigMem.v')
    sources.append(f'{TILES_ROOT}/GF_SRAM/GF_SRAM_top/GF_SRAM_top_switch_matrix.v')

    # N_term_SRAM
    sources.append(f'{TILES_ROOT}/N_term_SRAM/N_term_SRAM.v')
    sources.append(f'{TILES_ROOT}/N_term_SRAM/N_term_SRAM_switch_matrix.v')

    # S_term_SRAM
    sources.append(f'{TILES_ROOT}/S_term_SRAM/S_term_SRAM.v')
    sources.append(f'{TILES_ROOT}/S_term_SRAM/S_term_SRAM_switch_matrix.v')

    sources.append(proj_path / '../ip/tile_library/models_pack.v')


    build_args = []

    if sim == "icarus":
        # For debugging
        # build_args = ["-Winfloop", "-pfileline=1"]
        pass

    if sim == "verilator":
        build_args = ["--timing", "--trace", "--trace-fst", "--trace-structs"]

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=tb_toplevel,
        defines=defines,
        always=True,
        includes=includes,
        build_args=build_args,
        waves=True,
    )

    plusargs = []

    if enabled["flash1_slot0"]:
        plusargs += [f'+flash1_slot0={enabled["flash1_slot0"]}']
    if enabled["flash1_slot1"]:
        plusargs += [f'+flash1_slot1={enabled["flash1_slot1"]}']

    runner.test(
        hdl_toplevel=tb_toplevel,
        test_module="chip_top_tb,",
        plusargs=plusargs,
        waves=True,
    )


if __name__ == "__main__":
    chip_top_runner()
