module DSP_bot_ConfigMem
    #(
`ifdef EMULATION
        parameter [639:0] Emulate_Bitstream=640'b0,
`endif
        parameter MaxFramesPerCol=20,
        parameter FrameBitsPerRow=32,
        parameter NoConfigBits=416
    )
    (
        input  [FrameBitsPerRow - 1:0] FrameData,
        input  [MaxFramesPerCol - 1:0] FrameStrobe,
        output  [NoConfigBits - 1:0] ConfigBits,
        output  [NoConfigBits - 1:0] ConfigBits_N
    );

`ifdef EMULATION
assign ConfigBits[415] = Emulate_Bitstream[31];
assign ConfigBits[414] = Emulate_Bitstream[30];
assign ConfigBits[413] = Emulate_Bitstream[29];
assign ConfigBits[412] = Emulate_Bitstream[28];
assign ConfigBits[411] = Emulate_Bitstream[27];
assign ConfigBits[410] = Emulate_Bitstream[26];
assign ConfigBits[409] = Emulate_Bitstream[25];
assign ConfigBits[408] = Emulate_Bitstream[24];
assign ConfigBits[407] = Emulate_Bitstream[23];
assign ConfigBits[406] = Emulate_Bitstream[22];
assign ConfigBits[405] = Emulate_Bitstream[21];
assign ConfigBits[404] = Emulate_Bitstream[20];
assign ConfigBits[403] = Emulate_Bitstream[19];
assign ConfigBits[402] = Emulate_Bitstream[18];
assign ConfigBits[401] = Emulate_Bitstream[17];
assign ConfigBits[400] = Emulate_Bitstream[16];
assign ConfigBits[399] = Emulate_Bitstream[15];
assign ConfigBits[398] = Emulate_Bitstream[14];
assign ConfigBits[397] = Emulate_Bitstream[13];
assign ConfigBits[396] = Emulate_Bitstream[12];
assign ConfigBits[395] = Emulate_Bitstream[11];
assign ConfigBits[394] = Emulate_Bitstream[10];
assign ConfigBits[393] = Emulate_Bitstream[9];
assign ConfigBits[392] = Emulate_Bitstream[8];
assign ConfigBits[391] = Emulate_Bitstream[7];
assign ConfigBits[390] = Emulate_Bitstream[6];
assign ConfigBits[389] = Emulate_Bitstream[5];
assign ConfigBits[388] = Emulate_Bitstream[4];
assign ConfigBits[387] = Emulate_Bitstream[3];
assign ConfigBits[386] = Emulate_Bitstream[2];
assign ConfigBits[385] = Emulate_Bitstream[1];
assign ConfigBits[384] = Emulate_Bitstream[0];
assign ConfigBits[383] = Emulate_Bitstream[63];
assign ConfigBits[382] = Emulate_Bitstream[62];
assign ConfigBits[381] = Emulate_Bitstream[61];
assign ConfigBits[380] = Emulate_Bitstream[60];
assign ConfigBits[379] = Emulate_Bitstream[59];
assign ConfigBits[378] = Emulate_Bitstream[58];
assign ConfigBits[377] = Emulate_Bitstream[57];
assign ConfigBits[376] = Emulate_Bitstream[56];
assign ConfigBits[375] = Emulate_Bitstream[55];
assign ConfigBits[374] = Emulate_Bitstream[54];
assign ConfigBits[373] = Emulate_Bitstream[53];
assign ConfigBits[372] = Emulate_Bitstream[52];
assign ConfigBits[371] = Emulate_Bitstream[51];
assign ConfigBits[370] = Emulate_Bitstream[50];
assign ConfigBits[369] = Emulate_Bitstream[49];
assign ConfigBits[368] = Emulate_Bitstream[48];
assign ConfigBits[367] = Emulate_Bitstream[47];
assign ConfigBits[366] = Emulate_Bitstream[46];
assign ConfigBits[365] = Emulate_Bitstream[45];
assign ConfigBits[364] = Emulate_Bitstream[44];
assign ConfigBits[363] = Emulate_Bitstream[43];
assign ConfigBits[362] = Emulate_Bitstream[42];
assign ConfigBits[361] = Emulate_Bitstream[41];
assign ConfigBits[360] = Emulate_Bitstream[40];
assign ConfigBits[359] = Emulate_Bitstream[39];
assign ConfigBits[358] = Emulate_Bitstream[38];
assign ConfigBits[357] = Emulate_Bitstream[37];
assign ConfigBits[356] = Emulate_Bitstream[36];
assign ConfigBits[355] = Emulate_Bitstream[35];
assign ConfigBits[354] = Emulate_Bitstream[34];
assign ConfigBits[353] = Emulate_Bitstream[33];
assign ConfigBits[352] = Emulate_Bitstream[32];
assign ConfigBits[351] = Emulate_Bitstream[95];
assign ConfigBits[350] = Emulate_Bitstream[94];
assign ConfigBits[349] = Emulate_Bitstream[93];
assign ConfigBits[348] = Emulate_Bitstream[92];
assign ConfigBits[347] = Emulate_Bitstream[91];
assign ConfigBits[346] = Emulate_Bitstream[90];
assign ConfigBits[345] = Emulate_Bitstream[89];
assign ConfigBits[344] = Emulate_Bitstream[88];
assign ConfigBits[343] = Emulate_Bitstream[87];
assign ConfigBits[342] = Emulate_Bitstream[86];
assign ConfigBits[341] = Emulate_Bitstream[85];
assign ConfigBits[340] = Emulate_Bitstream[84];
assign ConfigBits[339] = Emulate_Bitstream[83];
assign ConfigBits[338] = Emulate_Bitstream[82];
assign ConfigBits[337] = Emulate_Bitstream[81];
assign ConfigBits[336] = Emulate_Bitstream[80];
assign ConfigBits[335] = Emulate_Bitstream[79];
assign ConfigBits[334] = Emulate_Bitstream[78];
assign ConfigBits[333] = Emulate_Bitstream[77];
assign ConfigBits[332] = Emulate_Bitstream[76];
assign ConfigBits[331] = Emulate_Bitstream[75];
assign ConfigBits[330] = Emulate_Bitstream[74];
assign ConfigBits[329] = Emulate_Bitstream[73];
assign ConfigBits[328] = Emulate_Bitstream[72];
assign ConfigBits[327] = Emulate_Bitstream[71];
assign ConfigBits[326] = Emulate_Bitstream[70];
assign ConfigBits[325] = Emulate_Bitstream[69];
assign ConfigBits[324] = Emulate_Bitstream[68];
assign ConfigBits[323] = Emulate_Bitstream[67];
assign ConfigBits[322] = Emulate_Bitstream[66];
assign ConfigBits[321] = Emulate_Bitstream[65];
assign ConfigBits[320] = Emulate_Bitstream[64];
assign ConfigBits[319] = Emulate_Bitstream[127];
assign ConfigBits[318] = Emulate_Bitstream[126];
assign ConfigBits[317] = Emulate_Bitstream[125];
assign ConfigBits[316] = Emulate_Bitstream[124];
assign ConfigBits[315] = Emulate_Bitstream[123];
assign ConfigBits[314] = Emulate_Bitstream[122];
assign ConfigBits[313] = Emulate_Bitstream[121];
assign ConfigBits[312] = Emulate_Bitstream[120];
assign ConfigBits[311] = Emulate_Bitstream[119];
assign ConfigBits[310] = Emulate_Bitstream[118];
assign ConfigBits[309] = Emulate_Bitstream[117];
assign ConfigBits[308] = Emulate_Bitstream[116];
assign ConfigBits[307] = Emulate_Bitstream[115];
assign ConfigBits[306] = Emulate_Bitstream[114];
assign ConfigBits[305] = Emulate_Bitstream[113];
assign ConfigBits[304] = Emulate_Bitstream[112];
assign ConfigBits[303] = Emulate_Bitstream[111];
assign ConfigBits[302] = Emulate_Bitstream[110];
assign ConfigBits[301] = Emulate_Bitstream[109];
assign ConfigBits[300] = Emulate_Bitstream[108];
assign ConfigBits[299] = Emulate_Bitstream[107];
assign ConfigBits[298] = Emulate_Bitstream[106];
assign ConfigBits[297] = Emulate_Bitstream[105];
assign ConfigBits[296] = Emulate_Bitstream[104];
assign ConfigBits[295] = Emulate_Bitstream[103];
assign ConfigBits[294] = Emulate_Bitstream[102];
assign ConfigBits[293] = Emulate_Bitstream[101];
assign ConfigBits[292] = Emulate_Bitstream[100];
assign ConfigBits[291] = Emulate_Bitstream[99];
assign ConfigBits[290] = Emulate_Bitstream[98];
assign ConfigBits[289] = Emulate_Bitstream[97];
assign ConfigBits[288] = Emulate_Bitstream[96];
assign ConfigBits[287] = Emulate_Bitstream[159];
assign ConfigBits[286] = Emulate_Bitstream[158];
assign ConfigBits[285] = Emulate_Bitstream[157];
assign ConfigBits[284] = Emulate_Bitstream[156];
assign ConfigBits[283] = Emulate_Bitstream[155];
assign ConfigBits[282] = Emulate_Bitstream[154];
assign ConfigBits[281] = Emulate_Bitstream[153];
assign ConfigBits[280] = Emulate_Bitstream[152];
assign ConfigBits[279] = Emulate_Bitstream[151];
assign ConfigBits[278] = Emulate_Bitstream[150];
assign ConfigBits[277] = Emulate_Bitstream[149];
assign ConfigBits[276] = Emulate_Bitstream[148];
assign ConfigBits[275] = Emulate_Bitstream[147];
assign ConfigBits[274] = Emulate_Bitstream[146];
assign ConfigBits[273] = Emulate_Bitstream[145];
assign ConfigBits[272] = Emulate_Bitstream[144];
assign ConfigBits[271] = Emulate_Bitstream[143];
assign ConfigBits[270] = Emulate_Bitstream[142];
assign ConfigBits[269] = Emulate_Bitstream[141];
assign ConfigBits[268] = Emulate_Bitstream[140];
assign ConfigBits[267] = Emulate_Bitstream[139];
assign ConfigBits[266] = Emulate_Bitstream[138];
assign ConfigBits[265] = Emulate_Bitstream[137];
assign ConfigBits[264] = Emulate_Bitstream[136];
assign ConfigBits[263] = Emulate_Bitstream[135];
assign ConfigBits[262] = Emulate_Bitstream[134];
assign ConfigBits[261] = Emulate_Bitstream[133];
assign ConfigBits[260] = Emulate_Bitstream[132];
assign ConfigBits[259] = Emulate_Bitstream[131];
assign ConfigBits[258] = Emulate_Bitstream[130];
assign ConfigBits[257] = Emulate_Bitstream[129];
assign ConfigBits[256] = Emulate_Bitstream[128];
assign ConfigBits[255] = Emulate_Bitstream[191];
assign ConfigBits[254] = Emulate_Bitstream[190];
assign ConfigBits[253] = Emulate_Bitstream[189];
assign ConfigBits[252] = Emulate_Bitstream[188];
assign ConfigBits[251] = Emulate_Bitstream[187];
assign ConfigBits[250] = Emulate_Bitstream[186];
assign ConfigBits[249] = Emulate_Bitstream[185];
assign ConfigBits[248] = Emulate_Bitstream[184];
assign ConfigBits[247] = Emulate_Bitstream[183];
assign ConfigBits[246] = Emulate_Bitstream[182];
assign ConfigBits[245] = Emulate_Bitstream[181];
assign ConfigBits[244] = Emulate_Bitstream[180];
assign ConfigBits[243] = Emulate_Bitstream[179];
assign ConfigBits[242] = Emulate_Bitstream[178];
assign ConfigBits[241] = Emulate_Bitstream[177];
assign ConfigBits[240] = Emulate_Bitstream[176];
assign ConfigBits[239] = Emulate_Bitstream[175];
assign ConfigBits[238] = Emulate_Bitstream[174];
assign ConfigBits[237] = Emulate_Bitstream[173];
assign ConfigBits[236] = Emulate_Bitstream[172];
assign ConfigBits[235] = Emulate_Bitstream[171];
assign ConfigBits[234] = Emulate_Bitstream[170];
assign ConfigBits[233] = Emulate_Bitstream[169];
assign ConfigBits[232] = Emulate_Bitstream[168];
assign ConfigBits[231] = Emulate_Bitstream[167];
assign ConfigBits[230] = Emulate_Bitstream[166];
assign ConfigBits[229] = Emulate_Bitstream[165];
assign ConfigBits[228] = Emulate_Bitstream[164];
assign ConfigBits[227] = Emulate_Bitstream[163];
assign ConfigBits[226] = Emulate_Bitstream[162];
assign ConfigBits[225] = Emulate_Bitstream[161];
assign ConfigBits[224] = Emulate_Bitstream[160];
assign ConfigBits[223] = Emulate_Bitstream[223];
assign ConfigBits[222] = Emulate_Bitstream[222];
assign ConfigBits[221] = Emulate_Bitstream[221];
assign ConfigBits[220] = Emulate_Bitstream[220];
assign ConfigBits[219] = Emulate_Bitstream[219];
assign ConfigBits[218] = Emulate_Bitstream[218];
assign ConfigBits[217] = Emulate_Bitstream[217];
assign ConfigBits[216] = Emulate_Bitstream[216];
assign ConfigBits[215] = Emulate_Bitstream[215];
assign ConfigBits[214] = Emulate_Bitstream[214];
assign ConfigBits[213] = Emulate_Bitstream[213];
assign ConfigBits[212] = Emulate_Bitstream[212];
assign ConfigBits[211] = Emulate_Bitstream[211];
assign ConfigBits[210] = Emulate_Bitstream[210];
assign ConfigBits[209] = Emulate_Bitstream[209];
assign ConfigBits[208] = Emulate_Bitstream[208];
assign ConfigBits[207] = Emulate_Bitstream[207];
assign ConfigBits[206] = Emulate_Bitstream[206];
assign ConfigBits[205] = Emulate_Bitstream[205];
assign ConfigBits[204] = Emulate_Bitstream[204];
assign ConfigBits[203] = Emulate_Bitstream[203];
assign ConfigBits[202] = Emulate_Bitstream[202];
assign ConfigBits[201] = Emulate_Bitstream[201];
assign ConfigBits[200] = Emulate_Bitstream[200];
assign ConfigBits[199] = Emulate_Bitstream[199];
assign ConfigBits[198] = Emulate_Bitstream[198];
assign ConfigBits[197] = Emulate_Bitstream[197];
assign ConfigBits[196] = Emulate_Bitstream[196];
assign ConfigBits[195] = Emulate_Bitstream[195];
assign ConfigBits[194] = Emulate_Bitstream[194];
assign ConfigBits[193] = Emulate_Bitstream[193];
assign ConfigBits[192] = Emulate_Bitstream[192];
assign ConfigBits[191] = Emulate_Bitstream[255];
assign ConfigBits[190] = Emulate_Bitstream[254];
assign ConfigBits[189] = Emulate_Bitstream[253];
assign ConfigBits[188] = Emulate_Bitstream[252];
assign ConfigBits[187] = Emulate_Bitstream[251];
assign ConfigBits[186] = Emulate_Bitstream[250];
assign ConfigBits[185] = Emulate_Bitstream[249];
assign ConfigBits[184] = Emulate_Bitstream[248];
assign ConfigBits[183] = Emulate_Bitstream[247];
assign ConfigBits[182] = Emulate_Bitstream[246];
assign ConfigBits[181] = Emulate_Bitstream[245];
assign ConfigBits[180] = Emulate_Bitstream[244];
assign ConfigBits[179] = Emulate_Bitstream[243];
assign ConfigBits[178] = Emulate_Bitstream[242];
assign ConfigBits[177] = Emulate_Bitstream[241];
assign ConfigBits[176] = Emulate_Bitstream[240];
assign ConfigBits[175] = Emulate_Bitstream[239];
assign ConfigBits[174] = Emulate_Bitstream[238];
assign ConfigBits[173] = Emulate_Bitstream[237];
assign ConfigBits[172] = Emulate_Bitstream[236];
assign ConfigBits[171] = Emulate_Bitstream[235];
assign ConfigBits[170] = Emulate_Bitstream[234];
assign ConfigBits[169] = Emulate_Bitstream[233];
assign ConfigBits[168] = Emulate_Bitstream[232];
assign ConfigBits[167] = Emulate_Bitstream[231];
assign ConfigBits[166] = Emulate_Bitstream[230];
assign ConfigBits[165] = Emulate_Bitstream[229];
assign ConfigBits[164] = Emulate_Bitstream[228];
assign ConfigBits[163] = Emulate_Bitstream[227];
assign ConfigBits[162] = Emulate_Bitstream[226];
assign ConfigBits[161] = Emulate_Bitstream[225];
assign ConfigBits[160] = Emulate_Bitstream[224];
assign ConfigBits[159] = Emulate_Bitstream[287];
assign ConfigBits[158] = Emulate_Bitstream[286];
assign ConfigBits[157] = Emulate_Bitstream[285];
assign ConfigBits[156] = Emulate_Bitstream[284];
assign ConfigBits[155] = Emulate_Bitstream[283];
assign ConfigBits[154] = Emulate_Bitstream[282];
assign ConfigBits[153] = Emulate_Bitstream[281];
assign ConfigBits[152] = Emulate_Bitstream[280];
assign ConfigBits[151] = Emulate_Bitstream[279];
assign ConfigBits[150] = Emulate_Bitstream[278];
assign ConfigBits[149] = Emulate_Bitstream[277];
assign ConfigBits[148] = Emulate_Bitstream[276];
assign ConfigBits[147] = Emulate_Bitstream[275];
assign ConfigBits[146] = Emulate_Bitstream[274];
assign ConfigBits[145] = Emulate_Bitstream[273];
assign ConfigBits[144] = Emulate_Bitstream[272];
assign ConfigBits[143] = Emulate_Bitstream[271];
assign ConfigBits[142] = Emulate_Bitstream[270];
assign ConfigBits[141] = Emulate_Bitstream[269];
assign ConfigBits[140] = Emulate_Bitstream[268];
assign ConfigBits[139] = Emulate_Bitstream[267];
assign ConfigBits[138] = Emulate_Bitstream[266];
assign ConfigBits[137] = Emulate_Bitstream[265];
assign ConfigBits[136] = Emulate_Bitstream[264];
assign ConfigBits[135] = Emulate_Bitstream[263];
assign ConfigBits[134] = Emulate_Bitstream[262];
assign ConfigBits[133] = Emulate_Bitstream[261];
assign ConfigBits[132] = Emulate_Bitstream[260];
assign ConfigBits[131] = Emulate_Bitstream[259];
assign ConfigBits[130] = Emulate_Bitstream[258];
assign ConfigBits[129] = Emulate_Bitstream[257];
assign ConfigBits[128] = Emulate_Bitstream[256];
assign ConfigBits[127] = Emulate_Bitstream[319];
assign ConfigBits[126] = Emulate_Bitstream[318];
assign ConfigBits[125] = Emulate_Bitstream[317];
assign ConfigBits[124] = Emulate_Bitstream[316];
assign ConfigBits[123] = Emulate_Bitstream[315];
assign ConfigBits[122] = Emulate_Bitstream[314];
assign ConfigBits[121] = Emulate_Bitstream[313];
assign ConfigBits[120] = Emulate_Bitstream[312];
assign ConfigBits[119] = Emulate_Bitstream[311];
assign ConfigBits[118] = Emulate_Bitstream[310];
assign ConfigBits[117] = Emulate_Bitstream[309];
assign ConfigBits[116] = Emulate_Bitstream[308];
assign ConfigBits[115] = Emulate_Bitstream[307];
assign ConfigBits[114] = Emulate_Bitstream[306];
assign ConfigBits[113] = Emulate_Bitstream[305];
assign ConfigBits[112] = Emulate_Bitstream[304];
assign ConfigBits[111] = Emulate_Bitstream[303];
assign ConfigBits[110] = Emulate_Bitstream[302];
assign ConfigBits[109] = Emulate_Bitstream[301];
assign ConfigBits[108] = Emulate_Bitstream[300];
assign ConfigBits[107] = Emulate_Bitstream[299];
assign ConfigBits[106] = Emulate_Bitstream[298];
assign ConfigBits[105] = Emulate_Bitstream[297];
assign ConfigBits[104] = Emulate_Bitstream[296];
assign ConfigBits[103] = Emulate_Bitstream[295];
assign ConfigBits[102] = Emulate_Bitstream[294];
assign ConfigBits[101] = Emulate_Bitstream[293];
assign ConfigBits[100] = Emulate_Bitstream[292];
assign ConfigBits[99] = Emulate_Bitstream[291];
assign ConfigBits[98] = Emulate_Bitstream[290];
assign ConfigBits[97] = Emulate_Bitstream[289];
assign ConfigBits[96] = Emulate_Bitstream[288];
assign ConfigBits[95] = Emulate_Bitstream[351];
assign ConfigBits[94] = Emulate_Bitstream[350];
assign ConfigBits[93] = Emulate_Bitstream[349];
assign ConfigBits[92] = Emulate_Bitstream[348];
assign ConfigBits[91] = Emulate_Bitstream[347];
assign ConfigBits[90] = Emulate_Bitstream[346];
assign ConfigBits[89] = Emulate_Bitstream[345];
assign ConfigBits[88] = Emulate_Bitstream[344];
assign ConfigBits[87] = Emulate_Bitstream[343];
assign ConfigBits[86] = Emulate_Bitstream[342];
assign ConfigBits[85] = Emulate_Bitstream[341];
assign ConfigBits[84] = Emulate_Bitstream[340];
assign ConfigBits[83] = Emulate_Bitstream[339];
assign ConfigBits[82] = Emulate_Bitstream[338];
assign ConfigBits[81] = Emulate_Bitstream[337];
assign ConfigBits[80] = Emulate_Bitstream[336];
assign ConfigBits[79] = Emulate_Bitstream[335];
assign ConfigBits[78] = Emulate_Bitstream[334];
assign ConfigBits[77] = Emulate_Bitstream[333];
assign ConfigBits[76] = Emulate_Bitstream[332];
assign ConfigBits[75] = Emulate_Bitstream[331];
assign ConfigBits[74] = Emulate_Bitstream[330];
assign ConfigBits[73] = Emulate_Bitstream[329];
assign ConfigBits[72] = Emulate_Bitstream[328];
assign ConfigBits[71] = Emulate_Bitstream[327];
assign ConfigBits[70] = Emulate_Bitstream[326];
assign ConfigBits[69] = Emulate_Bitstream[325];
assign ConfigBits[68] = Emulate_Bitstream[324];
assign ConfigBits[67] = Emulate_Bitstream[323];
assign ConfigBits[66] = Emulate_Bitstream[322];
assign ConfigBits[65] = Emulate_Bitstream[321];
assign ConfigBits[64] = Emulate_Bitstream[320];
assign ConfigBits[63] = Emulate_Bitstream[383];
assign ConfigBits[62] = Emulate_Bitstream[382];
assign ConfigBits[61] = Emulate_Bitstream[381];
assign ConfigBits[60] = Emulate_Bitstream[380];
assign ConfigBits[59] = Emulate_Bitstream[379];
assign ConfigBits[58] = Emulate_Bitstream[378];
assign ConfigBits[57] = Emulate_Bitstream[377];
assign ConfigBits[56] = Emulate_Bitstream[376];
assign ConfigBits[55] = Emulate_Bitstream[375];
assign ConfigBits[54] = Emulate_Bitstream[374];
assign ConfigBits[53] = Emulate_Bitstream[373];
assign ConfigBits[52] = Emulate_Bitstream[372];
assign ConfigBits[51] = Emulate_Bitstream[371];
assign ConfigBits[50] = Emulate_Bitstream[370];
assign ConfigBits[49] = Emulate_Bitstream[369];
assign ConfigBits[48] = Emulate_Bitstream[368];
assign ConfigBits[47] = Emulate_Bitstream[367];
assign ConfigBits[46] = Emulate_Bitstream[366];
assign ConfigBits[45] = Emulate_Bitstream[365];
assign ConfigBits[44] = Emulate_Bitstream[364];
assign ConfigBits[43] = Emulate_Bitstream[363];
assign ConfigBits[42] = Emulate_Bitstream[362];
assign ConfigBits[41] = Emulate_Bitstream[361];
assign ConfigBits[40] = Emulate_Bitstream[360];
assign ConfigBits[39] = Emulate_Bitstream[359];
assign ConfigBits[38] = Emulate_Bitstream[358];
assign ConfigBits[37] = Emulate_Bitstream[357];
assign ConfigBits[36] = Emulate_Bitstream[356];
assign ConfigBits[35] = Emulate_Bitstream[355];
assign ConfigBits[34] = Emulate_Bitstream[354];
assign ConfigBits[33] = Emulate_Bitstream[353];
assign ConfigBits[32] = Emulate_Bitstream[352];
assign ConfigBits[31] = Emulate_Bitstream[415];
assign ConfigBits[30] = Emulate_Bitstream[414];
assign ConfigBits[29] = Emulate_Bitstream[413];
assign ConfigBits[28] = Emulate_Bitstream[412];
assign ConfigBits[27] = Emulate_Bitstream[411];
assign ConfigBits[26] = Emulate_Bitstream[410];
assign ConfigBits[25] = Emulate_Bitstream[409];
assign ConfigBits[24] = Emulate_Bitstream[408];
assign ConfigBits[23] = Emulate_Bitstream[407];
assign ConfigBits[22] = Emulate_Bitstream[406];
assign ConfigBits[21] = Emulate_Bitstream[405];
assign ConfigBits[20] = Emulate_Bitstream[404];
assign ConfigBits[19] = Emulate_Bitstream[403];
assign ConfigBits[18] = Emulate_Bitstream[402];
assign ConfigBits[17] = Emulate_Bitstream[401];
assign ConfigBits[16] = Emulate_Bitstream[400];
assign ConfigBits[15] = Emulate_Bitstream[399];
assign ConfigBits[14] = Emulate_Bitstream[398];
assign ConfigBits[13] = Emulate_Bitstream[397];
assign ConfigBits[12] = Emulate_Bitstream[396];
assign ConfigBits[11] = Emulate_Bitstream[395];
assign ConfigBits[10] = Emulate_Bitstream[394];
assign ConfigBits[9] = Emulate_Bitstream[393];
assign ConfigBits[8] = Emulate_Bitstream[392];
assign ConfigBits[7] = Emulate_Bitstream[391];
assign ConfigBits[6] = Emulate_Bitstream[390];
assign ConfigBits[5] = Emulate_Bitstream[389];
assign ConfigBits[4] = Emulate_Bitstream[388];
assign ConfigBits[3] = Emulate_Bitstream[387];
assign ConfigBits[2] = Emulate_Bitstream[386];
assign ConfigBits[1] = Emulate_Bitstream[385];
assign ConfigBits[0] = Emulate_Bitstream[384];
`else

 //instantiate frame latches
