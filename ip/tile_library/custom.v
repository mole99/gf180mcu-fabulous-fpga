module clk_buf(input A, output X);
assign X = A;
endmodule

//(* blackbox *)
//(* keep *)
//(* keep_hierarchy *)
module break_comb_loop(input A, output X);
assign X = A;
endmodule
