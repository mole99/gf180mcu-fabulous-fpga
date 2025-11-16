module fabric_wrapper #(
    	parameter FrameBitsPerRow = 32,
	parameter MaxFramesPerCol = 20,
	
	parameter NumColumns = 5,
	parameter NumRows = 6,
	
    parameter FABRIC_NUM_IO_WEST = 8
)(
    input clk_i,
    
    // Configuration
    input  logic [(FrameBitsPerRow*NumRows)-1:0]    FrameData_i,
    input  logic [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe_i,
        
    // Fabric is configured
    input                                configured_i,

    // I/Os West
    input  [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_in_i,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_out_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_oe_o,

    // WARMBOOT
    output        fabric_warmboot_boot_o,
    output  [3:0] fabric_warmboot_slot_o,
    input         fabric_warmboot_reset_i,

    // CPU_IRQ
    output  [3:0] fabric_irq_o,

    // CUSTOM_INSTRUCTION
    output logic        fabric_issue_ready_o,
    output logic        fabric_issue_accept_o,
    output logic        fabric_issue_valid_i,
    output logic [31:0] fabric_issue_instr_i,
    input  logic [31:0] fabric_issue_op0_i,
    input  logic [31:0] fabric_issue_op1_i,
    input  logic [3 :0] fabric_issue_id_i,

    output logic        fabric_result_valid_o,
    output logic [3 :0] fabric_result_id_o,
    output logic [4 :0] fabric_result_rd_o,
    output logic [31:0] fabric_result_o,

    // S_OBI
    input          fabric_obi_req_i,
    input          fabric_obi_we_i,
    input   [3 :0] fabric_obi_be_i,
    input   [23:0] fabric_obi_addr_i,
    input   [31:0] fabric_obi_wdata_i,
    output         fabric_obi_gnt_o,
    output         fabric_obi_rvalid_o,
    output  [31:0] fabric_obi_rdata_o,

);

------------------ signals ------------------

    // SRAM 0
    logic [7:0] fabric_sram0_a_dout_i;
    logic [9 :0] fabric_sram0_a_addr_o;
    logic [7:0] fabric_sram0_a_bm_o;
    logic [7:0] fabric_sram0_a_din_o;
    logic        fabric_sram0_a_wen_o;
    logic        fabric_sram0_a_men_o;
    logic        fabric_sram0_a_ren_o;
    logic        fabric_sram0_a_clk_o;
    logic        fabric_sram0_a_tie_high_o;
    logic        fabric_sram0_a_tie_low_o;

    // SRAM 1
    logic [7:0] fabric_sram1_a_dout_i;
    logic [9 :0] fabric_sram1_a_addr_o;
    logic [7:0] fabric_sram1_a_bm_o;
    logic [7:0] fabric_sram1_a_din_o;
    logic        fabric_sram1_a_wen_o;
    logic        fabric_sram1_a_men_o;
    logic        fabric_sram1_a_ren_o;
    logic        fabric_sram1_a_clk_o;
    logic        fabric_sram1_a_tie_high_o;
    logic        fabric_sram1_a_tie_low_o;

------------------ body ------------------

    eFPGA
    //#(
    //    .MaxFramesPerCol(MaxFramesPerCol),
    //    .FrameBitsPerRow(FrameBitsPerRow)
    //)
    eFPGA
    (
        .FrameData      (FrameData_i),
        .FrameStrobe    (FrameStrobe_i),
        .UserCLK        (clk_i),

        // West I/Os
        .Tile_X0Y1_A_O_top(fabric_io_west_in_i[7]),
        .Tile_X0Y1_A_I_top(fabric_io_west_out_o[7]),
        .Tile_X0Y1_A_T_top(fabric_io_west_oe_o[7]),

        .Tile_X0Y1_B_O_top(fabric_io_west_in_i[6]),
        .Tile_X0Y1_B_I_top(fabric_io_west_out_o[6]),
        .Tile_X0Y1_B_T_top(fabric_io_west_oe_o[6]),

        .Tile_X0Y2_A_O_top(fabric_io_west_in_i[5]),
        .Tile_X0Y2_A_I_top(fabric_io_west_out_o[5]),
        .Tile_X0Y2_A_T_top(fabric_io_west_oe_o[5]),

        .Tile_X0Y2_B_O_top(fabric_io_west_in_i[4]),
        .Tile_X0Y2_B_I_top(fabric_io_west_out_o[4]),
        .Tile_X0Y2_B_T_top(fabric_io_west_oe_o[4]),

        .Tile_X0Y3_A_O_top(fabric_io_west_in_i[3]),
        .Tile_X0Y3_A_I_top(fabric_io_west_out_o[3]),
        .Tile_X0Y3_A_T_top(fabric_io_west_oe_o[3]),

        .Tile_X0Y3_B_O_top(fabric_io_west_in_i[2]),
        .Tile_X0Y3_B_I_top(fabric_io_west_out_o[2]),
        .Tile_X0Y3_B_T_top(fabric_io_west_oe_o[2]),

        .Tile_X0Y4_A_O_top(fabric_io_west_in_i[1]),
        .Tile_X0Y4_A_I_top(fabric_io_west_out_o[1]),
        .Tile_X0Y4_A_T_top(fabric_io_west_oe_o[1]),

        .Tile_X0Y4_B_O_top(fabric_io_west_in_i[0]),
        .Tile_X0Y4_B_I_top(fabric_io_west_out_o[0]),
        .Tile_X0Y4_B_T_top(fabric_io_west_oe_o[0]),

        // WARMBOOT
        .Tile_X1Y5_RESET_top(fabric_warmboot_reset_i),
        .Tile_X1Y5_BOOT_top(fabric_warmboot_boot_o),
        .Tile_X1Y5_SLOT_top0(fabric_warmboot_slot_o[0]),
        .Tile_X1Y5_SLOT_top1(fabric_warmboot_slot_o[1]),
        .Tile_X1Y5_SLOT_top2(fabric_warmboot_slot_o[2]),
        .Tile_X1Y5_SLOT_top3(fabric_warmboot_slot_o[3]),
        .Tile_X1Y5_CONFIGURED_top(configured_i),

        // SRAM 0
        .Tile_X11Y10_A_DOUT_SRAM0(fabric_sram0_a_dout_i[0]),
        .Tile_X11Y10_A_DOUT_SRAM1(fabric_sram0_a_dout_i[1]),
        .Tile_X11Y10_A_DOUT_SRAM2(fabric_sram0_a_dout_i[2]),
        .Tile_X11Y10_A_DOUT_SRAM3(fabric_sram0_a_dout_i[3]),
        .Tile_X11Y10_A_DOUT_SRAM4(fabric_sram0_a_dout_i[4]),
        .Tile_X11Y10_A_DOUT_SRAM5(fabric_sram0_a_dout_i[5]),
        .Tile_X11Y10_A_DOUT_SRAM6(fabric_sram0_a_dout_i[6]),
        .Tile_X11Y10_A_DOUT_SRAM7(fabric_sram0_a_dout_i[7]),
        .Tile_X11Y10_A_ADDR_SRAM0(fabric_sram0_a_addr_o[0]),
        .Tile_X11Y10_A_ADDR_SRAM1(fabric_sram0_a_addr_o[1]),
        .Tile_X11Y10_A_ADDR_SRAM2(fabric_sram0_a_addr_o[2]),
        .Tile_X11Y10_A_ADDR_SRAM3(fabric_sram0_a_addr_o[3]),
        .Tile_X11Y10_A_ADDR_SRAM4(fabric_sram0_a_addr_o[4]),
        .Tile_X11Y10_A_ADDR_SRAM5(fabric_sram0_a_addr_o[5]),
        .Tile_X11Y10_A_ADDR_SRAM6(fabric_sram0_a_addr_o[6]),
        .Tile_X11Y10_A_ADDR_SRAM7(fabric_sram0_a_addr_o[7]),
        .Tile_X11Y10_A_ADDR_SRAM8(fabric_sram0_a_addr_o[8]),
        .Tile_X11Y10_A_ADDR_SRAM9(fabric_sram0_a_addr_o[9]),
        .Tile_X11Y10_A_BM_SRAM0(fabric_sram0_a_bm_o[0]),
        .Tile_X11Y10_A_BM_SRAM1(fabric_sram0_a_bm_o[1]),
        .Tile_X11Y10_A_BM_SRAM2(fabric_sram0_a_bm_o[2]),
        .Tile_X11Y10_A_BM_SRAM3(fabric_sram0_a_bm_o[3]),
        .Tile_X11Y10_A_BM_SRAM4(fabric_sram0_a_bm_o[4]),
        .Tile_X11Y10_A_BM_SRAM5(fabric_sram0_a_bm_o[5]),
        .Tile_X11Y10_A_BM_SRAM6(fabric_sram0_a_bm_o[6]),
        .Tile_X11Y10_A_BM_SRAM7(fabric_sram0_a_bm_o[7]),
        .Tile_X11Y10_A_DIN_SRAM0(fabric_sram0_a_din_o[0]),
        .Tile_X11Y10_A_DIN_SRAM1(fabric_sram0_a_din_o[1]),
        .Tile_X11Y10_A_DIN_SRAM2(fabric_sram0_a_din_o[2]),
        .Tile_X11Y10_A_DIN_SRAM3(fabric_sram0_a_din_o[3]),
        .Tile_X11Y10_A_DIN_SRAM4(fabric_sram0_a_din_o[4]),
        .Tile_X11Y10_A_DIN_SRAM5(fabric_sram0_a_din_o[5]),
        .Tile_X11Y10_A_DIN_SRAM6(fabric_sram0_a_din_o[6]),
        .Tile_X11Y10_A_DIN_SRAM7(fabric_sram0_a_din_o[7]),
        .Tile_X11Y10_A_WEN_SRAM(fabric_sram0_a_wen_o),
        .Tile_X11Y10_A_MEN_SRAM(fabric_sram0_a_men_o),
        .Tile_X11Y10_A_REN_SRAM(fabric_sram0_a_ren_o),
        .Tile_X11Y10_A_CLK_SRAM(fabric_sram0_a_clk_o),
        .Tile_X11Y10_A_TIE_HIGH_SRAM(fabric_sram0_a_tie_high_o),
        .Tile_X11Y10_A_TIE_LOW_SRAM(fabric_sram0_a_tie_low_o),
        .Tile_X11Y10_CONFIGURED_top(configured_i),

        // SRAM 1
        .Tile_X11Y12_A_DOUT_SRAM0(fabric_sram1_a_dout_i[0]),
        .Tile_X11Y12_A_DOUT_SRAM1(fabric_sram1_a_dout_i[1]),
        .Tile_X11Y12_A_DOUT_SRAM2(fabric_sram1_a_dout_i[2]),
        .Tile_X11Y12_A_DOUT_SRAM3(fabric_sram1_a_dout_i[3]),
        .Tile_X11Y12_A_DOUT_SRAM4(fabric_sram1_a_dout_i[4]),
        .Tile_X11Y12_A_DOUT_SRAM5(fabric_sram1_a_dout_i[5]),
        .Tile_X11Y12_A_DOUT_SRAM6(fabric_sram1_a_dout_i[6]),
        .Tile_X11Y12_A_DOUT_SRAM7(fabric_sram1_a_dout_i[7]),
        .Tile_X11Y12_A_ADDR_SRAM0(fabric_sram1_a_addr_o[0]),
        .Tile_X11Y12_A_ADDR_SRAM1(fabric_sram1_a_addr_o[1]),
        .Tile_X11Y12_A_ADDR_SRAM2(fabric_sram1_a_addr_o[2]),
        .Tile_X11Y12_A_ADDR_SRAM3(fabric_sram1_a_addr_o[3]),
        .Tile_X11Y12_A_ADDR_SRAM4(fabric_sram1_a_addr_o[4]),
        .Tile_X11Y12_A_ADDR_SRAM5(fabric_sram1_a_addr_o[5]),
        .Tile_X11Y12_A_ADDR_SRAM6(fabric_sram1_a_addr_o[6]),
        .Tile_X11Y12_A_ADDR_SRAM7(fabric_sram1_a_addr_o[7]),
        .Tile_X11Y12_A_ADDR_SRAM8(fabric_sram1_a_addr_o[8]),
        .Tile_X11Y12_A_ADDR_SRAM9(fabric_sram1_a_addr_o[9]),
        .Tile_X11Y12_A_BM_SRAM0(fabric_sram1_a_bm_o[0]),
        .Tile_X11Y12_A_BM_SRAM1(fabric_sram1_a_bm_o[1]),
        .Tile_X11Y12_A_BM_SRAM2(fabric_sram1_a_bm_o[2]),
        .Tile_X11Y12_A_BM_SRAM3(fabric_sram1_a_bm_o[3]),
        .Tile_X11Y12_A_BM_SRAM4(fabric_sram1_a_bm_o[4]),
        .Tile_X11Y12_A_BM_SRAM5(fabric_sram1_a_bm_o[5]),
        .Tile_X11Y12_A_BM_SRAM6(fabric_sram1_a_bm_o[6]),
        .Tile_X11Y12_A_BM_SRAM7(fabric_sram1_a_bm_o[7]),
        .Tile_X11Y12_A_DIN_SRAM0(fabric_sram1_a_din_o[0]),
        .Tile_X11Y12_A_DIN_SRAM1(fabric_sram1_a_din_o[1]),
        .Tile_X11Y12_A_DIN_SRAM2(fabric_sram1_a_din_o[2]),
        .Tile_X11Y12_A_DIN_SRAM3(fabric_sram1_a_din_o[3]),
        .Tile_X11Y12_A_DIN_SRAM4(fabric_sram1_a_din_o[4]),
        .Tile_X11Y12_A_DIN_SRAM5(fabric_sram1_a_din_o[5]),
        .Tile_X11Y12_A_DIN_SRAM6(fabric_sram1_a_din_o[6]),
        .Tile_X11Y12_A_DIN_SRAM7(fabric_sram1_a_din_o[7]),
        .Tile_X11Y12_A_WEN_SRAM(fabric_sram1_a_wen_o),
        .Tile_X11Y12_A_MEN_SRAM(fabric_sram1_a_men_o),
        .Tile_X11Y12_A_REN_SRAM(fabric_sram1_a_ren_o),
        .Tile_X11Y12_A_CLK_SRAM(fabric_sram1_a_clk_o),
        .Tile_X11Y12_A_TIE_HIGH_SRAM(fabric_sram1_a_tie_high_o),
        .Tile_X11Y12_A_TIE_LOW_SRAM(fabric_sram1_a_tie_low_o),
        .Tile_X11Y12_CONFIGURED_top(configured_i),

    );

------------------ modules ------------------

// SRAM 0 instances

        RM_IHPSG13_1P_1024x32_c2_bm_bist sram0 (
            .A_CLK      (fabric_sram0_a_clk_o),
            .A_MEN      (fabric_sram0_a_men_o),
            .A_WEN      (fabric_sram0_a_wen_o),
            .A_REN      (fabric_sram0_a_ren_o),
            .A_ADDR     (fabric_sram0_a_addr_o),
            .A_DIN      (fabric_sram0_a_din_o),
            .A_DLY      (fabric_sram0_a_tie_high_o),
            .A_DOUT     (fabric_sram0_a_dout_i),
            .A_BM       (fabric_sram0_a_bm_o),

            .A_BIST_EN      (fabric_sram0_a_tie_low_o),
            .A_BIST_CLK     (fabric_sram0_a_tie_low_o),
            .A_BIST_MEN     (fabric_sram0_a_tie_low_o),
            .A_BIST_WEN     (fabric_sram0_a_tie_low_o),
            .A_BIST_REN     (fabric_sram0_a_tie_low_o),
            .A_BIST_ADDR    ({10{fabric_sram0_a_tie_low_o}}),
            .A_BIST_DIN     ({32{fabric_sram0_a_tie_low_o}}),
            .A_BIST_BM      ({32{fabric_sram0_a_tie_low_o}})
        );
        
// SRAM 1 instances

        RM_IHPSG13_1P_1024x32_c2_bm_bist sram1 (
            .A_CLK      (fabric_sram1_a_clk_o),
            .A_MEN      (fabric_sram1_a_men_o),
            .A_WEN      (fabric_sram1_a_wen_o),
            .A_REN      (fabric_sram1_a_ren_o),
            .A_ADDR     (fabric_sram1_a_addr_o),
            .A_DIN      (fabric_sram1_a_din_o),
            .A_DLY      (fabric_sram1_a_tie_high_o),
            .A_DOUT     (fabric_sram1_a_dout_i),
            .A_BM       (fabric_sram1_a_bm_o),

            .A_BIST_EN      (fabric_sram1_a_tie_low_o),
            .A_BIST_CLK     (fabric_sram1_a_tie_low_o),
            .A_BIST_MEN     (fabric_sram1_a_tie_low_o),
            .A_BIST_WEN     (fabric_sram1_a_tie_low_o),
            .A_BIST_REN     (fabric_sram1_a_tie_low_o),
            .A_BIST_ADDR    ({10{fabric_sram1_a_tie_low_o}}),
            .A_BIST_DIN     ({32{fabric_sram1_a_tie_low_o}}),
            .A_BIST_BM      ({32{fabric_sram1_a_tie_low_o}})
        );
        
