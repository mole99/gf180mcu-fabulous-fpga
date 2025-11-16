// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);

    logic reset;

    WARMBOOT_wrapper WARMBOOT_wrapper (
        .SLOT   (4'd0),
        .BOOT   (1'b0),
        .RESET  (reset)
    );

    // Our custom instruction interface    
    logic        issue_ready_o;
    logic        issue_accept_o;
    logic        issue_valid_i;
    logic [31:0] issue_instr_i;
    logic [31:0] issue_op0_i;
    logic [31:0] issue_op1_i;
    logic [ 3:0] issue_id_i;
    
    logic        result_valid_o;
    logic [ 3:0] result_id_o;
    logic [ 4:0] result_rd_o;
    logic [31:0] result_o;

    CUSTOM_INSTRUCTION_wrapper xif (
        .ISSUE_READY    (issue_ready_o),
        .ISSUE_ACCEPT   (issue_accept_o),
        .ISSUE_VALID    (issue_valid_i),
        .ISSUE_INSTR    (issue_instr_i),
        .ISSUE_OPA      (issue_op0_i),
        .ISSUE_OPB      (issue_op1_i),
        .ISSUE_ID       (issue_id_i),
        
        .RESULT_VALID   (result_valid_o),
        .RESULT_ID      (result_id_o),
        .RESULT_RD      (result_rd_o),
        .RESULT         (result_o),
    );
    
    // R-type instruction decoding
    logic [6:0] opcode;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign opcode   = issue_instr_i[6:0];
    assign rs1      = issue_instr_i[19:15];
    assign rs2      = issue_instr_i[24:20];
    assign rd       = issue_instr_i[11:7];
    assign funct3   = issue_instr_i[14:12];
    assign funct7   = issue_instr_i[31:25];

    // 0x0B, 0x2B, 0x5B and 0x7B
    // are free for custom use
    localparam OPCODE_XIF = 7'h5B;

    // Use GCC .insn pseudo directive:
    // R type: .insn r opcode7, func3, func7, rd, rs1, rs2

    assign issue_accept_o = opcode == OPCODE_XIF && issue_valid_i;
    
    assign issue_ready_o = 1'b1;
    
    logic [31:0] op0_d;
    logic [31:0] op1_d;
    logic [3:0]  id_d;
    logic [3:0]  rd_d;
    logic issue_valid_d;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            issue_valid_d   <= 1'b0;
            result_valid_o  <= 1'b0;
        end else begin
            issue_valid_d <= issue_valid_i;
        
            if (issue_valid_i) begin
                op0_d <= issue_op0_i;
                op1_d <= issue_op1_i;
                id_d  <= issue_id_i;
                rd_d  <= rd;  
            end
            
            result_valid_o <= 1'b0;
            if (issue_valid_d) begin
                result_valid_o  <= 1'b1;
                result_id_o     <= id_d;
                result_rd_o     <= rd_d;
                result_o        <= op0_d + op1_d;  
            end
        end
    end

    assign io_oeb = '0;
    assign io_out = 32'hCAFECAFE;

endmodule
