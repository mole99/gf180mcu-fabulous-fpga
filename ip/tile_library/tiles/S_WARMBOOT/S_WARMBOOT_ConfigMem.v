module S_WARMBOOT_ConfigMem
    #(
`ifdef EMULATION
        parameter [639:0] Emulate_Bitstream=640'b0,
`endif
        parameter MaxFramesPerCol=20,
        parameter FrameBitsPerRow=32,
        parameter NoConfigBits=19
    )
    (
        input  [FrameBitsPerRow - 1:0] FrameData,
        input  [MaxFramesPerCol - 1:0] FrameStrobe,
        output  [NoConfigBits - 1:0] ConfigBits,
        output  [NoConfigBits - 1:0] ConfigBits_N
    );

`ifdef EMULATION
assign ConfigBits[18] = Emulate_Bitstream[31];
assign ConfigBits[17] = Emulate_Bitstream[30];
assign ConfigBits[16] = Emulate_Bitstream[29];
assign ConfigBits[15] = Emulate_Bitstream[28];
assign ConfigBits[14] = Emulate_Bitstream[27];
assign ConfigBits[13] = Emulate_Bitstream[26];
assign ConfigBits[12] = Emulate_Bitstream[25];
assign ConfigBits[11] = Emulate_Bitstream[24];
assign ConfigBits[10] = Emulate_Bitstream[23];
assign ConfigBits[9] = Emulate_Bitstream[22];
assign ConfigBits[8] = Emulate_Bitstream[21];
assign ConfigBits[7] = Emulate_Bitstream[20];
assign ConfigBits[6] = Emulate_Bitstream[19];
assign ConfigBits[5] = Emulate_Bitstream[18];
assign ConfigBits[4] = Emulate_Bitstream[17];
assign ConfigBits[3] = Emulate_Bitstream[16];
assign ConfigBits[2] = Emulate_Bitstream[15];
assign ConfigBits[1] = Emulate_Bitstream[14];
assign ConfigBits[0] = Emulate_Bitstream[13];
`else

 //instantiate frame latches
LHQD1 Inst_frame0_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[18]),
    .QN(ConfigBits_N[18])
);

LHQD1 Inst_frame0_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[17]),
    .QN(ConfigBits_N[17])
);

LHQD1 Inst_frame0_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[16]),
    .QN(ConfigBits_N[16])
);

LHQD1 Inst_frame0_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[15]),
    .QN(ConfigBits_N[15])
);

LHQD1 Inst_frame0_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[14]),
    .QN(ConfigBits_N[14])
);

LHQD1 Inst_frame0_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[13]),
    .QN(ConfigBits_N[13])
);

LHQD1 Inst_frame0_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[12]),
    .QN(ConfigBits_N[12])
);

LHQD1 Inst_frame0_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[11]),
    .QN(ConfigBits_N[11])
);

LHQD1 Inst_frame0_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[10]),
    .QN(ConfigBits_N[10])
);

LHQD1 Inst_frame0_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[9]),
    .QN(ConfigBits_N[9])
);

LHQD1 Inst_frame0_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[8]),
    .QN(ConfigBits_N[8])
);

LHQD1 Inst_frame0_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[7]),
    .QN(ConfigBits_N[7])
);

LHQD1 Inst_frame0_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[6]),
    .QN(ConfigBits_N[6])
);

LHQD1 Inst_frame0_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[5]),
    .QN(ConfigBits_N[5])
);

LHQD1 Inst_frame0_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[4]),
    .QN(ConfigBits_N[4])
);

LHQD1 Inst_frame0_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[3]),
    .QN(ConfigBits_N[3])
);

LHQD1 Inst_frame0_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[2]),
    .QN(ConfigBits_N[2])
);

LHQD1 Inst_frame0_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[1]),
    .QN(ConfigBits_N[1])
);

LHQD1 Inst_frame0_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[0]),
    .QN(ConfigBits_N[0])
);

`endif
endmodule