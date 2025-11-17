module DSP
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
        output  [15:0] Tile_X0Y0_NN4BEG, //Port(Name=NN4BEG,IO=OUTPUT,XOffset=0,YOffset=-4,WireCount=4,Side=N)
        input  [3:0] Tile_X0Y0_S1END, //Port(Name=S1END,IO=INPUT,XOffset=0,YOffset=1,WireCount=4,Side=N)
        input  [7:0] Tile_X0Y0_S2MID, //Port(Name=S2MID,IO=INPUT,XOffset=0,YOffset=1,WireCount=8,Side=N)
        input  [7:0] Tile_X0Y0_S2END, //Port(Name=S2END,IO=INPUT,XOffset=0,YOffset=1,WireCount=8,Side=N)
        input  [15:0] Tile_X0Y0_S4END, //Port(Name=S4END,IO=INPUT,XOffset=0,YOffset=4,WireCount=4,Side=N)
        input  [15:0] Tile_X0Y0_SS4END, //Port(Name=SS4END,IO=INPUT,XOffset=0,YOffset=4,WireCount=4,Side=N)
    //Tile_X0Y0_Direction.EAST
        output  [3:0] Tile_X0Y0_E1BEG, //Port(Name=E1BEG,IO=OUTPUT,XOffset=1,YOffset=0,WireCount=4,Side=E)
        output  [7:0] Tile_X0Y0_E2BEG, //Port(Name=E2BEG,IO=OUTPUT,XOffset=1,YOffset=0,WireCount=8,Side=E)
        output  [7:0] Tile_X0Y0_E2BEGb, //Port(Name=E2BEGb,IO=OUTPUT,XOffset=1,YOffset=0,WireCount=8,Side=E)
        output  [15:0] Tile_X0Y0_EE4BEG, //Port(Name=EE4BEG,IO=OUTPUT,XOffset=4,YOffset=0,WireCount=4,Side=E)
        output  [11:0] Tile_X0Y0_E6BEG, //Port(Name=E6BEG,IO=OUTPUT,XOffset=6,YOffset=0,WireCount=2,Side=E)
        input  [3:0] Tile_X0Y0_W1END, //Port(Name=W1END,IO=INPUT,XOffset=-1,YOffset=0,WireCount=4,Side=E)
        input  [7:0] Tile_X0Y0_W2MID, //Port(Name=W2MID,IO=INPUT,XOffset=-1,YOffset=0,WireCount=8,Side=E)
        input  [7:0] Tile_X0Y0_W2END, //Port(Name=W2END,IO=INPUT,XOffset=-1,YOffset=0,WireCount=8,Side=E)
        input  [15:0] Tile_X0Y0_WW4END, //Port(Name=WW4END,IO=INPUT,XOffset=-4,YOffset=0,WireCount=4,Side=E)
        input  [11:0] Tile_X0Y0_W6END, //Port(Name=W6END,IO=INPUT,XOffset=-6,YOffset=0,WireCount=2,Side=E)
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
    //Tile_X0Y1_Direction.EAST
        output  [3:0] Tile_X0Y1_E1BEG, //Port(Name=E1BEG,IO=OUTPUT,XOffset=1,YOffset=0,WireCount=4,Side=E)
        output  [7:0] Tile_X0Y1_E2BEG, //Port(Name=E2BEG,IO=OUTPUT,XOffset=1,YOffset=0,WireCount=8,Side=E)
        output  [7:0] Tile_X0Y1_E2BEGb, //Port(Name=E2BEGb,IO=OUTPUT,XOffset=1,YOffset=0,WireCount=8,Side=E)
        output  [15:0] Tile_X0Y1_EE4BEG, //Port(Name=EE4BEG,IO=OUTPUT,XOffset=4,YOffset=0,WireCount=4,Side=E)
        output  [11:0] Tile_X0Y1_E6BEG, //Port(Name=E6BEG,IO=OUTPUT,XOffset=6,YOffset=0,WireCount=2,Side=E)
        input  [3:0] Tile_X0Y1_W1END, //Port(Name=W1END,IO=INPUT,XOffset=-1,YOffset=0,WireCount=4,Side=E)
        input  [7:0] Tile_X0Y1_W2MID, //Port(Name=W2MID,IO=INPUT,XOffset=-1,YOffset=0,WireCount=8,Side=E)
        input  [7:0] Tile_X0Y1_W2END, //Port(Name=W2END,IO=INPUT,XOffset=-1,YOffset=0,WireCount=8,Side=E)
        input  [15:0] Tile_X0Y1_WW4END, //Port(Name=WW4END,IO=INPUT,XOffset=-4,YOffset=0,WireCount=4,Side=E)
        input  [11:0] Tile_X0Y1_W6END, //Port(Name=W6END,IO=INPUT,XOffset=-6,YOffset=0,WireCount=2,Side=E)
    //Tile_X0Y1_Direction.NORTH
        input  [3:0] Tile_X0Y1_N1END, //Port(Name=N1END,IO=INPUT,XOffset=0,YOffset=-1,WireCount=4,Side=S)
        input  [7:0] Tile_X0Y1_N2MID, //Port(Name=N2MID,IO=INPUT,XOffset=0,YOffset=-1,WireCount=8,Side=S)
        input  [7:0] Tile_X0Y1_N2END, //Port(Name=N2END,IO=INPUT,XOffset=0,YOffset=-1,WireCount=8,Side=S)
        input  [15:0] Tile_X0Y1_N4END, //Port(Name=N4END,IO=INPUT,XOffset=0,YOffset=-4,WireCount=4,Side=S)
        input  [15:0] Tile_X0Y1_NN4END, //Port(Name=NN4END,IO=INPUT,XOffset=0,YOffset=-4,WireCount=4,Side=S)
        output  [3:0] Tile_X0Y1_S1BEG, //Port(Name=S1BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=4,Side=S)
        output  [7:0] Tile_X0Y1_S2BEG, //Port(Name=S2BEG,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
        output  [7:0] Tile_X0Y1_S2BEGb, //Port(Name=S2BEGb,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=8,Side=S)
        output  [15:0] Tile_X0Y1_S4BEG, //Port(Name=S4BEG,IO=OUTPUT,XOffset=0,YOffset=4,WireCount=4,Side=S)
        output  [15:0] Tile_X0Y1_SS4BEG, //Port(Name=SS4BEG,IO=OUTPUT,XOffset=0,YOffset=4,WireCount=4,Side=S)
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
    wire[15:0] Tile_X0Y0_SS4BEG; //Port(Name=SS4BEG,IO=OUTPUT,XOffset=0,YOffset=4,WireCount=4,Side=S)
    wire[17:0] Tile_X0Y0_top2bot; //Port(Name=top2bot,IO=OUTPUT,XOffset=0,YOffset=1,WireCount=18,Side=S)
 //Tile_X0Y1_Direction.NORTH
    wire[3:0] Tile_X0Y1_N1BEG; //Port(Name=N1BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=4,Side=N)
    wire[7:0] Tile_X0Y1_N2BEG; //Port(Name=N2BEG,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
    wire[7:0] Tile_X0Y1_N2BEGb; //Port(Name=N2BEGb,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=8,Side=N)
    wire[15:0] Tile_X0Y1_N4BEG; //Port(Name=N4BEG,IO=OUTPUT,XOffset=0,YOffset=-4,WireCount=4,Side=N)
    wire[15:0] Tile_X0Y1_NN4BEG; //Port(Name=NN4BEG,IO=OUTPUT,XOffset=0,YOffset=-4,WireCount=4,Side=N)
    wire[9:0] Tile_X0Y1_bot2top; //Port(Name=bot2top,IO=OUTPUT,XOffset=0,YOffset=-1,WireCount=10,Side=N)
    wire[MaxFramesPerCol-1:0] Tile_X0Y1_FrameStrobe_O;
    wire Tile_X0Y1_UserCLKo;

