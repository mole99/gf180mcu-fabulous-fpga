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
from cocotb.runner import get_runner

random.seed()

WAIT_CYCLES = random.randint(0, 5)
print(f'WAIT_CYCLES: {WAIT_CYCLES}')

FrameBitsPerRow = 32
MaxFramesPerCol = 20
FrameSelectWidth = 5 # hardcoded, should be based on NumColumns

NumColumns = 12
NumRows = 18

BITSTREAM_START = 0xFAB0FAB1
DESYNC_FLAG = 20

FABRIC_NUM_IO_WEST = 32

run_all_zeros   = False
run_all_ones    = False
run_counter     = False
run_passthrough = False
run_sram        = False
run_bram        = True
run_peripheral  = False
run_custom_instruction = False

def set_fabric_io(dut, value):
    value = value & 0xFFFFFFFF

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

    dut.fabric_issue_valid_i.value  = 0
    dut.fabric_issue_instr_i.value  = 0
    dut.fabric_issue_op0_i.value    = 0
    dut.fabric_issue_op1_i.value    = 0
    dut.fabric_issue_id_i.value     = 0
    
    dut.fabric_obi_req_i.value = 0
    dut.fabric_obi_we_i.value = 0
    dut.fabric_obi_be_i.value = 0
    dut.fabric_obi_addr_i.value = 13
    dut.fabric_obi_wdata_i.value = 42
    
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

    values = [random.randint(0,(1<<32)-1) for _ in range(10)]
    
    for value in values:
        set_fabric_io(dut, value)
        await ClockCycles(dut.clk_i, 1)
        assert(get_fabric_io(dut) == (1<<32)-1)
    
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
    
    values = [random.randint(0,(1<<32)-1) for _ in range(10)]
    
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
    
    data = [random.randint(0, 2**16-1) for _ in range(8)]
    
    REN_BIT = 31
    WEN_BIT = 30
    SRAM_SELECT_OFFSET = 26
    
    for i, word in enumerate(data):
    
        # Select sram and write value
        set_fabric_io(dut, 1<<WEN_BIT | i<<SRAM_SELECT_OFFSET | word)
        await ClockCycles(dut.clk_i, 1)
    
    for i, word in enumerate(data):
    
        set_fabric_io(dut, 1<<REN_BIT | i<<SRAM_SELECT_OFFSET)
        await ClockCycles(dut.clk_i, 2)
        
        print(get_fabric_io(dut))
    
        # Test the correct output of each sram
        assert(get_fabric_io(dut) == word)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_bram==False)
