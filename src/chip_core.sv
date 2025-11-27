// SPDX-FileCopyrightText: © 2025 XXX Authors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module chip_core #(
    parameter NUM_INPUT_PADS,
    parameter NUM_BIDIR_PADS,
    parameter NUM_ANALOG_PADS
    )(
    `ifdef USE_POWER_PINS
    inout  wire VDD,
    inout  wire VSS,
    `endif
    
    input  wire clk,       // clock
    input  wire rst_n,     // reset (active low)
    
    input  wire [NUM_INPUT_PADS-1:0] input_in,   // Input value
    output wire [NUM_INPUT_PADS-1:0] input_pu,   // Pull-up
    output wire [NUM_INPUT_PADS-1:0] input_pd,   // Pull-down

    input  wire [NUM_BIDIR_PADS-1:0] bidir_in,   // Input value
    output wire [NUM_BIDIR_PADS-1:0] bidir_out,  // Output value
    output wire [NUM_BIDIR_PADS-1:0] bidir_oe,   // Output enable
    output wire [NUM_BIDIR_PADS-1:0] bidir_cs,   // Input type (0=CMOS Buffer, 1=Schmitt Trigger)
    output wire [NUM_BIDIR_PADS-1:0] bidir_sl,   // Slew rate (0=fast, 1=slow)
    output wire [NUM_BIDIR_PADS-1:0] bidir_ie,   // Input enable
    output wire [NUM_BIDIR_PADS-1:0] bidir_pu,   // Pull-up
    output wire [NUM_BIDIR_PADS-1:0] bidir_pd    // Pull-down

    //inout  wire [NUM_ANALOG_PADS-1:0] analog  // Analog
);

    // -------------------

    // Fabric parameters
    parameter FrameBitsPerRow = 32;
    parameter MaxFramesPerCol = 20;

    parameter NumColumns = 9;
    parameter NumRows = 14;

    parameter FABRIC_NUM_IO_WEST = 48;

    // -------------------

    
    // Disable pull-up and pull-down for input
    assign input_pu = '0;
    assign input_pd = '0;

    // Set the bidir as output
    //assign bidir_oe[NUM_BIDIR_PADS-1:FABRIC_NUM_IO_WEST-1+6] = '1;
    //assign bidir_out[NUM_BIDIR_PADS-1:FABRIC_NUM_IO_WEST-1+6] = '1;
    assign bidir_cs = '0;
    assign bidir_sl = '0;
    assign bidir_ie = ~bidir_oe;
    assign bidir_pu = '0;
    assign bidir_pd = '0;
    
    // ------------
    
    // Fabric I/O
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_i;
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_o;
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_oe_o;
    
    // FPGA config
    logic fpga_sclk_i;
    logic fpga_sclk_o;
    logic fpga_sclk_oe_o;
    
    logic fpga_cs_n_i;
    logic fpga_cs_n_o;
    logic fpga_cs_n_oe_o;
    
    logic fpga_mosi_i;
    logic fpga_mosi_o;
    logic fpga_mosi_oe_o;
    
    logic fpga_miso_i;
    logic fpga_miso_o;
    logic fpga_miso_oe_o;
    
    // FPGA config mode
    // if mode == 0: SPI controller
    // if mode == 1: SPI receiver
    logic fpga_mode_i;
    logic config_busy_o;
    
    assign fabric_gpio_i = bidir_in[FABRIC_NUM_IO_WEST-1:0];
    assign bidir_out[FABRIC_NUM_IO_WEST-1:0] = fabric_gpio_o;
    assign bidir_oe[FABRIC_NUM_IO_WEST-1:0] = fabric_gpio_oe_o;
    
    assign fpga_sclk_i = bidir_in[FABRIC_NUM_IO_WEST-1+1];
    assign bidir_out[FABRIC_NUM_IO_WEST-1+1] = fpga_sclk_o;
    assign bidir_oe[FABRIC_NUM_IO_WEST-1+1] = fpga_sclk_oe_o;
    
    assign fpga_cs_n_i = bidir_in[FABRIC_NUM_IO_WEST-1+2];
    assign bidir_out[FABRIC_NUM_IO_WEST-1+2] = fpga_cs_n_o;
    assign bidir_oe[FABRIC_NUM_IO_WEST-1+2] = fpga_cs_n_oe_o;

    assign fpga_mosi_i = bidir_in[FABRIC_NUM_IO_WEST-1+3];
    assign bidir_out[FABRIC_NUM_IO_WEST-1+3] = fpga_mosi_o;
    assign bidir_oe[FABRIC_NUM_IO_WEST-1+3] = fpga_mosi_oe_o;

    assign fpga_miso_i = bidir_in[FABRIC_NUM_IO_WEST-1+4];
    assign bidir_out[FABRIC_NUM_IO_WEST-1+4] = fpga_miso_o;
    assign bidir_oe[FABRIC_NUM_IO_WEST-1+4] = fpga_miso_oe_o;

    assign bidir_out[FABRIC_NUM_IO_WEST-1+5] = config_busy_o;
    assign bidir_oe[FABRIC_NUM_IO_WEST-1+5] = 1'b1;

    assign fpga_mode_i = input_in[0];
    
    // ------------
    
    // Fabric config is currently
    // configuring the fabric
    wire            fabric_config_busy;
    
    // Fabric is configured
    wire            fabric_config_configured;
    
    // Fabric SPI controller is busy
    logic fabric_spi_controller_busy;
    
    // To the fabric
    wire [(FrameBitsPerRow*NumRows)-1:0]    FrameData;
    wire [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe;

    // Reset with asynchronous assertion and synchronous relase
    logic [1:0] rst_nd;
    logic rst_n_sync;
    
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            rst_nd <= '0;
        end else begin
            rst_nd[0] <= 1'b1;
            rst_nd[1] <= rst_nd[0];
        end
    end
    
    assign rst_n_sync = rst_nd[1];

    // Sync fpga_mode_i
    logic [1:0] fpga_mode_d;
    logic fpga_mode_sync;
    always_ff @(posedge clk) begin
        fpga_mode_d <= {fpga_mode_d[0], fpga_mode_i};
    end
    assign fpga_mode_sync = fpga_mode_d[1];
    
    // Config busy
    assign config_busy_o = fabric_config_busy;
    
    logic [31:0] spi_bitstream_data, spi_controller_bitstream_data_o, spi_receiver_bitstream_data_o;
    logic        spi_bitstream_valid, spi_controller_bitstream_valid_o, spi_receiver_bitstream_valid_o;
    
    // SPI receiver
    logic spi_receiver_sclk_i;
    logic spi_receiver_cs_ni;
    logic spi_receiver_mosi_i;
    logic spi_receiver_miso_o;
    
    // SPI controller
    logic spi_controller_sclk_o;
    logic spi_controller_cs_no;
    logic spi_controller_mosi_o;
    logic spi_controller_miso_i;
    
    logic spi_controller_start_i;
    logic [3:0] spi_controller_slot_i;
    
    // I/Os West
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_in_i;
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_out_o;
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_oe_o;

    // Assign fabric IOs
    assign fabric_io_west_in_i  = fabric_gpio_i;
    assign fabric_gpio_o        = fabric_io_west_out_o;
    assign fabric_gpio_oe_o     = fabric_io_west_oe_o;

    // WARMBOOT
    wire        fabric_warmboot_boot_o;
    wire  [3:0] fabric_warmboot_slot_o;
    wire        fabric_warmboot_reset_i;
    
    // At startup, trigger configuration
    // when fpga_mode_sync == 1'b0
    logic startup_trigger;
    always_ff @(posedge clk, negedge rst_n_sync) begin
        if (!rst_n_sync) begin
            startup_trigger = 1'b1;
        end else begin
            startup_trigger = 1'b0;
        end
    end
    
    always_comb begin
        // On reset, set SPI to tri-state
        if (!rst_n_sync) begin
            // Default output
            fpga_sclk_o = 1'b0;
            fpga_cs_n_o = 1'b0;
            fpga_mosi_o = 1'b0;
            fpga_miso_o = 1'b0;
        
            // Tri-state
            fpga_sclk_oe_o = 1'b0;
            fpga_cs_n_oe_o = 1'b0;
            fpga_mosi_oe_o = 1'b0;
            fpga_miso_oe_o = 1'b0;
            
            // Receiver not selected
            spi_receiver_sclk_i = 1'b0;
            spi_receiver_cs_ni  = 1'b1;
            spi_receiver_mosi_i = 1'b0;
            
            // Controller not selected
            spi_controller_miso_i = 1'b0;
            
            // No bitstream
            spi_bitstream_data  = '0;
            spi_bitstream_valid = '0;
            
            // Slot and trigger
            spi_controller_slot_i   = '0;
            spi_controller_start_i  = '0;
        end else begin
            // Default output
            fpga_sclk_o = 1'b0;
            fpga_cs_n_o = 1'b0;
            fpga_mosi_o = 1'b0;
            fpga_miso_o = 1'b0;
            
            // Receiver not selected
            spi_receiver_sclk_i = 1'b0;
            spi_receiver_cs_ni  = 1'b1;
            spi_receiver_mosi_i = 1'b0;
            
            // Controller not selected
            spi_controller_miso_i = 1'b0;

            if (fpga_mode_sync == 1'b0) begin
                // SPI Controller
                fpga_sclk_oe_o = 1'b1;
                fpga_cs_n_oe_o = 1'b1;
                fpga_mosi_oe_o = 1'b1;
                fpga_miso_oe_o = 1'b0;
                
                fpga_sclk_o = spi_controller_sclk_o;
                fpga_cs_n_o = spi_controller_cs_no;
                fpga_mosi_o = spi_controller_mosi_o;
                spi_controller_miso_i = fpga_miso_i;
                
                // Re-route bitstream
                spi_bitstream_data  = spi_controller_bitstream_data_o;
                spi_bitstream_valid = spi_controller_bitstream_valid_o;
                
                // Slot and trigger
                spi_controller_start_i  = startup_trigger || (fabric_warmboot_boot_o && !(fabric_config_busy || fabric_spi_controller_busy));
                spi_controller_slot_i   = startup_trigger ? '0 : fabric_warmboot_slot_o;

            end else begin
                // SPI receiver
                fpga_sclk_oe_o = 1'b0;
                fpga_cs_n_oe_o = 1'b0;
                fpga_mosi_oe_o = 1'b0;
                fpga_miso_oe_o = 1'b1;
                
                spi_receiver_sclk_i = fpga_sclk_i;
                spi_receiver_cs_ni  = fpga_cs_n_i;
                spi_receiver_mosi_i = fpga_mosi_i;
                fpga_miso_o = spi_receiver_miso_o;
                
                // Re-route bitstream
                spi_bitstream_data  = spi_receiver_bitstream_data_o;
                spi_bitstream_valid = spi_receiver_bitstream_valid_o;
                
                // Slot and trigger
                spi_controller_start_i  = '0;
                spi_controller_slot_i   = '0;
            end
        end
    end
    
    fabric_spi_receiver fabric_spi_receiver (
        .clk_i  (clk),
        .rst_ni (rst_n_sync),
        
        // Bitstream data
        .bitstream_data_o   (spi_receiver_bitstream_data_o),
        .bitstream_valid_o  (spi_receiver_bitstream_valid_o),
        
        // Enable the SPI receiver
        .enable_i   (fpga_mode_sync == 1'b1),
        
        // SPI
        .sclk_i     (spi_receiver_sclk_i),
        .cs_ni      (spi_receiver_cs_ni),
        .mosi_i     (spi_receiver_mosi_i),
        .miso_o     (spi_receiver_miso_o)
    );

    // TODO adjust BITSTREAM_LENGTH_WORDS
    fabric_spi_controller #(
        .BITSTREAM_LENGTH_WORDS (32'hA92),
        .SLOT_OFFSET_WORDS      (32'h1000),
        .NUM_SLOTS              (16)
    ) fabric_spi_controller (
        .clk_i  (clk),
        .rst_ni (rst_n_sync),
        
        // Start reading data at selected slot
        .start_i    (spi_controller_start_i),
        .slot_i     (spi_controller_slot_i),
        
        // Bitstream data
        .bitstream_data_o    (spi_controller_bitstream_data_o),
        .bitstream_valid_o   (spi_controller_bitstream_valid_o),
        
        // Reading in progress
        .busy_o     (fabric_spi_controller_busy),
        
        // SPI
        .sclk_o     (spi_controller_sclk_o),
        .cs_no      (spi_controller_cs_no),
        .mosi_o     (spi_controller_mosi_o),
        .miso_i     (spi_controller_miso_i)
    );
    
    fabric_config #(
        .FrameBitsPerRow    (FrameBitsPerRow),
        .MaxFramesPerCol    (MaxFramesPerCol),
        
        .NumColumns         (NumColumns),
        .NumRows            (NumRows)
    ) fabric_config (
        .clk_i              (clk),
        .rst_ni             (rst_n_sync),
        
        // Bitstream
        .bitstream_valid_i  (spi_bitstream_valid),
        .bitstream_data_i   (spi_bitstream_data),
        
        // Configuration in progress
        .busy_o             (fabric_config_busy),
        
        // Fabric is configured
        .configured_o       (fabric_config_configured),
        
        // To the fabric
        .FrameData_o        (FrameData),
        .FrameStrobe_o      (FrameStrobe)
    );

    assign fabric_warmboot_reset_i = fabric_config_busy;

    (* keep *) fabric_wrapper fabric_wrapper (
        .clk_i          (clk),
        
        // Configuration
        .FrameData_i    (FrameData),
        .FrameStrobe_i  (FrameStrobe),
        
        // Fabric is configured
        .configured_i   (fabric_config_configured),
        
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

`default_nettype wire
