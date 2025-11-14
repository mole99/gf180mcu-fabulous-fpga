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

module IHP_BRAM_1024x16 #(parameter NoConfigBits = 0)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)
	
	// User design
	
    // Port A
    input  [(10 - 1) : 0] A_ADDR,
    input  [(16 - 1) : 0] A_DIN,
    input  [(16 - 1) : 0] A_BM,
    input                 A_WEN,
    input                 A_MEN,
    input                 A_REN,
    	output [(16 - 1) : 0] A_DOUT,

    // Port B
    input  [(10 - 1) : 0] B_ADDR,
    input  [(16 - 1) : 0] B_DIN,
    input  [(16 - 1) : 0] B_BM,
    input                 B_WEN,
    input                 B_MEN,
    input                 B_REN,
    	output [(16 - 1) : 0] B_DOUT,

	// SRAM
	
    // Port A
    (* FABulous, EXTERNAL *) output [(10 - 1) : 0] A_ADDR_BRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] A_DIN_BRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] A_BM_BRAM,
    (* FABulous, EXTERNAL *) output                A_WEN_BRAM,
    (* FABulous, EXTERNAL *) output                A_MEN_BRAM,
    (* FABulous, EXTERNAL *) output                A_REN_BRAM,
    (* FABulous, EXTERNAL *) input  [(16 - 1) : 0] A_DOUT_BRAM,
    
    (* FABulous, EXTERNAL *) output                A_CLK_BRAM,

    (* FABulous, EXTERNAL *) output                A_TIE_HIGH_BRAM,
    (* FABulous, EXTERNAL *) output                A_TIE_LOW_BRAM,

    // Port B
    (* FABulous, EXTERNAL *) output [(10 - 1) : 0] B_ADDR_BRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] B_DIN_BRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] B_BM_BRAM,
    (* FABulous, EXTERNAL *) output                B_WEN_BRAM,
    (* FABulous, EXTERNAL *) output                B_MEN_BRAM,
    (* FABulous, EXTERNAL *) output                B_REN_BRAM,
    (* FABulous, EXTERNAL *) input  [(16 - 1) : 0] B_DOUT_BRAM,
    
    (* FABulous, EXTERNAL *) output                B_CLK_BRAM,

    (* FABulous, EXTERNAL *) output                B_TIE_HIGH_BRAM,
    (* FABulous, EXTERNAL *) output                B_TIE_LOW_BRAM,

    (* FABulous, EXTERNAL *) input                 CONFIGURED_top,
    
    // External and shared clock
    (* FABulous, EXTERNAL, SHARED_PORT *) input UserCLK,
    
    	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    // Port A
	assign A_ADDR_BRAM    = A_ADDR;
	assign A_DIN_BRAM     = A_DIN;
	assign A_BM_BRAM      = A_BM;
	assign A_WEN_BRAM     = A_WEN;
	// Only enable the SRAM if the fabric is configured
	assign A_MEN_BRAM     = A_MEN && CONFIGURED_top;
	assign A_REN_BRAM     = A_REN;
	assign A_DOUT         = A_DOUT_BRAM;

	assign A_CLK_BRAM       = UserCLK;

	assign A_TIE_HIGH_BRAM = 1'b1;
	assign A_TIE_LOW_BRAM  = 1'b0;

    // Port B
	assign B_ADDR_BRAM    = B_ADDR;
	assign B_DIN_BRAM     = B_DIN;
	assign B_BM_BRAM      = B_BM;
	assign B_WEN_BRAM     = B_WEN;
	// Only enable the SRAM if the fabric is configured
	assign B_MEN_BRAM     = B_MEN && CONFIGURED_top;
	assign B_REN_BRAM     = B_REN;
	assign B_DOUT         = B_DOUT_BRAM;

	assign B_CLK_BRAM       = UserCLK;

	assign B_TIE_HIGH_BRAM = 1'b1;
	assign B_TIE_LOW_BRAM  = 1'b0;

endmodule
