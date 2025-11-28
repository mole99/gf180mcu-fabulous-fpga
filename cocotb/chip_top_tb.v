// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`timescale 1 ns / 1 ps
`default_nettype none

`include "slot_defines.svh"

reg [1023:0] firmware_file;
module chip_top_tb;

    // Power/ground pads for core and I/O
    parameter NUM_DVDD_PADS = `NUM_DVDD_PADS;
    parameter NUM_DVSS_PADS = `NUM_DVSS_PADS;

    // Signal pads
    parameter NUM_FPGA_PADS = `NUM_FPGA_PADS;

    /*initial begin
        `ifdef DUMP_WAVEFORMS
            $dumpfile("chip_top_tb.fst");
            $dumpvars(0, chip_top_tb);
        `endif
    end*/

    `ifdef USE_POWER_PINS
    wire VDD;
    wire VSS;
    `endif

    wire clk_PAD;
    wire rst_n_PAD;
    
    wire fpga_mode_PAD;
    wire config_busy_PAD;
    
    wire fpga_sclk_PAD;
    wire fpga_cs_n_PAD;
    wire fpga_mosi_PAD;
    wire fpga_miso_PAD;

    wire [NUM_FPGA_PADS-1:0] fpga_PAD;
    
    `ifdef BITSTREAM_FLASH
    
    // SPI Flash - Bitstream
    spiflash_powered i_spiflash_powered (
	    .csb (fpga_cs_n_PAD),
	    .clk (fpga_sclk_PAD),
	    .io0 (fpga_mosi_PAD), // MOSI
	    .io1 (fpga_miso_PAD), // MISO
	    .io2 (  ),
	    .io3 (  )
    );
    
    // Pull down z to 0
    //assign (pull1, pull0) io_fpga_miso_PAD = 1'b0;
    
    `else

    assign fpga_cs_n_PAD = 1'b1;
    assign fpga_sclk_PAD = 1'b0;
    assign fpga_mosi_PAD = 1'b0;

    `endif

    // greyhound instance
    chip_top chip_top (
        `ifdef USE_POWER_PINS
        .VDD,
        .VSS,
        `endif

        .clk_PAD,
        .rst_n_PAD,
            
        .fpga_mode_PAD,
        .config_busy_PAD,
            
        .fpga_sclk_PAD,
        .fpga_cs_n_PAD,
        .fpga_mosi_PAD,
        .fpga_miso_PAD,

        .fpga_PAD
    );

endmodule

module clk_buf(input A, output X);
assign X = A;
endmodule

module break_comb_loop(input A, output X);
assign #0.1 X = A;
endmodule

`default_nettype wire
