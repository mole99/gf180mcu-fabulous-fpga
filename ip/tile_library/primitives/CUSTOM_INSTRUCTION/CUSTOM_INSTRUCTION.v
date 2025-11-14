// Copyright 2025 Leo Moser
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


module CUSTOM_INSTRUCTION #(parameter NoConfigBits = 0)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)

	// User design
    input         ISSUE_READY,
    input         ISSUE_ACCEPT,
    output        ISSUE_VALID,
    output [31:0] ISSUE_INSTR,
    output [31:0] ISSUE_OPA,
    output [31:0] ISSUE_OPB,
    output [ 3:0] ISSUE_ID,
    
    input         RESULT_VALID,
    input  [ 3:0] RESULT_ID,
    input  [ 4:0] RESULT_RD,
    input  [31:0] RESULT,

    // Top
    (* FABulous, EXTERNAL *) output        ISSUE_READY_top,
    (* FABulous, EXTERNAL *) output        ISSUE_ACCEPT_top,
    (* FABulous, EXTERNAL *) input         ISSUE_VALID_top,
    (* FABulous, EXTERNAL *) input  [31:0] ISSUE_INSTR_top,
    (* FABulous, EXTERNAL *) input  [31:0] ISSUE_OPA_top,
    (* FABulous, EXTERNAL *) input  [31:0] ISSUE_OPB_top,
    (* FABulous, EXTERNAL *) input  [ 3:0] ISSUE_ID_top,
    
    (* FABulous, EXTERNAL *) output        RESULT_VALID_top,
    (* FABulous, EXTERNAL *) output [ 3:0] RESULT_ID_top,
    (* FABulous, EXTERNAL *) output [ 4:0] RESULT_RD_top,
    (* FABulous, EXTERNAL *) output [31:0] RESULT_top,

    	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);

    assign ISSUE_READY_top  = ISSUE_READY;
    assign ISSUE_ACCEPT_top = ISSUE_ACCEPT;

    assign ISSUE_VALID  = ISSUE_VALID_top;
    assign ISSUE_INSTR  = ISSUE_INSTR_top;
    assign ISSUE_OPA    = ISSUE_OPA_top;
    assign ISSUE_OPB    = ISSUE_OPB_top;
    assign ISSUE_ID     = ISSUE_ID_top;

    assign RESULT_VALID_top = RESULT_VALID;
    assign RESULT_ID_top    = RESULT_ID;
    assign RESULT_RD_top    = RESULT_RD;
    assign RESULT_top       = RESULT;

endmodule
