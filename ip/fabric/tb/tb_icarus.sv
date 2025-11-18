// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`timescale 1ns/1ps
`default_nettype none

module tb;

    initial begin
        $dumpfile("tb.fst");
        $dumpvars(0, tb);
    end

    parameter FrameBitsPerRow = 32;
    parameter MaxFramesPerCol = 20;

    parameter NumColumns = 9;
    parameter NumRows = 14;

    parameter FABRIC_NUM_IO_WEST = 24;

    wire clk_i;
    wire rst_ni;
    
    // Bitstream
    wire  [31:0] bitstream_data_i;
    wire         bitstream_valid_i;
    
    // Configuration in progress
    wire  busy_o;
    
    // Fabric is configured
    wire configured_o;
    
    // To the fabric
    wire [(FrameBitsPerRow*NumRows)-1:0]    FrameData_o;
    wire [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe_o;
    
    // I/Os West
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_in_i;
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_out_o;
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_oe_o;

    // WARMBOOT
    wire        fabric_warmboot_boot_o;
    wire  [3:0] fabric_warmboot_slot_o;
    wire        fabric_warmboot_reset_i;
    
    assign fabric_warmboot_reset_i = busy_o;
    
    fabric_config #(
      .FrameBitsPerRow    (FrameBitsPerRow),
      .MaxFramesPerCol    (MaxFramesPerCol),
      
      .NumColumns         (NumColumns),
      .NumRows            (NumRows)
    ) fabric_config (
        .clk_i,
        .rst_ni,
        
        // Bitstream
        .bitstream_data_i,
        .bitstream_valid_i,
        
        // Configuration in progress
        .busy_o,
        
        // Fabric is configured
        .configured_o,
        
        // To the fabric
        .FrameData_o,
        .FrameStrobe_o
    );
    
    
    fabric_wrapper fabric_wrapper (
        .clk_i,
        
        // Configuration
        .FrameData_i    (FrameData_o),
        .FrameStrobe_i  (FrameStrobe_o),
        
        // Fabric is configured
        .configured_i   (configured_o),
        
        // I/Os West
        .fabric_io_west_in_i,
        .fabric_io_west_out_o,
        .fabric_io_west_oe_o,
        
        // WARMBOOT
        .fabric_warmboot_boot_o,
        .fabric_warmboot_slot_o,
        .fabric_warmboot_reset_i
    );

endmodule

module clk_buf(input A, output X);
assign X = A;
endmodule

module break_comb_loop(input A, output X);
assign #0.1 X = A;
endmodule
