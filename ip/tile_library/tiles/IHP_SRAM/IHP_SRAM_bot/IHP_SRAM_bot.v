module IHP_SRAM_bot
    #(
`ifdef EMULATION
        parameter [639:0] Emulate_Bitstream=640'b0,
`endif
        parameter MaxFramesPerCol=20,
        parameter FrameBitsPerRow=32,
        parameter NoConfigBits=310
    )
    (
 //N
        output  [3:0] N1BEG,        //Port(Name=N1BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=4,Side=N)
        output  [7:0] N2BEG,        //Port(Name=N2BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
        output  [7:0] N2BEGb,        //Port(Name=N2BEGb,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
        output  [15:0] N4BEG,        //Port(Name=N4BEG,IO=OUTPUT,XOffset=0,YOffset=-4,WireCount=4,Side=N)
        input  [3:0] S1END,        //Port(Name=S1END,IO=INPUT,XOffset=0,YOffset=1,WireCount=4,Side=N)
        input  [7:0] S2MID,        //Port(Name=S2MID,IO=INPUT,XOffset=0,YOffset=1,WireCount=8,Side=N)
        input  [7:0] S2END,        //Port(Name=S2END,IO=INPUT,XOffset=0,YOffset=1,WireCount=8,Side=N)
        input  [15:0] S4END,        //Port(Name=S4END,IO=INPUT,XOffset=0,YOffset=4,WireCount=4,Side=N)
        output  [15:0] bot2top_A_DOUT,        //Port(Name=bot2top_A_DOUT,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=16,Side=N)
        input  [15:0] top2bot_A_DIN,        //Port(Name=top2bot_A_DIN,IO=INPUT,XOffset=0,YOffset=1,WireCount=16,Side=N)
        input  [15:0] top2bot_A_BM,        //Port(Name=top2bot_A_BM,IO=INPUT,XOffset=0,YOffset=1,WireCount=16,Side=N)
        input  [4:0] top2bot_A_ADDR,        //Port(Name=top2bot_A_ADDR,IO=INPUT,XOffset=0,YOffset=1,WireCount=5,Side=N)
 //W
        input  [3:0] E1END,        //Port(Name=E1END,IO=INPUT,XOffset=1,YOffset=0,WireCount=4,Side=W)
        input  [7:0] E2MID,        //Port(Name=E2MID,IO=INPUT,XOffset=1,YOffset=0,WireCount=8,Side=W)
        input  [7:0] E2END,        //Port(Name=E2END,IO=INPUT,XOffset=1,YOffset=0,WireCount=8,Side=W)
        input  [15:0] EE4END,        //Port(Name=EE4END,IO=INPUT,XOffset=4,YOffset=0,WireCount=4,Side=W)
        input  [11:0] E6END,        //Port(Name=E6END,IO=INPUT,XOffset=6,YOffset=0,WireCount=2,Side=W)
        output  [3:0] W1BEG,        //Port(Name=W1BEG,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=4,Side=W)
        output  [7:0] W2BEG,        //Port(Name=W2BEG,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=8,Side=W)
        output  [7:0] W2BEGb,        //Port(Name=W2BEGb,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=8,Side=W)
        output  [15:0] WW4BEG,        //Port(Name=WW4BEG,IO=OUTPUT,XOffset=-4,YOffset=0,WireCount=4,Side=W)
        output  [11:0] W6BEG,        //Port(Name=W6BEG,IO=OUTPUT,XOffset=-6,YOffset=0,WireCount=2,Side=W)
 //S
        input  [3:0] N1END,        //Port(Name=N1END,IO=INPUT,XOffset=0,YOffset=-1,WireCount=4,Side=S)
        input  [7:0] N2MID,        //Port(Name=N2MID,IO=INPUT,XOffset=0,YOffset=-1,WireCount=8,Side=S)
        input  [7:0] N2END,        //Port(Name=N2END,IO=INPUT,XOffset=0,YOffset=-1,WireCount=8,Side=S)
        input  [15:0] N4END,        //Port(Name=N4END,IO=INPUT,XOffset=0,YOffset=-4,WireCount=4,Side=S)
        output  [3:0] S1BEG,        //Port(Name=S1BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=4,Side=S)
        output  [7:0] S2BEG,        //Port(Name=S2BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
        output  [7:0] S2BEGb,        //Port(Name=S2BEGb,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
        output  [15:0] S4BEG,        //Port(Name=S4BEG,IO=OUTPUT,XOffset=0,YOffset=4,WireCount=4,Side=S)
        input  A_DOUT_SRAM0,
        input  A_DOUT_SRAM1,
        input  A_DOUT_SRAM2,
        input  A_DOUT_SRAM3,
        input  A_DOUT_SRAM4,
        input  A_DOUT_SRAM5,
        input  A_DOUT_SRAM6,
        input  A_DOUT_SRAM7,
        input  A_DOUT_SRAM8,
        input  A_DOUT_SRAM9,
        input  A_DOUT_SRAM10,
        input  A_DOUT_SRAM11,
        input  A_DOUT_SRAM12,
        input  A_DOUT_SRAM13,
        input  A_DOUT_SRAM14,
        input  A_DOUT_SRAM15,
        input  A_DOUT_SRAM16,
        input  A_DOUT_SRAM17,
        input  A_DOUT_SRAM18,
        input  A_DOUT_SRAM19,
        input  A_DOUT_SRAM20,
        input  A_DOUT_SRAM21,
        input  A_DOUT_SRAM22,
        input  A_DOUT_SRAM23,
        input  A_DOUT_SRAM24,
        input  A_DOUT_SRAM25,
        input  A_DOUT_SRAM26,
        input  A_DOUT_SRAM27,
        input  A_DOUT_SRAM28,
        input  A_DOUT_SRAM29,
        input  A_DOUT_SRAM30,
        input  A_DOUT_SRAM31,
        input  CONFIGURED_top,
        output  A_ADDR_SRAM0,
        output  A_ADDR_SRAM1,
        output  A_ADDR_SRAM2,
        output  A_ADDR_SRAM3,
        output  A_ADDR_SRAM4,
        output  A_ADDR_SRAM5,
        output  A_ADDR_SRAM6,
        output  A_ADDR_SRAM7,
        output  A_ADDR_SRAM8,
        output  A_ADDR_SRAM9,
        output  A_DIN_SRAM0,
        output  A_DIN_SRAM1,
        output  A_DIN_SRAM2,
        output  A_DIN_SRAM3,
        output  A_DIN_SRAM4,
        output  A_DIN_SRAM5,
        output  A_DIN_SRAM6,
        output  A_DIN_SRAM7,
        output  A_DIN_SRAM8,
        output  A_DIN_SRAM9,
        output  A_DIN_SRAM10,
        output  A_DIN_SRAM11,
        output  A_DIN_SRAM12,
        output  A_DIN_SRAM13,
        output  A_DIN_SRAM14,
        output  A_DIN_SRAM15,
        output  A_DIN_SRAM16,
        output  A_DIN_SRAM17,
        output  A_DIN_SRAM18,
        output  A_DIN_SRAM19,
        output  A_DIN_SRAM20,
        output  A_DIN_SRAM21,
        output  A_DIN_SRAM22,
        output  A_DIN_SRAM23,
        output  A_DIN_SRAM24,
        output  A_DIN_SRAM25,
        output  A_DIN_SRAM26,
        output  A_DIN_SRAM27,
        output  A_DIN_SRAM28,
        output  A_DIN_SRAM29,
        output  A_DIN_SRAM30,
        output  A_DIN_SRAM31,
        output  A_BM_SRAM0,
        output  A_BM_SRAM1,
        output  A_BM_SRAM2,
        output  A_BM_SRAM3,
        output  A_BM_SRAM4,
        output  A_BM_SRAM5,
        output  A_BM_SRAM6,
        output  A_BM_SRAM7,
        output  A_BM_SRAM8,
        output  A_BM_SRAM9,
        output  A_BM_SRAM10,
        output  A_BM_SRAM11,
        output  A_BM_SRAM12,
        output  A_BM_SRAM13,
        output  A_BM_SRAM14,
        output  A_BM_SRAM15,
        output  A_BM_SRAM16,
        output  A_BM_SRAM17,
        output  A_BM_SRAM18,
        output  A_BM_SRAM19,
        output  A_BM_SRAM20,
        output  A_BM_SRAM21,
        output  A_BM_SRAM22,
        output  A_BM_SRAM23,
        output  A_BM_SRAM24,
        output  A_BM_SRAM25,
        output  A_BM_SRAM26,
        output  A_BM_SRAM27,
        output  A_BM_SRAM28,
        output  A_BM_SRAM29,
        output  A_BM_SRAM30,
        output  A_BM_SRAM31,
        output  A_WEN_SRAM,
        output  A_MEN_SRAM,
        output  A_REN_SRAM,
        output  A_CLK_SRAM,
        output  A_TIE_HIGH_SRAM,
        output  A_TIE_LOW_SRAM,
    //Tile IO ports from BELs
        input  UserCLK,
        output  UserCLKo,
        input  [FrameBitsPerRow-1:0] FrameData, //CONFIG_PORT
        output  [FrameBitsPerRow-1:0] FrameData_O,
        input  [MaxFramesPerCol-1:0] FrameStrobe, //CONFIG_PORT
        output  [MaxFramesPerCol-1:0] FrameStrobe_O
    //global
);
 //signal declarations
 //BEL ports (e.g., slices)
