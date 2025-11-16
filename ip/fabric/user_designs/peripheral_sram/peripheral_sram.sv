// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);
    // SRAM
    parameter NUM_SRAM = 6;
    logic [32-1:0] DOUT_SRAMS [NUM_SRAM];
    logic [32-1:0] DOUT, DOUT_D;

    // Peripheral
    logic        REQ;
    logic        WE;
    logic [3: 0] BE;
    logic [23:0] ADDR;
    logic [31:0] WDATA;
    
    logic        GNT;
    logic        RVALID;
    logic [31:0] RDATA;
    
    logic [2:0] select_sram, select_sram_d;
    assign select_sram = ADDR[12+2:10+2];
    
    generate
        for (genvar i=0; i<NUM_SRAM; i++) begin : gen
            // SRAM
            if (i < 4) begin
                IHP_SRAM_1024x32_wrapper sram (
                    .A_ADDR   (ADDR[9+2:0+2]),
                    .A_BM     ({{8{BE[3]}}, {8{BE[2]}}, {8{BE[1]}}, {8{BE[0]}}}),
                    .A_DIN    (WDATA),
                    .A_WEN    (WE),
                    .A_MEN    (select_sram == i && REQ),
                    .A_REN    (!WE),
                    .A_DOUT   (DOUT_SRAMS[i])
                );
            // BRAM
            end else begin
            
                IHP_BRAM_1024x16_wrapper bram_0 (
                    .A_ADDR   (ADDR[9+2:0+2]),
                    .A_BM     ({{8{BE[1]}}, {8{BE[0]}}}),
                    .A_DIN    (WDATA[15:0]),
                    .A_WEN    (WE),
                    .A_MEN    (select_sram == i && REQ),
                    .A_REN    (!WE),
                    .A_DOUT   (DOUT_SRAMS[i][15:0])
                );
                
                IHP_BRAM_1024x16_wrapper bram_1 (
                    .A_ADDR   (ADDR[9+2:0+2]),
                    .A_BM     ({{8{BE[3]}}, {8{BE[2]}}}),
                    .A_DIN    (WDATA[31:16]),
                    .A_WEN    (WE),
                    .A_MEN    (select_sram == i && REQ),
                    .A_REN    (!WE),
                    .A_DOUT   (DOUT_SRAMS[i][31:16])
                );
            
            end
        end
    endgenerate
    
    always_ff @(posedge clk) begin
        RVALID <= REQ;
        select_sram_d <= select_sram;
    end
    
    always_comb begin
        DOUT = 0;
        if (select_sram_d < NUM_SRAM) begin
            DOUT = DOUT_SRAMS[select_sram_d];
        end
    end
    
    assign RDATA = DOUT;
    assign GNT = 1'b1;

    OBI_PERIPHERAL_wrapper i_OBI_PERIPHERAL_wrapper (
        .REQ,
        .WE,
        .BE,
        .ADDR,
        .WDATA,
        
        .GNT,
        .RVALID,
        .RDATA,
    );
    
    WARMBOOT_wrapper WARMBOOT_wrapper (
        .SLOT   (4'd0),
        .BOOT   (1'b0),
        .RESET  (    )
    );
    
    assign io_oeb = '0;
    assign io_out = 32'hCAFECAFE;

endmodule
