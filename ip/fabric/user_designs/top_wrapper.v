`define NUM_IO 48

module top_wrapper;

wire [`NUM_IO-1:0] io_in, io_out, io_oeb;

// West

(* keep, BEL="X0Y1.A" *) IO_1_bidirectional_frame_config_pass io47_i (.O(io_in[47]), .I(io_out[47]), .T(io_oeb[47]));
(* keep, BEL="X0Y1.B" *) IO_1_bidirectional_frame_config_pass io46_i (.O(io_in[46]), .I(io_out[46]), .T(io_oeb[46]));
(* keep, BEL="X0Y1.C" *) IO_1_bidirectional_frame_config_pass io45_i (.O(io_in[45]), .I(io_out[45]), .T(io_oeb[45]));
(* keep, BEL="X0Y1.D" *) IO_1_bidirectional_frame_config_pass io44_i (.O(io_in[44]), .I(io_out[44]), .T(io_oeb[44]));
(* keep, BEL="X0Y2.A" *) IO_1_bidirectional_frame_config_pass io43_i (.O(io_in[43]), .I(io_out[43]), .T(io_oeb[43]));
(* keep, BEL="X0Y2.B" *) IO_1_bidirectional_frame_config_pass io42_i (.O(io_in[42]), .I(io_out[42]), .T(io_oeb[42]));
(* keep, BEL="X0Y2.C" *) IO_1_bidirectional_frame_config_pass io41_i (.O(io_in[41]), .I(io_out[41]), .T(io_oeb[41]));
(* keep, BEL="X0Y2.D" *) IO_1_bidirectional_frame_config_pass io40_i (.O(io_in[40]), .I(io_out[40]), .T(io_oeb[40]));
(* keep, BEL="X0Y3.A" *) IO_1_bidirectional_frame_config_pass io39_i (.O(io_in[39]), .I(io_out[39]), .T(io_oeb[39]));
(* keep, BEL="X0Y3.B" *) IO_1_bidirectional_frame_config_pass io38_i (.O(io_in[38]), .I(io_out[38]), .T(io_oeb[38]));
(* keep, BEL="X0Y3.C" *) IO_1_bidirectional_frame_config_pass io37_i (.O(io_in[37]), .I(io_out[37]), .T(io_oeb[37]));
(* keep, BEL="X0Y3.D" *) IO_1_bidirectional_frame_config_pass io36_i (.O(io_in[36]), .I(io_out[36]), .T(io_oeb[36]));
(* keep, BEL="X0Y4.A" *) IO_1_bidirectional_frame_config_pass io35_i (.O(io_in[35]), .I(io_out[35]), .T(io_oeb[35]));
(* keep, BEL="X0Y4.B" *) IO_1_bidirectional_frame_config_pass io34_i (.O(io_in[34]), .I(io_out[34]), .T(io_oeb[34]));
(* keep, BEL="X0Y4.C" *) IO_1_bidirectional_frame_config_pass io33_i (.O(io_in[33]), .I(io_out[33]), .T(io_oeb[33]));
(* keep, BEL="X0Y4.D" *) IO_1_bidirectional_frame_config_pass io32_i (.O(io_in[32]), .I(io_out[32]), .T(io_oeb[32]));
(* keep, BEL="X0Y5.A" *) IO_1_bidirectional_frame_config_pass io31_i (.O(io_in[31]), .I(io_out[31]), .T(io_oeb[31]));
(* keep, BEL="X0Y5.B" *) IO_1_bidirectional_frame_config_pass io30_i (.O(io_in[30]), .I(io_out[30]), .T(io_oeb[30]));
(* keep, BEL="X0Y5.C" *) IO_1_bidirectional_frame_config_pass io29_i (.O(io_in[29]), .I(io_out[29]), .T(io_oeb[29]));
(* keep, BEL="X0Y5.D" *) IO_1_bidirectional_frame_config_pass io28_i (.O(io_in[28]), .I(io_out[28]), .T(io_oeb[28]));
(* keep, BEL="X0Y6.A" *) IO_1_bidirectional_frame_config_pass io27_i (.O(io_in[27]), .I(io_out[27]), .T(io_oeb[27]));
(* keep, BEL="X0Y6.B" *) IO_1_bidirectional_frame_config_pass io26_i (.O(io_in[26]), .I(io_out[26]), .T(io_oeb[26]));
(* keep, BEL="X0Y6.C" *) IO_1_bidirectional_frame_config_pass io25_i (.O(io_in[25]), .I(io_out[25]), .T(io_oeb[25]));
(* keep, BEL="X0Y6.D" *) IO_1_bidirectional_frame_config_pass io24_i (.O(io_in[24]), .I(io_out[24]), .T(io_oeb[24]));
(* keep, BEL="X0Y7.A" *) IO_1_bidirectional_frame_config_pass io23_i (.O(io_in[23]), .I(io_out[23]), .T(io_oeb[23]));
(* keep, BEL="X0Y7.B" *) IO_1_bidirectional_frame_config_pass io22_i (.O(io_in[22]), .I(io_out[22]), .T(io_oeb[22]));
(* keep, BEL="X0Y7.C" *) IO_1_bidirectional_frame_config_pass io21_i (.O(io_in[21]), .I(io_out[21]), .T(io_oeb[21]));
(* keep, BEL="X0Y7.D" *) IO_1_bidirectional_frame_config_pass io20_i (.O(io_in[20]), .I(io_out[20]), .T(io_oeb[20]));
(* keep, BEL="X0Y8.A" *) IO_1_bidirectional_frame_config_pass io19_i (.O(io_in[19]), .I(io_out[19]), .T(io_oeb[19]));
(* keep, BEL="X0Y8.B" *) IO_1_bidirectional_frame_config_pass io18_i (.O(io_in[18]), .I(io_out[18]), .T(io_oeb[18]));
(* keep, BEL="X0Y8.C" *) IO_1_bidirectional_frame_config_pass io17_i (.O(io_in[17]), .I(io_out[17]), .T(io_oeb[17]));
(* keep, BEL="X0Y8.D" *) IO_1_bidirectional_frame_config_pass io16_i (.O(io_in[16]), .I(io_out[16]), .T(io_oeb[16]));
(* keep, BEL="X0Y9.A" *) IO_1_bidirectional_frame_config_pass io15_i (.O(io_in[15]), .I(io_out[15]), .T(io_oeb[15]));
(* keep, BEL="X0Y9.B" *) IO_1_bidirectional_frame_config_pass io14_i (.O(io_in[14]), .I(io_out[14]), .T(io_oeb[14]));
(* keep, BEL="X0Y9.C" *) IO_1_bidirectional_frame_config_pass io13_i (.O(io_in[13]), .I(io_out[13]), .T(io_oeb[13]));
(* keep, BEL="X0Y9.D" *) IO_1_bidirectional_frame_config_pass io12_i (.O(io_in[12]), .I(io_out[12]), .T(io_oeb[12]));
(* keep, BEL="X0Y10.A" *) IO_1_bidirectional_frame_config_pass io11_i (.O(io_in[11]), .I(io_out[11]), .T(io_oeb[11]));
(* keep, BEL="X0Y10.B" *) IO_1_bidirectional_frame_config_pass io10_i (.O(io_in[10]), .I(io_out[10]), .T(io_oeb[10]));
(* keep, BEL="X0Y10.C" *) IO_1_bidirectional_frame_config_pass io9_i (.O(io_in[9]), .I(io_out[9]), .T(io_oeb[9]));
(* keep, BEL="X0Y10.D" *) IO_1_bidirectional_frame_config_pass io8_i (.O(io_in[8]), .I(io_out[8]), .T(io_oeb[8]));
(* keep, BEL="X0Y11.A" *) IO_1_bidirectional_frame_config_pass io7_i (.O(io_in[7]), .I(io_out[7]), .T(io_oeb[7]));
(* keep, BEL="X0Y11.B" *) IO_1_bidirectional_frame_config_pass io6_i (.O(io_in[6]), .I(io_out[6]), .T(io_oeb[6]));
(* keep, BEL="X0Y11.C" *) IO_1_bidirectional_frame_config_pass io5_i (.O(io_in[5]), .I(io_out[5]), .T(io_oeb[5]));
(* keep, BEL="X0Y11.D" *) IO_1_bidirectional_frame_config_pass io4_i (.O(io_in[4]), .I(io_out[4]), .T(io_oeb[4]));
(* keep, BEL="X0Y12.A" *) IO_1_bidirectional_frame_config_pass io3_i (.O(io_in[3]), .I(io_out[3]), .T(io_oeb[3]));
(* keep, BEL="X0Y12.B" *) IO_1_bidirectional_frame_config_pass io2_i (.O(io_in[2]), .I(io_out[2]), .T(io_oeb[2]));
(* keep, BEL="X0Y12.C" *) IO_1_bidirectional_frame_config_pass io1_i (.O(io_in[1]), .I(io_out[1]), .T(io_oeb[1]));
(* keep, BEL="X0Y12.D" *) IO_1_bidirectional_frame_config_pass io0_i (.O(io_in[0]), .I(io_out[0]), .T(io_oeb[0]));

wire clk;
(* keep *) Global_Clock clk_i (.CLK(clk));

top top_i(.clk(clk), .io_in(io_in), .io_out(io_out), .io_oeb(io_oeb));

endmodule

