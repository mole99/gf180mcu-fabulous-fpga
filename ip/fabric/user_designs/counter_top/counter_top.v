// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);

	wire rst = io_in[31];
	reg [`NUM_IO-1:0] ctr;

	always @(posedge clk) begin
		if (rst)
			ctr <= 0;
		else
			ctr <= ctr + 1'b1;
    end

	assign io_out = ctr;

	assign io_oeb[30:0] = '0;
	assign io_oeb[31] = 1'b1;
endmodule
