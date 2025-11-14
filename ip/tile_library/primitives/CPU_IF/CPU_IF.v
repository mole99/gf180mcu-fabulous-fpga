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


module CPU_IF #(parameter NoConfigBits = 0)(
	// ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)

	// User design
    input  [(16 - 1) : 0] I,
    output [(16 - 1) : 0] O,

    // Top
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] I_top,
    (* FABulous, EXTERNAL *) input  [(16 - 1) : 0] O_top,

    	(* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);

	assign I_top  = I;
	assign O      = O_top;

endmodule
