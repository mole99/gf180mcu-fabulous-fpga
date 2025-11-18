module GF_SRAM
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
        input  Q_SRAM0,
        input  Q_SRAM1,
        input  Q_SRAM2,
        input  Q_SRAM3,
        input  Q_SRAM4,
        input  Q_SRAM5,
        input  Q_SRAM6,
        input  Q_SRAM7,
        input  CONFIGURED_top,
        output  CEN_SRAM,
        output  GWEN_SRAM,
        output  WEN_SRAM0,
        output  WEN_SRAM1,
        output  WEN_SRAM2,
        output  WEN_SRAM3,
        output  WEN_SRAM4,
        output  WEN_SRAM5,
        output  WEN_SRAM6,
        output  WEN_SRAM7,
        output  A_SRAM0,
        output  A_SRAM1,
        output  A_SRAM2,
        output  A_SRAM3,
        output  A_SRAM4,
        output  A_SRAM5,
        output  A_SRAM6,
        output  A_SRAM7,
        output  A_SRAM8,
        output  D_SRAM0,
        output  D_SRAM1,
        output  D_SRAM2,
        output  D_SRAM3,
        output  D_SRAM4,
        output  D_SRAM5,
        output  D_SRAM6,
        output  D_SRAM7,
        output  CLK_SRAM,
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
    wire[3:0] Tile_X0Y0_top2bot_D; //Port(Name=top2bot_D,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=4,Side=S)
    wire[3:0] Tile_X0Y0_top2bot_WEN; //Port(Name=top2bot_WEN,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=4,Side=S)
    wire[4:0] Tile_X0Y0_top2bot_A; //Port(Name=top2bot_A,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=5,Side=S)
 //Tile_X0Y1_Direction.NORTH
    wire[3:0] Tile_X0Y1_N1BEG; //Port(Name=N1BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=4,Side=N)
    wire[7:0] Tile_X0Y1_N2BEG; //Port(Name=N2BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
    wire[7:0] Tile_X0Y1_N2BEGb; //Port(Name=N2BEGb,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
    wire[15:0] Tile_X0Y1_N4BEG; //Port(Name=N4BEG,IO=OUTPUT,XOffset=0,YOffset=-4,WireCount=4,Side=N)
    wire[3:0] Tile_X0Y1_bot2top_Q; //Port(Name=bot2top_Q,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=4,Side=N)
    wire[MaxFramesPerCol-1:0] Tile_X0Y1_FrameStrobe_O;
    wire Tile_X0Y1_UserCLKo;

GF_SRAM_top
`ifdef EMULATION
    #(
    .Emulate_Bitstream(Tile_X0Y0_Emulate_Bitstream)
    )
`endif
    Tile_X0Y0_GF_SRAM_top
    (
    .N1END(Tile_X0Y1_N1BEG),
    .N2MID(Tile_X0Y1_N2BEG),
    .N2END(Tile_X0Y1_N2BEGb),
    .N4END(Tile_X0Y1_N4BEG),
    .bot2top_Q(Tile_X0Y1_bot2top_Q),
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
    .top2bot_D(Tile_X0Y0_top2bot_D),
    .top2bot_WEN(Tile_X0Y0_top2bot_WEN),
    .top2bot_A(Tile_X0Y0_top2bot_A),
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

GF_SRAM_bot
`ifdef EMULATION
    #(
    .Emulate_Bitstream(Tile_X0Y1_Emulate_Bitstream)
    )
`endif
    Tile_X0Y1_GF_SRAM_bot
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
    .top2bot_D(Tile_X0Y0_top2bot_D),
    .top2bot_WEN(Tile_X0Y0_top2bot_WEN),
    .top2bot_A(Tile_X0Y0_top2bot_A),
    .N1BEG(Tile_X0Y1_N1BEG),
    .N2BEG(Tile_X0Y1_N2BEG),
    .N2BEGb(Tile_X0Y1_N2BEGb),
    .N4BEG(Tile_X0Y1_N4BEG),
    .bot2top_Q(Tile_X0Y1_bot2top_Q),
    .S1BEG(Tile_X0Y1_S1BEG),
    .S2BEG(Tile_X0Y1_S2BEG),
    .S2BEGb(Tile_X0Y1_S2BEGb),
    .S4BEG(Tile_X0Y1_S4BEG),
    .W1BEG(Tile_X0Y1_W1BEG),
    .W2BEG(Tile_X0Y1_W2BEG),
    .W2BEGb(Tile_X0Y1_W2BEGb),
    .WW4BEG(Tile_X0Y1_WW4BEG),
    .W6BEG(Tile_X0Y1_W6BEG),
    .Q_SRAM0(Q_SRAM0),
    .Q_SRAM1(Q_SRAM1),
    .Q_SRAM2(Q_SRAM2),
    .Q_SRAM3(Q_SRAM3),
    .Q_SRAM4(Q_SRAM4),
    .Q_SRAM5(Q_SRAM5),
    .Q_SRAM6(Q_SRAM6),
    .Q_SRAM7(Q_SRAM7),
    .CONFIGURED_top(CONFIGURED_top),
    .CEN_SRAM(CEN_SRAM),
    .GWEN_SRAM(GWEN_SRAM),
    .WEN_SRAM0(WEN_SRAM0),
    .WEN_SRAM1(WEN_SRAM1),
    .WEN_SRAM2(WEN_SRAM2),
    .WEN_SRAM3(WEN_SRAM3),
    .WEN_SRAM4(WEN_SRAM4),
    .WEN_SRAM5(WEN_SRAM5),
    .WEN_SRAM6(WEN_SRAM6),
    .WEN_SRAM7(WEN_SRAM7),
    .A_SRAM0(A_SRAM0),
    .A_SRAM1(A_SRAM1),
    .A_SRAM2(A_SRAM2),
    .A_SRAM3(A_SRAM3),
    .A_SRAM4(A_SRAM4),
    .A_SRAM5(A_SRAM5),
    .A_SRAM6(A_SRAM6),
    .A_SRAM7(A_SRAM7),
    .A_SRAM8(A_SRAM8),
    .D_SRAM0(D_SRAM0),
    .D_SRAM1(D_SRAM1),
    .D_SRAM2(D_SRAM2),
    .D_SRAM3(D_SRAM3),
    .D_SRAM4(D_SRAM4),
    .D_SRAM5(D_SRAM5),
    .D_SRAM6(D_SRAM6),
    .D_SRAM7(D_SRAM7),
    .CLK_SRAM(CLK_SRAM),
    .UserCLK(Tile_X0Y1_UserCLK),
    .UserCLKo(Tile_X0Y1_UserCLKo),
    .FrameData(Tile_X0Y1_FrameData),
    .FrameData_O(Tile_X0Y1_FrameData_O),
    .FrameStrobe(Tile_X0Y1_FrameStrobe),
    .FrameStrobe_O(Tile_X0Y1_FrameStrobe_O)
);

endmodule