LHQD1 Inst_frame0_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[415]),
    .QN(ConfigBits_N[415])
);

LHQD1 Inst_frame0_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[414]),
    .QN(ConfigBits_N[414])
);

LHQD1 Inst_frame0_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[413]),
    .QN(ConfigBits_N[413])
);

LHQD1 Inst_frame0_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[412]),
    .QN(ConfigBits_N[412])
);

LHQD1 Inst_frame0_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[411]),
    .QN(ConfigBits_N[411])
);

LHQD1 Inst_frame0_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[410]),
    .QN(ConfigBits_N[410])
);

LHQD1 Inst_frame0_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[409]),
    .QN(ConfigBits_N[409])
);

LHQD1 Inst_frame0_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[408]),
    .QN(ConfigBits_N[408])
);

LHQD1 Inst_frame0_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[407]),
    .QN(ConfigBits_N[407])
);

LHQD1 Inst_frame0_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[406]),
    .QN(ConfigBits_N[406])
);

LHQD1 Inst_frame0_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[405]),
    .QN(ConfigBits_N[405])
);

LHQD1 Inst_frame0_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[404]),
    .QN(ConfigBits_N[404])
);

LHQD1 Inst_frame0_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[403]),
    .QN(ConfigBits_N[403])
);

LHQD1 Inst_frame0_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[402]),
    .QN(ConfigBits_N[402])
);

