module fabric_wrapper #(
    	parameter FrameBitsPerRow = 32,
	parameter MaxFramesPerCol = 20,
	
	parameter NumColumns = 9,
	parameter NumRows = 14,
	
    parameter FABRIC_NUM_IO_WEST = 48
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
    input         fabric_warmboot_reset_i

);

    // SRAM 0
    logic [7:0] fabric_sram0_q_i;
    logic [9-1:0] fabric_sram0_a_o;
    logic [7:0] fabric_sram0_wen_o;
    logic [7:0] fabric_sram0_d_o;
    logic        fabric_sram0_gwen_o;
    logic        fabric_sram0_cen_o;
    logic        fabric_sram0_clk_o;

    // SRAM 1
    logic [7:0] fabric_sram1_q_i;
    logic [9-1:0] fabric_sram1_a_o;
    logic [7:0] fabric_sram1_wen_o;
    logic [7:0] fabric_sram1_d_o;
    logic        fabric_sram1_gwen_o;
    logic        fabric_sram1_cen_o;
    logic        fabric_sram1_clk_o;

    // SRAM 2
    logic [7:0] fabric_sram2_q_i;
    logic [9-1:0] fabric_sram2_a_o;
    logic [7:0] fabric_sram2_wen_o;
    logic [7:0] fabric_sram2_d_o;
    logic        fabric_sram2_gwen_o;
    logic        fabric_sram2_cen_o;
    logic        fabric_sram2_clk_o;

    // SRAM 3
    logic [7:0] fabric_sram3_q_i;
    logic [9-1:0] fabric_sram3_a_o;
    logic [7:0] fabric_sram3_wen_o;
    logic [7:0] fabric_sram3_d_o;
    logic        fabric_sram3_gwen_o;
    logic        fabric_sram3_cen_o;
    logic        fabric_sram3_clk_o;

    // SRAM 4
    logic [7:0] fabric_sram4_q_i;
    logic [9-1:0] fabric_sram4_a_o;
    logic [7:0] fabric_sram4_wen_o;
    logic [7:0] fabric_sram4_d_o;
    logic        fabric_sram4_gwen_o;
    logic        fabric_sram4_cen_o;
    logic        fabric_sram4_clk_o;

    // SRAM 5
    logic [7:0] fabric_sram5_q_i;
    logic [9-1:0] fabric_sram5_a_o;
    logic [7:0] fabric_sram5_wen_o;
    logic [7:0] fabric_sram5_d_o;
    logic        fabric_sram5_gwen_o;
    logic        fabric_sram5_cen_o;
    logic        fabric_sram5_clk_o;

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
        .Tile_X0Y1_A_O_top(fabric_io_west_in_i[47]),
        .Tile_X0Y1_A_I_top(fabric_io_west_out_o[47]),
        .Tile_X0Y1_A_T_top(fabric_io_west_oe_o[47]),

        .Tile_X0Y1_B_O_top(fabric_io_west_in_i[46]),
        .Tile_X0Y1_B_I_top(fabric_io_west_out_o[46]),
        .Tile_X0Y1_B_T_top(fabric_io_west_oe_o[46]),

        .Tile_X0Y1_C_O_top(fabric_io_west_in_i[45]),
        .Tile_X0Y1_C_I_top(fabric_io_west_out_o[45]),
        .Tile_X0Y1_C_T_top(fabric_io_west_oe_o[45]),

        .Tile_X0Y1_D_O_top(fabric_io_west_in_i[44]),
        .Tile_X0Y1_D_I_top(fabric_io_west_out_o[44]),
        .Tile_X0Y1_D_T_top(fabric_io_west_oe_o[44]),

        .Tile_X0Y2_A_O_top(fabric_io_west_in_i[43]),
        .Tile_X0Y2_A_I_top(fabric_io_west_out_o[43]),
        .Tile_X0Y2_A_T_top(fabric_io_west_oe_o[43]),

        .Tile_X0Y2_B_O_top(fabric_io_west_in_i[42]),
        .Tile_X0Y2_B_I_top(fabric_io_west_out_o[42]),
        .Tile_X0Y2_B_T_top(fabric_io_west_oe_o[42]),

        .Tile_X0Y2_C_O_top(fabric_io_west_in_i[41]),
        .Tile_X0Y2_C_I_top(fabric_io_west_out_o[41]),
        .Tile_X0Y2_C_T_top(fabric_io_west_oe_o[41]),

        .Tile_X0Y2_D_O_top(fabric_io_west_in_i[40]),
        .Tile_X0Y2_D_I_top(fabric_io_west_out_o[40]),
        .Tile_X0Y2_D_T_top(fabric_io_west_oe_o[40]),

        .Tile_X0Y3_A_O_top(fabric_io_west_in_i[39]),
        .Tile_X0Y3_A_I_top(fabric_io_west_out_o[39]),
        .Tile_X0Y3_A_T_top(fabric_io_west_oe_o[39]),

        .Tile_X0Y3_B_O_top(fabric_io_west_in_i[38]),
        .Tile_X0Y3_B_I_top(fabric_io_west_out_o[38]),
        .Tile_X0Y3_B_T_top(fabric_io_west_oe_o[38]),

        .Tile_X0Y3_C_O_top(fabric_io_west_in_i[37]),
        .Tile_X0Y3_C_I_top(fabric_io_west_out_o[37]),
        .Tile_X0Y3_C_T_top(fabric_io_west_oe_o[37]),

        .Tile_X0Y3_D_O_top(fabric_io_west_in_i[36]),
        .Tile_X0Y3_D_I_top(fabric_io_west_out_o[36]),
        .Tile_X0Y3_D_T_top(fabric_io_west_oe_o[36]),

        .Tile_X0Y4_A_O_top(fabric_io_west_in_i[35]),
        .Tile_X0Y4_A_I_top(fabric_io_west_out_o[35]),
        .Tile_X0Y4_A_T_top(fabric_io_west_oe_o[35]),

        .Tile_X0Y4_B_O_top(fabric_io_west_in_i[34]),
        .Tile_X0Y4_B_I_top(fabric_io_west_out_o[34]),
        .Tile_X0Y4_B_T_top(fabric_io_west_oe_o[34]),

        .Tile_X0Y4_C_O_top(fabric_io_west_in_i[33]),
        .Tile_X0Y4_C_I_top(fabric_io_west_out_o[33]),
        .Tile_X0Y4_C_T_top(fabric_io_west_oe_o[33]),

        .Tile_X0Y4_D_O_top(fabric_io_west_in_i[32]),
        .Tile_X0Y4_D_I_top(fabric_io_west_out_o[32]),
        .Tile_X0Y4_D_T_top(fabric_io_west_oe_o[32]),

        .Tile_X0Y5_A_O_top(fabric_io_west_in_i[31]),
        .Tile_X0Y5_A_I_top(fabric_io_west_out_o[31]),
        .Tile_X0Y5_A_T_top(fabric_io_west_oe_o[31]),

        .Tile_X0Y5_B_O_top(fabric_io_west_in_i[30]),
        .Tile_X0Y5_B_I_top(fabric_io_west_out_o[30]),
        .Tile_X0Y5_B_T_top(fabric_io_west_oe_o[30]),

        .Tile_X0Y5_C_O_top(fabric_io_west_in_i[29]),
        .Tile_X0Y5_C_I_top(fabric_io_west_out_o[29]),
        .Tile_X0Y5_C_T_top(fabric_io_west_oe_o[29]),

        .Tile_X0Y5_D_O_top(fabric_io_west_in_i[28]),
        .Tile_X0Y5_D_I_top(fabric_io_west_out_o[28]),
        .Tile_X0Y5_D_T_top(fabric_io_west_oe_o[28]),

        .Tile_X0Y6_A_O_top(fabric_io_west_in_i[27]),
        .Tile_X0Y6_A_I_top(fabric_io_west_out_o[27]),
        .Tile_X0Y6_A_T_top(fabric_io_west_oe_o[27]),

        .Tile_X0Y6_B_O_top(fabric_io_west_in_i[26]),
        .Tile_X0Y6_B_I_top(fabric_io_west_out_o[26]),
        .Tile_X0Y6_B_T_top(fabric_io_west_oe_o[26]),

        .Tile_X0Y6_C_O_top(fabric_io_west_in_i[25]),
        .Tile_X0Y6_C_I_top(fabric_io_west_out_o[25]),
        .Tile_X0Y6_C_T_top(fabric_io_west_oe_o[25]),

        .Tile_X0Y6_D_O_top(fabric_io_west_in_i[24]),
        .Tile_X0Y6_D_I_top(fabric_io_west_out_o[24]),
        .Tile_X0Y6_D_T_top(fabric_io_west_oe_o[24]),

        .Tile_X0Y7_A_O_top(fabric_io_west_in_i[23]),
        .Tile_X0Y7_A_I_top(fabric_io_west_out_o[23]),
        .Tile_X0Y7_A_T_top(fabric_io_west_oe_o[23]),

        .Tile_X0Y7_B_O_top(fabric_io_west_in_i[22]),
        .Tile_X0Y7_B_I_top(fabric_io_west_out_o[22]),
        .Tile_X0Y7_B_T_top(fabric_io_west_oe_o[22]),

        .Tile_X0Y7_C_O_top(fabric_io_west_in_i[21]),
        .Tile_X0Y7_C_I_top(fabric_io_west_out_o[21]),
        .Tile_X0Y7_C_T_top(fabric_io_west_oe_o[21]),

        .Tile_X0Y7_D_O_top(fabric_io_west_in_i[20]),
        .Tile_X0Y7_D_I_top(fabric_io_west_out_o[20]),
        .Tile_X0Y7_D_T_top(fabric_io_west_oe_o[20]),

        .Tile_X0Y8_A_O_top(fabric_io_west_in_i[19]),
        .Tile_X0Y8_A_I_top(fabric_io_west_out_o[19]),
        .Tile_X0Y8_A_T_top(fabric_io_west_oe_o[19]),

        .Tile_X0Y8_B_O_top(fabric_io_west_in_i[18]),
        .Tile_X0Y8_B_I_top(fabric_io_west_out_o[18]),
        .Tile_X0Y8_B_T_top(fabric_io_west_oe_o[18]),

        .Tile_X0Y8_C_O_top(fabric_io_west_in_i[17]),
        .Tile_X0Y8_C_I_top(fabric_io_west_out_o[17]),
        .Tile_X0Y8_C_T_top(fabric_io_west_oe_o[17]),

        .Tile_X0Y8_D_O_top(fabric_io_west_in_i[16]),
        .Tile_X0Y8_D_I_top(fabric_io_west_out_o[16]),
        .Tile_X0Y8_D_T_top(fabric_io_west_oe_o[16]),

        .Tile_X0Y9_A_O_top(fabric_io_west_in_i[15]),
        .Tile_X0Y9_A_I_top(fabric_io_west_out_o[15]),
        .Tile_X0Y9_A_T_top(fabric_io_west_oe_o[15]),

        .Tile_X0Y9_B_O_top(fabric_io_west_in_i[14]),
        .Tile_X0Y9_B_I_top(fabric_io_west_out_o[14]),
        .Tile_X0Y9_B_T_top(fabric_io_west_oe_o[14]),

        .Tile_X0Y9_C_O_top(fabric_io_west_in_i[13]),
        .Tile_X0Y9_C_I_top(fabric_io_west_out_o[13]),
        .Tile_X0Y9_C_T_top(fabric_io_west_oe_o[13]),

        .Tile_X0Y9_D_O_top(fabric_io_west_in_i[12]),
        .Tile_X0Y9_D_I_top(fabric_io_west_out_o[12]),
        .Tile_X0Y9_D_T_top(fabric_io_west_oe_o[12]),

        .Tile_X0Y10_A_O_top(fabric_io_west_in_i[11]),
        .Tile_X0Y10_A_I_top(fabric_io_west_out_o[11]),
        .Tile_X0Y10_A_T_top(fabric_io_west_oe_o[11]),

        .Tile_X0Y10_B_O_top(fabric_io_west_in_i[10]),
        .Tile_X0Y10_B_I_top(fabric_io_west_out_o[10]),
        .Tile_X0Y10_B_T_top(fabric_io_west_oe_o[10]),

        .Tile_X0Y10_C_O_top(fabric_io_west_in_i[9]),
        .Tile_X0Y10_C_I_top(fabric_io_west_out_o[9]),
        .Tile_X0Y10_C_T_top(fabric_io_west_oe_o[9]),

        .Tile_X0Y10_D_O_top(fabric_io_west_in_i[8]),
        .Tile_X0Y10_D_I_top(fabric_io_west_out_o[8]),
        .Tile_X0Y10_D_T_top(fabric_io_west_oe_o[8]),

        .Tile_X0Y11_A_O_top(fabric_io_west_in_i[7]),
        .Tile_X0Y11_A_I_top(fabric_io_west_out_o[7]),
        .Tile_X0Y11_A_T_top(fabric_io_west_oe_o[7]),

        .Tile_X0Y11_B_O_top(fabric_io_west_in_i[6]),
        .Tile_X0Y11_B_I_top(fabric_io_west_out_o[6]),
        .Tile_X0Y11_B_T_top(fabric_io_west_oe_o[6]),

        .Tile_X0Y11_C_O_top(fabric_io_west_in_i[5]),
        .Tile_X0Y11_C_I_top(fabric_io_west_out_o[5]),
        .Tile_X0Y11_C_T_top(fabric_io_west_oe_o[5]),

        .Tile_X0Y11_D_O_top(fabric_io_west_in_i[4]),
        .Tile_X0Y11_D_I_top(fabric_io_west_out_o[4]),
        .Tile_X0Y11_D_T_top(fabric_io_west_oe_o[4]),

        .Tile_X0Y12_A_O_top(fabric_io_west_in_i[3]),
        .Tile_X0Y12_A_I_top(fabric_io_west_out_o[3]),
        .Tile_X0Y12_A_T_top(fabric_io_west_oe_o[3]),

        .Tile_X0Y12_B_O_top(fabric_io_west_in_i[2]),
        .Tile_X0Y12_B_I_top(fabric_io_west_out_o[2]),
        .Tile_X0Y12_B_T_top(fabric_io_west_oe_o[2]),

        .Tile_X0Y12_C_O_top(fabric_io_west_in_i[1]),
        .Tile_X0Y12_C_I_top(fabric_io_west_out_o[1]),
        .Tile_X0Y12_C_T_top(fabric_io_west_oe_o[1]),

        .Tile_X0Y12_D_O_top(fabric_io_west_in_i[0]),
        .Tile_X0Y12_D_I_top(fabric_io_west_out_o[0]),
        .Tile_X0Y12_D_T_top(fabric_io_west_oe_o[0]),

        // WARMBOOT
        .Tile_X1Y13_RESET_top(fabric_warmboot_reset_i),
        .Tile_X1Y13_BOOT_top(fabric_warmboot_boot_o),
        .Tile_X1Y13_SLOT_top0(fabric_warmboot_slot_o[0]),
        .Tile_X1Y13_SLOT_top1(fabric_warmboot_slot_o[1]),
        .Tile_X1Y13_SLOT_top2(fabric_warmboot_slot_o[2]),
        .Tile_X1Y13_SLOT_top3(fabric_warmboot_slot_o[3]),
        .Tile_X1Y13_CONFIGURED_top(configured_i),

        // SRAM 0
        .Tile_X8Y2_Q_SRAM0(fabric_sram0_q_i[0]),
        .Tile_X8Y2_Q_SRAM1(fabric_sram0_q_i[1]),
        .Tile_X8Y2_Q_SRAM2(fabric_sram0_q_i[2]),
        .Tile_X8Y2_Q_SRAM3(fabric_sram0_q_i[3]),
        .Tile_X8Y2_Q_SRAM4(fabric_sram0_q_i[4]),
        .Tile_X8Y2_Q_SRAM5(fabric_sram0_q_i[5]),
        .Tile_X8Y2_Q_SRAM6(fabric_sram0_q_i[6]),
        .Tile_X8Y2_Q_SRAM7(fabric_sram0_q_i[7]),
        .Tile_X8Y2_A_SRAM0(fabric_sram0_a_o[0]),
        .Tile_X8Y2_A_SRAM1(fabric_sram0_a_o[1]),
        .Tile_X8Y2_A_SRAM2(fabric_sram0_a_o[2]),
        .Tile_X8Y2_A_SRAM3(fabric_sram0_a_o[3]),
        .Tile_X8Y2_A_SRAM4(fabric_sram0_a_o[4]),
        .Tile_X8Y2_A_SRAM5(fabric_sram0_a_o[5]),
        .Tile_X8Y2_A_SRAM6(fabric_sram0_a_o[6]),
        .Tile_X8Y2_A_SRAM7(fabric_sram0_a_o[7]),
        .Tile_X8Y2_A_SRAM8(fabric_sram0_a_o[8]),
        .Tile_X8Y2_WEN_SRAM0(fabric_sram0_wen_o[0]),
        .Tile_X8Y2_WEN_SRAM1(fabric_sram0_wen_o[1]),
        .Tile_X8Y2_WEN_SRAM2(fabric_sram0_wen_o[2]),
        .Tile_X8Y2_WEN_SRAM3(fabric_sram0_wen_o[3]),
        .Tile_X8Y2_WEN_SRAM4(fabric_sram0_wen_o[4]),
        .Tile_X8Y2_WEN_SRAM5(fabric_sram0_wen_o[5]),
        .Tile_X8Y2_WEN_SRAM6(fabric_sram0_wen_o[6]),
        .Tile_X8Y2_WEN_SRAM7(fabric_sram0_wen_o[7]),
        .Tile_X8Y2_D_SRAM0(fabric_sram0_d_o[0]),
        .Tile_X8Y2_D_SRAM1(fabric_sram0_d_o[1]),
        .Tile_X8Y2_D_SRAM2(fabric_sram0_d_o[2]),
        .Tile_X8Y2_D_SRAM3(fabric_sram0_d_o[3]),
        .Tile_X8Y2_D_SRAM4(fabric_sram0_d_o[4]),
        .Tile_X8Y2_D_SRAM5(fabric_sram0_d_o[5]),
        .Tile_X8Y2_D_SRAM6(fabric_sram0_d_o[6]),
        .Tile_X8Y2_D_SRAM7(fabric_sram0_d_o[7]),
        .Tile_X8Y2_GWEN_SRAM(fabric_sram0_gwen_o),
        .Tile_X8Y2_CEN_SRAM(fabric_sram0_cen_o),
        .Tile_X8Y2_CLK_SRAM(fabric_sram0_clk_o),
        .Tile_X8Y2_CONFIGURED_top(configured_i),

        // SRAM 1
        .Tile_X8Y4_Q_SRAM0(fabric_sram1_q_i[0]),
        .Tile_X8Y4_Q_SRAM1(fabric_sram1_q_i[1]),
        .Tile_X8Y4_Q_SRAM2(fabric_sram1_q_i[2]),
        .Tile_X8Y4_Q_SRAM3(fabric_sram1_q_i[3]),
        .Tile_X8Y4_Q_SRAM4(fabric_sram1_q_i[4]),
        .Tile_X8Y4_Q_SRAM5(fabric_sram1_q_i[5]),
        .Tile_X8Y4_Q_SRAM6(fabric_sram1_q_i[6]),
        .Tile_X8Y4_Q_SRAM7(fabric_sram1_q_i[7]),
        .Tile_X8Y4_A_SRAM0(fabric_sram1_a_o[0]),
        .Tile_X8Y4_A_SRAM1(fabric_sram1_a_o[1]),
        .Tile_X8Y4_A_SRAM2(fabric_sram1_a_o[2]),
        .Tile_X8Y4_A_SRAM3(fabric_sram1_a_o[3]),
        .Tile_X8Y4_A_SRAM4(fabric_sram1_a_o[4]),
        .Tile_X8Y4_A_SRAM5(fabric_sram1_a_o[5]),
        .Tile_X8Y4_A_SRAM6(fabric_sram1_a_o[6]),
        .Tile_X8Y4_A_SRAM7(fabric_sram1_a_o[7]),
        .Tile_X8Y4_A_SRAM8(fabric_sram1_a_o[8]),
        .Tile_X8Y4_WEN_SRAM0(fabric_sram1_wen_o[0]),
        .Tile_X8Y4_WEN_SRAM1(fabric_sram1_wen_o[1]),
        .Tile_X8Y4_WEN_SRAM2(fabric_sram1_wen_o[2]),
        .Tile_X8Y4_WEN_SRAM3(fabric_sram1_wen_o[3]),
        .Tile_X8Y4_WEN_SRAM4(fabric_sram1_wen_o[4]),
        .Tile_X8Y4_WEN_SRAM5(fabric_sram1_wen_o[5]),
        .Tile_X8Y4_WEN_SRAM6(fabric_sram1_wen_o[6]),
        .Tile_X8Y4_WEN_SRAM7(fabric_sram1_wen_o[7]),
        .Tile_X8Y4_D_SRAM0(fabric_sram1_d_o[0]),
        .Tile_X8Y4_D_SRAM1(fabric_sram1_d_o[1]),
        .Tile_X8Y4_D_SRAM2(fabric_sram1_d_o[2]),
        .Tile_X8Y4_D_SRAM3(fabric_sram1_d_o[3]),
        .Tile_X8Y4_D_SRAM4(fabric_sram1_d_o[4]),
        .Tile_X8Y4_D_SRAM5(fabric_sram1_d_o[5]),
        .Tile_X8Y4_D_SRAM6(fabric_sram1_d_o[6]),
        .Tile_X8Y4_D_SRAM7(fabric_sram1_d_o[7]),
        .Tile_X8Y4_GWEN_SRAM(fabric_sram1_gwen_o),
        .Tile_X8Y4_CEN_SRAM(fabric_sram1_cen_o),
        .Tile_X8Y4_CLK_SRAM(fabric_sram1_clk_o),
        .Tile_X8Y4_CONFIGURED_top(configured_i),

        // SRAM 2
        .Tile_X8Y6_Q_SRAM0(fabric_sram2_q_i[0]),
        .Tile_X8Y6_Q_SRAM1(fabric_sram2_q_i[1]),
        .Tile_X8Y6_Q_SRAM2(fabric_sram2_q_i[2]),
        .Tile_X8Y6_Q_SRAM3(fabric_sram2_q_i[3]),
        .Tile_X8Y6_Q_SRAM4(fabric_sram2_q_i[4]),
        .Tile_X8Y6_Q_SRAM5(fabric_sram2_q_i[5]),
        .Tile_X8Y6_Q_SRAM6(fabric_sram2_q_i[6]),
        .Tile_X8Y6_Q_SRAM7(fabric_sram2_q_i[7]),
        .Tile_X8Y6_A_SRAM0(fabric_sram2_a_o[0]),
        .Tile_X8Y6_A_SRAM1(fabric_sram2_a_o[1]),
        .Tile_X8Y6_A_SRAM2(fabric_sram2_a_o[2]),
        .Tile_X8Y6_A_SRAM3(fabric_sram2_a_o[3]),
        .Tile_X8Y6_A_SRAM4(fabric_sram2_a_o[4]),
        .Tile_X8Y6_A_SRAM5(fabric_sram2_a_o[5]),
        .Tile_X8Y6_A_SRAM6(fabric_sram2_a_o[6]),
        .Tile_X8Y6_A_SRAM7(fabric_sram2_a_o[7]),
        .Tile_X8Y6_A_SRAM8(fabric_sram2_a_o[8]),
        .Tile_X8Y6_WEN_SRAM0(fabric_sram2_wen_o[0]),
        .Tile_X8Y6_WEN_SRAM1(fabric_sram2_wen_o[1]),
        .Tile_X8Y6_WEN_SRAM2(fabric_sram2_wen_o[2]),
        .Tile_X8Y6_WEN_SRAM3(fabric_sram2_wen_o[3]),
        .Tile_X8Y6_WEN_SRAM4(fabric_sram2_wen_o[4]),
        .Tile_X8Y6_WEN_SRAM5(fabric_sram2_wen_o[5]),
        .Tile_X8Y6_WEN_SRAM6(fabric_sram2_wen_o[6]),
        .Tile_X8Y6_WEN_SRAM7(fabric_sram2_wen_o[7]),
        .Tile_X8Y6_D_SRAM0(fabric_sram2_d_o[0]),
        .Tile_X8Y6_D_SRAM1(fabric_sram2_d_o[1]),
        .Tile_X8Y6_D_SRAM2(fabric_sram2_d_o[2]),
        .Tile_X8Y6_D_SRAM3(fabric_sram2_d_o[3]),
        .Tile_X8Y6_D_SRAM4(fabric_sram2_d_o[4]),
        .Tile_X8Y6_D_SRAM5(fabric_sram2_d_o[5]),
        .Tile_X8Y6_D_SRAM6(fabric_sram2_d_o[6]),
        .Tile_X8Y6_D_SRAM7(fabric_sram2_d_o[7]),
        .Tile_X8Y6_GWEN_SRAM(fabric_sram2_gwen_o),
        .Tile_X8Y6_CEN_SRAM(fabric_sram2_cen_o),
        .Tile_X8Y6_CLK_SRAM(fabric_sram2_clk_o),
        .Tile_X8Y6_CONFIGURED_top(configured_i),

        // SRAM 3
        .Tile_X8Y8_Q_SRAM0(fabric_sram3_q_i[0]),
        .Tile_X8Y8_Q_SRAM1(fabric_sram3_q_i[1]),
        .Tile_X8Y8_Q_SRAM2(fabric_sram3_q_i[2]),
        .Tile_X8Y8_Q_SRAM3(fabric_sram3_q_i[3]),
        .Tile_X8Y8_Q_SRAM4(fabric_sram3_q_i[4]),
        .Tile_X8Y8_Q_SRAM5(fabric_sram3_q_i[5]),
        .Tile_X8Y8_Q_SRAM6(fabric_sram3_q_i[6]),
        .Tile_X8Y8_Q_SRAM7(fabric_sram3_q_i[7]),
        .Tile_X8Y8_A_SRAM0(fabric_sram3_a_o[0]),
        .Tile_X8Y8_A_SRAM1(fabric_sram3_a_o[1]),
        .Tile_X8Y8_A_SRAM2(fabric_sram3_a_o[2]),
        .Tile_X8Y8_A_SRAM3(fabric_sram3_a_o[3]),
        .Tile_X8Y8_A_SRAM4(fabric_sram3_a_o[4]),
        .Tile_X8Y8_A_SRAM5(fabric_sram3_a_o[5]),
        .Tile_X8Y8_A_SRAM6(fabric_sram3_a_o[6]),
        .Tile_X8Y8_A_SRAM7(fabric_sram3_a_o[7]),
        .Tile_X8Y8_A_SRAM8(fabric_sram3_a_o[8]),
        .Tile_X8Y8_WEN_SRAM0(fabric_sram3_wen_o[0]),
        .Tile_X8Y8_WEN_SRAM1(fabric_sram3_wen_o[1]),
        .Tile_X8Y8_WEN_SRAM2(fabric_sram3_wen_o[2]),
        .Tile_X8Y8_WEN_SRAM3(fabric_sram3_wen_o[3]),
        .Tile_X8Y8_WEN_SRAM4(fabric_sram3_wen_o[4]),
        .Tile_X8Y8_WEN_SRAM5(fabric_sram3_wen_o[5]),
        .Tile_X8Y8_WEN_SRAM6(fabric_sram3_wen_o[6]),
        .Tile_X8Y8_WEN_SRAM7(fabric_sram3_wen_o[7]),
        .Tile_X8Y8_D_SRAM0(fabric_sram3_d_o[0]),
        .Tile_X8Y8_D_SRAM1(fabric_sram3_d_o[1]),
        .Tile_X8Y8_D_SRAM2(fabric_sram3_d_o[2]),
        .Tile_X8Y8_D_SRAM3(fabric_sram3_d_o[3]),
        .Tile_X8Y8_D_SRAM4(fabric_sram3_d_o[4]),
        .Tile_X8Y8_D_SRAM5(fabric_sram3_d_o[5]),
        .Tile_X8Y8_D_SRAM6(fabric_sram3_d_o[6]),
        .Tile_X8Y8_D_SRAM7(fabric_sram3_d_o[7]),
        .Tile_X8Y8_GWEN_SRAM(fabric_sram3_gwen_o),
        .Tile_X8Y8_CEN_SRAM(fabric_sram3_cen_o),
        .Tile_X8Y8_CLK_SRAM(fabric_sram3_clk_o),
        .Tile_X8Y8_CONFIGURED_top(configured_i),

        // SRAM 4
        .Tile_X8Y10_Q_SRAM0(fabric_sram4_q_i[0]),
        .Tile_X8Y10_Q_SRAM1(fabric_sram4_q_i[1]),
        .Tile_X8Y10_Q_SRAM2(fabric_sram4_q_i[2]),
        .Tile_X8Y10_Q_SRAM3(fabric_sram4_q_i[3]),
        .Tile_X8Y10_Q_SRAM4(fabric_sram4_q_i[4]),
        .Tile_X8Y10_Q_SRAM5(fabric_sram4_q_i[5]),
        .Tile_X8Y10_Q_SRAM6(fabric_sram4_q_i[6]),
        .Tile_X8Y10_Q_SRAM7(fabric_sram4_q_i[7]),
        .Tile_X8Y10_A_SRAM0(fabric_sram4_a_o[0]),
        .Tile_X8Y10_A_SRAM1(fabric_sram4_a_o[1]),
        .Tile_X8Y10_A_SRAM2(fabric_sram4_a_o[2]),
        .Tile_X8Y10_A_SRAM3(fabric_sram4_a_o[3]),
        .Tile_X8Y10_A_SRAM4(fabric_sram4_a_o[4]),
        .Tile_X8Y10_A_SRAM5(fabric_sram4_a_o[5]),
        .Tile_X8Y10_A_SRAM6(fabric_sram4_a_o[6]),
        .Tile_X8Y10_A_SRAM7(fabric_sram4_a_o[7]),
        .Tile_X8Y10_A_SRAM8(fabric_sram4_a_o[8]),
        .Tile_X8Y10_WEN_SRAM0(fabric_sram4_wen_o[0]),
        .Tile_X8Y10_WEN_SRAM1(fabric_sram4_wen_o[1]),
        .Tile_X8Y10_WEN_SRAM2(fabric_sram4_wen_o[2]),
        .Tile_X8Y10_WEN_SRAM3(fabric_sram4_wen_o[3]),
        .Tile_X8Y10_WEN_SRAM4(fabric_sram4_wen_o[4]),
        .Tile_X8Y10_WEN_SRAM5(fabric_sram4_wen_o[5]),
        .Tile_X8Y10_WEN_SRAM6(fabric_sram4_wen_o[6]),
        .Tile_X8Y10_WEN_SRAM7(fabric_sram4_wen_o[7]),
        .Tile_X8Y10_D_SRAM0(fabric_sram4_d_o[0]),
        .Tile_X8Y10_D_SRAM1(fabric_sram4_d_o[1]),
        .Tile_X8Y10_D_SRAM2(fabric_sram4_d_o[2]),
        .Tile_X8Y10_D_SRAM3(fabric_sram4_d_o[3]),
        .Tile_X8Y10_D_SRAM4(fabric_sram4_d_o[4]),
        .Tile_X8Y10_D_SRAM5(fabric_sram4_d_o[5]),
        .Tile_X8Y10_D_SRAM6(fabric_sram4_d_o[6]),
        .Tile_X8Y10_D_SRAM7(fabric_sram4_d_o[7]),
        .Tile_X8Y10_GWEN_SRAM(fabric_sram4_gwen_o),
        .Tile_X8Y10_CEN_SRAM(fabric_sram4_cen_o),
        .Tile_X8Y10_CLK_SRAM(fabric_sram4_clk_o),
        .Tile_X8Y10_CONFIGURED_top(configured_i),

        // SRAM 5
        .Tile_X8Y12_Q_SRAM0(fabric_sram5_q_i[0]),
        .Tile_X8Y12_Q_SRAM1(fabric_sram5_q_i[1]),
        .Tile_X8Y12_Q_SRAM2(fabric_sram5_q_i[2]),
        .Tile_X8Y12_Q_SRAM3(fabric_sram5_q_i[3]),
        .Tile_X8Y12_Q_SRAM4(fabric_sram5_q_i[4]),
        .Tile_X8Y12_Q_SRAM5(fabric_sram5_q_i[5]),
        .Tile_X8Y12_Q_SRAM6(fabric_sram5_q_i[6]),
        .Tile_X8Y12_Q_SRAM7(fabric_sram5_q_i[7]),
        .Tile_X8Y12_A_SRAM0(fabric_sram5_a_o[0]),
        .Tile_X8Y12_A_SRAM1(fabric_sram5_a_o[1]),
        .Tile_X8Y12_A_SRAM2(fabric_sram5_a_o[2]),
        .Tile_X8Y12_A_SRAM3(fabric_sram5_a_o[3]),
        .Tile_X8Y12_A_SRAM4(fabric_sram5_a_o[4]),
        .Tile_X8Y12_A_SRAM5(fabric_sram5_a_o[5]),
        .Tile_X8Y12_A_SRAM6(fabric_sram5_a_o[6]),
        .Tile_X8Y12_A_SRAM7(fabric_sram5_a_o[7]),
        .Tile_X8Y12_A_SRAM8(fabric_sram5_a_o[8]),
        .Tile_X8Y12_WEN_SRAM0(fabric_sram5_wen_o[0]),
        .Tile_X8Y12_WEN_SRAM1(fabric_sram5_wen_o[1]),
        .Tile_X8Y12_WEN_SRAM2(fabric_sram5_wen_o[2]),
        .Tile_X8Y12_WEN_SRAM3(fabric_sram5_wen_o[3]),
        .Tile_X8Y12_WEN_SRAM4(fabric_sram5_wen_o[4]),
        .Tile_X8Y12_WEN_SRAM5(fabric_sram5_wen_o[5]),
        .Tile_X8Y12_WEN_SRAM6(fabric_sram5_wen_o[6]),
        .Tile_X8Y12_WEN_SRAM7(fabric_sram5_wen_o[7]),
        .Tile_X8Y12_D_SRAM0(fabric_sram5_d_o[0]),
        .Tile_X8Y12_D_SRAM1(fabric_sram5_d_o[1]),
        .Tile_X8Y12_D_SRAM2(fabric_sram5_d_o[2]),
        .Tile_X8Y12_D_SRAM3(fabric_sram5_d_o[3]),
        .Tile_X8Y12_D_SRAM4(fabric_sram5_d_o[4]),
        .Tile_X8Y12_D_SRAM5(fabric_sram5_d_o[5]),
        .Tile_X8Y12_D_SRAM6(fabric_sram5_d_o[6]),
        .Tile_X8Y12_D_SRAM7(fabric_sram5_d_o[7]),
        .Tile_X8Y12_GWEN_SRAM(fabric_sram5_gwen_o),
        .Tile_X8Y12_CEN_SRAM(fabric_sram5_cen_o),
        .Tile_X8Y12_CLK_SRAM(fabric_sram5_clk_o),
        .Tile_X8Y12_CONFIGURED_top(configured_i)

    );

    // SRAM 0 instance

    gf180mcu_fd_ip_sram__sram512x8m8wm1 sram_0 (
      .CLK      (fabric_sram0_clk_o),
      .CEN      (fabric_sram0_cen_o),   //Chip Enable
      .GWEN     (fabric_sram0_gwen_o),  //Global Write Enable
      .WEN      (fabric_sram0_wen_o),   //Write Enable
      .A        (fabric_sram0_a_o),
      .D        (fabric_sram0_d_o),
      .Q        (fabric_sram0_q_i)
    );
        
    // SRAM 1 instance

    gf180mcu_fd_ip_sram__sram512x8m8wm1 sram_1 (
      .CLK      (fabric_sram1_clk_o),
      .CEN      (fabric_sram1_cen_o),   //Chip Enable
      .GWEN     (fabric_sram1_gwen_o),  //Global Write Enable
      .WEN      (fabric_sram1_wen_o),   //Write Enable
      .A        (fabric_sram1_a_o),
      .D        (fabric_sram1_d_o),
      .Q        (fabric_sram1_q_i)
    );
        
    // SRAM 2 instance

    gf180mcu_fd_ip_sram__sram512x8m8wm1 sram_2 (
      .CLK      (fabric_sram2_clk_o),
      .CEN      (fabric_sram2_cen_o),   //Chip Enable
      .GWEN     (fabric_sram2_gwen_o),  //Global Write Enable
      .WEN      (fabric_sram2_wen_o),   //Write Enable
      .A        (fabric_sram2_a_o),
      .D        (fabric_sram2_d_o),
      .Q        (fabric_sram2_q_i)
    );
        
    // SRAM 3 instance

    gf180mcu_fd_ip_sram__sram512x8m8wm1 sram_3 (
      .CLK      (fabric_sram3_clk_o),
      .CEN      (fabric_sram3_cen_o),   //Chip Enable
      .GWEN     (fabric_sram3_gwen_o),  //Global Write Enable
      .WEN      (fabric_sram3_wen_o),   //Write Enable
      .A        (fabric_sram3_a_o),
      .D        (fabric_sram3_d_o),
      .Q        (fabric_sram3_q_i)
    );
        
    // SRAM 4 instance

    gf180mcu_fd_ip_sram__sram512x8m8wm1 sram_4 (
      .CLK      (fabric_sram4_clk_o),
      .CEN      (fabric_sram4_cen_o),   //Chip Enable
      .GWEN     (fabric_sram4_gwen_o),  //Global Write Enable
      .WEN      (fabric_sram4_wen_o),   //Write Enable
      .A        (fabric_sram4_a_o),
      .D        (fabric_sram4_d_o),
      .Q        (fabric_sram4_q_i)
    );
        
    // SRAM 5 instance

    gf180mcu_fd_ip_sram__sram512x8m8wm1 sram_5 (
      .CLK      (fabric_sram5_clk_o),
      .CEN      (fabric_sram5_cen_o),   //Chip Enable
      .GWEN     (fabric_sram5_gwen_o),  //Global Write Enable
      .WEN      (fabric_sram5_wen_o),   //Write Enable
      .A        (fabric_sram5_a_o),
      .D        (fabric_sram5_d_o),
      .Q        (fabric_sram5_q_i)
    );
        
endmodule