async def test_bram(dut):
    """Load bitstream for test_bram"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")

    await upload_bitstream(dut, 'bram')
    
    data = [random.randint(0, 2**16-1) for _ in range(4)]
    
    REN_BIT = 31
    WEN_BIT = 30
    BRAM_SELECT_OFFSET = 26
    
    # A port and B port
    for i, word in enumerate(data):
    
        # Select bram and write value
        set_fabric_io(dut, 1<<WEN_BIT | i<<BRAM_SELECT_OFFSET | word)
        await ClockCycles(dut.clk_i, 1)
    
    # A port
    for i, word in enumerate(data):
    
        set_fabric_io(dut, 1<<REN_BIT | i<<BRAM_SELECT_OFFSET)
        await ClockCycles(dut.clk_i, 2)
        
        print(get_fabric_io(dut).integer)
        print(word)
    
        # Test the correct output of each bram
        assert(get_fabric_io(dut) == word)

    # B port
    for i, word in enumerate(data):
    
        set_fabric_io(dut, 1<<REN_BIT | (i+4)<<BRAM_SELECT_OFFSET)
        await ClockCycles(dut.clk_i, 2)
        
        print(get_fabric_io(dut).integer)
        print(word)
    
        # Test the correct output of each bram
        assert(get_fabric_io(dut) == word)

    await ClockCycles(dut.clk_i, 10)

async def write_reg(dut, addr, data, be=0xF):
    dut.fabric_obi_req_i.value = 1
    dut.fabric_obi_we_i.value = 1
    dut.fabric_obi_be_i.value = be
    dut.fabric_obi_addr_i.value = addr
    dut.fabric_obi_wdata_i.value = data
    
    while 1:
        await ClockCycles(dut.clk_i, 1)
        if dut.fabric_obi_gnt_o.value == 1 and dut.fabric_obi_rvalid_o.value == 1:
            dut.fabric_obi_req_i.value = 0
            dut.fabric_obi_we_i.value = 0
            dut.fabric_obi_be_i.value = 0
            dut.fabric_obi_addr_i.value = 0
            dut.fabric_obi_wdata_i.value = 0
            await ClockCycles(dut.clk_i, 1)
            return

async def read_reg(dut, addr):
    dut.fabric_obi_req_i.value = 1
    dut.fabric_obi_we_i.value = 0
    dut.fabric_obi_be_i.value = 0
    dut.fabric_obi_addr_i.value = addr
    dut.fabric_obi_wdata_i.value = 0

    while 1:
        await ClockCycles(dut.clk_i, 1)
        if dut.fabric_obi_gnt_o.value == 1 and dut.fabric_obi_rvalid_o.value == 1:
            rdata = dut.fabric_obi_rdata_o.value
            dut.fabric_obi_req_i.value = 0
            dut.fabric_obi_we_i.value = 0
            dut.fabric_obi_be_i.value = 0
            dut.fabric_obi_addr_i.value = 0
            dut.fabric_obi_wdata_i.value = 0
            await ClockCycles(dut.clk_i, 1)
            return rdata

@cocotb.test(skip=run_peripheral==False)
async def test_peripheral(dut):
    """Load bitstream for peripheral"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'peripheral')

    NUM_REGS = 32

    for i in range(NUM_REGS):
        for _ in range(5):
            value = random.randint(0,(1<<32)-1)
            
            await write_reg(dut, i, value)
            assert (await read_reg(dut, i) == value)

    for i in reversed(range(NUM_REGS)):
        for _ in range(5):
            value = random.randint(0,(1<<32)-1)
            
            await write_reg(dut, i, value)
            assert (await read_reg(dut, i) == value)

    # Test byte enable
    await write_reg(dut, 0, 0)

    await write_reg(dut, 0, 0x000000FF, be=0x1)
    assert (await read_reg(dut, 0) == 0x000000FF)
    
    await write_reg(dut, 0, 0xFF000000, be=0x8)
    assert (await read_reg(dut, 0) == 0xFF0000FF)
    
    await write_reg(dut, 0, 0xFFFF00FF, be=0x2)
    assert (await read_reg(dut, 0) == 0xFF0000FF)
    
    await write_reg(dut, 0, 0x000000FF, be=0x8)
    assert (await read_reg(dut, 0) == 0x000000FF)
    
    await write_reg(dut, 0, 0xDEADBEEF)
    assert (await read_reg(dut, 0) == 0xDEADBEEF)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_custom_instruction==False)
