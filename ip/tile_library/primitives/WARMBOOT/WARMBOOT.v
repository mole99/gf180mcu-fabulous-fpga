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


module WARMBOOT #(
    parameter NoConfigBits = 0,
    parameter SLOT_BITS = 4
)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)

	// User design
    input  [(SLOT_BITS - 1) : 0] SLOT,
    input                        BOOT,
    output                       RESET,

    // Top
    (* FABulous, EXTERNAL *) output [(SLOT_BITS - 1) : 0] SLOT_top,
    (* FABulous, EXTERNAL *) output                       BOOT_top,
    (* FABulous, EXTERNAL *) input                        RESET_top,
    
    (* FABulous, EXTERNAL *) input                        CONFIGURED_top,

    	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);

	assign SLOT_top = SLOT;
	// Only trigger boot if the fabric is configured
	assign BOOT_top = BOOT && CONFIGURED_top;
	assign RESET = RESET_top;

endmodule
