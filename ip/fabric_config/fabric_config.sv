// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

/*
Fabric configuration module.
Supply bistream data at bitstream_data_i, pulse bitstream_valid_i
for valid data. If data is valid on every cycle, bitstream_valid_i
can be held high, no idle cycles required.
*/

module fabric_config #(
    	parameter FrameBitsPerRow = 32,
	parameter MaxFramesPerCol = 20,
    parameter FrameSelectWidth = 5, // hardcoded, should be based on NumColumns
	
	parameter NumColumns = 12,
	parameter NumRows = 18
)(
    input  logic  clk_i,
    input  logic  rst_ni,
    
    // Bitstream data
    input  [31:0] bitstream_data_i,
    input         bitstream_valid_i,
    
    // Configuration in progress
    output logic  busy_o,
    
    // Fabric is configured
    output logic  configured_o,
    
    // To the fabric
    output logic [(FrameBitsPerRow*NumRows)-1:0]    FrameData_o,
    output logic [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe_o
);
    localparam logic [31:0] BITSTREAM_START = 32'hFAB0FAB1;
    localparam logic [31:0] DESYNC_FLAG = 20;
    
    // States
    typedef enum {
        S_IDLE,
        S_HEADER,
        S_DATA
    } state_t;
    
    state_t curr_state;
    state_t next_state;

    // Configuration signals
    logic  [$clog2(NumColumns)-1:0] column_select;
    logic  [MaxFramesPerCol-1:0]    frame_select;
    logic                           frame_strobe;
    
    logic  [FrameBitsPerRow-1:0]    row_data;
    logic  [$clog2(NumRows+1)-1:0]  row_select;
    logic                           row_strobe;

    // Next state logic
    always_comb begin
        next_state = curr_state;

        case (curr_state)
            S_IDLE:
                if (bitstream_valid_i && bitstream_data_i == BITSTREAM_START) next_state = S_HEADER;
            S_HEADER:
                if (bitstream_valid_i && bitstream_data_i[DESYNC_FLAG]) next_state = S_IDLE;
                else if (bitstream_valid_i) next_state = S_DATA;
            S_DATA:
                if (bitstream_valid_i && row_select == 0) next_state = S_HEADER;
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
            configured_o <= '0;
        end else begin
            // Clear the configured bit upon receiving the start of a bitstream
            if (curr_state == S_IDLE && bitstream_valid_i && bitstream_data_i == BITSTREAM_START) configured_o <= '0;
            // Set the configured bit after we've received the desync flag
            if (curr_state == S_HEADER && bitstream_valid_i && bitstream_data_i[DESYNC_FLAG]) configured_o <= '1;
        end
    end
    
    
    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni) begin
            column_select <= '0;
            frame_select  <= '0;
            frame_strobe  <= '0;
            row_select    <= '0;
        end else begin
            // Default frame strobe value
            frame_strobe <= 1'b0;
            
            case (curr_state)
                S_IDLE: begin
                    column_select <= '0;
                    frame_select  <= '0;
                    frame_strobe  <= '0;
                    row_select    <= '0;
                end
                S_HEADER: begin
                    if (bitstream_valid_i && !bitstream_data_i[DESYNC_FLAG]) begin
                        // Select frame and column
                        frame_select <= bitstream_data_i[MaxFramesPerCol-1:0];
                        column_select <= bitstream_data_i[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth];
                        
                        // Set row_select to maximum + 1
                        row_select <= NumRows-1;
                    end
                end
                S_DATA: begin
                    if (bitstream_valid_i) begin
                        // Decrement row select
                        row_select <= row_select - 1;
                        
                        // A new frame is available
                        if (row_select == 0) begin
                            // Write frame
                            frame_strobe <= 1'b1;
                        end
                    end
                end
            endcase
        end
    end
    
    // Assign row data and strobe
    assign row_data = bitstream_data_i;
    assign row_strobe = (curr_state == S_DATA) && bitstream_valid_i;

    // Map strobe from local frame select and
    // column select to global frame strobe
    generate
    for (genvar i=0; i<NumColumns; i++) begin : gen_framestrobe
        assign FrameStrobe_o[MaxFramesPerCol*i +: MaxFramesPerCol] = (column_select == i) && frame_strobe ? frame_select : '0;
    end
    endgenerate
    
    // Register for each of the rows
    logic [(FrameBitsPerRow*NumRows)-1:0] FrameDataRegister;
    
    // Strobe registers via row select
    generate
    for (genvar i=0; i<NumRows; i++) begin : gen_framedata
        always_ff @(posedge clk_i) begin
            if (row_strobe && row_select == i) begin
                FrameDataRegister[FrameBitsPerRow*i +: FrameBitsPerRow] <= row_data;
            end
        end
    end
    endgenerate

    assign FrameData_o = FrameDataRegister;

endmodule
