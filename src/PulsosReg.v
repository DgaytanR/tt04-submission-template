module PulsosReg (
input s1, s2, rst, clk,
output reg s
);

wire w1, w2, w3, w4;

Rising Rising1
(
	.In(s1) ,	// input  In_sig
	.rst(rst) ,	// input  rst_sig
	.clk(clk) ,	// input  clk_sig
	.R(w1) 	// output  R_sig
);

Rising Rising2
(
	.In(s2) ,	// input  In_sig
	.rst(rst) ,	// input  rst_sig
	.clk(clk) ,	// input  clk_sig
	.R(w2) 	// output  R_sig
);

assign w3 = w1 | w2;

Toggle Toggle_inst
(
	.i(w3) ,	// input  i_sig
	.nrst(~rst) ,	// input  nrst_sig
	.t1(w4) ,	// output  t1_sig
	.t2() 	// output  t2_sig
);

//assign s = ~w4;

always @(posedge clk) begin
  if (rst)
    s <= 1'b0;
	else
	 s <= ~w4;
end

endmodule