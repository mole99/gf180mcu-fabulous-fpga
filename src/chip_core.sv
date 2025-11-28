// SPDX-FileCopyrightText: © 2025 Leo Moser
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module chip_core #(
    parameter NUM_FPGA_PADS
    )(
    `ifdef USE_POWER_PINS
    inout  wire VDD,
    inout  wire VSS,
    `endif
    
    input  wire clk,       // clock
    input  wire rst_n,     // reset (active low)
    
    // FPGA config mode
    // if mode == 0: SPI controller
    // if mode == 1: SPI receiver
    input  wire fpga_mode_i,
    output wire config_busy_o,
    
    // FPGA config
    input  wire  fpga_sclk_i,
    output logic fpga_sclk_o,
    output logic fpga_sclk_oe_o,
    
    input  wire  fpga_cs_n_i,
    output logic fpga_cs_n_o,
    output logic fpga_cs_n_oe_o,
    
    input  wire  fpga_mosi_i,
    output logic fpga_mosi_o,
    output logic fpga_mosi_oe_o,
    
    input  wire  fpga_miso_i,
    output logic fpga_miso_o,
    output logic fpga_miso_oe_o,
    
    input  wire [NUM_FPGA_PADS-1:0] fpga_in,   // Input value
    output wire [NUM_FPGA_PADS-1:0] fpga_out,  // Output value
    output wire [NUM_FPGA_PADS-1:0] fpga_oe,   // Output enable
    output wire [NUM_FPGA_PADS-1:0] fpga_cs,   // Input type (0=CMOS Buffer, 1=Schmitt Trigger)
    output wire [NUM_FPGA_PADS-1:0] fpga_sl,   // Slew rate (0=fast, 1=slow)
    output wire [NUM_FPGA_PADS-1:0] fpga_ie,   // Input enable
    output wire [NUM_FPGA_PADS-1:0] fpga_pu,   // Pull-up
    output wire [NUM_FPGA_PADS-1:0] fpga_pd    // Pull-down
);

    // Fabric parameters
    parameter FrameBitsPerRow = 32;
    parameter MaxFramesPerCol = 20;

    parameter NumColumns = 9;
    parameter NumRows = 14;

    parameter FABRIC_NUM_IO_WEST = 48;
    
    // Fabric I/O
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_i;
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_o;
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_oe_o;
    
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_config0;
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_config1;
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_config2;
    logic [FABRIC_NUM_IO_WEST-1:0] fabric_gpio_config3;
    
    assign fabric_gpio_i = fpga_in[FABRIC_NUM_IO_WEST-1:0];
    assign fpga_out[FABRIC_NUM_IO_WEST-1:0] = fabric_gpio_o;
    assign fpga_oe[FABRIC_NUM_IO_WEST-1:0] = fabric_gpio_oe_o;
    assign fpga_cs = fabric_gpio_config2;
    assign fpga_sl = fabric_gpio_config3;
    assign fpga_ie = ~fpga_oe;
    assign fpga_pu = fabric_gpio_config0;
    assign fpga_pd = fabric_gpio_config1;
    
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
    
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config0_o;
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config1_o;
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config2_o;
    wire [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config3_o;

    // Assign fabric IOs
    assign fabric_io_west_in_i  = fabric_gpio_i;
    assign fabric_gpio_o        = fabric_io_west_out_o;
    assign fabric_gpio_oe_o     = fabric_io_west_oe_o;
    
    assign fabric_gpio_config0 = fabric_io_west_config0_o;
    assign fabric_gpio_config1 = fabric_io_west_config1_o;
    assign fabric_gpio_config2 = fabric_io_west_config2_o;
    assign fabric_gpio_config3 = fabric_io_west_config3_o;

    // WARMBOOT
    wire        fabric_warmboot_boot_o;
    wire  [3:0] fabric_warmboot_slot_o;
    wire        fabric_warmboot_reset_i;
    
    // At startup, trigger configuration
    // when fpga_mode_sync == 1'b0
    logic startup_trigger;
    always_ff @(posedge clk, negedge rst_n_sync) begin
        if (!rst_n_sync) begin
            startup_trigger <= 1'b1;
        end else begin
            startup_trigger <= 1'b0;
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
        
        .fabric_io_west_config0_o,
        .fabric_io_west_config1_o,
        .fabric_io_west_config2_o,
        .fabric_io_west_config3_o,

        // WARMBOOT
        .fabric_warmboot_boot_o,
        .fabric_warmboot_slot_o,
        .fabric_warmboot_reset_i
    );

endmodule

`default_nettype wire
