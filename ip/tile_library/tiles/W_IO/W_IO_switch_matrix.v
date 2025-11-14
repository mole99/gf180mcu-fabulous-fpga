 // NumberOfConfigBits: 106
module W_IO_switch_matrix
    #(
        parameter NoConfigBits=106
    )
    (
        input  W1END0,
        input  W1END1,
        input  W1END2,
        input  W1END3,
        input  W2MID0,
        input  W2MID1,
        input  W2MID2,
        input  W2MID3,
        input  W2MID4,
        input  W2MID5,
        input  W2MID6,
        input  W2MID7,
        input  W2END0,
        input  W2END1,
        input  W2END2,
        input  W2END3,
        input  W2END4,
        input  W2END5,
        input  W2END6,
        input  W2END7,
        input  WW4END0,
        input  WW4END1,
        input  WW4END2,
        input  WW4END3,
        input  WW4END4,
        input  WW4END5,
        input  WW4END6,
        input  WW4END7,
        input  WW4END8,
        input  WW4END9,
        input  WW4END10,
        input  WW4END11,
        input  WW4END12,
        input  WW4END13,
        input  WW4END14,
        input  WW4END15,
        input  W6END0,
        input  W6END1,
        input  W6END2,
        input  W6END3,
        input  W6END4,
        input  W6END5,
        input  W6END6,
        input  W6END7,
        input  W6END8,
        input  W6END9,
        input  W6END10,
        input  W6END11,
        input  A_O,
        input  A_Q,
        input  B_O,
        input  B_Q,
        output  E1BEG0,
        output  E1BEG1,
        output  E1BEG2,
        output  E1BEG3,
        output  E2BEG0,
        output  E2BEG1,
        output  E2BEG2,
        output  E2BEG3,
        output  E2BEG4,
        output  E2BEG5,
        output  E2BEG6,
        output  E2BEG7,
        output  E2BEGb0,
        output  E2BEGb1,
        output  E2BEGb2,
        output  E2BEGb3,
        output  E2BEGb4,
        output  E2BEGb5,
        output  E2BEGb6,
        output  E2BEGb7,
        output  EE4BEG0,
        output  EE4BEG1,
        output  EE4BEG2,
        output  EE4BEG3,
        output  EE4BEG4,
        output  EE4BEG5,
        output  EE4BEG6,
        output  EE4BEG7,
        output  EE4BEG8,
        output  EE4BEG9,
        output  EE4BEG10,
        output  EE4BEG11,
        output  EE4BEG12,
        output  EE4BEG13,
        output  EE4BEG14,
        output  EE4BEG15,
        output  E6BEG0,
        output  E6BEG1,
        output  E6BEG2,
        output  E6BEG3,
        output  E6BEG4,
        output  E6BEG5,
        output  E6BEG6,
        output  E6BEG7,
        output  E6BEG8,
        output  E6BEG9,
        output  E6BEG10,
        output  E6BEG11,
        output  A_I,
        output  A_T,
        output  B_I,
        output  B_T,
 //global
        input  [NoConfigBits-1:0] ConfigBits,
        input  [NoConfigBits-1:0] ConfigBits_N
);
parameter GND0 = 1'b0;
parameter GND = 1'b0;
parameter VCC0 = 1'b1;
parameter VCC = 1'b1;
parameter VDD0 = 1'b1;
parameter VDD = 1'b1;

wire[2-1:0] E1BEG0_input;
wire[2-1:0] E1BEG1_input;
wire[2-1:0] E1BEG2_input;
wire[2-1:0] E1BEG3_input;
wire[4-1:0] E2BEG0_input;
wire[4-1:0] E2BEG1_input;
wire[4-1:0] E2BEG2_input;
wire[4-1:0] E2BEG3_input;
wire[4-1:0] E2BEG4_input;
wire[4-1:0] E2BEG5_input;
wire[4-1:0] E2BEG6_input;
wire[4-1:0] E2BEG7_input;
wire[4-1:0] E2BEGb0_input;
wire[4-1:0] E2BEGb1_input;
wire[4-1:0] E2BEGb2_input;
wire[4-1:0] E2BEGb3_input;
wire[4-1:0] E2BEGb4_input;
wire[4-1:0] E2BEGb5_input;
wire[4-1:0] E2BEGb6_input;
wire[4-1:0] E2BEGb7_input;
wire[4-1:0] EE4BEG0_input;
wire[4-1:0] EE4BEG1_input;
wire[4-1:0] EE4BEG2_input;
wire[4-1:0] EE4BEG3_input;
wire[4-1:0] EE4BEG4_input;
wire[4-1:0] EE4BEG5_input;
wire[4-1:0] EE4BEG6_input;
wire[4-1:0] EE4BEG7_input;
wire[4-1:0] EE4BEG8_input;
wire[4-1:0] EE4BEG9_input;
wire[4-1:0] EE4BEG10_input;
wire[4-1:0] EE4BEG11_input;
wire[4-1:0] EE4BEG12_input;
wire[4-1:0] EE4BEG13_input;
wire[4-1:0] EE4BEG14_input;
wire[4-1:0] EE4BEG15_input;
wire[4-1:0] E6BEG0_input;
wire[4-1:0] E6BEG1_input;
wire[4-1:0] E6BEG2_input;
wire[4-1:0] E6BEG3_input;
wire[4-1:0] E6BEG4_input;
wire[4-1:0] E6BEG5_input;
wire[4-1:0] E6BEG6_input;
wire[4-1:0] E6BEG7_input;
wire[4-1:0] E6BEG8_input;
wire[4-1:0] E6BEG9_input;
wire[4-1:0] E6BEG10_input;
wire[4-1:0] E6BEG11_input;
wire[16-1:0] A_I_input;
wire[8-1:0] A_T_input;
wire[16-1:0] B_I_input;
wire[8-1:0] B_T_input;
 //The configuration bits (if any) are just a long shift register
 //This shift register is padded to an even number of flops/latches
 //switch matrix multiplexer E1BEG0 MUX-2