LHQD1 Inst_frame0_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[401]),
    .QN(ConfigBits_N[401])
);

LHQD1 Inst_frame0_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[400]),
    .QN(ConfigBits_N[400])
);

LHQD1 Inst_frame0_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[399]),
    .QN(ConfigBits_N[399])
);

LHQD1 Inst_frame0_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[398]),
    .QN(ConfigBits_N[398])
);

LHQD1 Inst_frame0_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[397]),
    .QN(ConfigBits_N[397])
);

LHQD1 Inst_frame0_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[396]),
    .QN(ConfigBits_N[396])
);

LHQD1 Inst_frame0_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[395]),
    .QN(ConfigBits_N[395])
);

LHQD1 Inst_frame0_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[394]),
    .QN(ConfigBits_N[394])
);

LHQD1 Inst_frame0_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[393]),
    .QN(ConfigBits_N[393])
);

LHQD1 Inst_frame0_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[392]),
    .QN(ConfigBits_N[392])
);

LHQD1 Inst_frame0_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[391]),
    .QN(ConfigBits_N[391])
);

LHQD1 Inst_frame0_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[390]),
    .QN(ConfigBits_N[390])
);

LHQD1 Inst_frame0_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[389]),
    .QN(ConfigBits_N[389])
);

LHQD1 Inst_frame0_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[388]),
    .QN(ConfigBits_N[388])
);