wire A_ADDR0;
wire A_ADDR1;
wire A_ADDR2;
wire A_ADDR3;
wire A_ADDR4;
wire A_ADDR5;
wire A_ADDR6;
wire A_ADDR7;
wire A_ADDR8;
wire A_ADDR9;
wire A_DIN0;
wire A_DIN1;
wire A_DIN2;
wire A_DIN3;
wire A_DIN4;
wire A_DIN5;
wire A_DIN6;
wire A_DIN7;
wire A_DIN8;
wire A_DIN9;
wire A_DIN10;
wire A_DIN11;
wire A_DIN12;
wire A_DIN13;
wire A_DIN14;
wire A_DIN15;
wire A_DIN16;
wire A_DIN17;
wire A_DIN18;
wire A_DIN19;
wire A_DIN20;
wire A_DIN21;
wire A_DIN22;
wire A_DIN23;
wire A_DIN24;
wire A_DIN25;
wire A_DIN26;
wire A_DIN27;
wire A_DIN28;
wire A_DIN29;
wire A_DIN30;
wire A_DIN31;
wire A_BM0;
wire A_BM1;
wire A_BM2;
wire A_BM3;
wire A_BM4;
wire A_BM5;
wire A_BM6;
wire A_BM7;
wire A_BM8;
wire A_BM9;
wire A_BM10;
wire A_BM11;
wire A_BM12;
wire A_BM13;
wire A_BM14;
wire A_BM15;
wire A_BM16;
wire A_BM17;
wire A_BM18;
wire A_BM19;
wire A_BM20;
wire A_BM21;
wire A_BM22;
wire A_BM23;
wire A_BM24;
wire A_BM25;
wire A_BM26;
wire A_BM27;
wire A_BM28;
wire A_BM29;
wire A_BM30;
wire A_BM31;
wire A_WEN;
wire A_MEN;
wire A_REN;
wire A_DOUT0;
wire A_DOUT1;
wire A_DOUT2;
wire A_DOUT3;
wire A_DOUT4;
wire A_DOUT5;
wire A_DOUT6;
wire A_DOUT7;
wire A_DOUT8;
wire A_DOUT9;
wire A_DOUT10;
wire A_DOUT11;
wire A_DOUT12;
wire A_DOUT13;
wire A_DOUT14;
wire A_DOUT15;
wire A_DOUT16;
wire A_DOUT17;
wire A_DOUT18;
wire A_DOUT19;
wire A_DOUT20;
wire A_DOUT21;
wire A_DOUT22;
wire A_DOUT23;
wire A_DOUT24;
wire A_DOUT25;
wire A_DOUT26;
wire A_DOUT27;
wire A_DOUT28;
wire A_DOUT29;
wire A_DOUT30;
wire A_DOUT31;
 //Jump wires
wire[16-1:0] J_NS4_BEG;
wire[8-1:0] J_NS2_BEG;
wire[4-1:0] J_NS1_BEG;
 //internal configuration data signal to daisy-chain all BELs (if any and in the order they are listed in the fabric.csv)
wire[NoConfigBits-1:0] ConfigBits;
wire[NoConfigBits-1:0] ConfigBits_N;

 //Connection for outgoing wires
wire[FrameBitsPerRow-1:0] FrameData_i;
wire[FrameBitsPerRow-1:0] FrameData_O_i;
wire[MaxFramesPerCol-1:0] FrameStrobe_i;
wire[MaxFramesPerCol-1:0] FrameStrobe_O_i;
wire[15:0] N4END_i;
wire[11:0] N4BEG_i;
wire[15:0] S4END_i;
wire[11:0] S4BEG_i;

assign FrameData_O_i = FrameData_i;

my_buf data_inbuf_0 (
    .A(FrameData[0]),
    .X(FrameData_i[0])
);

my_buf data_inbuf_1 (
    .A(FrameData[1]),
    .X(FrameData_i[1])
);

my_buf data_inbuf_2 (
    .A(FrameData[2]),
    .X(FrameData_i[2])
);

my_buf data_inbuf_3 (
    .A(FrameData[3]),
    .X(FrameData_i[3])
);

my_buf data_inbuf_4 (
    .A(FrameData[4]),
    .X(FrameData_i[4])
);

my_buf data_inbuf_5 (
    .A(FrameData[5]),
    .X(FrameData_i[5])
);

my_buf data_inbuf_6 (
    .A(FrameData[6]),
    .X(FrameData_i[6])
);

my_buf data_inbuf_7 (
    .A(FrameData[7]),
    .X(FrameData_i[7])
);

my_buf data_inbuf_8 (
    .A(FrameData[8]),
    .X(FrameData_i[8])
);

my_buf data_inbuf_9 (
    .A(FrameData[9]),
    .X(FrameData_i[9])
);

my_buf data_inbuf_10 (
    .A(FrameData[10]),
    .X(FrameData_i[10])
);

my_buf data_inbuf_11 (
    .A(FrameData[11]),
    .X(FrameData_i[11])
);

my_buf data_inbuf_12 (
    .A(FrameData[12]),
    .X(FrameData_i[12])
);

my_buf data_inbuf_13 (
    .A(FrameData[13]),
    .X(FrameData_i[13])
);

my_buf data_inbuf_14 (
    .A(FrameData[14]),
    .X(FrameData_i[14])
);