assign E1BEG0_input = {A_O,W1END3};
cus_mux21 inst_cus_mux21_E1BEG0 (
    .A0(E1BEG0_input[0]),
    .A1(E1BEG0_input[1]),
    .S(ConfigBits[0+0]),
    .X(E1BEG0)
);

 //switch matrix multiplexer E1BEG1 MUX-2
assign E1BEG1_input = {A_Q,W1END2};
cus_mux21 inst_cus_mux21_E1BEG1 (
    .A0(E1BEG1_input[0]),
    .A1(E1BEG1_input[1]),
    .S(ConfigBits[1+0]),
    .X(E1BEG1)
);

 //switch matrix multiplexer E1BEG2 MUX-2
assign E1BEG2_input = {B_O,W1END1};
cus_mux21 inst_cus_mux21_E1BEG2 (
    .A0(E1BEG2_input[0]),
    .A1(E1BEG2_input[1]),
    .S(ConfigBits[2+0]),
    .X(E1BEG2)
);

 //switch matrix multiplexer E1BEG3 MUX-2
assign E1BEG3_input = {B_Q,W1END0};
cus_mux21 inst_cus_mux21_E1BEG3 (
    .A0(E1BEG3_input[0]),
    .A1(E1BEG3_input[1]),
    .S(ConfigBits[3+0]),
    .X(E1BEG3)
);

 //switch matrix multiplexer E2BEG0 MUX-4
assign E2BEG0_input = {W6END7,WW4END15,WW4END7,W2MID7};
cus_mux41_buf inst_cus_mux41_buf_E2BEG0 (
    .A0(E2BEG0_input[0]),
    .A1(E2BEG0_input[1]),
    .A2(E2BEG0_input[2]),
    .A3(E2BEG0_input[3]),
    .S0(ConfigBits[4+0]),
    .S0N(ConfigBits_N[4+0]),
    .S1(ConfigBits[4+1]),
    .S1N(ConfigBits_N[4+1]),
    .X(E2BEG0)
);

 //switch matrix multiplexer E2BEG1 MUX-4
assign E2BEG1_input = {W6END6,WW4END14,WW4END6,W2MID6};
cus_mux41_buf inst_cus_mux41_buf_E2BEG1 (
    .A0(E2BEG1_input[0]),
    .A1(E2BEG1_input[1]),
    .A2(E2BEG1_input[2]),
    .A3(E2BEG1_input[3]),
    .S0(ConfigBits[6+0]),
    .S0N(ConfigBits_N[6+0]),
    .S1(ConfigBits[6+1]),
    .S1N(ConfigBits_N[6+1]),
    .X(E2BEG1)
);

 //switch matrix multiplexer E2BEG2 MUX-4
assign E2BEG2_input = {W6END5,WW4END13,WW4END5,W2MID5};
cus_mux41_buf inst_cus_mux41_buf_E2BEG2 (
    .A0(E2BEG2_input[0]),
    .A1(E2BEG2_input[1]),
    .A2(E2BEG2_input[2]),
    .A3(E2BEG2_input[3]),
    .S0(ConfigBits[8+0]),
    .S0N(ConfigBits_N[8+0]),
    .S1(ConfigBits[8+1]),
    .S1N(ConfigBits_N[8+1]),
    .X(E2BEG2)
);

 //switch matrix multiplexer E2BEG3 MUX-4
assign E2BEG3_input = {W6END4,WW4END12,WW4END4,W2MID4};
cus_mux41_buf inst_cus_mux41_buf_E2BEG3 (
    .A0(E2BEG3_input[0]),
    .A1(E2BEG3_input[1]),
    .A2(E2BEG3_input[2]),
    .A3(E2BEG3_input[3]),
    .S0(ConfigBits[10+0]),
    .S0N(ConfigBits_N[10+0]),
    .S1(ConfigBits[10+1]),
    .S1N(ConfigBits_N[10+1]),
    .X(E2BEG3)
);

 //switch matrix multiplexer E2BEG4 MUX-4
