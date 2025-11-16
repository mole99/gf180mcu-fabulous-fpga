module IHP_SRAM
    #(
`ifdef EMULATION
        parameter [639:0] Tile_X0Y0_Emulate_Bitstream=640'b0,
        parameter [639:0] Tile_X0Y1_Emulate_Bitstream=640'b0,
`endif
        parameter MaxFramesPerCol=20,
        parameter FrameBitsPerRow=32
    )
    (
    //Tile_X0Y0_Direction.NORTH
        output  [3:0] Tile_X0Y0_N1BEG, //Port(Name=N1BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=4,Side=N)
        output  [7:0] Tile_X0Y0_N2BEG, //Port(Name=N2BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
        output  [7:0] Tile_X0Y0_N2BEGb, //Port(Name=N2BEGb,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
        output  [15:0] Tile_X0Y0_N4BEG, //Port(Name=N4BEG,IO=OUTPUT,XOffset=0,YOffset=-4,WireCount=4,Side=N)
        input  [3:0] Tile_X0Y0_S1END, //Port(Name=S1END,IO=INPUT,XOffset=0,YOffset=1,WireCount=4,Side=N)
        input  [7:0] Tile_X0Y0_S2MID, //Port(Name=S2MID,IO=INPUT,XOffset=0,YOffset=1,WireCount=8,Side=N)
        input  [7:0] Tile_X0Y0_S2END, //Port(Name=S2END,IO=INPUT,XOffset=0,YOffset=1,WireCount=8,Side=N)
        input  [15:0] Tile_X0Y0_S4END, //Port(Name=S4END,IO=INPUT,XOffset=0,YOffset=4,WireCount=4,Side=N)
    //Tile_X0Y0_Direction.EAST
        input  [3:0] Tile_X0Y0_E1END, //Port(Name=E1END,IO=INPUT,XOffset=1,YOffset=0,WireCount=4,Side=W)
        input  [7:0] Tile_X0Y0_E2MID, //Port(Name=E2MID,IO=INPUT,XOffset=1,YOffset=0,WireCount=8,Side=W)
        input  [7:0] Tile_X0Y0_E2END, //Port(Name=E2END,IO=INPUT,XOffset=1,YOffset=0,WireCount=8,Side=W)
        input  [15:0] Tile_X0Y0_EE4END, //Port(Name=EE4END,IO=INPUT,XOffset=4,YOffset=0,WireCount=4,Side=W)
        input  [11:0] Tile_X0Y0_E6END, //Port(Name=E6END,IO=INPUT,XOffset=6,YOffset=0,WireCount=2,Side=W)
        output  [3:0] Tile_X0Y0_W1BEG, //Port(Name=W1BEG,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=4,Side=W)
        output  [7:0] Tile_X0Y0_W2BEG, //Port(Name=W2BEG,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=8,Side=W)
        output  [7:0] Tile_X0Y0_W2BEGb, //Port(Name=W2BEGb,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=8,Side=W)
        output  [15:0] Tile_X0Y0_WW4BEG, //Port(Name=WW4BEG,IO=OUTPUT,XOffset=-4,YOffset=0,WireCount=4,Side=W)
        output  [11:0] Tile_X0Y0_W6BEG, //Port(Name=W6BEG,IO=OUTPUT,XOffset=-6,YOffset=0,WireCount=2,Side=W)
    //Tile_X0Y1_Direction.NORTH
        input  [3:0] Tile_X0Y1_N1END, //Port(Name=N1END,IO=INPUT,XOffset=0,YOffset=-1,WireCount=4,Side=S)
        input  [7:0] Tile_X0Y1_N2MID, //Port(Name=N2MID,IO=INPUT,XOffset=0,YOffset=-1,WireCount=8,Side=S)
        input  [7:0] Tile_X0Y1_N2END, //Port(Name=N2END,IO=INPUT,XOffset=0,YOffset=-1,WireCount=8,Side=S)
        input  [15:0] Tile_X0Y1_N4END, //Port(Name=N4END,IO=INPUT,XOffset=0,YOffset=-4,WireCount=4,Side=S)
        output  [3:0] Tile_X0Y1_S1BEG, //Port(Name=S1BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=4,Side=S)
        output  [7:0] Tile_X0Y1_S2BEG, //Port(Name=S2BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
        output  [7:0] Tile_X0Y1_S2BEGb, //Port(Name=S2BEGb,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
        output  [15:0] Tile_X0Y1_S4BEG, //Port(Name=S4BEG,IO=OUTPUT,XOffset=0,YOffset=4,WireCount=4,Side=S)
    //Tile_X0Y1_Direction.EAST
        input  [3:0] Tile_X0Y1_E1END, //Port(Name=E1END,IO=INPUT,XOffset=1,YOffset=0,WireCount=4,Side=W)
        input  [7:0] Tile_X0Y1_E2MID, //Port(Name=E2MID,IO=INPUT,XOffset=1,YOffset=0,WireCount=8,Side=W)
        input  [7:0] Tile_X0Y1_E2END, //Port(Name=E2END,IO=INPUT,XOffset=1,YOffset=0,WireCount=8,Side=W)
        input  [15:0] Tile_X0Y1_EE4END, //Port(Name=EE4END,IO=INPUT,XOffset=4,YOffset=0,WireCount=4,Side=W)
        input  [11:0] Tile_X0Y1_E6END, //Port(Name=E6END,IO=INPUT,XOffset=6,YOffset=0,WireCount=2,Side=W)
        output  [3:0] Tile_X0Y1_W1BEG, //Port(Name=W1BEG,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=4,Side=W)
        output  [7:0] Tile_X0Y1_W2BEG, //Port(Name=W2BEG,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=8,Side=W)
        output  [7:0] Tile_X0Y1_W2BEGb, //Port(Name=W2BEGb,IO=OUTPUT,XOffset=-1,YOffset=0,WireCount=8,Side=W)
        output  [15:0] Tile_X0Y1_WW4BEG, //Port(Name=WW4BEG,IO=OUTPUT,XOffset=-4,YOffset=0,WireCount=4,Side=W)
        output  [11:0] Tile_X0Y1_W6BEG, //Port(Name=W6BEG,IO=OUTPUT,XOffset=-6,YOffset=0,WireCount=2,Side=W)
    //Tile IO ports from BELs
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
        output  [MaxFramesPerCol-1:0] Tile_X0Y0_FrameStrobe_O, //CONFIG_PORT
        input  [FrameBitsPerRow-1:0] Tile_X0Y0_FrameData, //CONFIG_PORT
        output  [FrameBitsPerRow-1:0] Tile_X0Y0_FrameData_O, //CONFIG_PORT
        input  [FrameBitsPerRow-1:0] Tile_X0Y1_FrameData, //CONFIG_PORT
        input  [MaxFramesPerCol-1:0] Tile_X0Y1_FrameStrobe, //CONFIG_PORT
        output  [FrameBitsPerRow-1:0] Tile_X0Y1_FrameData_O, //CONFIG_PORT
        output  Tile_X0Y0_UserCLKo,
        input  Tile_X0Y1_UserCLK
);

 //signal declarations
 //Tile_X0Y0_Direction.NORTH
    wire[3:0] Tile_X0Y0_S1BEG; //Port(Name=S1BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=4,Side=S)
    wire[7:0] Tile_X0Y0_S2BEG; //Port(Name=S2BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
    wire[7:0] Tile_X0Y0_S2BEGb; //Port(Name=S2BEGb,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
    wire[15:0] Tile_X0Y0_S4BEG; //Port(Name=S4BEG,IO=OUTPUT,XOffset=0,YOffset=4,WireCount=4,Side=S)
    wire[15:0] Tile_X0Y0_top2bot_A_DIN; //Port(Name=top2bot_A_DIN,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=16,Side=S)
    wire[15:0] Tile_X0Y0_top2bot_A_BM; //Port(Name=top2bot_A_BM,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=16,Side=S)
    wire[4:0] Tile_X0Y0_top2bot_A_ADDR; //Port(Name=top2bot_A_ADDR,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=5,Side=S)
 //Tile_X0Y1_Direction.NORTH
    wire[3:0] Tile_X0Y1_N1BEG; //Port(Name=N1BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=4,Side=N)
    wire[7:0] Tile_X0Y1_N2BEG; //Port(Name=N2BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
    wire[7:0] Tile_X0Y1_N2BEGb; //Port(Name=N2BEGb,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
    wire[15:0] Tile_X0Y1_N4BEG; //Port(Name=N4BEG,IO=OUTPUT,XOffset=0,YOffset=-4,WireCount=4,Side=N)
    wire[15:0] Tile_X0Y1_bot2top_A_DOUT; //Port(Name=bot2top_A_DOUT,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=16,Side=N)
    wire[MaxFramesPerCol-1:0] Tile_X0Y1_FrameStrobe_O;
    wire Tile_X0Y1_UserCLKo;

