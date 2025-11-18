# SPDX-FileCopyrightText: © 2025 Leo Moser <leomoser99@gmail.com>
# SPDX-License-Identifier: Apache-2.0

import os
import math
import random
from pathlib import Path
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.triggers import Timer, Edge, RisingEdge, FallingEdge
from cocotb.regression import TestFactory
from cocotb_tools.runner import get_runner

random.seed()

WAIT_CYCLES = random.randint(0, 5)
print(f'WAIT_CYCLES: {WAIT_CYCLES}')

FrameBitsPerRow = 32
MaxFramesPerCol = 20
FrameSelectWidth = 5 # hardcoded, should be based on NumColumns

NumColumns = 9
NumRows = 14

BITSTREAM_START = 0xFAB0FAB1
DESYNC_FLAG = 20

FABRIC_NUM_IO_WEST = 24
NUM_SRAM = 6
SRAM_WIDTH = 8
SRAM_ADDR_BITS = 9

run_all_zeros   = False
run_all_ones    = False
run_counter     = False
run_passthrough = False
run_sram        = True

def set_fabric_io(dut, value):
    value = value & (1<<FABRIC_NUM_IO_WEST)-1

    dut.fabric_io_west_in_i.value = value

def get_fabric_io(dut):
    value = dut.fabric_io_west_out_o.value
    
    return value

async def reset_design(dut):
    dut.rst_ni.value = 0
    await ClockCycles(dut.clk_i, 10)
    dut.rst_ni.value = 1

async def set_defaults(dut):
    dut.bitstream_data_i.value = 0
    dut.bitstream_valid_i.value = 0
    
    dut.fabric_io_west_in_i.value = 0
    
    print('Clearing bitstream!')
    
    # Reset all frames to zero
    await zero_bitstream(dut)
    
    print('Bitstream cleared!')

async def zero_bitstream(dut):
    """
    Upload an all-zeros bitstream in reverse to prevent
    logic loops before uploading a new user design.
    
    For faster clearing enable all FrameStrobe signals
    of a column at once.
    
    Note: Still does not reliably prevent logic loops...
    """

    # Write start of bitstream
    dut.bitstream_valid_i.value = 1
    dut.bitstream_data_i.value = BITSTREAM_START
    await ClockCycles(dut.clk_i, 1)
    
    # Write zero frames in reverse
    for column in reversed(range(NumColumns)):
    
        # Write header, clear all frames of a column at once
        dut.bitstream_data_i.value = column<<(FrameBitsPerRow-FrameSelectWidth) | ((1<<MaxFramesPerCol)-1)
        await ClockCycles(dut.clk_i, 1)

        # Write row data
        dut.bitstream_data_i.value = 0x00000000
        await ClockCycles(dut.clk_i, NumRows)

    # Write desync bit
    dut.bitstream_data_i.value = 1<<DESYNC_FLAG
    await ClockCycles(dut.clk_i, 1)

async def upload_bitstream(dut, name):
    """
    Read data until start of bitstream is detected
    Write data until desync bit is in header
    """

    print(f'Uploading bitstream: {name}')

    with open(f'../../user_designs/{name}/{name}.bit', 'br') as f:

        # Wait for start of bitstream
        while (data := f.read(4)) != None:
            number = int.from_bytes(data, "big")
            if number == BITSTREAM_START:
                print('Start of bitstream')
                
                # Write start of bitstream
                dut.bitstream_valid_i.value = 1
                dut.bitstream_data_i.value = number
                await ClockCycles(dut.clk_i, 1)

                if WAIT_CYCLES:
                    dut.bitstream_valid_i.value = 0
                    await ClockCycles(dut.clk_i, WAIT_CYCLES)

                break
    
        # Read bitstream content
        while 1:
        
            # Read header
            data = f.read(4)
            if data == None:
                break
            header = int.from_bytes(data, "big")
            
            print(f'--- header: 0x{header:08x}')

            # Write header
            dut.bitstream_valid_i.value = 1
            dut.bitstream_data_i.value = header
            await ClockCycles(dut.clk_i, 1)
            
            if WAIT_CYCLES:
                dut.bitstream_valid_i.value = 0
                await ClockCycles(dut.clk_i, WAIT_CYCLES)

            # Desync
            if header & (1<<DESYNC_FLAG):
                print("Detected desync flag!")
                break
            
            # Read row data
            for i in range(NumRows):
                row_data = int.from_bytes(f.read(4), "big")
                
                print(f'0x{row_data:08x}')
                
                # Write row data
                dut.bitstream_valid_i.value = 1
                dut.bitstream_data_i.value = row_data
                await ClockCycles(dut.clk_i, 1)
                
                if WAIT_CYCLES:
                    dut.bitstream_valid_i.value = 0
                    await ClockCycles(dut.clk_i, WAIT_CYCLES)
        
        print(f'Bitstream upload completed')
        
        # Stop the bitstream
        dut.bitstream_valid_i.value = 0
        dut.bitstream_data_i.value = 0
        await ClockCycles(dut.clk_i, 1)

