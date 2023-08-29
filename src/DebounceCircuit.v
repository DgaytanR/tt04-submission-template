module DebounceCircuit #(parameter N=1, parameter cuenta=167, parameter bits=8)
(
 input a, b, clk, rst,
 output a_prev, b_prev
);

wire a_new0, a_new1, b_new0, b_new1;
wire w1, w2, w3, w4, nrst;

assign nrst = ~ rst;
assign w1 = a_new0 ^ a_new1;
assign w2 = b_new0 ^ b_new1;
assign w3 = w1 | w2 | nrst; 

registro #(.N(N)) 
registro1 (
	.clk(clk) ,	// input  clk_sig 
	.rst(nrst) ,	// input  rst_sig
	.Len(1'b0) ,	// input  Len_sig
	.data_in(a) ,	// input [N-1:0] data_in_sig
	.data_out(a_new0) 	// output [N-1:0] data_out_sig
);

registro #(.N(N)) 
registro2 (
	.clk(clk) ,	// input  clk_sig 
	.rst(nrst) ,	// input  rst_sig
	.Len(1'b0) ,	// input  Len_sig
	.data_in(a_new0) ,	// input [N-1:0] data_in_sig
	.data_out(a_new1) 	// output [N-1:0] data_out_sig
);

registro #(.N(N)) 
registro4 (
	.clk(clk) ,	// input  clk_sig 
	.rst(nrst) ,	// input  rst_sig
	.Len(1'b0) ,	// input  Len_sig
	.data_in(b) ,	// input [N-1:0] data_in_sig
	.data_out(b_new0) 	// output [N-1:0] data_out_sig
);

registro #(.N(N)) 
registro5 (
	.clk(clk) ,	// input  clk_sig 
	.rst(nrst) ,	// input  rst_sig
	.Len(1'b0) ,	// input  Len_sig
	.data_in(b_new0) ,	// input [N-1:0] data_in_sig
	.data_out(b_new1) 	// output [N-1:0] data_out_sig
);

mod_n_counter #(.M(cuenta), .N(bits)) //M=833
C1 (
	.clk(clk) ,	// input  clk_sig
	.rst(w3) ,	// input  rst_sig
	.en(~w4) ,	// input  en_sig
	.count() ,	// output [N-1:0] count_sig
	.max_count(w4) 	// output  max_count_sig
);

registro #(.N(N)) 
registro3 (
	.clk(clk) ,	// input  clk_sig 
	.rst(nrst) ,	// input  rst_sig
	.Len(~w4) ,	// input  Len_sig
	.data_in(a_new1) ,	// input [N-1:0] data_in_sig
	.data_out(a_prev) 	// output [N-1:0] data_out_sig
);

registro #(.N(N)) 
registro6 (
	.clk(clk) ,	// input  clk_sig 
	.rst(nrst) ,	// input  rst_sig
	.Len(~w4) ,	// input  Len_sig
	.data_in(b_new1) ,	// input [N-1:0] data_in_sig
	.data_out(b_prev) 	// output [N-1:0] data_out_sig
);

endmodule