assign E2BEG4_input = {W6END3,WW4END11,WW4END3,W2MID3};
cus_mux41_buf inst_cus_mux41_buf_E2BEG4 (
    .A0(E2BEG4_input[0]),
    .A1(E2BEG4_input[1]),
    .A2(E2BEG4_input[2]),
    .A3(E2BEG4_input[3]),
    .S0(ConfigBits[12+0]),
    .S0N(ConfigBits_N[12+0]),
    .S1(ConfigBits[12+1]),
    .S1N(ConfigBits_N[12+1]),
    .X(E2BEG4)
);

 //switch matrix multiplexer E2BEG5 MUX-4
assign E2BEG5_input = {W6END2,WW4END10,WW4END2,W2MID2};
cus_mux41_buf inst_cus_mux41_buf_E2BEG5 (
    .A0(E2BEG5_input[0]),
    .A1(E2BEG5_input[1]),
    .A2(E2BEG5_input[2]),
    .A3(E2BEG5_input[3]),
    .S0(ConfigBits[14+0]),
    .S0N(ConfigBits_N[14+0]),
    .S1(ConfigBits[14+1]),
    .S1N(ConfigBits_N[14+1]),
    .X(E2BEG5)
);

 //switch matrix multiplexer E2BEG6 MUX-4
assign E2BEG6_input = {W6END1,WW4END9,WW4END1,W2MID1};
cus_mux41_buf inst_cus_mux41_buf_E2BEG6 (
    .A0(E2BEG6_input[0]),
    .A1(E2BEG6_input[1]),
    .A2(E2BEG6_input[2]),
    .A3(E2BEG6_input[3]),
    .S0(ConfigBits[16+0]),
    .S0N(ConfigBits_N[16+0]),
    .S1(ConfigBits[16+1]),
    .S1N(ConfigBits_N[16+1]),
    .X(E2BEG6)
);

 //switch matrix multiplexer E2BEG7 MUX-4
assign E2BEG7_input = {W6END0,WW4END8,WW4END0,W2MID0};
cus_mux41_buf inst_cus_mux41_buf_E2BEG7 (
    .A0(E2BEG7_input[0]),
    .A1(E2BEG7_input[1]),
    .A2(E2BEG7_input[2]),
    .A3(E2BEG7_input[3]),
    .S0(ConfigBits[18+0]),
    .S0N(ConfigBits_N[18+0]),
    .S1(ConfigBits[18+1]),
    .S1N(ConfigBits_N[18+1]),
    .X(E2BEG7)
);

 //switch matrix multiplexer E2BEGb0 MUX-4
assign E2BEGb0_input = {W6END7,WW4END15,WW4END7,W2END7};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb0 (
    .A0(E2BEGb0_input[0]),
    .A1(E2BEGb0_input[1]),
    .A2(E2BEGb0_input[2]),
    .A3(E2BEGb0_input[3]),
    .S0(ConfigBits[20+0]),
    .S0N(ConfigBits_N[20+0]),
    .S1(ConfigBits[20+1]),
    .S1N(ConfigBits_N[20+1]),
    .X(E2BEGb0)
);

 //switch matrix multiplexer E2BEGb1 MUX-4
assign E2BEGb1_input = {W6END6,WW4END14,WW4END6,W2END6};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb1 (
    .A0(E2BEGb1_input[0]),
    .A1(E2BEGb1_input[1]),
    .A2(E2BEGb1_input[2]),
    .A3(E2BEGb1_input[3]),
    .S0(ConfigBits[22+0]),
    .S0N(ConfigBits_N[22+0]),
    .S1(ConfigBits[22+1]),
    .S1N(ConfigBits_N[22+1]),
    .X(E2BEGb1)
);

 //switch matrix multiplexer E2BEGb2 MUX-4
assign E2BEGb2_input = {W6END5,WW4END13,WW4END5,W2END5};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb2 (
    .A0(E2BEGb2_input[0]),
    .A1(E2BEGb2_input[1]),
    .A2(E2BEGb2_input[2]),
    .A3(E2BEGb2_input[3]),
    .S0(ConfigBits[24+0]),
    .S0N(ConfigBits_N[24+0]),
    .S1(ConfigBits[24+1]),
    .S1N(ConfigBits_N[24+1]),
    .X(E2BEGb2)
);

 //switch matrix multiplexer E2BEGb3 MUX-4