IHP_SRAM_top
`ifdef EMULATION
    #(
    .Emulate_Bitstream(Tile_X0Y0_Emulate_Bitstream)
    )
`endif
    Tile_X0Y0_IHP_SRAM_top
    (
    .N1END(Tile_X0Y1_N1BEG),
    .N2MID(Tile_X0Y1_N2BEG),
    .N2END(Tile_X0Y1_N2BEGb),
    .N4END(Tile_X0Y1_N4BEG),
    .bot2top_A_DOUT(Tile_X0Y1_bot2top_A_DOUT),
    .E1END(Tile_X0Y0_E1END),
    .E2MID(Tile_X0Y0_E2MID),
    .E2END(Tile_X0Y0_E2END),
    .EE4END(Tile_X0Y0_EE4END),
    .E6END(Tile_X0Y0_E6END),
    .S1END(Tile_X0Y0_S1END),
    .S2MID(Tile_X0Y0_S2MID),
    .S2END(Tile_X0Y0_S2END),
    .S4END(Tile_X0Y0_S4END),
    .N1BEG(Tile_X0Y0_N1BEG),
    .N2BEG(Tile_X0Y0_N2BEG),
    .N2BEGb(Tile_X0Y0_N2BEGb),
    .N4BEG(Tile_X0Y0_N4BEG),
    .S1BEG(Tile_X0Y0_S1BEG),
    .S2BEG(Tile_X0Y0_S2BEG),
    .S2BEGb(Tile_X0Y0_S2BEGb),
    .S4BEG(Tile_X0Y0_S4BEG),
    .top2bot_A_DIN(Tile_X0Y0_top2bot_A_DIN),
    .top2bot_A_BM(Tile_X0Y0_top2bot_A_BM),
    .top2bot_A_ADDR(Tile_X0Y0_top2bot_A_ADDR),
    .W1BEG(Tile_X0Y0_W1BEG),
    .W2BEG(Tile_X0Y0_W2BEG),
    .W2BEGb(Tile_X0Y0_W2BEGb),
    .WW4BEG(Tile_X0Y0_WW4BEG),
    .W6BEG(Tile_X0Y0_W6BEG),
    .UserCLK(Tile_X0Y1_UserCLKo),
    .UserCLKo(Tile_X0Y0_UserCLKo),
    .FrameData(Tile_X0Y0_FrameData),
    .FrameData_O(Tile_X0Y0_FrameData_O),
    .FrameStrobe(Tile_X0Y1_FrameStrobe_O),
    .FrameStrobe_O(Tile_X0Y0_FrameStrobe_O)
);