my_buf data_inbuf_15 (
    .A(FrameData[15]),
    .X(FrameData_i[15])
);

my_buf data_inbuf_16 (
    .A(FrameData[16]),
    .X(FrameData_i[16])
);

my_buf data_inbuf_17 (
    .A(FrameData[17]),
    .X(FrameData_i[17])
);

my_buf data_inbuf_18 (
    .A(FrameData[18]),
    .X(FrameData_i[18])
);

my_buf data_inbuf_19 (
    .A(FrameData[19]),
    .X(FrameData_i[19])
);

my_buf data_inbuf_20 (
    .A(FrameData[20]),
    .X(FrameData_i[20])
);

my_buf data_inbuf_21 (
    .A(FrameData[21]),
    .X(FrameData_i[21])
);

my_buf data_inbuf_22 (
    .A(FrameData[22]),
    .X(FrameData_i[22])
);

my_buf data_inbuf_23 (
    .A(FrameData[23]),
    .X(FrameData_i[23])
);

my_buf data_inbuf_24 (
    .A(FrameData[24]),
    .X(FrameData_i[24])
);

my_buf data_inbuf_25 (
    .A(FrameData[25]),
    .X(FrameData_i[25])
);

my_buf data_inbuf_26 (
    .A(FrameData[26]),
    .X(FrameData_i[26])
);

my_buf data_inbuf_27 (
    .A(FrameData[27]),
    .X(FrameData_i[27])
);

my_buf data_inbuf_28 (
    .A(FrameData[28]),
    .X(FrameData_i[28])
);

my_buf data_inbuf_29 (
    .A(FrameData[29]),
    .X(FrameData_i[29])
);

my_buf data_inbuf_30 (
    .A(FrameData[30]),
    .X(FrameData_i[30])
);

my_buf data_inbuf_31 (
    .A(FrameData[31]),
    .X(FrameData_i[31])
);

my_buf data_outbuf_0 (
    .A(FrameData_O_i[0]),
    .X(FrameData_O[0])
);

my_buf data_outbuf_1 (
    .A(FrameData_O_i[1]),
    .X(FrameData_O[1])
);

my_buf data_outbuf_2 (
    .A(FrameData_O_i[2]),
    .X(FrameData_O[2])
);

my_buf data_outbuf_3 (
    .A(FrameData_O_i[3]),
    .X(FrameData_O[3])
);

my_buf data_outbuf_4 (
    .A(FrameData_O_i[4]),
    .X(FrameData_O[4])
);

my_buf data_outbuf_5 (
    .A(FrameData_O_i[5]),
    .X(FrameData_O[5])
);

my_buf data_outbuf_6 (
    .A(FrameData_O_i[6]),
    .X(FrameData_O[6])
);

my_buf data_outbuf_7 (
    .A(FrameData_O_i[7]),
    .X(FrameData_O[7])
);

my_buf data_outbuf_8 (
    .A(FrameData_O_i[8]),
    .X(FrameData_O[8])
);

my_buf data_outbuf_9 (
    .A(FrameData_O_i[9]),
    .X(FrameData_O[9])
);

my_buf data_outbuf_10 (
    .A(FrameData_O_i[10]),
    .X(FrameData_O[10])
);

my_buf data_outbuf_11 (
    .A(FrameData_O_i[11]),
    .X(FrameData_O[11])
);

my_buf data_outbuf_12 (
    .A(FrameData_O_i[12]),
    .X(FrameData_O[12])
);

my_buf data_outbuf_13 (
    .A(FrameData_O_i[13]),
    .X(FrameData_O[13])
);

my_buf data_outbuf_14 (
    .A(FrameData_O_i[14]),
    .X(FrameData_O[14])
);

my_buf data_outbuf_15 (
    .A(FrameData_O_i[15]),
    .X(FrameData_O[15])
);

my_buf data_outbuf_16 (
    .A(FrameData_O_i[16]),
    .X(FrameData_O[16])
);

my_buf data_outbuf_17 (
    .A(FrameData_O_i[17]),
    .X(FrameData_O[17])
);

my_buf data_outbuf_18 (
    .A(FrameData_O_i[18]),
    .X(FrameData_O[18])
);

my_buf data_outbuf_19 (
    .A(FrameData_O_i[19]),
    .X(FrameData_O[19])
);

my_buf data_outbuf_20 (
    .A(FrameData_O_i[20]),
    .X(FrameData_O[20])
);

my_buf data_outbuf_21 (
    .A(FrameData_O_i[21]),
    .X(FrameData_O[21])
);

my_buf data_outbuf_22 (
    .A(FrameData_O_i[22]),
    .X(FrameData_O[22])
);

my_buf data_outbuf_23 (
    .A(FrameData_O_i[23]),
    .X(FrameData_O[23])
);

my_buf data_outbuf_24 (
    .A(FrameData_O_i[24]),
    .X(FrameData_O[24])
);

my_buf data_outbuf_25 (
    .A(FrameData_O_i[25]),
    .X(FrameData_O[25])
);

my_buf data_outbuf_26 (
    .A(FrameData_O_i[26]),
    .X(FrameData_O[26])
);

my_buf data_outbuf_27 (
    .A(FrameData_O_i[27]),
    .X(FrameData_O[27])
);

my_buf data_outbuf_28 (
    .A(FrameData_O_i[28]),
    .X(FrameData_O[28])
);

my_buf data_outbuf_29 (
    .A(FrameData_O_i[29]),
    .X(FrameData_O[29])
);

my_buf data_outbuf_30 (
    .A(FrameData_O_i[30]),
    .X(FrameData_O[30])
);

my_buf data_outbuf_31 (
    .A(FrameData_O_i[31]),
    .X(FrameData_O[31])
);

assign FrameStrobe_O_i = FrameStrobe_i;

my_buf strobe_inbuf_0 (
    .A(FrameStrobe[0]),
    .X(FrameStrobe_i[0])
);

my_buf strobe_inbuf_1 (
    .A(FrameStrobe[1]),
    .X(FrameStrobe_i[1])
);

my_buf strobe_inbuf_2 (
    .A(FrameStrobe[2]),
    .X(FrameStrobe_i[2])
);

my_buf strobe_inbuf_3 (
    .A(FrameStrobe[3]),
    .X(FrameStrobe_i[3])
);

my_buf strobe_inbuf_4 (
    .A(FrameStrobe[4]),
    .X(FrameStrobe_i[4])
);

my_buf strobe_inbuf_5 (
    .A(FrameStrobe[5]),
    .X(FrameStrobe_i[5])
);

my_buf strobe_inbuf_6 (
    .A(FrameStrobe[6]),
    .X(FrameStrobe_i[6])
);

my_buf strobe_inbuf_7 (
    .A(FrameStrobe[7]),
    .X(FrameStrobe_i[7])
);

my_buf strobe_inbuf_8 (
    .A(FrameStrobe[8]),
    .X(FrameStrobe_i[8])
);

my_buf strobe_inbuf_9 (
    .A(FrameStrobe[9]),
    .X(FrameStrobe_i[9])
);

my_buf strobe_inbuf_10 (
    .A(FrameStrobe[10]),
    .X(FrameStrobe_i[10])
);

my_buf strobe_inbuf_11 (
    .A(FrameStrobe[11]),
    .X(FrameStrobe_i[11])
);

my_buf strobe_inbuf_12 (
    .A(FrameStrobe[12]),
    .X(FrameStrobe_i[12])
);