async def test_custom_instruction(dut):
    """Load bitstream for custom_instruction"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'custom_instruction')
    
    values_rs1 = [random.randint(0,(1<<32)-1) for _ in range(10)]
    values_rs2 = [random.randint(0,(1<<32)-1) for _ in range(10)]
    
    for i, (value_rs1, value_rs2) in enumerate(zip(values_rs1, values_rs2)):
    
        # Set the instruction
        # opcode   = [6:0]
        # rs1      = [19:15]
        # rs2      = [24:20]
        # rd       = [11:7]
        # funct3   = [14:12]
        # funct7   = [31:25]
        
        # Simply set the opcode
        dut.fabric_issue_instr_i.value = 0x5B
        
        dut.fabric_issue_op0_i.value = value_rs1
        dut.fabric_issue_op1_i.value = value_rs2
        
        result = (value_rs1 + value_rs2) & 0xFFFFFFFF
        
        dut.fabric_issue_id_i.value = i & 0xF
        dut.fabric_issue_valid_i.value = 1
        
        # Wait for accept
        await ClockCycles(dut.clk_i, 1)
        assert (dut.fabric_issue_ready_o.value == 1)
        assert (dut.fabric_issue_accept_o.value == 1)
        
        dut.fabric_issue_valid_i.value = 0
        
        # Wait for result
        await ClockCycles(dut.clk_i, 2)

        assert (dut.fabric_result_valid_o.value == 1)
        assert (dut.fabric_result_id_o.value == i & 0xF)
        assert (dut.fabric_result_rd_o.value == 0)
        assert (dut.fabric_result_o.value == result)

    await ClockCycles(dut.clk_i, 10)

if __name__ == "__main__":

    sim = os.getenv("SIM", "icarus")
    pdk_root = os.getenv("PDK_ROOT", Path("~/.ciel").expanduser())
    pdk = os.getenv("PDK", "ihp-sg13g2")
    scl = os.getenv("SCL", "sg13g2_stdcell")
    gl = os.getenv("GL", None)

    proj_path = Path(__file__).resolve().parent
    
    # Add fabric wrapper, fabric config and tb wrapper
    sources = [
        '../rtl/fabric_wrapper.sv',
        '../../fabric_config/fabric_config.sv',
        'tb_icarus.sv',
        
        # SRAM models
        proj_path / '../../' / "RM_IHPSG13_1P_1024x32_c2_bm_bist" / "verilog" / "RM_IHPSG13_1P_1024x32_c2_bm_bist.v",
        proj_path / '../../' / "RM_IHPSG13_1P_1024x32_c2_bm_bist" / "verilog" / "RM_IHPSG13_1P_core_behavioral_bm_bist.v",

        # BRAM models
        proj_path / '../../' / "RM_IHPSG13_2P_1024x16_c2_bm_bist" / "verilog" / "RM_IHPSG13_2P_1024x16_c2_bm_bist.v",
        proj_path / '../../' / "RM_IHPSG13_2P_1024x16_c2_bm_bist" / "verilog" / "RM_IHPSG13_2P_core_behavioral_bm_bist_ideal.v",

        # SCL models (for the clock gate)
        Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v"
    ]
    
    # Add tiles
    TILES_ROOT = '../../tile_library/tiles'

    if gl:
        # GL does not work because of pessimistic x-propagation!
        sources.append(f'../macro/{pdk}/nl/eFPGA.nl.v')
        sources.append(Path(pdk_root).expanduser() / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v" )
        
        sources.append(f'{TILES_ROOT}/LUT4AB/macro/{pdk}/nl/LUT4AB.nl.v')
        sources.append(f'{TILES_ROOT}/E_TT_IF/macro/{pdk}/nl/E_TT_IF.nl.v')
        sources.append(f'{TILES_ROOT}/W_TT_IF/macro/{pdk}/nl/W_TT_IF.nl.v')
        sources.append(f'{TILES_ROOT}/N_IO4/macro/{pdk}/nl/N_IO4.nl.v')
        sources.append(f'{TILES_ROOT}/S_IO4/macro/{pdk}/nl/S_IO4.nl.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/macro/{pdk}/nl/IHP_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/NE_term/macro/{pdk}/nl/NE_term.nl.v')
        sources.append(f'{TILES_ROOT}/SE_term/macro/{pdk}/nl/SE_term.nl.v')
        sources.append(f'{TILES_ROOT}/NW_term/macro/{pdk}/nl/NW_term.nl.v')
        sources.append(f'{TILES_ROOT}/SW_term/macro/{pdk}/nl/SW_term.nl.v')

        sources.append(f'{TILES_ROOT}/DSP/macro/{pdk}/nl/DSP.nl.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/macro/{pdk}/nl/IHP_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/LUT4AB/macro/{pdk}/nl/LUT4AB.nl.v')
        sources.append(f'{TILES_ROOT}/N_IO/macro/{pdk}/nl/N_IO.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_DSP/macro/{pdk}/nl/N_term_DSP.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_IHP_SRAM/macro/{pdk}/nl/N_term_IHP_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_single/macro/{pdk}/nl/N_term_single.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_single2/macro/{pdk}/nl/N_term_single2.nl.v')
        sources.append(f'{TILES_ROOT}/RegFile/macro/{pdk}/nl/RegFile.nl.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IF/macro/{pdk}/nl/S_CPU_IF.nl.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/macro/{pdk}/nl/S_CPU_IRQ.nl.v')
        sources.append(f'{TILES_ROOT}/S_WARMBOOT/macro/{pdk}/nl/S_WARMBOOT.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_DSP/macro/{pdk}/nl/S_term_DSP.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_IHP_SRAM/macro/{pdk}/nl/S_term_IHP_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_single/macro/{pdk}/nl/S_term_single.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_single2/macro/{pdk}/nl/S_term_single2.nl.v')
        sources.append(f'{TILES_ROOT}/W_IO/macro/{pdk}/nl/W_IO.nl.v')
    else:
        # Add fabric
        sources.append(f'../macro/{pdk}/fabulous/eFPGA.v')
        
        # Add primitives
        PRIMITIVES_ROOT = proj_path / '../../tile_library/primitives'
        
        # Primitives
        sources.append(f'{PRIMITIVES_ROOT}/CPU_IRQ/CPU_IRQ.v')
        sources.append(f'{PRIMITIVES_ROOT}/CUSTOM_INSTRUCTION/CUSTOM_INSTRUCTION.v')
        sources.append(f'{PRIMITIVES_ROOT}/IHP_SRAM_1024x32/IHP_SRAM_1024x32.v')
        sources.append(f'{PRIMITIVES_ROOT}/IHP_BRAM_1024x16/IHP_BRAM_1024x16.v')
        sources.append(f'{PRIMITIVES_ROOT}/IO_1_bidirectional_frame_config_pass/IO_1_bidirectional_frame_config_pass.v')
        sources.append(f'{PRIMITIVES_ROOT}/LUT4c_frame_config_dffesr/LUT4c_frame_config_dffesr.v')
        sources.append(f'{PRIMITIVES_ROOT}/MULADD/MULADD.v')
        sources.append(f'{PRIMITIVES_ROOT}/MUX8LUT_frame_config_mux/MUX8LUT_frame_config_mux.v')
        sources.append(f'{PRIMITIVES_ROOT}/OBI_PERIPHERAL/OBI_PERIPHERAL.v')
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
        
        # S_CPU_IF
        sources.append(f'{TILES_ROOT}/S_CPU_IF/S_CPU_IF.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IF/S_CPU_IF_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IF/S_CPU_IF_switch_matrix.v')

        # S_CPU_IRQ
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/S_CPU_IRQ.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/S_CPU_IRQ_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/S_CPU_IRQ_switch_matrix.v')

        # IHP_SRAM
        sources.append(f'{TILES_ROOT}/IHP_SRAM/IHP_SRAM.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/IHP_SRAM_bot/IHP_SRAM_bot.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/IHP_SRAM_bot/IHP_SRAM_bot_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/IHP_SRAM_bot/IHP_SRAM_bot_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/IHP_SRAM_top/IHP_SRAM_top.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/IHP_SRAM_top/IHP_SRAM_top_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/IHP_SRAM/IHP_SRAM_top/IHP_SRAM_top_switch_matrix.v')

        # IHP_BRAM
        sources.append(f'{TILES_ROOT}/IHP_BRAM/IHP_BRAM.v')
        sources.append(f'{TILES_ROOT}/IHP_BRAM/IHP_BRAM_bot/IHP_BRAM_bot.v')
        sources.append(f'{TILES_ROOT}/IHP_BRAM/IHP_BRAM_bot/IHP_BRAM_bot_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/IHP_BRAM/IHP_BRAM_bot/IHP_BRAM_bot_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/IHP_BRAM/IHP_BRAM_top/IHP_BRAM_top.v')
        sources.append(f'{TILES_ROOT}/IHP_BRAM/IHP_BRAM_top/IHP_BRAM_top_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/IHP_BRAM/IHP_BRAM_top/IHP_BRAM_top_switch_matrix.v')

        # N_term_IHP_SRAM
        sources.append(f'{TILES_ROOT}/N_term_IHP_SRAM/N_term_IHP_SRAM.v')
        sources.append(f'{TILES_ROOT}/N_term_IHP_SRAM/N_term_IHP_SRAM_switch_matrix.v')

        # S_term_IHP_SRAM
        sources.append(f'{TILES_ROOT}/S_term_IHP_SRAM/S_term_IHP_SRAM.v')
        sources.append(f'{TILES_ROOT}/S_term_IHP_SRAM/S_term_IHP_SRAM_switch_matrix.v')

        # S_OBI
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_left/S_OBI_left.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_left/S_OBI_left_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_left/S_OBI_left_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_middle/S_OBI_middle.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_middle/S_OBI_middle_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_middle/S_OBI_middle_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_right/S_OBI_right.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_right/S_OBI_right_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_OBI/S_OBI_right/S_OBI_right_switch_matrix.v')

        # S_XIF
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_left/S_XIF_left.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_left/S_XIF_left_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_left/S_XIF_left_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_middle/S_XIF_middle.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_middle/S_XIF_middle_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_middle/S_XIF_middle_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_right/S_XIF_right.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_right/S_XIF_right_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_XIF/S_XIF_right/S_XIF_right_switch_matrix.v')

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