assign E2BEGb3_input = {W6END4,WW4END12,WW4END4,W2END4};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb3 (
    .A0(E2BEGb3_input[0]),
    .A1(E2BEGb3_input[1]),
    .A2(E2BEGb3_input[2]),
    .A3(E2BEGb3_input[3]),
    .S0(ConfigBits[26+0]),
    .S0N(ConfigBits_N[26+0]),
    .S1(ConfigBits[26+1]),
    .S1N(ConfigBits_N[26+1]),
    .X(E2BEGb3)
);

 //switch matrix multiplexer E2BEGb4 MUX-4
assign E2BEGb4_input = {W6END3,WW4END11,WW4END3,W2END3};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb4 (
    .A0(E2BEGb4_input[0]),
    .A1(E2BEGb4_input[1]),
    .A2(E2BEGb4_input[2]),
    .A3(E2BEGb4_input[3]),
    .S0(ConfigBits[28+0]),
    .S0N(ConfigBits_N[28+0]),
    .S1(ConfigBits[28+1]),
    .S1N(ConfigBits_N[28+1]),
    .X(E2BEGb4)
);

 //switch matrix multiplexer E2BEGb5 MUX-4
assign E2BEGb5_input = {W6END2,WW4END10,WW4END2,W2END2};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb5 (
    .A0(E2BEGb5_input[0]),
    .A1(E2BEGb5_input[1]),
    .A2(E2BEGb5_input[2]),
    .A3(E2BEGb5_input[3]),
    .S0(ConfigBits[30+0]),
    .S0N(ConfigBits_N[30+0]),
    .S1(ConfigBits[30+1]),
    .S1N(ConfigBits_N[30+1]),
    .X(E2BEGb5)
);

 //switch matrix multiplexer E2BEGb6 MUX-4
assign E2BEGb6_input = {W6END1,WW4END9,WW4END1,W2END1};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb6 (
    .A0(E2BEGb6_input[0]),
    .A1(E2BEGb6_input[1]),
    .A2(E2BEGb6_input[2]),
    .A3(E2BEGb6_input[3]),
    .S0(ConfigBits[32+0]),
    .S0N(ConfigBits_N[32+0]),
    .S1(ConfigBits[32+1]),
    .S1N(ConfigBits_N[32+1]),
    .X(E2BEGb6)
);

 //switch matrix multiplexer E2BEGb7 MUX-4
assign E2BEGb7_input = {W6END0,WW4END8,WW4END0,W2END0};
cus_mux41_buf inst_cus_mux41_buf_E2BEGb7 (
    .A0(E2BEGb7_input[0]),
    .A1(E2BEGb7_input[1]),
    .A2(E2BEGb7_input[2]),
    .A3(E2BEGb7_input[3]),
    .S0(ConfigBits[34+0]),
    .S0N(ConfigBits_N[34+0]),
    .S1(ConfigBits[34+1]),
    .S1N(ConfigBits_N[34+1]),
    .X(E2BEGb7)
);

 //switch matrix multiplexer EE4BEG0 MUX-4
assign EE4BEG0_input = {A_O,W6END4,W6END2,W6END0};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG0 (
    .A0(EE4BEG0_input[0]),
    .A1(EE4BEG0_input[1]),
    .A2(EE4BEG0_input[2]),
    .A3(EE4BEG0_input[3]),
    .S0(ConfigBits[36+0]),
    .S0N(ConfigBits_N[36+0]),
    .S1(ConfigBits[36+1]),
    .S1N(ConfigBits_N[36+1]),
    .X(EE4BEG0)
);

 //switch matrix multiplexer EE4BEG1 MUX-4
assign EE4BEG1_input = {B_O,W6END10,W6END8,W6END6};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG1 (
    .A0(EE4BEG1_input[0]),
    .A1(EE4BEG1_input[1]),
    .A2(EE4BEG1_input[2]),
    .A3(EE4BEG1_input[3]),
    .S0(ConfigBits[38+0]),
    .S0N(ConfigBits_N[38+0]),
    .S1(ConfigBits[38+1]),
    .S1N(ConfigBits_N[38+1]),
    .X(EE4BEG1)
);

 //switch matrix multiplexer EE4BEG2 MUX-4
assign EE4BEG2_input = {A_Q,W6END5,W6END3,W6END1};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG2 (
    .A0(EE4BEG2_input[0]),
    .A1(EE4BEG2_input[1]),
    .A2(EE4BEG2_input[2]),
    .A3(EE4BEG2_input[3]),
    .S0(ConfigBits[40+0]),
    .S0N(ConfigBits_N[40+0]),
    .S1(ConfigBits[40+1]),
    .S1N(ConfigBits_N[40+1]),
    .X(EE4BEG2)
);

 //switch matrix multiplexer EE4BEG3 MUX-4
assign EE4BEG3_input = {B_Q,W6END11,W6END9,W6END7};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG3 (
    .A0(EE4BEG3_input[0]),
    .A1(EE4BEG3_input[1]),
    .A2(EE4BEG3_input[2]),
    .A3(EE4BEG3_input[3]),
    .S0(ConfigBits[42+0]),
    .S0N(ConfigBits_N[42+0]),
    .S1(ConfigBits[42+1]),
    .S1N(ConfigBits_N[42+1]),
    .X(EE4BEG3)
);

 //switch matrix multiplexer EE4BEG4 MUX-4
