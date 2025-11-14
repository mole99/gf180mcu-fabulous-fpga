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


module CPU_IRQ #(
    parameter NoConfigBits = 0,
    parameter NUM_IRQ = 4
)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)

	// User design
    input  [(NUM_IRQ - 1) : 0] IRQ,

    // Top
    (* FABulous, EXTERNAL *) output [(NUM_IRQ - 1) : 0] IRQ_top,
    
    (* FABulous, EXTERNAL *) input                        CONFIGURED_top,

    	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);

	// Only trigger IRQs if the fabric is configured
	assign IRQ_top  = IRQ & {NUM_IRQ{CONFIGURED_top}};

endmodule
