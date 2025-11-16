// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);
    logic reset;

    WARMBOOT_wrapper i_WARMBOOT_wrapper (
        .SLOT   (4'd0),
        .BOOT   (1'b0),
        .RESET  (reset)
    );

    fsoc #( 
        .CHUNKSIZE (1),
        .CONF      ("MIN"),
        .RFTYPE    ("BRAM"),
        .MTVAL     ('h0),
        .BOOTADR   ('h0),
        .MEMFILE   (""),
        .MEMSIZE   (4096),
        .MEMDLY1   (1),
        .GPOCNT    (8)
    ) i_fsoc (
        .clk_i    (clk),
        .rst_in   (!reset),

        .gpi_i    (io_in[8]),
        .gpo_o    (io_out[7:0])
    );

    assign io_oeb[8] = 1'b1;
    assign io_oeb[7:0] = '0;

    assign io_oeb[`NUM_IO-1:9] = '1;

endmodule
