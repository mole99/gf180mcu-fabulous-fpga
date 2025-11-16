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

    servant #(
        .memfile        (""),
        .memsize        (4096),
        .reset_strategy ("MINI"),
        .width          (4),
        .sim            (0),
        .debug          (1'b0),
        .with_csr       (1),
        .compress       (0)
    ) servant (
        .wb_clk (clk),
        .wb_rst (reset),
        .q      (io_out[0])
    );

    assign io_oeb[0] = 1'b0;
    assign io_oeb[`NUM_IO-1:1] = '1;

endmodule
