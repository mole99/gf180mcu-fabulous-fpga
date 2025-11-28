from contextlib import redirect_stdout

COLUMNS = 9
ROWS = 14

FABRIC_NUM_IO_WEST = 48
BELS_PER_IO_TILE = ['A', 'B', 'C', 'D']
NUM_SRAM = 6
SRAM_WIDTH = 8
SRAM_ADDR_BITS = 9

with open('fabric_wrapper.sv', 'w') as f:
    with redirect_stdout(f):
        
        print(f"""module fabric_wrapper #(
    	parameter FrameBitsPerRow = 32,
	parameter MaxFramesPerCol = 20,
	
	parameter NumColumns = {COLUMNS},
	parameter NumRows = {ROWS},
	
    parameter FABRIC_NUM_IO_WEST = {FABRIC_NUM_IO_WEST}
)(
    input clk_i,
    
    // Configuration
    input  logic [(FrameBitsPerRow*NumRows)-1:0]    FrameData_i,
    input  logic [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe_i,
        """)

        print(f'    // Fabric is configured')
        print("""    input                                configured_i,\n""")

        # I/Os
        print(f'    // I/Os West')
        print("""    input  [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_in_i,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_out_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_oe_o,
    
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config0_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config1_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config2_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config3_o,\n""")

        # WARMBOOT
        print(f'    // WARMBOOT')
        print("""    output        fabric_warmboot_boot_o,""")
        print("""    output  [3:0] fabric_warmboot_slot_o,""")
        print("""    input         fabric_warmboot_reset_i\n""")
        
        print(");\n")

        # SRAM
        for i in range(NUM_SRAM):
            print(f'    // SRAM {i}')
            print(f"""    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_q_i;
    logic [{SRAM_ADDR_BITS}-1:0] fabric_sram{i}_a_o;
    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_wen_o;
    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_d_o;
    logic        fabric_sram{i}_gwen_o;
    logic        fabric_sram{i}_cen_o;
    logic        fabric_sram{i}_clk_o;\n""")
        
        print("""    eFPGA
    //#(
    //    .MaxFramesPerCol(MaxFramesPerCol),
    //    .FrameBitsPerRow(FrameBitsPerRow)
    //)
    eFPGA
    (
        .FrameData      (FrameData_i),
        .FrameStrobe    (FrameStrobe_i),
        .UserCLK        (clk_i),
""")

        # I/Os
        print(f"""        // West I/Os""")
        num_bels = len(BELS_PER_IO_TILE)
        IO_WEST_OFFSET = 1
        for i in range(IO_WEST_OFFSET,(FABRIC_NUM_IO_WEST//num_bels)+1):
            for j, bel in enumerate(BELS_PER_IO_TILE):
                print(f"""        .Tile_X0Y{i}_{bel}_O_top(fabric_io_west_in_i[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_I_top(fabric_io_west_out_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_T_top(fabric_io_west_oe_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        
        .Tile_X0Y{i}_{bel}_config_C_bit0(fabric_io_west_config0_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_config_C_bit1(fabric_io_west_config1_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_config_C_bit2(fabric_io_west_config2_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_config_C_bit3(fabric_io_west_config3_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),\n""")

        # WARMBOOT
        warmboot_coords = f'X1Y{ROWS-1}'
        print('        // WARMBOOT')
        print(f"""        .Tile_{warmboot_coords}_RESET_top(fabric_warmboot_reset_i),
        .Tile_{warmboot_coords}_BOOT_top(fabric_warmboot_boot_o),
        .Tile_{warmboot_coords}_SLOT_top0(fabric_warmboot_slot_o[0]),
        .Tile_{warmboot_coords}_SLOT_top1(fabric_warmboot_slot_o[1]),
        .Tile_{warmboot_coords}_SLOT_top2(fabric_warmboot_slot_o[2]),
        .Tile_{warmboot_coords}_SLOT_top3(fabric_warmboot_slot_o[3]),
        .Tile_{warmboot_coords}_CONFIGURED_top(configured_i),\n""")

        # SRAM
        sram_coords = f'X{COLUMNS-1}'
        sram_y_start = 2
        for i in range(NUM_SRAM):
            print(f'        // SRAM {i}')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_Q_SRAM{j}(fabric_sram{i}_q_i[{j}]),')
            for j in range(SRAM_ADDR_BITS):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_SRAM{j}(fabric_sram{i}_a_o[{j}]),')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_WEN_SRAM{j}(fabric_sram{i}_wen_o[{j}]),')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_D_SRAM{j}(fabric_sram{i}_d_o[{j}]),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_GWEN_SRAM(fabric_sram{i}_gwen_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CEN_SRAM(fabric_sram{i}_cen_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CLK_SRAM(fabric_sram{i}_clk_o),')
            
            if (i==NUM_SRAM-1):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CONFIGURED_top(configured_i)')
            else:
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CONFIGURED_top(configured_i),')
            print('')

        print("    );\n")

        for i in range(NUM_SRAM):

            print(f"""    // SRAM {i} instance

    gf180mcu_fd_ip_sram__sram512x8m8wm1 sram_{i} (
      .CLK      (fabric_sram{i}_clk_o),
      .CEN      (fabric_sram{i}_cen_o),   //Chip Enable
      .GWEN     (fabric_sram{i}_gwen_o),  //Global Write Enable
      .WEN      (fabric_sram{i}_wen_o),   //Write Enable
      .A        (fabric_sram{i}_a_o),
      .D        (fabric_sram{i}_d_o),
      .Q        (fabric_sram{i}_q_i)
    );
        """)

        print("endmodule")