LHQD1 Inst_frame0_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[387]),
    .QN(ConfigBits_N[387])
);

LHQD1 Inst_frame0_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[386]),
    .QN(ConfigBits_N[386])
);

LHQD1 Inst_frame0_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[385]),
    .QN(ConfigBits_N[385])
);

LHQD1 Inst_frame0_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[0]),
    .Q(ConfigBits[384]),
    .QN(ConfigBits_N[384])
);

LHQD1 Inst_frame1_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[383]),
    .QN(ConfigBits_N[383])
);

LHQD1 Inst_frame1_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[382]),
    .QN(ConfigBits_N[382])
);

LHQD1 Inst_frame1_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[381]),
    .QN(ConfigBits_N[381])
);

LHQD1 Inst_frame1_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[380]),
    .QN(ConfigBits_N[380])
);

LHQD1 Inst_frame1_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[379]),
    .QN(ConfigBits_N[379])
);

LHQD1 Inst_frame1_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[378]),
    .QN(ConfigBits_N[378])
);

LHQD1 Inst_frame1_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[377]),
    .QN(ConfigBits_N[377])
);

LHQD1 Inst_frame1_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[376]),
    .QN(ConfigBits_N[376])
);

LHQD1 Inst_frame1_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[375]),
    .QN(ConfigBits_N[375])
);

LHQD1 Inst_frame1_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[374]),
    .QN(ConfigBits_N[374])
);

LHQD1 Inst_frame1_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[373]),
    .QN(ConfigBits_N[373])
);

LHQD1 Inst_frame1_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[372]),
    .QN(ConfigBits_N[372])
);

LHQD1 Inst_frame1_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[371]),
    .QN(ConfigBits_N[371])
);

LHQD1 Inst_frame1_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[370]),
    .QN(ConfigBits_N[370])
);

LHQD1 Inst_frame1_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[369]),
    .QN(ConfigBits_N[369])
);

LHQD1 Inst_frame1_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[368]),
    .QN(ConfigBits_N[368])
);

LHQD1 Inst_frame1_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[367]),
    .QN(ConfigBits_N[367])
);

LHQD1 Inst_frame1_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[366]),
    .QN(ConfigBits_N[366])
);

LHQD1 Inst_frame1_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[365]),
    .QN(ConfigBits_N[365])
);

LHQD1 Inst_frame1_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[364]),
    .QN(ConfigBits_N[364])
);

LHQD1 Inst_frame1_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[363]),
    .QN(ConfigBits_N[363])
);

LHQD1 Inst_frame1_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[362]),
    .QN(ConfigBits_N[362])
);

LHQD1 Inst_frame1_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[361]),
    .QN(ConfigBits_N[361])
);

LHQD1 Inst_frame1_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[360]),
    .QN(ConfigBits_N[360])
);

LHQD1 Inst_frame1_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[359]),
    .QN(ConfigBits_N[359])
);

LHQD1 Inst_frame1_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[358]),
    .QN(ConfigBits_N[358])
);

LHQD1 Inst_frame1_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[357]),
    .QN(ConfigBits_N[357])
);

LHQD1 Inst_frame1_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[356]),
    .QN(ConfigBits_N[356])
);

LHQD1 Inst_frame1_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[355]),
    .QN(ConfigBits_N[355])
);

LHQD1 Inst_frame1_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[354]),
    .QN(ConfigBits_N[354])
);

LHQD1 Inst_frame1_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[353]),
    .QN(ConfigBits_N[353])
);

LHQD1 Inst_frame1_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[1]),
    .Q(ConfigBits[352]),
    .QN(ConfigBits_N[352])
);

LHQD1 Inst_frame2_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[351]),
    .QN(ConfigBits_N[351])
);

LHQD1 Inst_frame2_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[350]),
    .QN(ConfigBits_N[350])
);

LHQD1 Inst_frame2_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[349]),
    .QN(ConfigBits_N[349])
);

LHQD1 Inst_frame2_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[348]),
    .QN(ConfigBits_N[348])
);

LHQD1 Inst_frame2_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[347]),
    .QN(ConfigBits_N[347])
);

LHQD1 Inst_frame2_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[346]),
    .QN(ConfigBits_N[346])
);

LHQD1 Inst_frame2_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[345]),
    .QN(ConfigBits_N[345])
);

LHQD1 Inst_frame2_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[344]),
    .QN(ConfigBits_N[344])
);

LHQD1 Inst_frame2_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[343]),
    .QN(ConfigBits_N[343])
);

LHQD1 Inst_frame2_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[342]),
    .QN(ConfigBits_N[342])
);

LHQD1 Inst_frame2_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[341]),
    .QN(ConfigBits_N[341])
);

