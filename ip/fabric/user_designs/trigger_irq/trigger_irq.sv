// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);
    
    // Trigger IRQ0 when the counter
    // has reached the value 0
    
    logic RESET;
    logic [3:0] counter;
    logic trigger_irq0;
    
    always_ff @(posedge clk) begin
        if (RESET) begin
            counter <= '1;
            trigger_irq0 <= 1'b0;
        end else begin
            if (counter > 0) begin
                counter <= counter - 1;
            end else begin
                trigger_irq0 <= 1'b1;
            end
        end
    end
    
    CPU_IRQ_wrapper CPU_IRQ_wrapper (
        .IRQ    ({3'b000, trigger_irq0}),
    );
    
    WARMBOOT_wrapper WARMBOOT_wrapper (
        .SLOT   (4'd0),
        .BOOT   (1'b0),
        .RESET  (RESET)
    );
    
    assign io_oeb = '0;
    assign io_out = 32'hCAFECAFE;

endmodule