my_buf strobe_inbuf_13 (
    .A(FrameStrobe[13]),
    .X(FrameStrobe_i[13])
);

my_buf strobe_inbuf_14 (
    .A(FrameStrobe[14]),
    .X(FrameStrobe_i[14])
);

my_buf strobe_inbuf_15 (
    .A(FrameStrobe[15]),
    .X(FrameStrobe_i[15])
);

my_buf strobe_inbuf_16 (
    .A(FrameStrobe[16]),
    .X(FrameStrobe_i[16])
);

my_buf strobe_inbuf_17 (
    .A(FrameStrobe[17]),
    .X(FrameStrobe_i[17])
);

my_buf strobe_inbuf_18 (
    .A(FrameStrobe[18]),
    .X(FrameStrobe_i[18])
);

my_buf strobe_inbuf_19 (
    .A(FrameStrobe[19]),
    .X(FrameStrobe_i[19])
);

my_buf strobe_outbuf_0 (
    .A(FrameStrobe_O_i[0]),
    .X(FrameStrobe_O[0])
);

my_buf strobe_outbuf_1 (
    .A(FrameStrobe_O_i[1]),
    .X(FrameStrobe_O[1])
);

my_buf strobe_outbuf_2 (
    .A(FrameStrobe_O_i[2]),
    .X(FrameStrobe_O[2])
);

my_buf strobe_outbuf_3 (
    .A(FrameStrobe_O_i[3]),
    .X(FrameStrobe_O[3])
);

my_buf strobe_outbuf_4 (
    .A(FrameStrobe_O_i[4]),
    .X(FrameStrobe_O[4])
);

my_buf strobe_outbuf_5 (
    .A(FrameStrobe_O_i[5]),
    .X(FrameStrobe_O[5])
);

my_buf strobe_outbuf_6 (
    .A(FrameStrobe_O_i[6]),
    .X(FrameStrobe_O[6])
);

my_buf strobe_outbuf_7 (
    .A(FrameStrobe_O_i[7]),
    .X(FrameStrobe_O[7])
);

my_buf strobe_outbuf_8 (
    .A(FrameStrobe_O_i[8]),
    .X(FrameStrobe_O[8])
);

my_buf strobe_outbuf_9 (
    .A(FrameStrobe_O_i[9]),
    .X(FrameStrobe_O[9])
);

my_buf strobe_outbuf_10 (
    .A(FrameStrobe_O_i[10]),
    .X(FrameStrobe_O[10])
);

my_buf strobe_outbuf_11 (
    .A(FrameStrobe_O_i[11]),
    .X(FrameStrobe_O[11])
);

my_buf strobe_outbuf_12 (
    .A(FrameStrobe_O_i[12]),
    .X(FrameStrobe_O[12])
);

my_buf strobe_outbuf_13 (
    .A(FrameStrobe_O_i[13]),
    .X(FrameStrobe_O[13])
);

my_buf strobe_outbuf_14 (
    .A(FrameStrobe_O_i[14]),
    .X(FrameStrobe_O[14])
);

my_buf strobe_outbuf_15 (
    .A(FrameStrobe_O_i[15]),
    .X(FrameStrobe_O[15])
);

my_buf strobe_outbuf_16 (
    .A(FrameStrobe_O_i[16]),
    .X(FrameStrobe_O[16])
);

my_buf strobe_outbuf_17 (
    .A(FrameStrobe_O_i[17]),
    .X(FrameStrobe_O[17])
);

my_buf strobe_outbuf_18 (
    .A(FrameStrobe_O_i[18]),
    .X(FrameStrobe_O[18])
);

my_buf strobe_outbuf_19 (
    .A(FrameStrobe_O_i[19]),
    .X(FrameStrobe_O[19])
);

assign N4BEG_i[15-4:0] = N4END_i[15:4];

my_buf N4END_inbuf_0 (
    .A(N4END[4]),
    .X(N4END_i[4])
);

my_buf N4END_inbuf_1 (
    .A(N4END[5]),
    .X(N4END_i[5])
);

my_buf N4END_inbuf_2 (
    .A(N4END[6]),
    .X(N4END_i[6])
);

my_buf N4END_inbuf_3 (
    .A(N4END[7]),
    .X(N4END_i[7])
);

my_buf N4END_inbuf_4 (
    .A(N4END[8]),
    .X(N4END_i[8])
);

my_buf N4END_inbuf_5 (
    .A(N4END[9]),
    .X(N4END_i[9])
);

my_buf N4END_inbuf_6 (
    .A(N4END[10]),
    .X(N4END_i[10])
);

my_buf N4END_inbuf_7 (
    .A(N4END[11]),
    .X(N4END_i[11])
);

my_buf N4END_inbuf_8 (
    .A(N4END[12]),
    .X(N4END_i[12])
);

my_buf N4END_inbuf_9 (
    .A(N4END[13]),
    .X(N4END_i[13])
);

my_buf N4END_inbuf_10 (
    .A(N4END[14]),
    .X(N4END_i[14])
);

my_buf N4END_inbuf_11 (
    .A(N4END[15]),
    .X(N4END_i[15])
);

my_buf N4BEG_outbuf_0 (
    .A(N4BEG_i[0]),
    .X(N4BEG[0])
);

my_buf N4BEG_outbuf_1 (
    .A(N4BEG_i[1]),
    .X(N4BEG[1])
);

my_buf N4BEG_outbuf_2 (
    .A(N4BEG_i[2]),
    .X(N4BEG[2])
);

my_buf N4BEG_outbuf_3 (
    .A(N4BEG_i[3]),
    .X(N4BEG[3])
);

my_buf N4BEG_outbuf_4 (
    .A(N4BEG_i[4]),
    .X(N4BEG[4])
);

my_buf N4BEG_outbuf_5 (
    .A(N4BEG_i[5]),
    .X(N4BEG[5])
);

my_buf N4BEG_outbuf_6 (
    .A(N4BEG_i[6]),
    .X(N4BEG[6])
);

my_buf N4BEG_outbuf_7 (
    .A(N4BEG_i[7]),
    .X(N4BEG[7])
);

my_buf N4BEG_outbuf_8 (
    .A(N4BEG_i[8]),
    .X(N4BEG[8])
);

my_buf N4BEG_outbuf_9 (
    .A(N4BEG_i[9]),
    .X(N4BEG[9])
);

my_buf N4BEG_outbuf_10 (
    .A(N4BEG_i[10]),
    .X(N4BEG[10])
);

my_buf N4BEG_outbuf_11 (
    .A(N4BEG_i[11]),
    .X(N4BEG[11])
);

assign S4BEG_i[15-4:0] = S4END_i[15:4];

my_buf S4END_inbuf_0 (
    .A(S4END[4]),
    .X(S4END_i[4])
);

my_buf S4END_inbuf_1 (
    .A(S4END[5]),
    .X(S4END_i[5])
);

my_buf S4END_inbuf_2 (
    .A(S4END[6]),
    .X(S4END_i[6])
);

my_buf S4END_inbuf_3 (
    .A(S4END[7]),
    .X(S4END_i[7])
);

my_buf S4END_inbuf_4 (
    .A(S4END[8]),
    .X(S4END_i[8])
);

my_buf S4END_inbuf_5 (
    .A(S4END[9]),
    .X(S4END_i[9])
);

my_buf S4END_inbuf_6 (
    .A(S4END[10]),
    .X(S4END_i[10])
);