@cocotb.test(skip=True)
async def test_default(dut):
    """No bitstream loaded"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_all_zeros==False)
async def test_all_zeros(dut):
    """Load bitstream to set output to zero"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'all_zeros')
    
    values = [random.randint(0,(1<<32)-1) for _ in range(10)]
    
    for value in values:
        set_fabric_io(dut, value)
        await ClockCycles(dut.clk_i, 1)
        assert(get_fabric_io(dut) == 0)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_all_ones==False)
async def test_all_ones(dut):
    """Load bitstream to set output to ones"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'all_ones')

    values = [random.randint(0,(1<<FABRIC_NUM_IO_WEST)-1) for _ in range(10)]
    
    for value in values:
        set_fabric_io(dut, value)
        await ClockCycles(dut.clk_i, 1)
        assert(get_fabric_io(dut) == (1<<FABRIC_NUM_IO_WEST)-1)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_counter==False)
async def test_counter(dut):
    """Load bitstream for counter"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'counter')
    
    set_fabric_io(dut, 1)
    await ClockCycles(dut.clk_i, 5)
    set_fabric_io(dut, 0)
    
    MAX_CNT = 30
    
    await ClockCycles(dut.clk_i, MAX_CNT)
    assert(get_fabric_io(dut) == MAX_CNT-1)

@cocotb.test(skip=run_passthrough==False)
async def test_passthrough(dut):
    """Load bitstream for test_passthrough"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")

    await upload_bitstream(dut, 'passthrough')
    
    values = [random.randint(0,(1<<FABRIC_NUM_IO_WEST)-1) for _ in range(10)]
    
    for value in values:
        set_fabric_io(dut, value)
        await ClockCycles(dut.clk_i, 1)
        assert(get_fabric_io(dut) == value)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_sram==False)
async def test_sram(dut):
    """Load bitstream for test_sram"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")

    await upload_bitstream(dut, 'sram')
    
    data = [random.randint(0, 2**SRAM_WIDTH-1) for _ in range(NUM_SRAM)]
    
    GWEN_BIT = 23
    SRAM_SELECT_OFFSET = 20

    # Select an invalid SRAM, needed for the simulation model
    set_fabric_io(dut, NUM_SRAM<<SRAM_SELECT_OFFSET)
    
    await ClockCycles(dut.clk_i, 1)
    
    for i, word in enumerate(data):
    
        print(f"Writing: {word}")
    
        # Select sram and write value
        set_fabric_io(dut, 1<<GWEN_BIT | i<<SRAM_SELECT_OFFSET | word << 8)
        await ClockCycles(dut.clk_i, 1)
    
    for i, word in enumerate(data):
    
        set_fabric_io(dut, i<<SRAM_SELECT_OFFSET)
        await ClockCycles(dut.clk_i, 2)
        
        print(get_fabric_io(dut))
    
        # Test the correct output of each sram
        assert(get_fabric_io(dut) == word)
    
    await ClockCycles(dut.clk_i, 10)

