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


module OBI_PERIPHERAL #(parameter NoConfigBits = 0)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)

	// User design
    output        REQ,
    output        WE,
    output [3: 0] BE,
    output [23:0] ADDR,
    output [31:0] WDATA,
    
    input         GNT,
    input         RVALID,
    input  [31:0] RDATA,

    // Top
    (* FABulous, EXTERNAL *) input        REQ_top,
    (* FABulous, EXTERNAL *) input        WE_top,
    (* FABulous, EXTERNAL *) input [3: 0] BE_top,
    (* FABulous, EXTERNAL *) input [23:0] ADDR_top,
    (* FABulous, EXTERNAL *) input [31:0] WDATA_top,
    
    (* FABulous, EXTERNAL *) output         GNT_top,
    (* FABulous, EXTERNAL *) output         RVALID_top,
    (* FABulous, EXTERNAL *) output  [31:0] RDATA_top,

    	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);

    assign REQ   = REQ_top;
    assign WE    = WE_top;
    assign BE    = BE_top;
    assign ADDR  = ADDR_top;
    assign WDATA = WDATA_top;

    assign GNT_top      = GNT;
    assign RVALID_top   = RVALID;
    assign RDATA_top    = RDATA;

endmodule
