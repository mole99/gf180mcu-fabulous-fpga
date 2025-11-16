// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);

    wire [15:0] bram0_a_do, bram1_a_do, bram2_a_do, bram3_a_do;
    wire [15:0] bram0_b_do, bram1_b_do, bram2_b_do, bram3_b_do;
    
    wire [15:0] sram_do;
    wire bram0_a_en, bram1_a_en, bram2_a_en, bram3_a_en;
    wire bram0_b_en, bram1_b_en, bram2_b_en, bram3_b_en;
    
    assign bram0_a_en = io_in[29:26] == 4'd0;
    assign bram1_a_en = io_in[29:26] == 4'd1;
    assign bram2_a_en = io_in[29:26] == 4'd2;
    assign bram3_a_en = io_in[29:26] == 4'd3;
    assign bram0_b_en = io_in[29:26] == 4'd4;
    assign bram1_b_en = io_in[29:26] == 4'd5;
    assign bram2_b_en = io_in[29:26] == 4'd6;
    assign bram3_b_en = io_in[29:26] == 4'd7; 

    wire write_enable, read_enable;

    assign write_enable = io_in[30];
    assign read_enable = io_in[31];

    IHP_BRAM_1024x16_wrapper0 bram0 (
        .A_ADDR    (io_in[25:16]),
        .A_BM      (16'hFFFF),
        .A_DIN     (io_in[15:0]),
        .A_WEN     (write_enable),
        .A_MEN     (bram0_a_en),
        .A_REN     (read_enable),
        .A_DOUT    (bram0_a_do),
        
        .B_ADDR    (io_in[25:16]),
        .B_BM      (16'hFFFF),
        .B_DIN     (io_in[15:0]),
        .B_WEN     (write_enable && bram0_a_en),
        .B_MEN     (1'b1),
        .B_REN     (read_enable && bram0_b_en),
        .B_DOUT    (bram0_b_do)
    );

    IHP_BRAM_1024x16_wrapper1 bram1 (
        .A_ADDR    (io_in[25:16]),
        .A_BM      (16'hFFFF),
        .A_DIN     (io_in[15:0]),
        .A_WEN     (write_enable),
        .A_MEN     (bram1_a_en),
        .A_REN     (read_enable),
        .A_DOUT    (bram1_a_do),
        
        .B_ADDR    (io_in[25:16]),
        .B_BM      (16'hFFFF),
        .B_DIN     (io_in[15:0]),
        .B_WEN     (write_enable && bram1_a_en),
        .B_MEN     (1'b1),
        .B_REN     (read_enable && bram1_b_en),
        .B_DOUT    (bram1_b_do)
    );

    IHP_BRAM_1024x16_wrapper2 bram2 (
        .A_ADDR    (io_in[25:16]),
        .A_BM      (16'hFFFF),
        .A_DIN     (io_in[15:0]),
        .A_WEN     (write_enable),
        .A_MEN     (bram2_a_en),
        .A_REN     (read_enable),
        .A_DOUT    (bram2_a_do),
        
        .B_ADDR    (io_in[25:16]),
        .B_BM      (16'hFFFF),
        .B_DIN     (io_in[15:0]),
        .B_WEN     (write_enable && bram2_a_en),
        .B_MEN     (1'b1),
        .B_REN     (read_enable && bram2_b_en),
        .B_DOUT    (bram2_b_do)
    );

    IHP_BRAM_1024x16_wrapper3 bram3 (
        .A_ADDR    (io_in[25:16]),
        .A_BM      (16'hFFFF),
        .A_DIN     (io_in[15:0]),
        .A_WEN     (write_enable),
        .A_MEN     (bram3_a_en),
        .A_REN     (read_enable),
        .A_DOUT    (bram3_a_do),
        
        .B_ADDR    (io_in[25:16]),
        .B_BM      (16'hFFFF),
        .B_DIN     (io_in[15:0]),
        .B_WEN     (write_enable && bram3_a_en),
        .B_MEN     (1'b1),
        .B_REN     (read_enable && bram3_b_en),
        .B_DOUT    (bram3_b_do)
    );

    always_comb begin
        case (io_in[29:26])
            4'd0:  sram_do = bram0_a_do;
            4'd1:  sram_do = bram1_a_do;
            4'd2:  sram_do = bram2_a_do;
            4'd3:  sram_do = bram3_a_do;
            4'd4:  sram_do = bram0_b_do;
            4'd5:  sram_do = bram1_b_do;
            4'd6:  sram_do = bram2_b_do;
            4'd7:  sram_do = bram3_b_do;
            default: sram_do = 'x;
        endcase
    end
    
    assign io_out = {16'd0, sram_do};

endmodule

module IHP_BRAM_1024x16_wrapper0 (
    input  [ 9:0] A_ADDR,
    input  [16:0] A_BM,
    input  [16:0] A_DIN,
    input         A_WEN,
    input         A_MEN,
    input         A_REN,
    output [16:0] A_DOUT,

    input  [ 9:0] B_ADDR,
    input  [16:0] B_BM,
    input  [16:0] B_DIN,
    input         B_WEN,
    input         B_MEN,
    input         B_REN,
    output [16:0] B_DOUT
);

    (* keep, BEL="X11Y2.A" *)
    IHP_BRAM_1024x16 i_IHP_BRAM_1024x16 (
        .A_ADDR0 (A_ADDR[0]),
        .A_ADDR1 (A_ADDR[1]),
        .A_ADDR2 (A_ADDR[2]),
        .A_ADDR3 (A_ADDR[3]),
        .A_ADDR4 (A_ADDR[4]),
        .A_ADDR5 (A_ADDR[5]),
        .A_ADDR6 (A_ADDR[6]),
        .A_ADDR7 (A_ADDR[7]),
        .A_ADDR8 (A_ADDR[8]),
        .A_ADDR9 (A_ADDR[9]),

        .A_BM0 (A_BM[0]),
        .A_BM1 (A_BM[1]),
        .A_BM2 (A_BM[2]),
        .A_BM3 (A_BM[3]),
        .A_BM4 (A_BM[4]),
        .A_BM5 (A_BM[5]),
        .A_BM6 (A_BM[6]),
        .A_BM7 (A_BM[7]),
        .A_BM8 (A_BM[8]),
        .A_BM9 (A_BM[9]),
        .A_BM10 (A_BM[10]),
        .A_BM11 (A_BM[11]),
        .A_BM12 (A_BM[12]),
        .A_BM13 (A_BM[13]),
        .A_BM14 (A_BM[14]),
        .A_BM15 (A_BM[15]),

        .A_DIN0 (A_DIN[0]),
        .A_DIN1 (A_DIN[1]),
        .A_DIN2 (A_DIN[2]),
        .A_DIN3 (A_DIN[3]),
        .A_DIN4 (A_DIN[4]),
        .A_DIN5 (A_DIN[5]),
        .A_DIN6 (A_DIN[6]),
        .A_DIN7 (A_DIN[7]),
        .A_DIN8 (A_DIN[8]),
        .A_DIN9 (A_DIN[9]),
        .A_DIN10 (A_DIN[10]),
        .A_DIN11 (A_DIN[11]),
        .A_DIN12 (A_DIN[12]),
        .A_DIN13 (A_DIN[13]),
        .A_DIN14 (A_DIN[14]),
        .A_DIN15 (A_DIN[15]),

        .A_WEN (A_WEN),
        .A_MEN (A_MEN),
        .A_REN (A_REN),

        .A_DOUT0 (A_DOUT[0]),
        .A_DOUT1 (A_DOUT[1]),
        .A_DOUT2 (A_DOUT[2]),
        .A_DOUT3 (A_DOUT[3]),
        .A_DOUT4 (A_DOUT[4]),
        .A_DOUT5 (A_DOUT[5]),
        .A_DOUT6 (A_DOUT[6]),
        .A_DOUT7 (A_DOUT[7]),
        .A_DOUT8 (A_DOUT[8]),
        .A_DOUT9 (A_DOUT[9]),
        .A_DOUT10 (A_DOUT[10]),
        .A_DOUT11 (A_DOUT[11]),
        .A_DOUT12 (A_DOUT[12]),
        .A_DOUT13 (A_DOUT[13]),
        .A_DOUT14 (A_DOUT[14]),
        .A_DOUT15 (A_DOUT[15]),

        .B_ADDR0 (B_ADDR[0]),
        .B_ADDR1 (B_ADDR[1]),
        .B_ADDR2 (B_ADDR[2]),
        .B_ADDR3 (B_ADDR[3]),
        .B_ADDR4 (B_ADDR[4]),
        .B_ADDR5 (B_ADDR[5]),
        .B_ADDR6 (B_ADDR[6]),
        .B_ADDR7 (B_ADDR[7]),
        .B_ADDR8 (B_ADDR[8]),
        .B_ADDR9 (B_ADDR[9]),

        .B_BM0 (B_BM[0]),
        .B_BM1 (B_BM[1]),
        .B_BM2 (B_BM[2]),
        .B_BM3 (B_BM[3]),
        .B_BM4 (B_BM[4]),
        .B_BM5 (B_BM[5]),
        .B_BM6 (B_BM[6]),
        .B_BM7 (B_BM[7]),
        .B_BM8 (B_BM[8]),
        .B_BM9 (B_BM[9]),
        .B_BM10 (B_BM[10]),
        .B_BM11 (B_BM[11]),
        .B_BM12 (B_BM[12]),
        .B_BM13 (B_BM[13]),
        .B_BM14 (B_BM[14]),
        .B_BM15 (B_BM[15]),

        .B_DIN0 (B_DIN[0]),
        .B_DIN1 (B_DIN[1]),
        .B_DIN2 (B_DIN[2]),
        .B_DIN3 (B_DIN[3]),
        .B_DIN4 (B_DIN[4]),
        .B_DIN5 (B_DIN[5]),
        .B_DIN6 (B_DIN[6]),
        .B_DIN7 (B_DIN[7]),
        .B_DIN8 (B_DIN[8]),
        .B_DIN9 (B_DIN[9]),
        .B_DIN10 (B_DIN[10]),
        .B_DIN11 (B_DIN[11]),
        .B_DIN12 (B_DIN[12]),
        .B_DIN13 (B_DIN[13]),
        .B_DIN14 (B_DIN[14]),
        .B_DIN15 (B_DIN[15]),

        .B_WEN (B_WEN),
        .B_MEN (B_MEN),
        .B_REN (B_REN),

        .B_DOUT0 (B_DOUT[0]),
        .B_DOUT1 (B_DOUT[1]),
        .B_DOUT2 (B_DOUT[2]),
        .B_DOUT3 (B_DOUT[3]),
        .B_DOUT4 (B_DOUT[4]),
        .B_DOUT5 (B_DOUT[5]),
        .B_DOUT6 (B_DOUT[6]),
        .B_DOUT7 (B_DOUT[7]),
        .B_DOUT8 (B_DOUT[8]),
        .B_DOUT9 (B_DOUT[9]),
        .B_DOUT10 (B_DOUT[10]),
        .B_DOUT11 (B_DOUT[11]),
        .B_DOUT12 (B_DOUT[12]),
        .B_DOUT13 (B_DOUT[13]),
        .B_DOUT14 (B_DOUT[14]),
        .B_DOUT15 (B_DOUT[15])
    );

endmodule

module IHP_BRAM_1024x16_wrapper1 (
    input  [ 9:0] A_ADDR,
    input  [16:0] A_BM,
    input  [16:0] A_DIN,
    input         A_WEN,
    input         A_MEN,
    input         A_REN,
    output [16:0] A_DOUT,

    input  [ 9:0] B_ADDR,
    input  [16:0] B_BM,
    input  [16:0] B_DIN,
    input         B_WEN,
    input         B_MEN,
    input         B_REN,
    output [16:0] B_DOUT
);

    (* keep, BEL="X11Y4.A" *)
    IHP_BRAM_1024x16 i_IHP_BRAM_1024x16 (
        .A_ADDR0 (A_ADDR[0]),
        .A_ADDR1 (A_ADDR[1]),
        .A_ADDR2 (A_ADDR[2]),
        .A_ADDR3 (A_ADDR[3]),
        .A_ADDR4 (A_ADDR[4]),
        .A_ADDR5 (A_ADDR[5]),
        .A_ADDR6 (A_ADDR[6]),
        .A_ADDR7 (A_ADDR[7]),
        .A_ADDR8 (A_ADDR[8]),
        .A_ADDR9 (A_ADDR[9]),

        .A_BM0 (A_BM[0]),
        .A_BM1 (A_BM[1]),
        .A_BM2 (A_BM[2]),
        .A_BM3 (A_BM[3]),
        .A_BM4 (A_BM[4]),
        .A_BM5 (A_BM[5]),
        .A_BM6 (A_BM[6]),
        .A_BM7 (A_BM[7]),
        .A_BM8 (A_BM[8]),
        .A_BM9 (A_BM[9]),
        .A_BM10 (A_BM[10]),
        .A_BM11 (A_BM[11]),
        .A_BM12 (A_BM[12]),
        .A_BM13 (A_BM[13]),
        .A_BM14 (A_BM[14]),
        .A_BM15 (A_BM[15]),

        .A_DIN0 (A_DIN[0]),
        .A_DIN1 (A_DIN[1]),
        .A_DIN2 (A_DIN[2]),
        .A_DIN3 (A_DIN[3]),
        .A_DIN4 (A_DIN[4]),
        .A_DIN5 (A_DIN[5]),
        .A_DIN6 (A_DIN[6]),
        .A_DIN7 (A_DIN[7]),
        .A_DIN8 (A_DIN[8]),
        .A_DIN9 (A_DIN[9]),
        .A_DIN10 (A_DIN[10]),
        .A_DIN11 (A_DIN[11]),
        .A_DIN12 (A_DIN[12]),
        .A_DIN13 (A_DIN[13]),
        .A_DIN14 (A_DIN[14]),
        .A_DIN15 (A_DIN[15]),

        .A_WEN (A_WEN),
        .A_MEN (A_MEN),
        .A_REN (A_REN),

        .A_DOUT0 (A_DOUT[0]),
        .A_DOUT1 (A_DOUT[1]),
        .A_DOUT2 (A_DOUT[2]),
        .A_DOUT3 (A_DOUT[3]),
        .A_DOUT4 (A_DOUT[4]),
        .A_DOUT5 (A_DOUT[5]),
        .A_DOUT6 (A_DOUT[6]),
        .A_DOUT7 (A_DOUT[7]),
        .A_DOUT8 (A_DOUT[8]),
        .A_DOUT9 (A_DOUT[9]),
        .A_DOUT10 (A_DOUT[10]),
        .A_DOUT11 (A_DOUT[11]),
        .A_DOUT12 (A_DOUT[12]),
        .A_DOUT13 (A_DOUT[13]),
        .A_DOUT14 (A_DOUT[14]),
        .A_DOUT15 (A_DOUT[15]),

        .B_ADDR0 (B_ADDR[0]),
        .B_ADDR1 (B_ADDR[1]),
        .B_ADDR2 (B_ADDR[2]),
        .B_ADDR3 (B_ADDR[3]),
        .B_ADDR4 (B_ADDR[4]),
        .B_ADDR5 (B_ADDR[5]),
        .B_ADDR6 (B_ADDR[6]),
        .B_ADDR7 (B_ADDR[7]),
        .B_ADDR8 (B_ADDR[8]),
        .B_ADDR9 (B_ADDR[9]),

        .B_BM0 (B_BM[0]),
        .B_BM1 (B_BM[1]),
        .B_BM2 (B_BM[2]),
        .B_BM3 (B_BM[3]),
        .B_BM4 (B_BM[4]),
        .B_BM5 (B_BM[5]),
        .B_BM6 (B_BM[6]),
        .B_BM7 (B_BM[7]),
        .B_BM8 (B_BM[8]),
        .B_BM9 (B_BM[9]),
        .B_BM10 (B_BM[10]),
        .B_BM11 (B_BM[11]),
        .B_BM12 (B_BM[12]),
        .B_BM13 (B_BM[13]),
        .B_BM14 (B_BM[14]),
        .B_BM15 (B_BM[15]),

        .B_DIN0 (B_DIN[0]),
        .B_DIN1 (B_DIN[1]),
        .B_DIN2 (B_DIN[2]),
        .B_DIN3 (B_DIN[3]),
        .B_DIN4 (B_DIN[4]),
        .B_DIN5 (B_DIN[5]),
        .B_DIN6 (B_DIN[6]),
        .B_DIN7 (B_DIN[7]),
        .B_DIN8 (B_DIN[8]),
        .B_DIN9 (B_DIN[9]),
        .B_DIN10 (B_DIN[10]),
        .B_DIN11 (B_DIN[11]),
        .B_DIN12 (B_DIN[12]),
        .B_DIN13 (B_DIN[13]),
        .B_DIN14 (B_DIN[14]),
        .B_DIN15 (B_DIN[15]),

        .B_WEN (B_WEN),
        .B_MEN (B_MEN),
        .B_REN (B_REN),

        .B_DOUT0 (B_DOUT[0]),
        .B_DOUT1 (B_DOUT[1]),
        .B_DOUT2 (B_DOUT[2]),
        .B_DOUT3 (B_DOUT[3]),
        .B_DOUT4 (B_DOUT[4]),
        .B_DOUT5 (B_DOUT[5]),
        .B_DOUT6 (B_DOUT[6]),
        .B_DOUT7 (B_DOUT[7]),
        .B_DOUT8 (B_DOUT[8]),
        .B_DOUT9 (B_DOUT[9]),
        .B_DOUT10 (B_DOUT[10]),
        .B_DOUT11 (B_DOUT[11]),
        .B_DOUT12 (B_DOUT[12]),
        .B_DOUT13 (B_DOUT[13]),
        .B_DOUT14 (B_DOUT[14]),
        .B_DOUT15 (B_DOUT[15])
    );

endmodule

module IHP_BRAM_1024x16_wrapper2 (
    input  [ 9:0] A_ADDR,
    input  [16:0] A_BM,
    input  [16:0] A_DIN,
    input         A_WEN,
    input         A_MEN,
    input         A_REN,
    output [16:0] A_DOUT,

    input  [ 9:0] B_ADDR,
    input  [16:0] B_BM,
    input  [16:0] B_DIN,
    input         B_WEN,
    input         B_MEN,
    input         B_REN,
    output [16:0] B_DOUT
);

    (* keep, BEL="X11Y6.A" *)
    IHP_BRAM_1024x16 i_IHP_BRAM_1024x16 (
        .A_ADDR0 (A_ADDR[0]),
        .A_ADDR1 (A_ADDR[1]),
        .A_ADDR2 (A_ADDR[2]),
        .A_ADDR3 (A_ADDR[3]),
        .A_ADDR4 (A_ADDR[4]),
        .A_ADDR5 (A_ADDR[5]),
        .A_ADDR6 (A_ADDR[6]),
        .A_ADDR7 (A_ADDR[7]),
        .A_ADDR8 (A_ADDR[8]),
        .A_ADDR9 (A_ADDR[9]),

        .A_BM0 (A_BM[0]),
        .A_BM1 (A_BM[1]),
        .A_BM2 (A_BM[2]),
        .A_BM3 (A_BM[3]),
        .A_BM4 (A_BM[4]),
        .A_BM5 (A_BM[5]),
        .A_BM6 (A_BM[6]),
        .A_BM7 (A_BM[7]),
        .A_BM8 (A_BM[8]),
        .A_BM9 (A_BM[9]),
        .A_BM10 (A_BM[10]),
        .A_BM11 (A_BM[11]),
        .A_BM12 (A_BM[12]),
        .A_BM13 (A_BM[13]),
        .A_BM14 (A_BM[14]),
        .A_BM15 (A_BM[15]),

        .A_DIN0 (A_DIN[0]),
        .A_DIN1 (A_DIN[1]),
        .A_DIN2 (A_DIN[2]),
        .A_DIN3 (A_DIN[3]),
        .A_DIN4 (A_DIN[4]),
        .A_DIN5 (A_DIN[5]),
        .A_DIN6 (A_DIN[6]),
        .A_DIN7 (A_DIN[7]),
        .A_DIN8 (A_DIN[8]),
        .A_DIN9 (A_DIN[9]),
        .A_DIN10 (A_DIN[10]),
        .A_DIN11 (A_DIN[11]),
        .A_DIN12 (A_DIN[12]),
        .A_DIN13 (A_DIN[13]),
        .A_DIN14 (A_DIN[14]),
        .A_DIN15 (A_DIN[15]),

        .A_WEN (A_WEN),
        .A_MEN (A_MEN),
        .A_REN (A_REN),

        .A_DOUT0 (A_DOUT[0]),
        .A_DOUT1 (A_DOUT[1]),
        .A_DOUT2 (A_DOUT[2]),
        .A_DOUT3 (A_DOUT[3]),
        .A_DOUT4 (A_DOUT[4]),
        .A_DOUT5 (A_DOUT[5]),
        .A_DOUT6 (A_DOUT[6]),
        .A_DOUT7 (A_DOUT[7]),
        .A_DOUT8 (A_DOUT[8]),
        .A_DOUT9 (A_DOUT[9]),
        .A_DOUT10 (A_DOUT[10]),
        .A_DOUT11 (A_DOUT[11]),
        .A_DOUT12 (A_DOUT[12]),
        .A_DOUT13 (A_DOUT[13]),
        .A_DOUT14 (A_DOUT[14]),
        .A_DOUT15 (A_DOUT[15]),

        .B_ADDR0 (B_ADDR[0]),
        .B_ADDR1 (B_ADDR[1]),
        .B_ADDR2 (B_ADDR[2]),
        .B_ADDR3 (B_ADDR[3]),
        .B_ADDR4 (B_ADDR[4]),
        .B_ADDR5 (B_ADDR[5]),
        .B_ADDR6 (B_ADDR[6]),
        .B_ADDR7 (B_ADDR[7]),
        .B_ADDR8 (B_ADDR[8]),
        .B_ADDR9 (B_ADDR[9]),

        .B_BM0 (B_BM[0]),
        .B_BM1 (B_BM[1]),
        .B_BM2 (B_BM[2]),
        .B_BM3 (B_BM[3]),
        .B_BM4 (B_BM[4]),
        .B_BM5 (B_BM[5]),
        .B_BM6 (B_BM[6]),
        .B_BM7 (B_BM[7]),
        .B_BM8 (B_BM[8]),
        .B_BM9 (B_BM[9]),
        .B_BM10 (B_BM[10]),
        .B_BM11 (B_BM[11]),
        .B_BM12 (B_BM[12]),
        .B_BM13 (B_BM[13]),
        .B_BM14 (B_BM[14]),
        .B_BM15 (B_BM[15]),

        .B_DIN0 (B_DIN[0]),
        .B_DIN1 (B_DIN[1]),
        .B_DIN2 (B_DIN[2]),
        .B_DIN3 (B_DIN[3]),
        .B_DIN4 (B_DIN[4]),
        .B_DIN5 (B_DIN[5]),
        .B_DIN6 (B_DIN[6]),
        .B_DIN7 (B_DIN[7]),
        .B_DIN8 (B_DIN[8]),
        .B_DIN9 (B_DIN[9]),
        .B_DIN10 (B_DIN[10]),
        .B_DIN11 (B_DIN[11]),
        .B_DIN12 (B_DIN[12]),
        .B_DIN13 (B_DIN[13]),
        .B_DIN14 (B_DIN[14]),
        .B_DIN15 (B_DIN[15]),

        .B_WEN (B_WEN),
        .B_MEN (B_MEN),
        .B_REN (B_REN),

        .B_DOUT0 (B_DOUT[0]),
        .B_DOUT1 (B_DOUT[1]),
        .B_DOUT2 (B_DOUT[2]),
        .B_DOUT3 (B_DOUT[3]),
        .B_DOUT4 (B_DOUT[4]),
        .B_DOUT5 (B_DOUT[5]),
        .B_DOUT6 (B_DOUT[6]),
        .B_DOUT7 (B_DOUT[7]),
        .B_DOUT8 (B_DOUT[8]),
        .B_DOUT9 (B_DOUT[9]),
        .B_DOUT10 (B_DOUT[10]),
        .B_DOUT11 (B_DOUT[11]),
        .B_DOUT12 (B_DOUT[12]),
        .B_DOUT13 (B_DOUT[13]),
        .B_DOUT14 (B_DOUT[14]),
        .B_DOUT15 (B_DOUT[15])
    );

endmodule

module IHP_BRAM_1024x16_wrapper3 (
    input  [ 9:0] A_ADDR,
    input  [16:0] A_BM,
    input  [16:0] A_DIN,
    input         A_WEN,
    input         A_MEN,
    input         A_REN,
    output [16:0] A_DOUT,

    input  [ 9:0] B_ADDR,
    input  [16:0] B_BM,
    input  [16:0] B_DIN,
    input         B_WEN,
    input         B_MEN,
    input         B_REN,
    output [16:0] B_DOUT
);

    (* keep, BEL="X11Y8.A" *)
    IHP_BRAM_1024x16 i_IHP_BRAM_1024x16 (
        .A_ADDR0 (A_ADDR[0]),
        .A_ADDR1 (A_ADDR[1]),
        .A_ADDR2 (A_ADDR[2]),
        .A_ADDR3 (A_ADDR[3]),
        .A_ADDR4 (A_ADDR[4]),
        .A_ADDR5 (A_ADDR[5]),
        .A_ADDR6 (A_ADDR[6]),
        .A_ADDR7 (A_ADDR[7]),
        .A_ADDR8 (A_ADDR[8]),
        .A_ADDR9 (A_ADDR[9]),

        .A_BM0 (A_BM[0]),
        .A_BM1 (A_BM[1]),
        .A_BM2 (A_BM[2]),
        .A_BM3 (A_BM[3]),
        .A_BM4 (A_BM[4]),
        .A_BM5 (A_BM[5]),
        .A_BM6 (A_BM[6]),
        .A_BM7 (A_BM[7]),
        .A_BM8 (A_BM[8]),
        .A_BM9 (A_BM[9]),
        .A_BM10 (A_BM[10]),
        .A_BM11 (A_BM[11]),
        .A_BM12 (A_BM[12]),
        .A_BM13 (A_BM[13]),
        .A_BM14 (A_BM[14]),
        .A_BM15 (A_BM[15]),

        .A_DIN0 (A_DIN[0]),
        .A_DIN1 (A_DIN[1]),
        .A_DIN2 (A_DIN[2]),
        .A_DIN3 (A_DIN[3]),
        .A_DIN4 (A_DIN[4]),
        .A_DIN5 (A_DIN[5]),
        .A_DIN6 (A_DIN[6]),
        .A_DIN7 (A_DIN[7]),
        .A_DIN8 (A_DIN[8]),
        .A_DIN9 (A_DIN[9]),
        .A_DIN10 (A_DIN[10]),
        .A_DIN11 (A_DIN[11]),
        .A_DIN12 (A_DIN[12]),
        .A_DIN13 (A_DIN[13]),
        .A_DIN14 (A_DIN[14]),
        .A_DIN15 (A_DIN[15]),

        .A_WEN (A_WEN),
        .A_MEN (A_MEN),
        .A_REN (A_REN),

        .A_DOUT0 (A_DOUT[0]),
        .A_DOUT1 (A_DOUT[1]),
        .A_DOUT2 (A_DOUT[2]),
        .A_DOUT3 (A_DOUT[3]),
        .A_DOUT4 (A_DOUT[4]),
        .A_DOUT5 (A_DOUT[5]),
        .A_DOUT6 (A_DOUT[6]),
        .A_DOUT7 (A_DOUT[7]),
        .A_DOUT8 (A_DOUT[8]),
        .A_DOUT9 (A_DOUT[9]),
        .A_DOUT10 (A_DOUT[10]),
        .A_DOUT11 (A_DOUT[11]),
        .A_DOUT12 (A_DOUT[12]),
        .A_DOUT13 (A_DOUT[13]),
        .A_DOUT14 (A_DOUT[14]),
        .A_DOUT15 (A_DOUT[15]),

        .B_ADDR0 (B_ADDR[0]),
        .B_ADDR1 (B_ADDR[1]),
        .B_ADDR2 (B_ADDR[2]),
        .B_ADDR3 (B_ADDR[3]),
        .B_ADDR4 (B_ADDR[4]),
        .B_ADDR5 (B_ADDR[5]),
        .B_ADDR6 (B_ADDR[6]),
        .B_ADDR7 (B_ADDR[7]),
        .B_ADDR8 (B_ADDR[8]),
        .B_ADDR9 (B_ADDR[9]),

        .B_BM0 (B_BM[0]),
        .B_BM1 (B_BM[1]),
        .B_BM2 (B_BM[2]),
        .B_BM3 (B_BM[3]),
        .B_BM4 (B_BM[4]),
        .B_BM5 (B_BM[5]),
        .B_BM6 (B_BM[6]),
        .B_BM7 (B_BM[7]),
        .B_BM8 (B_BM[8]),
        .B_BM9 (B_BM[9]),
        .B_BM10 (B_BM[10]),
        .B_BM11 (B_BM[11]),
        .B_BM12 (B_BM[12]),
        .B_BM13 (B_BM[13]),
        .B_BM14 (B_BM[14]),
        .B_BM15 (B_BM[15]),

        .B_DIN0 (B_DIN[0]),
        .B_DIN1 (B_DIN[1]),
        .B_DIN2 (B_DIN[2]),
        .B_DIN3 (B_DIN[3]),
        .B_DIN4 (B_DIN[4]),
        .B_DIN5 (B_DIN[5]),
        .B_DIN6 (B_DIN[6]),
        .B_DIN7 (B_DIN[7]),
        .B_DIN8 (B_DIN[8]),
        .B_DIN9 (B_DIN[9]),
        .B_DIN10 (B_DIN[10]),
        .B_DIN11 (B_DIN[11]),
        .B_DIN12 (B_DIN[12]),
        .B_DIN13 (B_DIN[13]),
        .B_DIN14 (B_DIN[14]),
        .B_DIN15 (B_DIN[15]),

        .B_WEN (B_WEN),
        .B_MEN (B_MEN),
        .B_REN (B_REN),

        .B_DOUT0 (B_DOUT[0]),
        .B_DOUT1 (B_DOUT[1]),
        .B_DOUT2 (B_DOUT[2]),
        .B_DOUT3 (B_DOUT[3]),
        .B_DOUT4 (B_DOUT[4]),
        .B_DOUT5 (B_DOUT[5]),
        .B_DOUT6 (B_DOUT[6]),
        .B_DOUT7 (B_DOUT[7]),
        .B_DOUT8 (B_DOUT[8]),
        .B_DOUT9 (B_DOUT[9]),
        .B_DOUT10 (B_DOUT[10]),
        .B_DOUT11 (B_DOUT[11]),
        .B_DOUT12 (B_DOUT[12]),
        .B_DOUT13 (B_DOUT[13]),
        .B_DOUT14 (B_DOUT[14]),
        .B_DOUT15 (B_DOUT[15])
    );

endmodule