LHQD1 Inst_frame2_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[340]),
    .QN(ConfigBits_N[340])
);

LHQD1 Inst_frame2_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[339]),
    .QN(ConfigBits_N[339])
);

LHQD1 Inst_frame2_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[338]),
    .QN(ConfigBits_N[338])
);

LHQD1 Inst_frame2_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[337]),
    .QN(ConfigBits_N[337])
);

LHQD1 Inst_frame2_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[336]),
    .QN(ConfigBits_N[336])
);

LHQD1 Inst_frame2_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[335]),
    .QN(ConfigBits_N[335])
);

LHQD1 Inst_frame2_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[334]),
    .QN(ConfigBits_N[334])
);

LHQD1 Inst_frame2_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[333]),
    .QN(ConfigBits_N[333])
);

LHQD1 Inst_frame2_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[332]),
    .QN(ConfigBits_N[332])
);

LHQD1 Inst_frame2_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[331]),
    .QN(ConfigBits_N[331])
);

LHQD1 Inst_frame2_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[330]),
    .QN(ConfigBits_N[330])
);

LHQD1 Inst_frame2_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[329]),
    .QN(ConfigBits_N[329])
);

LHQD1 Inst_frame2_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[328]),
    .QN(ConfigBits_N[328])
);

LHQD1 Inst_frame2_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[327]),
    .QN(ConfigBits_N[327])
);

LHQD1 Inst_frame2_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[326]),
    .QN(ConfigBits_N[326])
);

LHQD1 Inst_frame2_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[325]),
    .QN(ConfigBits_N[325])
);

LHQD1 Inst_frame2_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[324]),
    .QN(ConfigBits_N[324])
);

LHQD1 Inst_frame2_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[323]),
    .QN(ConfigBits_N[323])
);

LHQD1 Inst_frame2_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[322]),
    .QN(ConfigBits_N[322])
);

LHQD1 Inst_frame2_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[321]),
    .QN(ConfigBits_N[321])
);

LHQD1 Inst_frame2_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[2]),
    .Q(ConfigBits[320]),
    .QN(ConfigBits_N[320])
);

LHQD1 Inst_frame3_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[319]),
    .QN(ConfigBits_N[319])
);

LHQD1 Inst_frame3_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[318]),
    .QN(ConfigBits_N[318])
);

LHQD1 Inst_frame3_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[317]),
    .QN(ConfigBits_N[317])
);

LHQD1 Inst_frame3_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[316]),
    .QN(ConfigBits_N[316])
);

LHQD1 Inst_frame3_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[315]),
    .QN(ConfigBits_N[315])
);

LHQD1 Inst_frame3_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[314]),
    .QN(ConfigBits_N[314])
);

LHQD1 Inst_frame3_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[313]),
    .QN(ConfigBits_N[313])
);

LHQD1 Inst_frame3_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[312]),
    .QN(ConfigBits_N[312])
);

LHQD1 Inst_frame3_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[311]),
    .QN(ConfigBits_N[311])
);

LHQD1 Inst_frame3_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[310]),
    .QN(ConfigBits_N[310])
);

LHQD1 Inst_frame3_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[309]),
    .QN(ConfigBits_N[309])
);

LHQD1 Inst_frame3_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[308]),
    .QN(ConfigBits_N[308])
);

LHQD1 Inst_frame3_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[307]),
    .QN(ConfigBits_N[307])
);

LHQD1 Inst_frame3_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[306]),
    .QN(ConfigBits_N[306])
);

LHQD1 Inst_frame3_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[305]),
    .QN(ConfigBits_N[305])
);

LHQD1 Inst_frame3_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[304]),
    .QN(ConfigBits_N[304])
);

LHQD1 Inst_frame3_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[303]),
    .QN(ConfigBits_N[303])
);

LHQD1 Inst_frame3_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[302]),
    .QN(ConfigBits_N[302])
);

LHQD1 Inst_frame3_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[301]),
    .QN(ConfigBits_N[301])
);

LHQD1 Inst_frame3_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[300]),
    .QN(ConfigBits_N[300])
);

LHQD1 Inst_frame3_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[299]),
    .QN(ConfigBits_N[299])
);

LHQD1 Inst_frame3_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[298]),
    .QN(ConfigBits_N[298])
);

LHQD1 Inst_frame3_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[297]),
    .QN(ConfigBits_N[297])
);

LHQD1 Inst_frame3_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[296]),
    .QN(ConfigBits_N[296])
);

LHQD1 Inst_frame3_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[295]),
    .QN(ConfigBits_N[295])
);

LHQD1 Inst_frame3_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[294]),
    .QN(ConfigBits_N[294])
);

LHQD1 Inst_frame3_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[293]),
    .QN(ConfigBits_N[293])
);

LHQD1 Inst_frame3_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[292]),
    .QN(ConfigBits_N[292])
);

LHQD1 Inst_frame3_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[291]),
    .QN(ConfigBits_N[291])
);

LHQD1 Inst_frame3_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[290]),
    .QN(ConfigBits_N[290])
);

LHQD1 Inst_frame3_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[289]),
    .QN(ConfigBits_N[289])
);

LHQD1 Inst_frame3_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[3]),
    .Q(ConfigBits[288]),
    .QN(ConfigBits_N[288])
);

LHQD1 Inst_frame4_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[287]),
    .QN(ConfigBits_N[287])
);

LHQD1 Inst_frame4_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[286]),
    .QN(ConfigBits_N[286])
);

LHQD1 Inst_frame4_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[285]),
    .QN(ConfigBits_N[285])
);

LHQD1 Inst_frame4_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[284]),
    .QN(ConfigBits_N[284])
);

LHQD1 Inst_frame4_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[283]),
    .QN(ConfigBits_N[283])
);

LHQD1 Inst_frame4_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[282]),
    .QN(ConfigBits_N[282])
);

LHQD1 Inst_frame4_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[281]),
    .QN(ConfigBits_N[281])
);

LHQD1 Inst_frame4_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[280]),
    .QN(ConfigBits_N[280])
);

LHQD1 Inst_frame4_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[279]),
    .QN(ConfigBits_N[279])
);

LHQD1 Inst_frame4_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[278]),
    .QN(ConfigBits_N[278])
);

LHQD1 Inst_frame4_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[277]),
    .QN(ConfigBits_N[277])
);

LHQD1 Inst_frame4_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[276]),
    .QN(ConfigBits_N[276])
);

LHQD1 Inst_frame4_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[275]),
    .QN(ConfigBits_N[275])
);

LHQD1 Inst_frame4_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[274]),
    .QN(ConfigBits_N[274])
);

LHQD1 Inst_frame4_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[273]),
    .QN(ConfigBits_N[273])
);

LHQD1 Inst_frame4_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[272]),
    .QN(ConfigBits_N[272])
);

LHQD1 Inst_frame4_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[271]),
    .QN(ConfigBits_N[271])
);

LHQD1 Inst_frame4_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[270]),
    .QN(ConfigBits_N[270])
);

LHQD1 Inst_frame4_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[269]),
    .QN(ConfigBits_N[269])
);

LHQD1 Inst_frame4_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[268]),
    .QN(ConfigBits_N[268])
);

LHQD1 Inst_frame4_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[267]),
    .QN(ConfigBits_N[267])
);

LHQD1 Inst_frame4_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[266]),
    .QN(ConfigBits_N[266])
);

LHQD1 Inst_frame4_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[265]),
    .QN(ConfigBits_N[265])
);

LHQD1 Inst_frame4_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[264]),
    .QN(ConfigBits_N[264])
);

LHQD1 Inst_frame4_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[263]),
    .QN(ConfigBits_N[263])
);

LHQD1 Inst_frame4_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[262]),
    .QN(ConfigBits_N[262])
);

LHQD1 Inst_frame4_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[261]),
    .QN(ConfigBits_N[261])
);

LHQD1 Inst_frame4_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[260]),
    .QN(ConfigBits_N[260])
);

LHQD1 Inst_frame4_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[259]),
    .QN(ConfigBits_N[259])
);

LHQD1 Inst_frame4_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[258]),
    .QN(ConfigBits_N[258])
);

LHQD1 Inst_frame4_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[257]),
    .QN(ConfigBits_N[257])
);

LHQD1 Inst_frame4_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[4]),
    .Q(ConfigBits[256]),
    .QN(ConfigBits_N[256])
);

LHQD1 Inst_frame5_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[255]),
    .QN(ConfigBits_N[255])
);

LHQD1 Inst_frame5_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[254]),
    .QN(ConfigBits_N[254])
);

LHQD1 Inst_frame5_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[253]),
    .QN(ConfigBits_N[253])
);

LHQD1 Inst_frame5_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[252]),
    .QN(ConfigBits_N[252])
);

