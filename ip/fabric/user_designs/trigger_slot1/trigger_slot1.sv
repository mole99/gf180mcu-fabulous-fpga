// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);
    
    // Boot from slot 1
    
    WARMBOOT_wrapper WARMBOOT_wrapper (
        .SLOT   (4'd1),
        .BOOT   (1'b1),
        .RESET  (    )
    );
    
    	assign io_out = '0;
	assign io_oeb = '0;

endmodule