assign EE4BEG4_input = {W2END6,W2END4,W2END2,W2END0};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG4 (
    .A0(EE4BEG4_input[0]),
    .A1(EE4BEG4_input[1]),
    .A2(EE4BEG4_input[2]),
    .A3(EE4BEG4_input[3]),
    .S0(ConfigBits[44+0]),
    .S0N(ConfigBits_N[44+0]),
    .S1(ConfigBits[44+1]),
    .S1N(ConfigBits_N[44+1]),
    .X(EE4BEG4)
);

 //switch matrix multiplexer EE4BEG5 MUX-4
assign EE4BEG5_input = {W2END7,W2END5,W2END3,W2END1};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG5 (
    .A0(EE4BEG5_input[0]),
    .A1(EE4BEG5_input[1]),
    .A2(EE4BEG5_input[2]),
    .A3(EE4BEG5_input[3]),
    .S0(ConfigBits[46+0]),
    .S0N(ConfigBits_N[46+0]),
    .S1(ConfigBits[46+1]),
    .S1N(ConfigBits_N[46+1]),
    .X(EE4BEG5)
);

 //switch matrix multiplexer EE4BEG6 MUX-4
assign EE4BEG6_input = {W2MID6,W2MID4,W2MID2,W2MID0};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG6 (
    .A0(EE4BEG6_input[0]),
    .A1(EE4BEG6_input[1]),
    .A2(EE4BEG6_input[2]),
    .A3(EE4BEG6_input[3]),
    .S0(ConfigBits[48+0]),
    .S0N(ConfigBits_N[48+0]),
    .S1(ConfigBits[48+1]),
    .S1N(ConfigBits_N[48+1]),
    .X(EE4BEG6)
);

 //switch matrix multiplexer EE4BEG7 MUX-4
assign EE4BEG7_input = {W2MID7,W2MID5,W2MID3,W2MID1};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG7 (
    .A0(EE4BEG7_input[0]),
    .A1(EE4BEG7_input[1]),
    .A2(EE4BEG7_input[2]),
    .A3(EE4BEG7_input[3]),
    .S0(ConfigBits[50+0]),
    .S0N(ConfigBits_N[50+0]),
    .S1(ConfigBits[50+1]),
    .S1N(ConfigBits_N[50+1]),
    .X(EE4BEG7)
);

 //switch matrix multiplexer EE4BEG8 MUX-4
assign EE4BEG8_input = {W6END10,W6END8,W6END6,W6END4};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG8 (
    .A0(EE4BEG8_input[0]),
    .A1(EE4BEG8_input[1]),
    .A2(EE4BEG8_input[2]),
    .A3(EE4BEG8_input[3]),
    .S0(ConfigBits[52+0]),
    .S0N(ConfigBits_N[52+0]),
    .S1(ConfigBits[52+1]),
    .S1N(ConfigBits_N[52+1]),
    .X(EE4BEG8)
);

 //switch matrix multiplexer EE4BEG9 MUX-4
assign EE4BEG9_input = {W6END7,W6END5,W6END3,W6END1};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG9 (
    .A0(EE4BEG9_input[0]),
    .A1(EE4BEG9_input[1]),
    .A2(EE4BEG9_input[2]),
    .A3(EE4BEG9_input[3]),
    .S0(ConfigBits[54+0]),
    .S0N(ConfigBits_N[54+0]),
    .S1(ConfigBits[54+1]),
    .S1N(ConfigBits_N[54+1]),
    .X(EE4BEG9)
);

 //switch matrix multiplexer EE4BEG10 MUX-4
assign EE4BEG10_input = {A_O,W6END4,W6END2,W6END0};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG10 (
    .A0(EE4BEG10_input[0]),
    .A1(EE4BEG10_input[1]),
    .A2(EE4BEG10_input[2]),
    .A3(EE4BEG10_input[3]),
    .S0(ConfigBits[56+0]),
    .S0N(ConfigBits_N[56+0]),
    .S1(ConfigBits[56+1]),
    .S1N(ConfigBits_N[56+1]),
    .X(EE4BEG10)
);

 //switch matrix multiplexer EE4BEG11 MUX-4
assign EE4BEG11_input = {B_O,W6END10,W6END8,W6END6};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG11 (
    .A0(EE4BEG11_input[0]),
    .A1(EE4BEG11_input[1]),
    .A2(EE4BEG11_input[2]),
    .A3(EE4BEG11_input[3]),
    .S0(ConfigBits[58+0]),
    .S0N(ConfigBits_N[58+0]),
    .S1(ConfigBits[58+1]),
    .S1N(ConfigBits_N[58+1]),
    .X(EE4BEG11)
);

 //switch matrix multiplexer EE4BEG12 MUX-4