my_buf S4END_inbuf_7 (
    .A(S4END[11]),
    .X(S4END_i[11])
);

my_buf S4END_inbuf_8 (
    .A(S4END[12]),
    .X(S4END_i[12])
);

my_buf S4END_inbuf_9 (
    .A(S4END[13]),
    .X(S4END_i[13])
);

my_buf S4END_inbuf_10 (
    .A(S4END[14]),
    .X(S4END_i[14])
);

my_buf S4END_inbuf_11 (
    .A(S4END[15]),
    .X(S4END_i[15])
);

my_buf S4BEG_outbuf_0 (
    .A(S4BEG_i[0]),
    .X(S4BEG[0])
);

my_buf S4BEG_outbuf_1 (
    .A(S4BEG_i[1]),
    .X(S4BEG[1])
);

my_buf S4BEG_outbuf_2 (
    .A(S4BEG_i[2]),
    .X(S4BEG[2])
);

my_buf S4BEG_outbuf_3 (
    .A(S4BEG_i[3]),
    .X(S4BEG[3])
);

my_buf S4BEG_outbuf_4 (
    .A(S4BEG_i[4]),
    .X(S4BEG[4])
);

my_buf S4BEG_outbuf_5 (
    .A(S4BEG_i[5]),
    .X(S4BEG[5])
);

my_buf S4BEG_outbuf_6 (
    .A(S4BEG_i[6]),
    .X(S4BEG[6])
);

my_buf S4BEG_outbuf_7 (
    .A(S4BEG_i[7]),
    .X(S4BEG[7])
);

my_buf S4BEG_outbuf_8 (
    .A(S4BEG_i[8]),
    .X(S4BEG[8])
);

my_buf S4BEG_outbuf_9 (
    .A(S4BEG_i[9]),
    .X(S4BEG[9])
);

my_buf S4BEG_outbuf_10 (
    .A(S4BEG_i[10]),
    .X(S4BEG[10])
);

my_buf S4BEG_outbuf_11 (
    .A(S4BEG_i[11]),
    .X(S4BEG[11])
);

clk_buf inst_clk_buf (
    .A(UserCLK),
    .X(UserCLKo)
);


 //configuration storage latches
IHP_SRAM_bot_ConfigMem
`ifdef EMULATION
    #(
    .Emulate_Bitstream(Emulate_Bitstream)
    )
`endif
    Inst_IHP_SRAM_bot_ConfigMem
    (
    .FrameData(FrameData),
    .FrameStrobe(FrameStrobe),
    .ConfigBits(ConfigBits),
    .ConfigBits_N(ConfigBits_N)
);


 //BEL component instantiations
IHP_SRAM_1024x32 Inst_IHP_SRAM_1024x32 (
    .A_ADDR({A_ADDR9, A_ADDR8, A_ADDR7, A_ADDR6, A_ADDR5, A_ADDR4, A_ADDR3, A_ADDR2, A_ADDR1, A_ADDR0}),
    .A_DIN({A_DIN31, A_DIN30, A_DIN29, A_DIN28, A_DIN27, A_DIN26, A_DIN25, A_DIN24, A_DIN23, A_DIN22, A_DIN21, A_DIN20, A_DIN19, A_DIN18, A_DIN17, A_DIN16, A_DIN15, A_DIN14, A_DIN13, A_DIN12, A_DIN11, A_DIN10, A_DIN9, A_DIN8, A_DIN7, A_DIN6, A_DIN5, A_DIN4, A_DIN3, A_DIN2, A_DIN1, A_DIN0}),
    .A_BM({A_BM31, A_BM30, A_BM29, A_BM28, A_BM27, A_BM26, A_BM25, A_BM24, A_BM23, A_BM22, A_BM21, A_BM20, A_BM19, A_BM18, A_BM17, A_BM16, A_BM15, A_BM14, A_BM13, A_BM12, A_BM11, A_BM10, A_BM9, A_BM8, A_BM7, A_BM6, A_BM5, A_BM4, A_BM3, A_BM2, A_BM1, A_BM0}),
    .A_WEN(A_WEN),
    .A_MEN(A_MEN),
    .A_REN(A_REN),
    .A_DOUT({A_DOUT31, A_DOUT30, A_DOUT29, A_DOUT28, A_DOUT27, A_DOUT26, A_DOUT25, A_DOUT24, A_DOUT23, A_DOUT22, A_DOUT21, A_DOUT20, A_DOUT19, A_DOUT18, A_DOUT17, A_DOUT16, A_DOUT15, A_DOUT14, A_DOUT13, A_DOUT12, A_DOUT11, A_DOUT10, A_DOUT9, A_DOUT8, A_DOUT7, A_DOUT6, A_DOUT5, A_DOUT4, A_DOUT3, A_DOUT2, A_DOUT1, A_DOUT0}),
    .A_ADDR_SRAM({A_ADDR_SRAM9, A_ADDR_SRAM8, A_ADDR_SRAM7, A_ADDR_SRAM6, A_ADDR_SRAM5, A_ADDR_SRAM4, A_ADDR_SRAM3, A_ADDR_SRAM2, A_ADDR_SRAM1, A_ADDR_SRAM0}),
    .A_DIN_SRAM({A_DIN_SRAM31, A_DIN_SRAM30, A_DIN_SRAM29, A_DIN_SRAM28, A_DIN_SRAM27, A_DIN_SRAM26, A_DIN_SRAM25, A_DIN_SRAM24, A_DIN_SRAM23, A_DIN_SRAM22, A_DIN_SRAM21, A_DIN_SRAM20, A_DIN_SRAM19, A_DIN_SRAM18, A_DIN_SRAM17, A_DIN_SRAM16, A_DIN_SRAM15, A_DIN_SRAM14, A_DIN_SRAM13, A_DIN_SRAM12, A_DIN_SRAM11, A_DIN_SRAM10, A_DIN_SRAM9, A_DIN_SRAM8, A_DIN_SRAM7, A_DIN_SRAM6, A_DIN_SRAM5, A_DIN_SRAM4, A_DIN_SRAM3, A_DIN_SRAM2, A_DIN_SRAM1, A_DIN_SRAM0}),
    .A_BM_SRAM({A_BM_SRAM31, A_BM_SRAM30, A_BM_SRAM29, A_BM_SRAM28, A_BM_SRAM27, A_BM_SRAM26, A_BM_SRAM25, A_BM_SRAM24, A_BM_SRAM23, A_BM_SRAM22, A_BM_SRAM21, A_BM_SRAM20, A_BM_SRAM19, A_BM_SRAM18, A_BM_SRAM17, A_BM_SRAM16, A_BM_SRAM15, A_BM_SRAM14, A_BM_SRAM13, A_BM_SRAM12, A_BM_SRAM11, A_BM_SRAM10, A_BM_SRAM9, A_BM_SRAM8, A_BM_SRAM7, A_BM_SRAM6, A_BM_SRAM5, A_BM_SRAM4, A_BM_SRAM3, A_BM_SRAM2, A_BM_SRAM1, A_BM_SRAM0}),
    .A_WEN_SRAM(A_WEN_SRAM),
    .A_MEN_SRAM(A_MEN_SRAM),
    .A_REN_SRAM(A_REN_SRAM),
    .A_DOUT_SRAM({A_DOUT_SRAM31, A_DOUT_SRAM30, A_DOUT_SRAM29, A_DOUT_SRAM28, A_DOUT_SRAM27, A_DOUT_SRAM26, A_DOUT_SRAM25, A_DOUT_SRAM24, A_DOUT_SRAM23, A_DOUT_SRAM22, A_DOUT_SRAM21, A_DOUT_SRAM20, A_DOUT_SRAM19, A_DOUT_SRAM18, A_DOUT_SRAM17, A_DOUT_SRAM16, A_DOUT_SRAM15, A_DOUT_SRAM14, A_DOUT_SRAM13, A_DOUT_SRAM12, A_DOUT_SRAM11, A_DOUT_SRAM10, A_DOUT_SRAM9, A_DOUT_SRAM8, A_DOUT_SRAM7, A_DOUT_SRAM6, A_DOUT_SRAM5, A_DOUT_SRAM4, A_DOUT_SRAM3, A_DOUT_SRAM2, A_DOUT_SRAM1, A_DOUT_SRAM0}),
    .A_CLK_SRAM(A_CLK_SRAM),
    .A_TIE_HIGH_SRAM(A_TIE_HIGH_SRAM),
    .A_TIE_LOW_SRAM(A_TIE_LOW_SRAM),
    .CONFIGURED_top(CONFIGURED_top),
    .UserCLK(UserCLK)
);

