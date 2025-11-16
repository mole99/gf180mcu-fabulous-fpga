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

module IHP_SRAM_1024x32 #(parameter NoConfigBits = 0)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)
	
	// User design
    input  [(10 - 1) : 0] A_ADDR,
    input  [(32 - 1) : 0] A_DIN,
    input  [(32 - 1) : 0] A_BM,
    input                 A_WEN,
    input                 A_MEN,
    input                 A_REN,
    	output [(32 - 1) : 0] A_DOUT,

	// SRAM
    (* FABulous, EXTERNAL *) output [(10 - 1) : 0] A_ADDR_SRAM,
    (* FABulous, EXTERNAL *) output [(32 - 1) : 0] A_DIN_SRAM,
    (* FABulous, EXTERNAL *) output [(32 - 1) : 0] A_BM_SRAM,
    (* FABulous, EXTERNAL *) output                A_WEN_SRAM,
    (* FABulous, EXTERNAL *) output                A_MEN_SRAM,
    (* FABulous, EXTERNAL *) output                A_REN_SRAM,
    (* FABulous, EXTERNAL *) input  [(32 - 1) : 0] A_DOUT_SRAM,
    
    (* FABulous, EXTERNAL *) output                A_CLK_SRAM,
    
    (* FABulous, EXTERNAL *) output                A_TIE_HIGH_SRAM,
    (* FABulous, EXTERNAL *) output                A_TIE_LOW_SRAM,
    
    (* FABulous, EXTERNAL *) input                 CONFIGURED_top,
    
    // External and shared clock
    (* FABulous, EXTERNAL, SHARED_PORT *) input UserCLK
    
    //	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    
	assign A_ADDR_SRAM    = A_ADDR;
	assign A_DIN_SRAM     = A_DIN;
	assign A_BM_SRAM      = A_BM;
	assign A_WEN_SRAM     = A_WEN;
	// Only enable the SRAM if the fabric is configured
	assign A_MEN_SRAM     = A_MEN && CONFIGURED_top;
	assign A_REN_SRAM     = A_REN;
	assign A_DOUT         = A_DOUT_SRAM;

	assign A_CLK_SRAM     = UserCLK;
	
	assign A_TIE_HIGH_SRAM = 1'b1;
	assign A_TIE_LOW_SRAM  = 1'b0;

endmodule
