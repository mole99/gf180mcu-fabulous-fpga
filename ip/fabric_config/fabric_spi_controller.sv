// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

/*
This SPI controller reads a bitstream from an
SPI Flash upon receiving a start_i pulse.
The starting address can be changed using the
slot_i input.
Use the parameters to adjust for the correct
bitstream length of your fabric.
*/

module fabric_spi_controller #(
    parameter BITSTREAM_LENGTH_WORDS = 100,
    parameter SLOT_OFFSET_WORDS = 128,
    parameter NUM_SLOTS = 16
)(
    input  logic  clk_i,
    input  logic  rst_ni,
    
    // Start reading data at selected slot
    input logic   start_i,
    input logic   [$clog2(NUM_SLOTS)-1:0] slot_i,
    
    // Bitstream data
    output logic [31:0] bitstream_data_o,
    output logic        bitstream_valid_o,
    
    // Reading in progress
    output logic  busy_o,
    
    // SPI
    output logic sclk_o,
    output logic cs_no,
    output logic mosi_o,
    input  logic miso_i
);
    // CPOL = 0, CPHA = 0

    localparam READ_CMD = 8'h03;
    
    logic [31:0] shift_register;
    logic [4:0] shift_cnt;
    logic [21:0] address_counter_words;
    
    logic [$clog2(NUM_SLOTS)-1:0] slot;

    // States
    typedef enum {
        S_IDLE,
        S_LOAD_ADDR,
        S_SHIFT_ADDR,
        S_LOAD_DATA,
        S_SHIFT_DATA,
        S_WRITE_DATA
    } state_t;
    
    state_t curr_state;
    state_t next_state;

    // Next state logic
    always_comb begin
        next_state = curr_state;

        case (curr_state)
            S_IDLE:
                if (start_i) next_state = S_LOAD_ADDR;
            S_LOAD_ADDR:
                next_state = S_SHIFT_ADDR;
            S_SHIFT_ADDR:
                if (shift_cnt == '0 && sclk_o) next_state = S_LOAD_DATA;
            S_LOAD_DATA:
                if (address_counter_words == SLOT_OFFSET_WORDS*slot+BITSTREAM_LENGTH_WORDS) next_state = S_IDLE;
                else next_state = S_SHIFT_DATA;
            S_SHIFT_DATA:
                if (shift_cnt == '0 && sclk_o) next_state = S_WRITE_DATA;
            S_WRITE_DATA:
                next_state = S_LOAD_DATA;
        endcase
    end

    assign busy_o = curr_state != S_IDLE;

    // State transition
    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni) begin
            curr_state <= S_IDLE;
        end else begin
            curr_state <= next_state;
        end
    end
    
    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni) begin
            shift_cnt <= '0;
            shift_register <= '0;
            sclk_o <= 1'b0;
            bitstream_data_o <= '0;
            bitstream_valid_o <= '0;
            slot <= '0;
            address_counter_words <= '0;
        end else begin
            bitstream_valid_o <= 1'b0;
        
            case (curr_state)
                S_IDLE: begin
                    if (start_i) begin
                        address_counter_words <= SLOT_OFFSET_WORDS * slot_i;
                        slot <= slot_i;
                    end
                    
                    sclk_o <= 1'b0;
                end
                S_LOAD_ADDR: begin
                    shift_cnt <= 31;
                    shift_register <= {READ_CMD, {address_counter_words, 2'b00}};
                    sclk_o <= 1'b0;
                end
                S_SHIFT_ADDR: begin
                    sclk_o <= !sclk_o;

                    // On falling edge of sclk
                    if (sclk_o) begin
                        shift_cnt <= shift_cnt-1;
                        shift_register <= {shift_register[30:0], miso_i};
                    end
                end

                S_LOAD_DATA: begin
                    shift_cnt <= 31;
                    //shift_register <= {READ_CMD, address_counter_words};
                    sclk_o <= 1'b0;
                end
                S_SHIFT_DATA: begin
                    sclk_o <= !sclk_o;

                    // On falling edge of sclk
                    if (sclk_o) begin
                        shift_cnt <= shift_cnt-1;
                        shift_register <= {shift_register[30:0], miso_i};
                    end
                end
                S_WRITE_DATA: begin
                    address_counter_words <= address_counter_words + 1;
                    
                    bitstream_data_o <= shift_register;
                    bitstream_valid_o <= 1'b1;
                end
            endcase
        end
    end

    // MSB first
    assign mosi_o = shift_register[31];
    
    // CS active when not idle
    assign cs_no = !(curr_state != S_IDLE);

endmodule