assign EE4BEG12_input = {A_Q,W6END5,W6END3,W6END1};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG12 (
    .A0(EE4BEG12_input[0]),
    .A1(EE4BEG12_input[1]),
    .A2(EE4BEG12_input[2]),
    .A3(EE4BEG12_input[3]),
    .S0(ConfigBits[60+0]),
    .S0N(ConfigBits_N[60+0]),
    .S1(ConfigBits[60+1]),
    .S1N(ConfigBits_N[60+1]),
    .X(EE4BEG12)
);

 //switch matrix multiplexer EE4BEG13 MUX-4
assign EE4BEG13_input = {B_Q,W6END11,W6END9,W6END7};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG13 (
    .A0(EE4BEG13_input[0]),
    .A1(EE4BEG13_input[1]),
    .A2(EE4BEG13_input[2]),
    .A3(EE4BEG13_input[3]),
    .S0(ConfigBits[62+0]),
    .S0N(ConfigBits_N[62+0]),
    .S1(ConfigBits[62+1]),
    .S1N(ConfigBits_N[62+1]),
    .X(EE4BEG13)
);

 //switch matrix multiplexer EE4BEG14 MUX-4
assign EE4BEG14_input = {W2MID6,W2MID4,W2MID2,W2MID0};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG14 (
    .A0(EE4BEG14_input[0]),
    .A1(EE4BEG14_input[1]),
    .A2(EE4BEG14_input[2]),
    .A3(EE4BEG14_input[3]),
    .S0(ConfigBits[64+0]),
    .S0N(ConfigBits_N[64+0]),
    .S1(ConfigBits[64+1]),
    .S1N(ConfigBits_N[64+1]),
    .X(EE4BEG14)
);

 //switch matrix multiplexer EE4BEG15 MUX-4
assign EE4BEG15_input = {W2MID7,W2MID5,W2MID3,W2MID1};
cus_mux41_buf inst_cus_mux41_buf_EE4BEG15 (
    .A0(EE4BEG15_input[0]),
    .A1(EE4BEG15_input[1]),
    .A2(EE4BEG15_input[2]),
    .A3(EE4BEG15_input[3]),
    .S0(ConfigBits[66+0]),
    .S0N(ConfigBits_N[66+0]),
    .S1(ConfigBits[66+1]),
    .S1N(ConfigBits_N[66+1]),
    .X(EE4BEG15)
);

 //switch matrix multiplexer E6BEG0 MUX-4
assign E6BEG0_input = {A_O,W6END11,WW4END11,W1END2};
cus_mux41_buf inst_cus_mux41_buf_E6BEG0 (
    .A0(E6BEG0_input[0]),
    .A1(E6BEG0_input[1]),
    .A2(E6BEG0_input[2]),
    .A3(E6BEG0_input[3]),
    .S0(ConfigBits[68+0]),
    .S0N(ConfigBits_N[68+0]),
    .S1(ConfigBits[68+1]),
    .S1N(ConfigBits_N[68+1]),
    .X(E6BEG0)
);

 //switch matrix multiplexer E6BEG1 MUX-4
assign E6BEG1_input = {B_O,W6END10,WW4END10,W1END3};
cus_mux41_buf inst_cus_mux41_buf_E6BEG1 (
    .A0(E6BEG1_input[0]),
    .A1(E6BEG1_input[1]),
    .A2(E6BEG1_input[2]),
    .A3(E6BEG1_input[3]),
    .S0(ConfigBits[70+0]),
    .S0N(ConfigBits_N[70+0]),
    .S1(ConfigBits[70+1]),
    .S1N(ConfigBits_N[70+1]),
    .X(E6BEG1)
);

 //switch matrix multiplexer E6BEG2 MUX-4
assign E6BEG2_input = {A_O,W6END7,WW4END15,WW4END7};
cus_mux41_buf inst_cus_mux41_buf_E6BEG2 (
    .A0(E6BEG2_input[0]),
    .A1(E6BEG2_input[1]),
    .A2(E6BEG2_input[2]),
    .A3(E6BEG2_input[3]),
    .S0(ConfigBits[72+0]),
    .S0N(ConfigBits_N[72+0]),
    .S1(ConfigBits[72+1]),
    .S1N(ConfigBits_N[72+1]),
    .X(E6BEG2)
);

 //switch matrix multiplexer E6BEG3 MUX-4
assign E6BEG3_input = {B_O,W6END6,WW4END14,WW4END6};
cus_mux41_buf inst_cus_mux41_buf_E6BEG3 (
    .A0(E6BEG3_input[0]),
    .A1(E6BEG3_input[1]),
    .A2(E6BEG3_input[2]),
    .A3(E6BEG3_input[3]),
    .S0(ConfigBits[74+0]),
    .S0N(ConfigBits_N[74+0]),
    .S1(ConfigBits[74+1]),
    .S1N(ConfigBits_N[74+1]),
    .X(E6BEG3)
);

 //switch matrix multiplexer E6BEG4 MUX-4
