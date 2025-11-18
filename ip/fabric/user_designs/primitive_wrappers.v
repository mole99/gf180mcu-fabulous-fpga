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

module GF_SRAM_512x8_wrapper (
    input  [9:0] A,
    input  [7:0] WEN,
    input  [7:0] D,
    input        GWEN,
    input        CEN,
    output [7:0] Q
);
    GF_SRAM_512x8 i_GF_SRAM_512x8 (
        .A0 (A[0]),
        .A1 (A[1]),
        .A2 (A[2]),
        .A3 (A[3]),
        .A4 (A[4]),
        .A5 (A[5]),
        .A6 (A[6]),
        .A7 (A[7]),
        .A8 (A[8]),

        .WEN0 (WEN[0]),
        .WEN1 (WEN[1]),
        .WEN2 (WEN[2]),
        .WEN3 (WEN[3]),
        .WEN4 (WEN[4]),
        .WEN5 (WEN[5]),
        .WEN6 (WEN[6]),
        .WEN7 (WEN[7]),

        .D0 (D[0]),
        .D1 (D[1]),
        .D2 (D[2]),
        .D3 (D[3]),
        .D4 (D[4]),
        .D5 (D[5]),
        .D6 (D[6]),
        .D7 (D[7]),

        .GWEN (GWEN),
        .CEN (CEN),

        .Q0 (Q[0]),
        .Q1 (Q[1]),
        .Q2 (Q[2]),
        .Q3 (Q[3]),
        .Q4 (Q[4]),
        .Q5 (Q[5]),
        .Q6 (Q[6]),
        .Q7 (Q[7])
    );

endmodule

module WARMBOOT_wrapper (
    input  [3:0] SLOT,
    input        BOOT,
    output       RESET
);

    WARMBOOT i_WARMBOOT (
        .SLOT0  (SLOT[0]),
        .SLOT1  (SLOT[1]),
        .SLOT2  (SLOT[2]),
        .SLOT3  (SLOT[3]),
        .BOOT   (BOOT),
        .RESET  (RESET)
    );

endmodule

module MULADD_wrapper #(
    parameter A_reg=0,
    parameter B_reg=0,
    parameter C_reg=0,
    parameter signExtension=0,
    parameter ACC=0,
    parameter ACCout=0
) (
    input [7:0] A,
    input [7:0] B,
    input [19:0] C,
    input clr,
    
    output [19:0] Q
);

    MULADD #(
        .A_reg  (A_reg),
        .B_reg  (B_reg),
        .C_reg  (C_reg),
        
        .signExtension  (signExtension),
        .ACC            (ACC),
        .ACCout         (ACCout),
    ) muladd (
        .A0 (A[0]),
        .A1 (A[1]),
        .A2 (A[2]),
        .A3 (A[3]),
        .A4 (A[4]),
        .A5 (A[5]),
        .A6 (A[6]),
        .A7 (A[7]),

        .B0 (B[0]),
        .B1 (B[1]),
        .B2 (B[2]),
        .B3 (B[3]),
        .B4 (B[4]),
        .B5 (B[5]),
        .B6 (B[6]),
        .B7 (B[7]),
        
        .C0 (C[0]),
        .C1 (C[1]),
        .C2 (C[2]),
        .C3 (C[3]),
        .C4 (C[4]),
        .C5 (C[5]),
        .C6 (C[6]),
        .C7 (C[7]),
        .C8 (C[8]),
        .C9 (C[9]),
        .C10 (C[10]),
        .C11 (C[11]),
        .C12 (C[12]),
        .C13 (C[13]),
        .C14 (C[14]),
        .C15 (C[15]),
        .C16 (C[16]),
        .C17 (C[17]),
        .C18 (C[18]),
        .C19 (C[19]),
        
        .clr (clr),
        
        .Q0 (Q[0]),
        .Q1 (Q[1]),
        .Q2 (Q[2]),
        .Q3 (Q[3]),
        .Q4 (Q[4]),
        .Q5 (Q[5]),
        .Q6 (Q[6]),
        .Q7 (Q[7]),
        .Q8 (Q[8]),
        .Q9 (Q[9]),
        .Q10 (Q[10]),
        .Q11 (Q[11]),
        .Q12 (Q[12]),
        .Q13 (Q[13]),
        .Q14 (Q[14]),
        .Q15 (Q[15]),
        .Q16 (Q[16]),
        .Q17 (Q[17]),
        .Q18 (Q[18]),
        .Q19 (Q[19])
    );

endmodule
