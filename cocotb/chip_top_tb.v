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
    parameter NUM_INPUT_PADS = `NUM_INPUT_PADS;
    parameter NUM_BIDIR_PADS = `NUM_BIDIR_PADS;
    parameter NUM_ANALOG_PADS = `NUM_ANALOG_PADS;

    parameter FABRIC_NUM_IO_WEST = 48;

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
    
    wire [NUM_INPUT_PADS-1:0] input_PAD;
    wire [NUM_BIDIR_PADS-1:0] bidir_PAD;
    
    wire fpga_mode_i;
    wire config_busy_o;
    wire [FABRIC_NUM_IO_WEST-1:0] fpga_io;
    
    assign input_PAD[0] = fpga_mode_i;
    assign config_busy_o = bidir_PAD[FABRIC_NUM_IO_WEST-1+5];
    assign fpga_io = bidir_PAD[FABRIC_NUM_IO_WEST-1:0];
    
    `ifdef BITSTREAM_FLASH
    
    // SPI Flash - Bitstream
    spiflash_powered i_spiflash_powered (
	    .csb (bidir_PAD[FABRIC_NUM_IO_WEST-1+2]),
	    .clk (bidir_PAD[FABRIC_NUM_IO_WEST-1+1]),
	    .io0 (bidir_PAD[FABRIC_NUM_IO_WEST-1+3]), // MOSI
	    .io1 (bidir_PAD[FABRIC_NUM_IO_WEST-1+4]), // MISO
	    .io2 (  ),
	    .io3 (  )
    );
    
    // Pull down z to 0
    //assign (pull1, pull0) io_fpga_miso_PAD = 1'b0;
    
    `else

    assign bidir_PAD[FABRIC_NUM_IO_WEST-1+2] = 1'b1;
    assign bidir_PAD[FABRIC_NUM_IO_WEST-1+1] = 1'b0;
    assign bidir_PAD[FABRIC_NUM_IO_WEST-1+3] = 1'b0;

    `endif

    // greyhound instance
    chip_top chip_top (
        `ifdef USE_POWER_PINS
        .VDD,
        .VSS,
        `endif

        .clk_PAD,
        .rst_n_PAD,
        
        .input_PAD,
        .bidir_PAD
    );

endmodule

module clk_buf(input A, output X);
assign X = A;
endmodule

module break_comb_loop(input A, output X);
assign #0.1 X = A;
endmodule

`default_nettype wire
