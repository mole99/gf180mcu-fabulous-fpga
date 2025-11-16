from contextlib import redirect_stdout

COLUMNS = 5
ROWS = 6

FABRIC_NUM_IO_WEST = 8
BELS_PER_IO_TILE = ['A', 'B']
NUM_SRAM = 2
SRAM_WIDTH = 8
NUM_BRAM = 0
BRAM_WIDTH = 16

with open('fabric_wrapper2.sv', 'w') as f:
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
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_oe_o,\n""")

        # WARMBOOT
        print(f'    // WARMBOOT')
        print("""    output        fabric_warmboot_boot_o,""")
        print("""    output  [3:0] fabric_warmboot_slot_o,""")
        print("""    input         fabric_warmboot_reset_i,\n""")

        # CPU_IRQ
        print(f'    // CPU_IRQ')
        print("""    output  [3:0] fabric_irq_o,\n""")

        # CUSTOM_INSTRUCTION
        print(f'    // CUSTOM_INSTRUCTION')
        print("""    output logic        fabric_issue_ready_o,""")
        print("""    output logic        fabric_issue_accept_o,""")
        print("""    output logic        fabric_issue_valid_i,""")
        print("""    output logic [31:0] fabric_issue_instr_i,""")
        print("""    input  logic [31:0] fabric_issue_op0_i,""")
        print("""    input  logic [31:0] fabric_issue_op1_i,""")
        print("""    input  logic [3 :0] fabric_issue_id_i,\n""")
            
        print("""    output logic        fabric_result_valid_o,""")
        print("""    output logic [3 :0] fabric_result_id_o,""")
        print("""    output logic [4 :0] fabric_result_rd_o,""")
        print("""    output logic [31:0] fabric_result_o,\n""")

        # S_OBI
        print(f'    // S_OBI')
        print("""    input          fabric_obi_req_i,""")
        print("""    input          fabric_obi_we_i,""")
        print("""    input   [3 :0] fabric_obi_be_i,""")
        print("""    input   [23:0] fabric_obi_addr_i,""")
        print("""    input   [31:0] fabric_obi_wdata_i,""")

        print("""    output         fabric_obi_gnt_o,""")
        print("""    output         fabric_obi_rvalid_o,""")
        print("""    output  [31:0] fabric_obi_rdata_o,\n""")
        
        print(");\n")

        print(f'------------------ signals ------------------\n')

        # SRAM
        for i in range(NUM_SRAM):
            print(f'    // SRAM {i}')
            print(f"""    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_a_dout_i;
    logic [9 :0] fabric_sram{i}_a_addr_o;
    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_a_bm_o;
    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_a_din_o;
    logic        fabric_sram{i}_a_wen_o;
    logic        fabric_sram{i}_a_men_o;
    logic        fabric_sram{i}_a_ren_o;
    logic        fabric_sram{i}_a_clk_o;
    logic        fabric_sram{i}_a_tie_high_o;
    logic        fabric_sram{i}_a_tie_low_o;\n""")

        # BRAM
        for i in range(NUM_BRAM):
            print(f'    // BRAM {i}')
            print(f"""    logic [{BRAM_WIDTH-1}:0] fabric_bram{i}_a_dout_i;
    logic [9 :0] fabric_bram{i}_a_addr_o;
    logic [{BRAM_WIDTH-1}:0] fabric_bram{i}_a_bm_o;
    logic [{BRAM_WIDTH-1}:0] fabric_bram{i}_a_din_o;
    logic        fabric_bram{i}_a_wen_o;
    logic        fabric_bram{i}_a_men_o;
    logic        fabric_bram{i}_a_ren_o;
    logic        fabric_bram{i}_a_clk_o;
    logic        fabric_bram{i}_a_tie_high_o;
    logic        fabric_bram{i}_a_tie_low_o;
    logic [{BRAM_WIDTH-1}:0] fabric_bram{i}_b_dout_i;
    logic [9 :0] fabric_bram{i}_b_addr_o;
    logic [{BRAM_WIDTH-1}:0] fabric_bram{i}_b_bm_o;
    logic [{BRAM_WIDTH-1}:0] fabric_bram{i}_b_din_o;
    logic        fabric_bram{i}_b_wen_o;
    logic        fabric_bram{i}_b_men_o;
    logic        fabric_bram{i}_b_ren_o;
    logic        fabric_bram{i}_b_clk_o;
    logic        fabric_bram{i}_b_tie_high_o;
    logic        fabric_bram{i}_b_tie_low_o;\n""")

        print(f'------------------ body ------------------\n')
        
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
        .Tile_X0Y{i}_{bel}_T_top(fabric_io_west_oe_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),\n""")

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
        sram_coords = 'X11'
        sram_y_start = 10
        for i in range(NUM_SRAM):
            print(f'        // SRAM {i}')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_DOUT_SRAM{j}(fabric_sram{i}_a_dout_i[{j}]),')
            for j in range(10):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_ADDR_SRAM{j}(fabric_sram{i}_a_addr_o[{j}]),')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_BM_SRAM{j}(fabric_sram{i}_a_bm_o[{j}]),')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_DIN_SRAM{j}(fabric_sram{i}_a_din_o[{j}]),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_WEN_SRAM(fabric_sram{i}_a_wen_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_MEN_SRAM(fabric_sram{i}_a_men_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_REN_SRAM(fabric_sram{i}_a_ren_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_CLK_SRAM(fabric_sram{i}_a_clk_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_TIE_HIGH_SRAM(fabric_sram{i}_a_tie_high_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_TIE_LOW_SRAM(fabric_sram{i}_a_tie_low_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CONFIGURED_top(configured_i),')
            print('')

        print("    );\n")

        print(f'------------------ modules ------------------\n')

        for i in range(NUM_SRAM):

            print(f"""// SRAM {i} instances

        RM_IHPSG13_1P_1024x32_c2_bm_bist sram{i} (
            .A_CLK      (fabric_sram{i}_a_clk_o),
            .A_MEN      (fabric_sram{i}_a_men_o),
            .A_WEN      (fabric_sram{i}_a_wen_o),
            .A_REN      (fabric_sram{i}_a_ren_o),
            .A_ADDR     (fabric_sram{i}_a_addr_o),
            .A_DIN      (fabric_sram{i}_a_din_o),
            .A_DLY      (fabric_sram{i}_a_tie_high_o),
            .A_DOUT     (fabric_sram{i}_a_dout_i),
            .A_BM       (fabric_sram{i}_a_bm_o),

            .A_BIST_EN      (fabric_sram{i}_a_tie_low_o),
            .A_BIST_CLK     (fabric_sram{i}_a_tie_low_o),
            .A_BIST_MEN     (fabric_sram{i}_a_tie_low_o),
            .A_BIST_WEN     (fabric_sram{i}_a_tie_low_o),
            .A_BIST_REN     (fabric_sram{i}_a_tie_low_o),
            .A_BIST_ADDR    ({{10{{fabric_sram{i}_a_tie_low_o}}}}),
            .A_BIST_DIN     ({{32{{fabric_sram{i}_a_tie_low_o}}}}),
            .A_BIST_BM      ({{32{{fabric_sram{i}_a_tie_low_o}}}})
        );
        """)

        for i in range(NUM_BRAM):

            print(f"""// BRAM {i} instances

        RM_IHPSG13_2P_1024x16_c2_bm_bist bram{i} (
            .A_CLK      (fabric_bram{i}_a_clk_o),
            .A_MEN      (fabric_bram{i}_a_men_o),
            .A_WEN      (fabric_bram{i}_a_wen_o),
            .A_REN      (fabric_bram{i}_a_ren_o),
            .A_ADDR     (fabric_bram{i}_a_addr_o),
            .A_DIN      (fabric_bram{i}_a_din_o),
            .A_DLY      (fabric_bram{i}_a_tie_high_o),
            .A_DOUT     (fabric_bram{i}_a_dout_i),
            .A_BM       (fabric_bram{i}_a_bm_o),

            .A_BIST_EN      (fabric_bram{i}_a_tie_low_o),
            .A_BIST_CLK     (fabric_bram{i}_a_tie_low_o),
            .A_BIST_MEN     (fabric_bram{i}_a_tie_low_o),
            .A_BIST_WEN     (fabric_bram{i}_a_tie_low_o),
            .A_BIST_REN     (fabric_bram{i}_a_tie_low_o),
            .A_BIST_ADDR    ({{10{{fabric_bram{i}_a_tie_low_o}}}}),
            .A_BIST_DIN     ({{16{{fabric_bram{i}_a_tie_low_o}}}}),
            .A_BIST_BM      ({{16{{fabric_bram{i}_a_tie_low_o}}}}),

            .B_CLK      (fabric_bram{i}_b_clk_o),
            .B_MEN      (fabric_bram{i}_b_men_o),
            .B_WEN      (fabric_bram{i}_b_wen_o),
            .B_REN      (fabric_bram{i}_b_ren_o),
            .B_ADDR     (fabric_bram{i}_b_addr_o),
            .B_DIN      (fabric_bram{i}_b_din_o),
            .B_DLY      (fabric_bram{i}_b_tie_high_o),
            .B_DOUT     (fabric_bram{i}_b_dout_i),
            .B_BM       (fabric_bram{i}_b_bm_o),

            .B_BIST_EN      (fabric_bram{i}_b_tie_low_o),
            .B_BIST_CLK     (fabric_bram{i}_b_tie_low_o),
            .B_BIST_MEN     (fabric_bram{i}_b_tie_low_o),
            .B_BIST_WEN     (fabric_bram{i}_b_tie_low_o),
            .B_BIST_REN     (fabric_bram{i}_b_tie_low_o),
            .B_BIST_ADDR    ({{10{{fabric_bram{i}_b_tie_low_o}}}}),
            .B_BIST_DIN     ({{16{{fabric_bram{i}_b_tie_low_o}}}}),
            .B_BIST_BM      ({{16{{fabric_bram{i}_b_tie_low_o}}}})
        );
        """)