LHQD1 Inst_frame5_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[251]),
    .QN(ConfigBits_N[251])
);

LHQD1 Inst_frame5_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[250]),
    .QN(ConfigBits_N[250])
);

LHQD1 Inst_frame5_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[249]),
    .QN(ConfigBits_N[249])
);

LHQD1 Inst_frame5_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[248]),
    .QN(ConfigBits_N[248])
);

LHQD1 Inst_frame5_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[247]),
    .QN(ConfigBits_N[247])
);

LHQD1 Inst_frame5_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[246]),
    .QN(ConfigBits_N[246])
);

LHQD1 Inst_frame5_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[245]),
    .QN(ConfigBits_N[245])
);

LHQD1 Inst_frame5_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[244]),
    .QN(ConfigBits_N[244])
);

LHQD1 Inst_frame5_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[243]),
    .QN(ConfigBits_N[243])
);

LHQD1 Inst_frame5_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[242]),
    .QN(ConfigBits_N[242])
);

LHQD1 Inst_frame5_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[241]),
    .QN(ConfigBits_N[241])
);

LHQD1 Inst_frame5_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[240]),
    .QN(ConfigBits_N[240])
);

LHQD1 Inst_frame5_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[239]),
    .QN(ConfigBits_N[239])
);

LHQD1 Inst_frame5_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[238]),
    .QN(ConfigBits_N[238])
);

LHQD1 Inst_frame5_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[237]),
    .QN(ConfigBits_N[237])
);

LHQD1 Inst_frame5_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[236]),
    .QN(ConfigBits_N[236])
);

LHQD1 Inst_frame5_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[235]),
    .QN(ConfigBits_N[235])
);

LHQD1 Inst_frame5_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[234]),
    .QN(ConfigBits_N[234])
);

LHQD1 Inst_frame5_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[233]),
    .QN(ConfigBits_N[233])
);

LHQD1 Inst_frame5_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[232]),
    .QN(ConfigBits_N[232])
);

LHQD1 Inst_frame5_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[231]),
    .QN(ConfigBits_N[231])
);

LHQD1 Inst_frame5_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[230]),
    .QN(ConfigBits_N[230])
);

LHQD1 Inst_frame5_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[229]),
    .QN(ConfigBits_N[229])
);

LHQD1 Inst_frame5_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[228]),
    .QN(ConfigBits_N[228])
);

LHQD1 Inst_frame5_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[227]),
    .QN(ConfigBits_N[227])
);

LHQD1 Inst_frame5_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[226]),
    .QN(ConfigBits_N[226])
);

LHQD1 Inst_frame5_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[225]),
    .QN(ConfigBits_N[225])
);

LHQD1 Inst_frame5_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[5]),
    .Q(ConfigBits[224]),
    .QN(ConfigBits_N[224])
);

LHQD1 Inst_frame6_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[223]),
    .QN(ConfigBits_N[223])
);

LHQD1 Inst_frame6_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[222]),
    .QN(ConfigBits_N[222])
);

LHQD1 Inst_frame6_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[221]),
    .QN(ConfigBits_N[221])
);

LHQD1 Inst_frame6_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[220]),
    .QN(ConfigBits_N[220])
);

LHQD1 Inst_frame6_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[219]),
    .QN(ConfigBits_N[219])
);

LHQD1 Inst_frame6_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[218]),
    .QN(ConfigBits_N[218])
);

LHQD1 Inst_frame6_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[217]),
    .QN(ConfigBits_N[217])
);

LHQD1 Inst_frame6_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[216]),
    .QN(ConfigBits_N[216])
);

LHQD1 Inst_frame6_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[215]),
    .QN(ConfigBits_N[215])
);

LHQD1 Inst_frame6_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[214]),
    .QN(ConfigBits_N[214])
);

LHQD1 Inst_frame6_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[213]),
    .QN(ConfigBits_N[213])
);

LHQD1 Inst_frame6_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[212]),
    .QN(ConfigBits_N[212])
);

LHQD1 Inst_frame6_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[211]),
    .QN(ConfigBits_N[211])
);

LHQD1 Inst_frame6_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[210]),
    .QN(ConfigBits_N[210])
);

LHQD1 Inst_frame6_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[209]),
    .QN(ConfigBits_N[209])
);

LHQD1 Inst_frame6_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[208]),
    .QN(ConfigBits_N[208])
);

LHQD1 Inst_frame6_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[207]),
    .QN(ConfigBits_N[207])
);

LHQD1 Inst_frame6_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[206]),
    .QN(ConfigBits_N[206])
);

LHQD1 Inst_frame6_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[205]),
    .QN(ConfigBits_N[205])
);

LHQD1 Inst_frame6_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[204]),
    .QN(ConfigBits_N[204])
);

LHQD1 Inst_frame6_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[203]),
    .QN(ConfigBits_N[203])
);

LHQD1 Inst_frame6_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[202]),
    .QN(ConfigBits_N[202])
);

LHQD1 Inst_frame6_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[201]),
    .QN(ConfigBits_N[201])
);

LHQD1 Inst_frame6_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[200]),
    .QN(ConfigBits_N[200])
);

LHQD1 Inst_frame6_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[199]),
    .QN(ConfigBits_N[199])
);

LHQD1 Inst_frame6_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[198]),
    .QN(ConfigBits_N[198])
);

LHQD1 Inst_frame6_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[197]),
    .QN(ConfigBits_N[197])
);

LHQD1 Inst_frame6_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[196]),
    .QN(ConfigBits_N[196])
);

LHQD1 Inst_frame6_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[195]),
    .QN(ConfigBits_N[195])
);

LHQD1 Inst_frame6_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[194]),
    .QN(ConfigBits_N[194])
);

LHQD1 Inst_frame6_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[193]),
    .QN(ConfigBits_N[193])
);

LHQD1 Inst_frame6_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[6]),
    .Q(ConfigBits[192]),
    .QN(ConfigBits_N[192])
);

LHQD1 Inst_frame7_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[191]),
    .QN(ConfigBits_N[191])
);

LHQD1 Inst_frame7_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[190]),
    .QN(ConfigBits_N[190])
);

LHQD1 Inst_frame7_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[189]),
    .QN(ConfigBits_N[189])
);

LHQD1 Inst_frame7_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[188]),
    .QN(ConfigBits_N[188])
);

LHQD1 Inst_frame7_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[187]),
    .QN(ConfigBits_N[187])
);

LHQD1 Inst_frame7_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[186]),
    .QN(ConfigBits_N[186])
);

LHQD1 Inst_frame7_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[185]),
    .QN(ConfigBits_N[185])
);

LHQD1 Inst_frame7_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[184]),
    .QN(ConfigBits_N[184])
);

LHQD1 Inst_frame7_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[183]),
    .QN(ConfigBits_N[183])
);

LHQD1 Inst_frame7_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[182]),
    .QN(ConfigBits_N[182])
);

LHQD1 Inst_frame7_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[181]),
    .QN(ConfigBits_N[181])
);

LHQD1 Inst_frame7_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[180]),
    .QN(ConfigBits_N[180])
);

LHQD1 Inst_frame7_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[179]),
    .QN(ConfigBits_N[179])
);

LHQD1 Inst_frame7_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[178]),
    .QN(ConfigBits_N[178])
);

LHQD1 Inst_frame7_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[177]),
    .QN(ConfigBits_N[177])
);

LHQD1 Inst_frame7_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[176]),
    .QN(ConfigBits_N[176])
);

LHQD1 Inst_frame7_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[175]),
    .QN(ConfigBits_N[175])
);

LHQD1 Inst_frame7_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[174]),
    .QN(ConfigBits_N[174])
);

LHQD1 Inst_frame7_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[173]),
    .QN(ConfigBits_N[173])
);

LHQD1 Inst_frame7_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[172]),
    .QN(ConfigBits_N[172])
);

LHQD1 Inst_frame7_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[171]),
    .QN(ConfigBits_N[171])
);

LHQD1 Inst_frame7_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[170]),
    .QN(ConfigBits_N[170])
);

LHQD1 Inst_frame7_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[169]),
    .QN(ConfigBits_N[169])
);

LHQD1 Inst_frame7_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[168]),
    .QN(ConfigBits_N[168])
);

LHQD1 Inst_frame7_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[167]),
    .QN(ConfigBits_N[167])
);

LHQD1 Inst_frame7_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[166]),
    .QN(ConfigBits_N[166])
);

LHQD1 Inst_frame7_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[165]),
    .QN(ConfigBits_N[165])
);

LHQD1 Inst_frame7_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[164]),
    .QN(ConfigBits_N[164])
);

LHQD1 Inst_frame7_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[163]),
    .QN(ConfigBits_N[163])
);