IHP_SRAM_bot
`ifdef EMULATION
    #(
    .Emulate_Bitstream(Tile_X0Y1_Emulate_Bitstream)
    )
`endif
    Tile_X0Y1_IHP_SRAM_bot
    (
    .N1END(Tile_X0Y1_N1END),
    .N2MID(Tile_X0Y1_N2MID),
    .N2END(Tile_X0Y1_N2END),
    .N4END(Tile_X0Y1_N4END),
    .E1END(Tile_X0Y1_E1END),
    .E2MID(Tile_X0Y1_E2MID),
    .E2END(Tile_X0Y1_E2END),
    .EE4END(Tile_X0Y1_EE4END),
    .E6END(Tile_X0Y1_E6END),
    .S1END(Tile_X0Y0_S1BEG),
    .S2MID(Tile_X0Y0_S2BEG),
    .S2END(Tile_X0Y0_S2BEGb),
    .S4END(Tile_X0Y0_S4BEG),
    .top2bot_A_DIN(Tile_X0Y0_top2bot_A_DIN),
    .top2bot_A_BM(Tile_X0Y0_top2bot_A_BM),
    .top2bot_A_ADDR(Tile_X0Y0_top2bot_A_ADDR),
    .N1BEG(Tile_X0Y1_N1BEG),
    .N2BEG(Tile_X0Y1_N2BEG),
    .N2BEGb(Tile_X0Y1_N2BEGb),
    .N4BEG(Tile_X0Y1_N4BEG),
    .bot2top_A_DOUT(Tile_X0Y1_bot2top_A_DOUT),
    .S1BEG(Tile_X0Y1_S1BEG),
    .S2BEG(Tile_X0Y1_S2BEG),
    .S2BEGb(Tile_X0Y1_S2BEGb),
    .S4BEG(Tile_X0Y1_S4BEG),
    .W1BEG(Tile_X0Y1_W1BEG),
    .W2BEG(Tile_X0Y1_W2BEG),
    .W2BEGb(Tile_X0Y1_W2BEGb),
    .WW4BEG(Tile_X0Y1_WW4BEG),
    .W6BEG(Tile_X0Y1_W6BEG),
    .A_DOUT_SRAM0(A_DOUT_SRAM0),
    .A_DOUT_SRAM1(A_DOUT_SRAM1),
    .A_DOUT_SRAM2(A_DOUT_SRAM2),
    .A_DOUT_SRAM3(A_DOUT_SRAM3),
    .A_DOUT_SRAM4(A_DOUT_SRAM4),
    .A_DOUT_SRAM5(A_DOUT_SRAM5),
    .A_DOUT_SRAM6(A_DOUT_SRAM6),
    .A_DOUT_SRAM7(A_DOUT_SRAM7),
    .A_DOUT_SRAM8(A_DOUT_SRAM8),
    .A_DOUT_SRAM9(A_DOUT_SRAM9),
    .A_DOUT_SRAM10(A_DOUT_SRAM10),
    .A_DOUT_SRAM11(A_DOUT_SRAM11),
    .A_DOUT_SRAM12(A_DOUT_SRAM12),
    .A_DOUT_SRAM13(A_DOUT_SRAM13),
    .A_DOUT_SRAM14(A_DOUT_SRAM14),
    .A_DOUT_SRAM15(A_DOUT_SRAM15),
    .A_DOUT_SRAM16(A_DOUT_SRAM16),
    .A_DOUT_SRAM17(A_DOUT_SRAM17),
    .A_DOUT_SRAM18(A_DOUT_SRAM18),
    .A_DOUT_SRAM19(A_DOUT_SRAM19),
    .A_DOUT_SRAM20(A_DOUT_SRAM20),
    .A_DOUT_SRAM21(A_DOUT_SRAM21),
    .A_DOUT_SRAM22(A_DOUT_SRAM22),
    .A_DOUT_SRAM23(A_DOUT_SRAM23),
    .A_DOUT_SRAM24(A_DOUT_SRAM24),
    .A_DOUT_SRAM25(A_DOUT_SRAM25),
    .A_DOUT_SRAM26(A_DOUT_SRAM26),
    .A_DOUT_SRAM27(A_DOUT_SRAM27),
    .A_DOUT_SRAM28(A_DOUT_SRAM28),
    .A_DOUT_SRAM29(A_DOUT_SRAM29),
    .A_DOUT_SRAM30(A_DOUT_SRAM30),
    .A_DOUT_SRAM31(A_DOUT_SRAM31),
    .CONFIGURED_top(CONFIGURED_top),
    .A_ADDR_SRAM0(A_ADDR_SRAM0),
    .A_ADDR_SRAM1(A_ADDR_SRAM1),
    .A_ADDR_SRAM2(A_ADDR_SRAM2),
    .A_ADDR_SRAM3(A_ADDR_SRAM3),
    .A_ADDR_SRAM4(A_ADDR_SRAM4),
    .A_ADDR_SRAM5(A_ADDR_SRAM5),
    .A_ADDR_SRAM6(A_ADDR_SRAM6),
    .A_ADDR_SRAM7(A_ADDR_SRAM7),
    .A_ADDR_SRAM8(A_ADDR_SRAM8),
    .A_ADDR_SRAM9(A_ADDR_SRAM9),
    .A_DIN_SRAM0(A_DIN_SRAM0),
    .A_DIN_SRAM1(A_DIN_SRAM1),
    .A_DIN_SRAM2(A_DIN_SRAM2),
    .A_DIN_SRAM3(A_DIN_SRAM3),
    .A_DIN_SRAM4(A_DIN_SRAM4),
    .A_DIN_SRAM5(A_DIN_SRAM5),
    .A_DIN_SRAM6(A_DIN_SRAM6),
    .A_DIN_SRAM7(A_DIN_SRAM7),
    .A_DIN_SRAM8(A_DIN_SRAM8),
    .A_DIN_SRAM9(A_DIN_SRAM9),
    .A_DIN_SRAM10(A_DIN_SRAM10),
    .A_DIN_SRAM11(A_DIN_SRAM11),
    .A_DIN_SRAM12(A_DIN_SRAM12),
    .A_DIN_SRAM13(A_DIN_SRAM13),
    .A_DIN_SRAM14(A_DIN_SRAM14),
    .A_DIN_SRAM15(A_DIN_SRAM15),
    .A_DIN_SRAM16(A_DIN_SRAM16),
    .A_DIN_SRAM17(A_DIN_SRAM17),
    .A_DIN_SRAM18(A_DIN_SRAM18),
    .A_DIN_SRAM19(A_DIN_SRAM19),
    .A_DIN_SRAM20(A_DIN_SRAM20),
    .A_DIN_SRAM21(A_DIN_SRAM21),
    .A_DIN_SRAM22(A_DIN_SRAM22),
    .A_DIN_SRAM23(A_DIN_SRAM23),
    .A_DIN_SRAM24(A_DIN_SRAM24),
    .A_DIN_SRAM25(A_DIN_SRAM25),
    .A_DIN_SRAM26(A_DIN_SRAM26),
    .A_DIN_SRAM27(A_DIN_SRAM27),
    .A_DIN_SRAM28(A_DIN_SRAM28),
    .A_DIN_SRAM29(A_DIN_SRAM29),
    .A_DIN_SRAM30(A_DIN_SRAM30),
    .A_DIN_SRAM31(A_DIN_SRAM31),
    .A_BM_SRAM0(A_BM_SRAM0),
    .A_BM_SRAM1(A_BM_SRAM1),
    .A_BM_SRAM2(A_BM_SRAM2),
    .A_BM_SRAM3(A_BM_SRAM3),
    .A_BM_SRAM4(A_BM_SRAM4),
    .A_BM_SRAM5(A_BM_SRAM5),
    .A_BM_SRAM6(A_BM_SRAM6),
    .A_BM_SRAM7(A_BM_SRAM7),
    .A_BM_SRAM8(A_BM_SRAM8),
    .A_BM_SRAM9(A_BM_SRAM9),
    .A_BM_SRAM10(A_BM_SRAM10),
    .A_BM_SRAM11(A_BM_SRAM11),
    .A_BM_SRAM12(A_BM_SRAM12),
    .A_BM_SRAM13(A_BM_SRAM13),
    .A_BM_SRAM14(A_BM_SRAM14),
    .A_BM_SRAM15(A_BM_SRAM15),
    .A_BM_SRAM16(A_BM_SRAM16),
    .A_BM_SRAM17(A_BM_SRAM17),
    .A_BM_SRAM18(A_BM_SRAM18),
    .A_BM_SRAM19(A_BM_SRAM19),
    .A_BM_SRAM20(A_BM_SRAM20),
    .A_BM_SRAM21(A_BM_SRAM21),
    .A_BM_SRAM22(A_BM_SRAM22),
    .A_BM_SRAM23(A_BM_SRAM23),
    .A_BM_SRAM24(A_BM_SRAM24),
    .A_BM_SRAM25(A_BM_SRAM25),
    .A_BM_SRAM26(A_BM_SRAM26),
    .A_BM_SRAM27(A_BM_SRAM27),
    .A_BM_SRAM28(A_BM_SRAM28),
    .A_BM_SRAM29(A_BM_SRAM29),
    .A_BM_SRAM30(A_BM_SRAM30),
    .A_BM_SRAM31(A_BM_SRAM31),
    .A_WEN_SRAM(A_WEN_SRAM),
    .A_MEN_SRAM(A_MEN_SRAM),
    .A_REN_SRAM(A_REN_SRAM),
    .A_CLK_SRAM(A_CLK_SRAM),
    .A_TIE_HIGH_SRAM(A_TIE_HIGH_SRAM),
    .A_TIE_LOW_SRAM(A_TIE_LOW_SRAM),
    .UserCLK(Tile_X0Y1_UserCLK),
    .UserCLKo(Tile_X0Y1_UserCLKo),
    .FrameData(Tile_X0Y1_FrameData),
    .FrameData_O(Tile_X0Y1_FrameData_O),
    .FrameStrobe(Tile_X0Y1_FrameStrobe),
    .FrameStrobe_O(Tile_X0Y1_FrameStrobe_O)
);

endmodule