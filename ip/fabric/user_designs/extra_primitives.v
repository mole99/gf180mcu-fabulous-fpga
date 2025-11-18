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

(* blackbox *)
module GF_SRAM_512x8 (
    input  A0,
    input  A1,
    input  A2,
    input  A3,
    input  A4,
    input  A5,
    input  A6,
    input  A7,
    input  A8,

    input  WEN0,
    input  WEN1,
    input  WEN2,
    input  WEN3,
    input  WEN4,
    input  WEN5,
    input  WEN6,
    input  WEN7,

    input  D0,
    input  D1,
    input  D2,
    input  D3,
    input  D4,
    input  D5,
    input  D6,
    input  D7,

    input  GWEN,
    input  CEN,

    output Q0,
    output Q1,
    output Q2,
    output Q3,
    output Q4,
    output Q5,
    output Q6,
    output Q7
);

endmodule

(* blackbox, keep *)
module WARMBOOT (
    input  SLOT0,
    input  SLOT1,
    input  SLOT2,
    input  SLOT3,
    input  BOOT,
    output RESET
);

endmodule

(* blackbox *)
module MULADD #(
    parameter A_reg=0,
    parameter B_reg=0,
    parameter C_reg=0,
    parameter signExtension=0,
    parameter ACC=0,
    parameter ACCout=0
)(
    input A0,
    input A1,
    input A2,
    input A3,
    input A4,
    input A5,
    input A6,
    input A7,
    
    input B0,
    input B1,
    input B2,
    input B3,
    input B4,
    input B5,
    input B6,
    input B7,
    
    input C0,
    input C1,
    input C2,
    input C3,
    input C4,
    input C5,
    input C6,
    input C7,
    input C8,
    input C9,
    input C10,
    input C11,
    input C12,
    input C13,
    input C14,
    input C15,
    input C16,
    input C17,
    input C18,
    input C19,
    
    input clr,
    
    output Q0,
    output Q1,
    output Q2,
    output Q3,
    output Q4,
    output Q5,
    output Q6,
    output Q7,
    output Q8,
    output Q9,
    output Q10,
    output Q11,
    output Q12,
    output Q13,
    output Q14,
    output Q15,
    output Q16,
    output Q17,
    output Q18,
    output Q19
);

endmodule