assign E6BEG4_input = {A_O,W6END3,WW4END3,W1END2};
cus_mux41_buf inst_cus_mux41_buf_E6BEG4 (
    .A0(E6BEG4_input[0]),
    .A1(E6BEG4_input[1]),
    .A2(E6BEG4_input[2]),
    .A3(E6BEG4_input[3]),
    .S0(ConfigBits[76+0]),
    .S0N(ConfigBits_N[76+0]),
    .S1(ConfigBits[76+1]),
    .S1N(ConfigBits_N[76+1]),
    .X(E6BEG4)
);

 //switch matrix multiplexer E6BEG5 MUX-4
assign E6BEG5_input = {B_O,W6END2,WW4END2,W1END3};
cus_mux41_buf inst_cus_mux41_buf_E6BEG5 (
    .A0(E6BEG5_input[0]),
    .A1(E6BEG5_input[1]),
    .A2(E6BEG5_input[2]),
    .A3(E6BEG5_input[3]),
    .S0(ConfigBits[78+0]),
    .S0N(ConfigBits_N[78+0]),
    .S1(ConfigBits[78+1]),
    .S1N(ConfigBits_N[78+1]),
    .X(E6BEG5)
);

 //switch matrix multiplexer E6BEG6 MUX-4
assign E6BEG6_input = {A_Q,W6END9,WW4END9,W1END1};
cus_mux41_buf inst_cus_mux41_buf_E6BEG6 (
    .A0(E6BEG6_input[0]),
    .A1(E6BEG6_input[1]),
    .A2(E6BEG6_input[2]),
    .A3(E6BEG6_input[3]),
    .S0(ConfigBits[80+0]),
    .S0N(ConfigBits_N[80+0]),
    .S1(ConfigBits[80+1]),
    .S1N(ConfigBits_N[80+1]),
    .X(E6BEG6)
);

 //switch matrix multiplexer E6BEG7 MUX-4
assign E6BEG7_input = {B_Q,W6END8,WW4END8,W1END0};
cus_mux41_buf inst_cus_mux41_buf_E6BEG7 (
    .A0(E6BEG7_input[0]),
    .A1(E6BEG7_input[1]),
    .A2(E6BEG7_input[2]),
    .A3(E6BEG7_input[3]),
    .S0(ConfigBits[82+0]),
    .S0N(ConfigBits_N[82+0]),
    .S1(ConfigBits[82+1]),
    .S1N(ConfigBits_N[82+1]),
    .X(E6BEG7)
);

 //switch matrix multiplexer E6BEG8 MUX-4
assign E6BEG8_input = {A_Q,W6END5,WW4END13,WW4END5};
cus_mux41_buf inst_cus_mux41_buf_E6BEG8 (
    .A0(E6BEG8_input[0]),
    .A1(E6BEG8_input[1]),
    .A2(E6BEG8_input[2]),
    .A3(E6BEG8_input[3]),
    .S0(ConfigBits[84+0]),
    .S0N(ConfigBits_N[84+0]),
    .S1(ConfigBits[84+1]),
    .S1N(ConfigBits_N[84+1]),
    .X(E6BEG8)
);

 //switch matrix multiplexer E6BEG9 MUX-4
assign E6BEG9_input = {B_Q,W6END4,WW4END12,WW4END4};
cus_mux41_buf inst_cus_mux41_buf_E6BEG9 (
    .A0(E6BEG9_input[0]),
    .A1(E6BEG9_input[1]),
    .A2(E6BEG9_input[2]),
    .A3(E6BEG9_input[3]),
    .S0(ConfigBits[86+0]),
    .S0N(ConfigBits_N[86+0]),
    .S1(ConfigBits[86+1]),
    .S1N(ConfigBits_N[86+1]),
    .X(E6BEG9)
);

 //switch matrix multiplexer E6BEG10 MUX-4
assign E6BEG10_input = {A_Q,W6END1,WW4END1,W1END1};
cus_mux41_buf inst_cus_mux41_buf_E6BEG10 (
    .A0(E6BEG10_input[0]),
    .A1(E6BEG10_input[1]),
    .A2(E6BEG10_input[2]),
    .A3(E6BEG10_input[3]),
    .S0(ConfigBits[88+0]),
    .S0N(ConfigBits_N[88+0]),
    .S1(ConfigBits[88+1]),
    .S1N(ConfigBits_N[88+1]),
    .X(E6BEG10)
);

 //switch matrix multiplexer E6BEG11 MUX-4
