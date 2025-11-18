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

module GF_SRAM_512x8 #(
  parameter NoConfigBits = 0,
  parameter WIDTH        = 8,
  parameter ADDR_BITS    = 9
  )(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)
	
	// User design
    input                         CEN,
    input                         GWEN,
    input  [(WIDTH - 1) : 0]      WEN,
    input  [(ADDR_BITS - 1) : 0]  A,
    input  [(WIDTH - 1) : 0]      D,
    	output [(WIDTH - 1) : 0]      Q,

	// SRAM
    (* FABulous, EXTERNAL *) output                       CEN_SRAM,
    (* FABulous, EXTERNAL *) output                       GWEN_SRAM,
    (* FABulous, EXTERNAL *) output [(WIDTH - 1) : 0]     WEN_SRAM,
    (* FABulous, EXTERNAL *) output [(ADDR_BITS - 1) : 0] A_SRAM,
    (* FABulous, EXTERNAL *) output [(WIDTH - 1) : 0]     D_SRAM,
    (* FABulous, EXTERNAL *) input  [(WIDTH - 1) : 0]     Q_SRAM,
    
    (* FABulous, EXTERNAL *) output                       CLK_SRAM,
    
    (* FABulous, EXTERNAL *) input CONFIGURED_top,
    
    // External and shared clock
    (* FABulous, EXTERNAL, SHARED_PORT *) input UserCLK
    
    //	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
  
  	// Only enable the SRAM if the fabric is configured
	assign CEN_SRAM   = CEN && CONFIGURED_top;
	assign GWEN_SRAM  = GWEN;
	assign WEN_SRAM   = WEN;
	assign A_SRAM     = A;
	assign D_SRAM     = D;
	assign Q          = Q_SRAM;

	assign CLK_SRAM     = UserCLK;

endmodule