LHQD1 Inst_frame7_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[162]),
    .QN(ConfigBits_N[162])
);

LHQD1 Inst_frame7_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[161]),
    .QN(ConfigBits_N[161])
);

LHQD1 Inst_frame7_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[7]),
    .Q(ConfigBits[160]),
    .QN(ConfigBits_N[160])
);

LHQD1 Inst_frame8_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[159]),
    .QN(ConfigBits_N[159])
);

LHQD1 Inst_frame8_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[158]),
    .QN(ConfigBits_N[158])
);

LHQD1 Inst_frame8_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[157]),
    .QN(ConfigBits_N[157])
);

LHQD1 Inst_frame8_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[156]),
    .QN(ConfigBits_N[156])
);

LHQD1 Inst_frame8_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[155]),
    .QN(ConfigBits_N[155])
);

LHQD1 Inst_frame8_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[154]),
    .QN(ConfigBits_N[154])
);

LHQD1 Inst_frame8_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[153]),
    .QN(ConfigBits_N[153])
);

LHQD1 Inst_frame8_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[152]),
    .QN(ConfigBits_N[152])
);

LHQD1 Inst_frame8_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[151]),
    .QN(ConfigBits_N[151])
);

LHQD1 Inst_frame8_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[150]),
    .QN(ConfigBits_N[150])
);

LHQD1 Inst_frame8_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[149]),
    .QN(ConfigBits_N[149])
);

LHQD1 Inst_frame8_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[148]),
    .QN(ConfigBits_N[148])
);

LHQD1 Inst_frame8_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[147]),
    .QN(ConfigBits_N[147])
);

LHQD1 Inst_frame8_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[146]),
    .QN(ConfigBits_N[146])
);

LHQD1 Inst_frame8_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[145]),
    .QN(ConfigBits_N[145])
);

LHQD1 Inst_frame8_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[144]),
    .QN(ConfigBits_N[144])
);

LHQD1 Inst_frame8_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[143]),
    .QN(ConfigBits_N[143])
);

LHQD1 Inst_frame8_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[142]),
    .QN(ConfigBits_N[142])
);

LHQD1 Inst_frame8_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[141]),
    .QN(ConfigBits_N[141])
);

LHQD1 Inst_frame8_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[140]),
    .QN(ConfigBits_N[140])
);

LHQD1 Inst_frame8_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[139]),
    .QN(ConfigBits_N[139])
);

LHQD1 Inst_frame8_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[138]),
    .QN(ConfigBits_N[138])
);

LHQD1 Inst_frame8_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[137]),
    .QN(ConfigBits_N[137])
);

LHQD1 Inst_frame8_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[136]),
    .QN(ConfigBits_N[136])
);

LHQD1 Inst_frame8_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[135]),
    .QN(ConfigBits_N[135])
);

LHQD1 Inst_frame8_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[134]),
    .QN(ConfigBits_N[134])
);

LHQD1 Inst_frame8_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[133]),
    .QN(ConfigBits_N[133])
);

LHQD1 Inst_frame8_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[132]),
    .QN(ConfigBits_N[132])
);

LHQD1 Inst_frame8_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[131]),
    .QN(ConfigBits_N[131])
);

LHQD1 Inst_frame8_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[130]),
    .QN(ConfigBits_N[130])
);

LHQD1 Inst_frame8_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[129]),
    .QN(ConfigBits_N[129])
);

LHQD1 Inst_frame8_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[8]),
    .Q(ConfigBits[128]),
    .QN(ConfigBits_N[128])
);

LHQD1 Inst_frame9_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[127]),
    .QN(ConfigBits_N[127])
);

LHQD1 Inst_frame9_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[126]),
    .QN(ConfigBits_N[126])
);

LHQD1 Inst_frame9_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[125]),
    .QN(ConfigBits_N[125])
);

LHQD1 Inst_frame9_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[124]),
    .QN(ConfigBits_N[124])
);

LHQD1 Inst_frame9_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[123]),
    .QN(ConfigBits_N[123])
);

LHQD1 Inst_frame9_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[122]),
    .QN(ConfigBits_N[122])
);

LHQD1 Inst_frame9_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[121]),
    .QN(ConfigBits_N[121])
);

LHQD1 Inst_frame9_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[120]),
    .QN(ConfigBits_N[120])
);

LHQD1 Inst_frame9_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[119]),
    .QN(ConfigBits_N[119])
);

LHQD1 Inst_frame9_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[118]),
    .QN(ConfigBits_N[118])
);

LHQD1 Inst_frame9_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[117]),
    .QN(ConfigBits_N[117])
);

LHQD1 Inst_frame9_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[116]),
    .QN(ConfigBits_N[116])
);

LHQD1 Inst_frame9_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[115]),
    .QN(ConfigBits_N[115])
);

LHQD1 Inst_frame9_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[114]),
    .QN(ConfigBits_N[114])
);

LHQD1 Inst_frame9_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[113]),
    .QN(ConfigBits_N[113])
);

LHQD1 Inst_frame9_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[112]),
    .QN(ConfigBits_N[112])
);

LHQD1 Inst_frame9_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[111]),
    .QN(ConfigBits_N[111])
);

LHQD1 Inst_frame9_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[110]),
    .QN(ConfigBits_N[110])
);

LHQD1 Inst_frame9_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[109]),
    .QN(ConfigBits_N[109])
);

LHQD1 Inst_frame9_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[108]),
    .QN(ConfigBits_N[108])
);

LHQD1 Inst_frame9_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[107]),
    .QN(ConfigBits_N[107])
);

LHQD1 Inst_frame9_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[106]),
    .QN(ConfigBits_N[106])
);

LHQD1 Inst_frame9_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[105]),
    .QN(ConfigBits_N[105])
);

LHQD1 Inst_frame9_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[104]),
    .QN(ConfigBits_N[104])
);

LHQD1 Inst_frame9_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[103]),
    .QN(ConfigBits_N[103])
);

LHQD1 Inst_frame9_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[102]),
    .QN(ConfigBits_N[102])
);

LHQD1 Inst_frame9_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[101]),
    .QN(ConfigBits_N[101])
);

LHQD1 Inst_frame9_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[100]),
    .QN(ConfigBits_N[100])
);

LHQD1 Inst_frame9_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[99]),
    .QN(ConfigBits_N[99])
);

LHQD1 Inst_frame9_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[98]),
    .QN(ConfigBits_N[98])
);

LHQD1 Inst_frame9_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[97]),
    .QN(ConfigBits_N[97])
);

LHQD1 Inst_frame9_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[9]),
    .Q(ConfigBits[96]),
    .QN(ConfigBits_N[96])
);

LHQD1 Inst_frame10_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[95]),
    .QN(ConfigBits_N[95])
);

LHQD1 Inst_frame10_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[94]),
    .QN(ConfigBits_N[94])
);

LHQD1 Inst_frame10_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[93]),
    .QN(ConfigBits_N[93])
);

LHQD1 Inst_frame10_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[92]),
    .QN(ConfigBits_N[92])
);

LHQD1 Inst_frame10_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[91]),
    .QN(ConfigBits_N[91])
);

LHQD1 Inst_frame10_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[90]),
    .QN(ConfigBits_N[90])
);

LHQD1 Inst_frame10_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[89]),
    .QN(ConfigBits_N[89])
);

LHQD1 Inst_frame10_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[88]),
    .QN(ConfigBits_N[88])
);

LHQD1 Inst_frame10_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[87]),
    .QN(ConfigBits_N[87])
);

LHQD1 Inst_frame10_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[86]),
    .QN(ConfigBits_N[86])
);

LHQD1 Inst_frame10_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[85]),
    .QN(ConfigBits_N[85])
);

LHQD1 Inst_frame10_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[84]),
    .QN(ConfigBits_N[84])
);

LHQD1 Inst_frame10_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[83]),
    .QN(ConfigBits_N[83])
);

LHQD1 Inst_frame10_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[82]),
    .QN(ConfigBits_N[82])
);

LHQD1 Inst_frame10_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[81]),
    .QN(ConfigBits_N[81])
);

LHQD1 Inst_frame10_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[80]),
    .QN(ConfigBits_N[80])
);

LHQD1 Inst_frame10_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[79]),
    .QN(ConfigBits_N[79])
);

LHQD1 Inst_frame10_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[78]),
    .QN(ConfigBits_N[78])
);

LHQD1 Inst_frame10_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[77]),
    .QN(ConfigBits_N[77])
);

LHQD1 Inst_frame10_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[76]),
    .QN(ConfigBits_N[76])
);

LHQD1 Inst_frame10_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[75]),
    .QN(ConfigBits_N[75])
);

LHQD1 Inst_frame10_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[74]),
    .QN(ConfigBits_N[74])
);