assign E6BEG11_input = {B_Q,W6END0,WW4END0,W1END0};
cus_mux41_buf inst_cus_mux41_buf_E6BEG11 (
    .A0(E6BEG11_input[0]),
    .A1(E6BEG11_input[1]),
    .A2(E6BEG11_input[2]),
    .A3(E6BEG11_input[3]),
    .S0(ConfigBits[90+0]),
    .S0N(ConfigBits_N[90+0]),
    .S1(ConfigBits[90+1]),
    .S1N(ConfigBits_N[90+1]),
    .X(E6BEG11)
);

 //switch matrix multiplexer A_I MUX-16
assign A_I_input = {W2END7,W2END6,W2END5,W2END4,W2END3,W2END2,W2END1,W2END0,W2MID7,W2MID6,W2MID5,W2MID4,W2MID3,W2MID2,W2MID1,W2MID0};
cus_mux161_buf inst_cus_mux161_buf_A_I (
    .A0(A_I_input[0]),
    .A1(A_I_input[1]),
    .A2(A_I_input[2]),
    .A3(A_I_input[3]),
    .A4(A_I_input[4]),
    .A5(A_I_input[5]),
    .A6(A_I_input[6]),
    .A7(A_I_input[7]),
    .A8(A_I_input[8]),
    .A9(A_I_input[9]),
    .A10(A_I_input[10]),
    .A11(A_I_input[11]),
    .A12(A_I_input[12]),
    .A13(A_I_input[13]),
    .A14(A_I_input[14]),
    .A15(A_I_input[15]),
    .S0(ConfigBits[92+0]),
    .S0N(ConfigBits_N[92+0]),
    .S1(ConfigBits[92+1]),
    .S1N(ConfigBits_N[92+1]),
    .S2(ConfigBits[92+2]),
    .S2N(ConfigBits_N[92+2]),
    .S3(ConfigBits[92+3]),
    .S3N(ConfigBits_N[92+3]),
    .X(A_I)
);

 //switch matrix multiplexer A_T MUX-8
assign A_T_input = {VCC0,GND0,W2END4,W2END3,W2END2,W2END1,W2END0,W2MID7};
cus_mux81_buf inst_cus_mux81_buf_A_T (
    .A0(A_T_input[0]),
    .A1(A_T_input[1]),
    .A2(A_T_input[2]),
    .A3(A_T_input[3]),
    .A4(A_T_input[4]),
    .A5(A_T_input[5]),
    .A6(A_T_input[6]),
    .A7(A_T_input[7]),
    .S0(ConfigBits[96+0]),
    .S0N(ConfigBits_N[96+0]),
    .S1(ConfigBits[96+1]),
    .S1N(ConfigBits_N[96+1]),
    .S2(ConfigBits[96+2]),
    .S2N(ConfigBits_N[96+2]),
    .X(A_T)
);

 //switch matrix multiplexer B_I MUX-16
assign B_I_input = {W2END7,W2END6,W2END5,W2END4,W2END3,W2END2,W2END1,W2END0,W2MID7,W2MID6,W2MID5,W2MID4,W2MID3,W2MID2,W2MID1,W2MID0};
cus_mux161_buf inst_cus_mux161_buf_B_I (
    .A0(B_I_input[0]),
    .A1(B_I_input[1]),
    .A2(B_I_input[2]),
    .A3(B_I_input[3]),
    .A4(B_I_input[4]),
    .A5(B_I_input[5]),
    .A6(B_I_input[6]),
    .A7(B_I_input[7]),
    .A8(B_I_input[8]),
    .A9(B_I_input[9]),
    .A10(B_I_input[10]),
    .A11(B_I_input[11]),
    .A12(B_I_input[12]),
    .A13(B_I_input[13]),
    .A14(B_I_input[14]),
    .A15(B_I_input[15]),
    .S0(ConfigBits[99+0]),
    .S0N(ConfigBits_N[99+0]),
    .S1(ConfigBits[99+1]),
    .S1N(ConfigBits_N[99+1]),
    .S2(ConfigBits[99+2]),
    .S2N(ConfigBits_N[99+2]),
    .S3(ConfigBits[99+3]),
    .S3N(ConfigBits_N[99+3]),
    .X(B_I)
);

 //switch matrix multiplexer B_T MUX-8
assign B_T_input = {VCC0,GND0,W2END6,W2END5,W2END4,W2END0,W2MID7,W2MID6};
cus_mux81_buf inst_cus_mux81_buf_B_T (
    .A0(B_T_input[0]),
    .A1(B_T_input[1]),
    .A2(B_T_input[2]),
    .A3(B_T_input[3]),
    .A4(B_T_input[4]),
    .A5(B_T_input[5]),
    .A6(B_T_input[6]),
    .A7(B_T_input[7]),
    .S0(ConfigBits[103+0]),
    .S0N(ConfigBits_N[103+0]),
    .S1(ConfigBits[103+1]),
    .S1N(ConfigBits_N[103+1]),
    .S2(ConfigBits[103+2]),
    .S2N(ConfigBits_N[103+2]),
    .X(B_T)
);

endmodule