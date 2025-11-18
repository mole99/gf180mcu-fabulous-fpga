// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);

    parameter NUM_SRAM = 6;

    logic [7:0] sram_do [NUM_SRAM];
    logic [7:0] final_sram_do;
    
    logic [NUM_SRAM-1:0] sram_en;
    
    always_comb begin
      for (int i=0; i<NUM_SRAM; i++) begin
          sram_en[i] = io_in[22:20] == i;
      end
    end
    
    generate
      for (genvar j=0; j<NUM_SRAM; j++) begin
        GF_SRAM_512x8_wrapper sram (
            .A        (io_in[19:17]),
            .WEN      (~8'hFF),
            .D        (io_in[16:8]),
            .GWEN     (!io_in[23]),
            .CEN      (!sram_en[j]),
            .Q        (sram_do[j])
        );
      end
    endgenerate

    always_comb begin
      final_sram_do = 'x;
      for (int i=0; i<NUM_SRAM; i++) begin
          if (io_in[22:20] == i)
            final_sram_do = sram_do[i];
      end
    end
    
    assign io_out = {16'd0, final_sram_do};
    assign io_oeb = {16'd0, 8'hFF};

endmodule