DSP_top
`ifdef EMULATION
    #(
    .Emulate_Bitstream(Tile_X0Y0_Emulate_Bitstream)
    )
`endif
    Tile_X0Y0_DSP_top
    (
    .N1END(Tile_X0Y1_N1BEG),
    .N2MID(Tile_X0Y1_N2BEG),
    .N2END(Tile_X0Y1_N2BEGb),
    .N4END(Tile_X0Y1_N4BEG),
    .NN4END(Tile_X0Y1_NN4BEG),
    .bot2top(Tile_X0Y1_bot2top),
    .E1END(Tile_X0Y0_E1END),
    .E2MID(Tile_X0Y0_E2MID),
    .E2END(Tile_X0Y0_E2END),
    .EE4END(Tile_X0Y0_EE4END),
    .E6END(Tile_X0Y0_E6END),
    .S1END(Tile_X0Y0_S1END),
    .S2MID(Tile_X0Y0_S2MID),
    .S2END(Tile_X0Y0_S2END),
    .S4END(Tile_X0Y0_S4END),
    .SS4END(Tile_X0Y0_SS4END),
    .W1END(Tile_X0Y0_W1END),
    .W2MID(Tile_X0Y0_W2MID),
    .W2END(Tile_X0Y0_W2END),
    .WW4END(Tile_X0Y0_WW4END),
    .W6END(Tile_X0Y0_W6END),
    .N1BEG(Tile_X0Y0_N1BEG),
    .N2BEG(Tile_X0Y0_N2BEG),
    .N2BEGb(Tile_X0Y0_N2BEGb),
    .N4BEG(Tile_X0Y0_N4BEG),
    .NN4BEG(Tile_X0Y0_NN4BEG),
    .E1BEG(Tile_X0Y0_E1BEG),
    .E2BEG(Tile_X0Y0_E2BEG),
    .E2BEGb(Tile_X0Y0_E2BEGb),
    .EE4BEG(Tile_X0Y0_EE4BEG),
    .E6BEG(Tile_X0Y0_E6BEG),
    .S1BEG(Tile_X0Y0_S1BEG),
    .S2BEG(Tile_X0Y0_S2BEG),
    .S2BEGb(Tile_X0Y0_S2BEGb),
    .S4BEG(Tile_X0Y0_S4BEG),
    .SS4BEG(Tile_X0Y0_SS4BEG),
    .top2bot(Tile_X0Y0_top2bot),
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

DSP_bot
`ifdef EMULATION
    #(
    .Emulate_Bitstream(Tile_X0Y1_Emulate_Bitstream)
    )
`endif
    Tile_X0Y1_DSP_bot
    (
    .N1END(Tile_X0Y1_N1END),
    .N2MID(Tile_X0Y1_N2MID),
    .N2END(Tile_X0Y1_N2END),
    .N4END(Tile_X0Y1_N4END),
    .NN4END(Tile_X0Y1_NN4END),
    .E1END(Tile_X0Y1_E1END),
    .E2MID(Tile_X0Y1_E2MID),
    .E2END(Tile_X0Y1_E2END),
    .EE4END(Tile_X0Y1_EE4END),
    .E6END(Tile_X0Y1_E6END),
    .S1END(Tile_X0Y0_S1BEG),
    .S2MID(Tile_X0Y0_S2BEG),
    .S2END(Tile_X0Y0_S2BEGb),
    .S4END(Tile_X0Y0_S4BEG),
    .SS4END(Tile_X0Y0_SS4BEG),
    .top2bot(Tile_X0Y0_top2bot),
    .W1END(Tile_X0Y1_W1END),
    .W2MID(Tile_X0Y1_W2MID),
    .W2END(Tile_X0Y1_W2END),
    .WW4END(Tile_X0Y1_WW4END),
    .W6END(Tile_X0Y1_W6END),
    .N1BEG(Tile_X0Y1_N1BEG),
    .N2BEG(Tile_X0Y1_N2BEG),
    .N2BEGb(Tile_X0Y1_N2BEGb),
    .N4BEG(Tile_X0Y1_N4BEG),
    .NN4BEG(Tile_X0Y1_NN4BEG),
    .bot2top(Tile_X0Y1_bot2top),
    .E1BEG(Tile_X0Y1_E1BEG),
    .E2BEG(Tile_X0Y1_E2BEG),
    .E2BEGb(Tile_X0Y1_E2BEGb),
    .EE4BEG(Tile_X0Y1_EE4BEG),
    .E6BEG(Tile_X0Y1_E6BEG),
    .S1BEG(Tile_X0Y1_S1BEG),
    .S2BEG(Tile_X0Y1_S2BEG),
    .S2BEGb(Tile_X0Y1_S2BEGb),
    .S4BEG(Tile_X0Y1_S4BEG),
    .SS4BEG(Tile_X0Y1_SS4BEG),
    .W1BEG(Tile_X0Y1_W1BEG),
    .W2BEG(Tile_X0Y1_W2BEG),
    .W2BEGb(Tile_X0Y1_W2BEGb),
    .WW4BEG(Tile_X0Y1_WW4BEG),
    .W6BEG(Tile_X0Y1_W6BEG),
    .UserCLK(Tile_X0Y1_UserCLK),
    .UserCLKo(Tile_X0Y1_UserCLKo),
    .FrameData(Tile_X0Y1_FrameData),
    .FrameData_O(Tile_X0Y1_FrameData_O),
    .FrameStrobe(Tile_X0Y1_FrameStrobe),
    .FrameStrobe_O(Tile_X0Y1_FrameStrobe_O)
);

endmodule