if __name__ == "__main__":

    sim = os.getenv("SIM", "icarus")
    pdk_root = os.getenv("PDK_ROOT", Path("~/.ciel").expanduser())
    pdk = os.getenv("PDK", "gf180mcuD")
    scl = os.getenv("SCL", "gf180mcu_fd_sc_mcu7t5v0")
    gl = os.getenv("GL", None)

    proj_path = Path(__file__).resolve().parent
    
    # Add fabric wrapper, fabric config and tb wrapper
    sources = [
        proj_path / '../rtl/fabric_wrapper.sv',
        proj_path / '../../fabric_config/fabric_config.sv',
        proj_path / 'tb_icarus.sv',
        
        # SRAM macros
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram512x8m8wm1.v",

        # SCL models
        #Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v",
        #Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / "primitives.v",
    ]
    
    # Add tiles
    TILES_ROOT = proj_path / '../../tile_library/tiles'

    if gl:
        # GL does not work because of pessimistic x-propagation!
        sources.append(proj_path / f'../macro/{pdk}/nl/eFPGA.nl.v')
        sources.append(pdk_root / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v" )

        sources.append(f'{TILES_ROOT}/DSP/macro/{pdk}/nl/DSP.nl.v')
        sources.append(f'{TILES_ROOT}/GF_SRAM/macro/{pdk}/nl/GF_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/LUT4AB/macro/{pdk}/nl/LUT4AB.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_DSP/macro/{pdk}/nl/N_term_DSP.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_SRAM/macro/{pdk}/nl/N_term_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_single/macro/{pdk}/nl/N_term_single.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_single2/macro/{pdk}/nl/N_term_single2.nl.v')
        sources.append(f'{TILES_ROOT}/RegFile/macro/{pdk}/nl/RegFile.nl.v')
        sources.append(f'{TILES_ROOT}/S_WARMBOOT/macro/{pdk}/nl/S_WARMBOOT.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_DSP/macro/{pdk}/nl/S_term_DSP.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_SRAM/macro/{pdk}/nl/S_term_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_single/macro/{pdk}/nl/S_term_single.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_single2/macro/{pdk}/nl/S_term_single2.nl.v')
        sources.append(f'{TILES_ROOT}/W_IO/macro/{pdk}/nl/W_IO.nl.v')
    else:
        # Add fabric
        sources.append(f'../macro/{pdk}/fabulous/eFPGA.v')
        
        # Add primitives
        PRIMITIVES_ROOT = proj_path / '../../tile_library/primitives'
        
        # Primitives
        sources.append(f'{PRIMITIVES_ROOT}/GF_SRAM_512x8/GF_SRAM_512x8.v')
        sources.append(f'{PRIMITIVES_ROOT}/IO_1_bidirectional_frame_config_pass/IO_1_bidirectional_frame_config_pass.v')
        sources.append(f'{PRIMITIVES_ROOT}/LUT4c_frame_config_dffesr/LUT4c_frame_config_dffesr.v')
        sources.append(f'{PRIMITIVES_ROOT}/MULADD/MULADD.v')
        sources.append(f'{PRIMITIVES_ROOT}/MUX8LUT_frame_config_mux/MUX8LUT_frame_config_mux.v')
        sources.append(f'{PRIMITIVES_ROOT}/RegFile_32x4/RegFile_32x4.v')
        sources.append(f'{PRIMITIVES_ROOT}/WARMBOOT/WARMBOOT.v')

        # Add tiles
        
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

        # W_IO
        sources.append(f'{TILES_ROOT}/W_IO/W_IO.v')
        sources.append(f'{TILES_ROOT}/W_IO/W_IO_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/W_IO/W_IO_switch_matrix.v')

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

        sources.append('../../tile_library/models_pack.v')

    hdl_toplevel = "tb"

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=hdl_toplevel,
        defines={'COCOTB': True, 'FUNCTIONAL': True, 'UNIT_DELAY': '#0'},
        always=True,
    )

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module="tb_cocotb,",
        plusargs=['-fst'],
        waves=True
    )