IHP_SRAM_bot_switch_matrix Inst_IHP_SRAM_bot_switch_matrix (
    .N1END0(N1END[0]),
    .N1END1(N1END[1]),
    .N1END2(N1END[2]),
    .N1END3(N1END[3]),
    .N2MID0(N2MID[0]),
    .N2MID1(N2MID[1]),
    .N2MID2(N2MID[2]),
    .N2MID3(N2MID[3]),
    .N2MID4(N2MID[4]),
    .N2MID5(N2MID[5]),
    .N2MID6(N2MID[6]),
    .N2MID7(N2MID[7]),
    .N2END0(N2END[0]),
    .N2END1(N2END[1]),
    .N2END2(N2END[2]),
    .N2END3(N2END[3]),
    .N2END4(N2END[4]),
    .N2END5(N2END[5]),
    .N2END6(N2END[6]),
    .N2END7(N2END[7]),
    .N4END0(N4END[0]),
    .N4END1(N4END[1]),
    .N4END2(N4END[2]),
    .N4END3(N4END[3]),
    .E1END0(E1END[0]),
    .E1END1(E1END[1]),
    .E1END2(E1END[2]),
    .E1END3(E1END[3]),
    .E2MID0(E2MID[0]),
    .E2MID1(E2MID[1]),
    .E2MID2(E2MID[2]),
    .E2MID3(E2MID[3]),
    .E2MID4(E2MID[4]),
    .E2MID5(E2MID[5]),
    .E2MID6(E2MID[6]),
    .E2MID7(E2MID[7]),
    .E2END0(E2END[0]),
    .E2END1(E2END[1]),
    .E2END2(E2END[2]),
    .E2END3(E2END[3]),
    .E2END4(E2END[4]),
    .E2END5(E2END[5]),
    .E2END6(E2END[6]),
    .E2END7(E2END[7]),
    .EE4END0(EE4END[0]),
    .EE4END1(EE4END[1]),
    .EE4END2(EE4END[2]),
    .EE4END3(EE4END[3]),
    .EE4END4(EE4END[4]),
    .EE4END5(EE4END[5]),
    .EE4END6(EE4END[6]),
    .EE4END7(EE4END[7]),
    .EE4END8(EE4END[8]),
    .EE4END9(EE4END[9]),
    .EE4END10(EE4END[10]),
    .EE4END11(EE4END[11]),
    .EE4END12(EE4END[12]),
    .EE4END13(EE4END[13]),
    .EE4END14(EE4END[14]),
    .EE4END15(EE4END[15]),
    .E6END0(E6END[0]),
    .E6END1(E6END[1]),
    .E6END2(E6END[2]),
    .E6END3(E6END[3]),
    .E6END4(E6END[4]),
    .E6END5(E6END[5]),
    .E6END6(E6END[6]),
    .E6END7(E6END[7]),
    .E6END8(E6END[8]),
    .E6END9(E6END[9]),
    .E6END10(E6END[10]),
    .E6END11(E6END[11]),
    .S1END0(S1END[0]),
    .S1END1(S1END[1]),
    .S1END2(S1END[2]),
    .S1END3(S1END[3]),
    .S2MID0(S2MID[0]),
    .S2MID1(S2MID[1]),
    .S2MID2(S2MID[2]),
    .S2MID3(S2MID[3]),
    .S2MID4(S2MID[4]),
    .S2MID5(S2MID[5]),
    .S2MID6(S2MID[6]),
    .S2MID7(S2MID[7]),
    .S2END0(S2END[0]),
    .S2END1(S2END[1]),
    .S2END2(S2END[2]),
    .S2END3(S2END[3]),
    .S2END4(S2END[4]),
    .S2END5(S2END[5]),
    .S2END6(S2END[6]),
    .S2END7(S2END[7]),
    .S4END0(S4END[0]),
    .S4END1(S4END[1]),
    .S4END2(S4END[2]),
    .S4END3(S4END[3]),
    .top2bot_A_DIN0(top2bot_A_DIN[0]),
    .top2bot_A_DIN1(top2bot_A_DIN[1]),
    .top2bot_A_DIN2(top2bot_A_DIN[2]),
    .top2bot_A_DIN3(top2bot_A_DIN[3]),
    .top2bot_A_DIN4(top2bot_A_DIN[4]),
    .top2bot_A_DIN5(top2bot_A_DIN[5]),
    .top2bot_A_DIN6(top2bot_A_DIN[6]),
    .top2bot_A_DIN7(top2bot_A_DIN[7]),
    .top2bot_A_DIN8(top2bot_A_DIN[8]),
    .top2bot_A_DIN9(top2bot_A_DIN[9]),
    .top2bot_A_DIN10(top2bot_A_DIN[10]),
    .top2bot_A_DIN11(top2bot_A_DIN[11]),
    .top2bot_A_DIN12(top2bot_A_DIN[12]),
    .top2bot_A_DIN13(top2bot_A_DIN[13]),
    .top2bot_A_DIN14(top2bot_A_DIN[14]),
    .top2bot_A_DIN15(top2bot_A_DIN[15]),
    .top2bot_A_BM0(top2bot_A_BM[0]),
    .top2bot_A_BM1(top2bot_A_BM[1]),
    .top2bot_A_BM2(top2bot_A_BM[2]),
    .top2bot_A_BM3(top2bot_A_BM[3]),
    .top2bot_A_BM4(top2bot_A_BM[4]),
    .top2bot_A_BM5(top2bot_A_BM[5]),
    .top2bot_A_BM6(top2bot_A_BM[6]),
    .top2bot_A_BM7(top2bot_A_BM[7]),
    .top2bot_A_BM8(top2bot_A_BM[8]),
    .top2bot_A_BM9(top2bot_A_BM[9]),
    .top2bot_A_BM10(top2bot_A_BM[10]),
    .top2bot_A_BM11(top2bot_A_BM[11]),
    .top2bot_A_BM12(top2bot_A_BM[12]),
    .top2bot_A_BM13(top2bot_A_BM[13]),
    .top2bot_A_BM14(top2bot_A_BM[14]),
    .top2bot_A_BM15(top2bot_A_BM[15]),
    .top2bot_A_ADDR0(top2bot_A_ADDR[0]),
    .top2bot_A_ADDR1(top2bot_A_ADDR[1]),
    .top2bot_A_ADDR2(top2bot_A_ADDR[2]),
    .top2bot_A_ADDR3(top2bot_A_ADDR[3]),
    .top2bot_A_ADDR4(top2bot_A_ADDR[4]),
    .A_DOUT0(A_DOUT0),
    .A_DOUT1(A_DOUT1),
    .A_DOUT2(A_DOUT2),
    .A_DOUT3(A_DOUT3),
    .A_DOUT4(A_DOUT4),
    .A_DOUT5(A_DOUT5),
    .A_DOUT6(A_DOUT6),
    .A_DOUT7(A_DOUT7),
    .A_DOUT8(A_DOUT8),
    .A_DOUT9(A_DOUT9),
    .A_DOUT10(A_DOUT10),
    .A_DOUT11(A_DOUT11),
    .A_DOUT12(A_DOUT12),
    .A_DOUT13(A_DOUT13),
    .A_DOUT14(A_DOUT14),
    .A_DOUT15(A_DOUT15),
    .A_DOUT16(A_DOUT16),
    .A_DOUT17(A_DOUT17),
    .A_DOUT18(A_DOUT18),
    .A_DOUT19(A_DOUT19),
    .A_DOUT20(A_DOUT20),
    .A_DOUT21(A_DOUT21),
    .A_DOUT22(A_DOUT22),
    .A_DOUT23(A_DOUT23),
    .A_DOUT24(A_DOUT24),
    .A_DOUT25(A_DOUT25),
    .A_DOUT26(A_DOUT26),
    .A_DOUT27(A_DOUT27),
    .A_DOUT28(A_DOUT28),
    .A_DOUT29(A_DOUT29),
    .A_DOUT30(A_DOUT30),
    .A_DOUT31(A_DOUT31),
    .J_NS4_END0(J_NS4_BEG[0]),
    .J_NS4_END1(J_NS4_BEG[1]),
    .J_NS4_END2(J_NS4_BEG[2]),
    .J_NS4_END3(J_NS4_BEG[3]),
    .J_NS4_END4(J_NS4_BEG[4]),
    .J_NS4_END5(J_NS4_BEG[5]),
    .J_NS4_END6(J_NS4_BEG[6]),
    .J_NS4_END7(J_NS4_BEG[7]),
    .J_NS4_END8(J_NS4_BEG[8]),
    .J_NS4_END9(J_NS4_BEG[9]),
    .J_NS4_END10(J_NS4_BEG[10]),
    .J_NS4_END11(J_NS4_BEG[11]),
    .J_NS4_END12(J_NS4_BEG[12]),
    .J_NS4_END13(J_NS4_BEG[13]),
    .J_NS4_END14(J_NS4_BEG[14]),
    .J_NS4_END15(J_NS4_BEG[15]),
    .J_NS2_END0(J_NS2_BEG[0]),
    .J_NS2_END1(J_NS2_BEG[1]),
    .J_NS2_END2(J_NS2_BEG[2]),
    .J_NS2_END3(J_NS2_BEG[3]),
    .J_NS2_END4(J_NS2_BEG[4]),
    .J_NS2_END5(J_NS2_BEG[5]),
    .J_NS2_END6(J_NS2_BEG[6]),
    .J_NS2_END7(J_NS2_BEG[7]),
    .J_NS1_END0(J_NS1_BEG[0]),
    .J_NS1_END1(J_NS1_BEG[1]),
    .J_NS1_END2(J_NS1_BEG[2]),
    .J_NS1_END3(J_NS1_BEG[3]),
    .N1BEG0(N1BEG[0]),
    .N1BEG1(N1BEG[1]),
    .N1BEG2(N1BEG[2]),
    .N1BEG3(N1BEG[3]),
    .N2BEG0(N2BEG[0]),
    .N2BEG1(N2BEG[1]),
    .N2BEG2(N2BEG[2]),
    .N2BEG3(N2BEG[3]),
    .N2BEG4(N2BEG[4]),
    .N2BEG5(N2BEG[5]),
    .N2BEG6(N2BEG[6]),
    .N2BEG7(N2BEG[7]),
    .N2BEGb0(N2BEGb[0]),
    .N2BEGb1(N2BEGb[1]),
    .N2BEGb2(N2BEGb[2]),
    .N2BEGb3(N2BEGb[3]),
    .N2BEGb4(N2BEGb[4]),
    .N2BEGb5(N2BEGb[5]),
    .N2BEGb6(N2BEGb[6]),
    .N2BEGb7(N2BEGb[7]),
    .N4BEG0(N4BEG[12]),
    .N4BEG1(N4BEG[13]),
    .N4BEG2(N4BEG[14]),
    .N4BEG3(N4BEG[15]),
    .S1BEG0(S1BEG[0]),
    .S1BEG1(S1BEG[1]),
    .S1BEG2(S1BEG[2]),
    .S1BEG3(S1BEG[3]),
    .S2BEG0(S2BEG[0]),
    .S2BEG1(S2BEG[1]),
    .S2BEG2(S2BEG[2]),
    .S2BEG3(S2BEG[3]),
    .S2BEG4(S2BEG[4]),
    .S2BEG5(S2BEG[5]),
    .S2BEG6(S2BEG[6]),
    .S2BEG7(S2BEG[7]),
    .S2BEGb0(S2BEGb[0]),
    .S2BEGb1(S2BEGb[1]),
    .S2BEGb2(S2BEGb[2]),
    .S2BEGb3(S2BEGb[3]),
    .S2BEGb4(S2BEGb[4]),
    .S2BEGb5(S2BEGb[5]),
    .S2BEGb6(S2BEGb[6]),
    .S2BEGb7(S2BEGb[7]),
    .S4BEG0(S4BEG[12]),
    .S4BEG1(S4BEG[13]),
    .S4BEG2(S4BEG[14]),
    .S4BEG3(S4BEG[15]),
    .W1BEG0(W1BEG[0]),
    .W1BEG1(W1BEG[1]),
    .W1BEG2(W1BEG[2]),
    .W1BEG3(W1BEG[3]),
    .W2BEG0(W2BEG[0]),
    .W2BEG1(W2BEG[1]),
    .W2BEG2(W2BEG[2]),
    .W2BEG3(W2BEG[3]),
    .W2BEG4(W2BEG[4]),
    .W2BEG5(W2BEG[5]),
    .W2BEG6(W2BEG[6]),
    .W2BEG7(W2BEG[7]),
    .W2BEGb0(W2BEGb[0]),
    .W2BEGb1(W2BEGb[1]),
    .W2BEGb2(W2BEGb[2]),
    .W2BEGb3(W2BEGb[3]),
    .W2BEGb4(W2BEGb[4]),
    .W2BEGb5(W2BEGb[5]),
    .W2BEGb6(W2BEGb[6]),
    .W2BEGb7(W2BEGb[7]),
    .WW4BEG0(WW4BEG[0]),
    .WW4BEG1(WW4BEG[1]),
    .WW4BEG2(WW4BEG[2]),
    .WW4BEG3(WW4BEG[3]),
    .WW4BEG4(WW4BEG[4]),
    .WW4BEG5(WW4BEG[5]),
    .WW4BEG6(WW4BEG[6]),
    .WW4BEG7(WW4BEG[7]),
    .WW4BEG8(WW4BEG[8]),
    .WW4BEG9(WW4BEG[9]),
    .WW4BEG10(WW4BEG[10]),
    .WW4BEG11(WW4BEG[11]),
    .WW4BEG12(WW4BEG[12]),
    .WW4BEG13(WW4BEG[13]),
    .WW4BEG14(WW4BEG[14]),
    .WW4BEG15(WW4BEG[15]),
    .W6BEG0(W6BEG[0]),
    .W6BEG1(W6BEG[1]),
    .W6BEG2(W6BEG[2]),
    .W6BEG3(W6BEG[3]),
    .W6BEG4(W6BEG[4]),
    .W6BEG5(W6BEG[5]),
    .W6BEG6(W6BEG[6]),
    .W6BEG7(W6BEG[7]),
    .W6BEG8(W6BEG[8]),
    .W6BEG9(W6BEG[9]),
    .W6BEG10(W6BEG[10]),
    .W6BEG11(W6BEG[11]),
    .bot2top_A_DOUT0(bot2top_A_DOUT[0]),
    .bot2top_A_DOUT1(bot2top_A_DOUT[1]),
    .bot2top_A_DOUT2(bot2top_A_DOUT[2]),
    .bot2top_A_DOUT3(bot2top_A_DOUT[3]),
    .bot2top_A_DOUT4(bot2top_A_DOUT[4]),
    .bot2top_A_DOUT5(bot2top_A_DOUT[5]),
    .bot2top_A_DOUT6(bot2top_A_DOUT[6]),
    .bot2top_A_DOUT7(bot2top_A_DOUT[7]),
    .bot2top_A_DOUT8(bot2top_A_DOUT[8]),
    .bot2top_A_DOUT9(bot2top_A_DOUT[9]),
    .bot2top_A_DOUT10(bot2top_A_DOUT[10]),
    .bot2top_A_DOUT11(bot2top_A_DOUT[11]),
    .bot2top_A_DOUT12(bot2top_A_DOUT[12]),
    .bot2top_A_DOUT13(bot2top_A_DOUT[13]),
    .bot2top_A_DOUT14(bot2top_A_DOUT[14]),
    .bot2top_A_DOUT15(bot2top_A_DOUT[15]),
    .A_ADDR0(A_ADDR0),
    .A_ADDR1(A_ADDR1),
    .A_ADDR2(A_ADDR2),
    .A_ADDR3(A_ADDR3),
    .A_ADDR4(A_ADDR4),
    .A_ADDR5(A_ADDR5),
    .A_ADDR6(A_ADDR6),
    .A_ADDR7(A_ADDR7),
    .A_ADDR8(A_ADDR8),
    .A_ADDR9(A_ADDR9),
    .A_DIN0(A_DIN0),
    .A_DIN1(A_DIN1),
    .A_DIN2(A_DIN2),
    .A_DIN3(A_DIN3),
    .A_DIN4(A_DIN4),
    .A_DIN5(A_DIN5),
    .A_DIN6(A_DIN6),
    .A_DIN7(A_DIN7),
    .A_DIN8(A_DIN8),
    .A_DIN9(A_DIN9),
    .A_DIN10(A_DIN10),
    .A_DIN11(A_DIN11),
    .A_DIN12(A_DIN12),
    .A_DIN13(A_DIN13),
    .A_DIN14(A_DIN14),
    .A_DIN15(A_DIN15),
    .A_DIN16(A_DIN16),
    .A_DIN17(A_DIN17),
    .A_DIN18(A_DIN18),
    .A_DIN19(A_DIN19),
    .A_DIN20(A_DIN20),
    .A_DIN21(A_DIN21),
    .A_DIN22(A_DIN22),
    .A_DIN23(A_DIN23),
    .A_DIN24(A_DIN24),
    .A_DIN25(A_DIN25),
    .A_DIN26(A_DIN26),
    .A_DIN27(A_DIN27),
    .A_DIN28(A_DIN28),
    .A_DIN29(A_DIN29),
    .A_DIN30(A_DIN30),
    .A_DIN31(A_DIN31),
    .A_BM0(A_BM0),
    .A_BM1(A_BM1),
    .A_BM2(A_BM2),
    .A_BM3(A_BM3),
    .A_BM4(A_BM4),
    .A_BM5(A_BM5),
    .A_BM6(A_BM6),
    .A_BM7(A_BM7),
    .A_BM8(A_BM8),
    .A_BM9(A_BM9),
    .A_BM10(A_BM10),
    .A_BM11(A_BM11),
    .A_BM12(A_BM12),
    .A_BM13(A_BM13),
    .A_BM14(A_BM14),
    .A_BM15(A_BM15),
    .A_BM16(A_BM16),
    .A_BM17(A_BM17),
    .A_BM18(A_BM18),
    .A_BM19(A_BM19),
    .A_BM20(A_BM20),
    .A_BM21(A_BM21),
    .A_BM22(A_BM22),
    .A_BM23(A_BM23),
    .A_BM24(A_BM24),
    .A_BM25(A_BM25),
    .A_BM26(A_BM26),
    .A_BM27(A_BM27),
    .A_BM28(A_BM28),
    .A_BM29(A_BM29),
    .A_BM30(A_BM30),
    .A_BM31(A_BM31),
    .A_WEN(A_WEN),
    .A_MEN(A_MEN),
    .A_REN(A_REN),
    .J_NS4_BEG0(J_NS4_BEG[0]),
    .J_NS4_BEG1(J_NS4_BEG[1]),
    .J_NS4_BEG2(J_NS4_BEG[2]),
    .J_NS4_BEG3(J_NS4_BEG[3]),
    .J_NS4_BEG4(J_NS4_BEG[4]),
    .J_NS4_BEG5(J_NS4_BEG[5]),
    .J_NS4_BEG6(J_NS4_BEG[6]),
    .J_NS4_BEG7(J_NS4_BEG[7]),
    .J_NS4_BEG8(J_NS4_BEG[8]),
    .J_NS4_BEG9(J_NS4_BEG[9]),
    .J_NS4_BEG10(J_NS4_BEG[10]),
    .J_NS4_BEG11(J_NS4_BEG[11]),
    .J_NS4_BEG12(J_NS4_BEG[12]),
    .J_NS4_BEG13(J_NS4_BEG[13]),
    .J_NS4_BEG14(J_NS4_BEG[14]),
    .J_NS4_BEG15(J_NS4_BEG[15]),
    .J_NS2_BEG0(J_NS2_BEG[0]),
    .J_NS2_BEG1(J_NS2_BEG[1]),
    .J_NS2_BEG2(J_NS2_BEG[2]),
    .J_NS2_BEG3(J_NS2_BEG[3]),
    .J_NS2_BEG4(J_NS2_BEG[4]),
    .J_NS2_BEG5(J_NS2_BEG[5]),
    .J_NS2_BEG6(J_NS2_BEG[6]),
    .J_NS2_BEG7(J_NS2_BEG[7]),
    .J_NS1_BEG0(J_NS1_BEG[0]),
    .J_NS1_BEG1(J_NS1_BEG[1]),
    .J_NS1_BEG2(J_NS1_BEG[2]),
    .J_NS1_BEG3(J_NS1_BEG[3]),
    .ConfigBits(ConfigBits[310-1:0]),
    .ConfigBits_N(ConfigBits_N[310-1:0])
);

endmodule