LHQD1 Inst_frame10_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[73]),
    .QN(ConfigBits_N[73])
);

LHQD1 Inst_frame10_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[72]),
    .QN(ConfigBits_N[72])
);

LHQD1 Inst_frame10_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[71]),
    .QN(ConfigBits_N[71])
);

LHQD1 Inst_frame10_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[70]),
    .QN(ConfigBits_N[70])
);

LHQD1 Inst_frame10_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[69]),
    .QN(ConfigBits_N[69])
);

LHQD1 Inst_frame10_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[68]),
    .QN(ConfigBits_N[68])
);

LHQD1 Inst_frame10_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[67]),
    .QN(ConfigBits_N[67])
);

LHQD1 Inst_frame10_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[66]),
    .QN(ConfigBits_N[66])
);

LHQD1 Inst_frame10_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[65]),
    .QN(ConfigBits_N[65])
);

LHQD1 Inst_frame10_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[10]),
    .Q(ConfigBits[64]),
    .QN(ConfigBits_N[64])
);

LHQD1 Inst_frame11_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[63]),
    .QN(ConfigBits_N[63])
);

LHQD1 Inst_frame11_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[62]),
    .QN(ConfigBits_N[62])
);

LHQD1 Inst_frame11_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[61]),
    .QN(ConfigBits_N[61])
);

LHQD1 Inst_frame11_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[60]),
    .QN(ConfigBits_N[60])
);

LHQD1 Inst_frame11_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[59]),
    .QN(ConfigBits_N[59])
);

LHQD1 Inst_frame11_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[58]),
    .QN(ConfigBits_N[58])
);

LHQD1 Inst_frame11_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[57]),
    .QN(ConfigBits_N[57])
);

LHQD1 Inst_frame11_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[56]),
    .QN(ConfigBits_N[56])
);

LHQD1 Inst_frame11_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[55]),
    .QN(ConfigBits_N[55])
);

LHQD1 Inst_frame11_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[54]),
    .QN(ConfigBits_N[54])
);

LHQD1 Inst_frame11_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[53]),
    .QN(ConfigBits_N[53])
);

LHQD1 Inst_frame11_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[52]),
    .QN(ConfigBits_N[52])
);

LHQD1 Inst_frame11_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[51]),
    .QN(ConfigBits_N[51])
);

LHQD1 Inst_frame11_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[50]),
    .QN(ConfigBits_N[50])
);

LHQD1 Inst_frame11_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[49]),
    .QN(ConfigBits_N[49])
);

LHQD1 Inst_frame11_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[48]),
    .QN(ConfigBits_N[48])
);

LHQD1 Inst_frame11_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[47]),
    .QN(ConfigBits_N[47])
);

LHQD1 Inst_frame11_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[46]),
    .QN(ConfigBits_N[46])
);

LHQD1 Inst_frame11_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[45]),
    .QN(ConfigBits_N[45])
);

LHQD1 Inst_frame11_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[44]),
    .QN(ConfigBits_N[44])
);

LHQD1 Inst_frame11_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[43]),
    .QN(ConfigBits_N[43])
);

LHQD1 Inst_frame11_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[42]),
    .QN(ConfigBits_N[42])
);

LHQD1 Inst_frame11_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[41]),
    .QN(ConfigBits_N[41])
);

LHQD1 Inst_frame11_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[40]),
    .QN(ConfigBits_N[40])
);

LHQD1 Inst_frame11_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[39]),
    .QN(ConfigBits_N[39])
);

LHQD1 Inst_frame11_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[38]),
    .QN(ConfigBits_N[38])
);

LHQD1 Inst_frame11_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[37]),
    .QN(ConfigBits_N[37])
);

LHQD1 Inst_frame11_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[36]),
    .QN(ConfigBits_N[36])
);

LHQD1 Inst_frame11_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[35]),
    .QN(ConfigBits_N[35])
);

LHQD1 Inst_frame11_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[34]),
    .QN(ConfigBits_N[34])
);

LHQD1 Inst_frame11_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[33]),
    .QN(ConfigBits_N[33])
);

LHQD1 Inst_frame11_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[11]),
    .Q(ConfigBits[32]),
    .QN(ConfigBits_N[32])
);

LHQD1 Inst_frame12_bit31 (
    .D(FrameData[31]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[31]),
    .QN(ConfigBits_N[31])
);

LHQD1 Inst_frame12_bit30 (
    .D(FrameData[30]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[30]),
    .QN(ConfigBits_N[30])
);

LHQD1 Inst_frame12_bit29 (
    .D(FrameData[29]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[29]),
    .QN(ConfigBits_N[29])
);

LHQD1 Inst_frame12_bit28 (
    .D(FrameData[28]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[28]),
    .QN(ConfigBits_N[28])
);

LHQD1 Inst_frame12_bit27 (
    .D(FrameData[27]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[27]),
    .QN(ConfigBits_N[27])
);

LHQD1 Inst_frame12_bit26 (
    .D(FrameData[26]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[26]),
    .QN(ConfigBits_N[26])
);

LHQD1 Inst_frame12_bit25 (
    .D(FrameData[25]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[25]),
    .QN(ConfigBits_N[25])
);

LHQD1 Inst_frame12_bit24 (
    .D(FrameData[24]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[24]),
    .QN(ConfigBits_N[24])
);

LHQD1 Inst_frame12_bit23 (
    .D(FrameData[23]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[23]),
    .QN(ConfigBits_N[23])
);

LHQD1 Inst_frame12_bit22 (
    .D(FrameData[22]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[22]),
    .QN(ConfigBits_N[22])
);

LHQD1 Inst_frame12_bit21 (
    .D(FrameData[21]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[21]),
    .QN(ConfigBits_N[21])
);

LHQD1 Inst_frame12_bit20 (
    .D(FrameData[20]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[20]),
    .QN(ConfigBits_N[20])
);

LHQD1 Inst_frame12_bit19 (
    .D(FrameData[19]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[19]),
    .QN(ConfigBits_N[19])
);

LHQD1 Inst_frame12_bit18 (
    .D(FrameData[18]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[18]),
    .QN(ConfigBits_N[18])
);

LHQD1 Inst_frame12_bit17 (
    .D(FrameData[17]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[17]),
    .QN(ConfigBits_N[17])
);

LHQD1 Inst_frame12_bit16 (
    .D(FrameData[16]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[16]),
    .QN(ConfigBits_N[16])
);

LHQD1 Inst_frame12_bit15 (
    .D(FrameData[15]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[15]),
    .QN(ConfigBits_N[15])
);

LHQD1 Inst_frame12_bit14 (
    .D(FrameData[14]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[14]),
    .QN(ConfigBits_N[14])
);

LHQD1 Inst_frame12_bit13 (
    .D(FrameData[13]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[13]),
    .QN(ConfigBits_N[13])
);

LHQD1 Inst_frame12_bit12 (
    .D(FrameData[12]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[12]),
    .QN(ConfigBits_N[12])
);

LHQD1 Inst_frame12_bit11 (
    .D(FrameData[11]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[11]),
    .QN(ConfigBits_N[11])
);

LHQD1 Inst_frame12_bit10 (
    .D(FrameData[10]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[10]),
    .QN(ConfigBits_N[10])
);

LHQD1 Inst_frame12_bit9 (
    .D(FrameData[9]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[9]),
    .QN(ConfigBits_N[9])
);

LHQD1 Inst_frame12_bit8 (
    .D(FrameData[8]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[8]),
    .QN(ConfigBits_N[8])
);

LHQD1 Inst_frame12_bit7 (
    .D(FrameData[7]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[7]),
    .QN(ConfigBits_N[7])
);

LHQD1 Inst_frame12_bit6 (
    .D(FrameData[6]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[6]),
    .QN(ConfigBits_N[6])
);

LHQD1 Inst_frame12_bit5 (
    .D(FrameData[5]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[5]),
    .QN(ConfigBits_N[5])
);

LHQD1 Inst_frame12_bit4 (
    .D(FrameData[4]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[4]),
    .QN(ConfigBits_N[4])
);

LHQD1 Inst_frame12_bit3 (
    .D(FrameData[3]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[3]),
    .QN(ConfigBits_N[3])
);

LHQD1 Inst_frame12_bit2 (
    .D(FrameData[2]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[2]),
    .QN(ConfigBits_N[2])
);

LHQD1 Inst_frame12_bit1 (
    .D(FrameData[1]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[1]),
    .QN(ConfigBits_N[1])
);

LHQD1 Inst_frame12_bit0 (
    .D(FrameData[0]),
    .E(FrameStrobe[12]),
    .Q(ConfigBits[0]),
    .QN(ConfigBits_N[0])
);

`endif
endmodule