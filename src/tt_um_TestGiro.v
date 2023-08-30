`default_nettype none

module tt_um_TestGiro (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire d1, d2;
wire x1, x2;

assign d1 = ui_in[0];
assign d2 = ui_in[1];
assign uo_out = {6'b000000,x2,x1};

// use bidirectionals as outputs
assign uio_oe = 8'b11111111;
assign uio_out = 8'b00000000;

wire a_prev, b_prev, s_x1, s_x2, dAux;

localparam N = 1;

DebounceCircuit #(.cuenta(80), .bits(7))
DebounceCircuit_inst(
	.a(d1) ,	// input  a_sig
	.b(d2) ,	// input  b_sig
	.clk(clk) ,	// input  clk_sig
	.rst(rst_n) ,	// input  rst_sig
	.a_prev(a_prev) ,	// output  a_prev_sig
	.b_prev(b_prev) 	// output  b_prev_sig
);

PulsosReg Pulsos_inst
(
	.s1(a_prev) ,	// input  s1_sig
	.s2(b_prev) ,	// input  s2_sig
	.rst(~rst_n) ,	// input  rst_sig
	.clk(clk) ,	// input  clk_sig
	.s(dAux) 	// output  s_sig
);

Giro2 Giro_inst
(
	.clk(clk) ,	// input  clk_sig
	.rst(~rst_n) ,	// input  rst_sig
	.d1(a_prev) ,	// input  d1_sig
	.d2(b_prev) ,	// input  d2_sig
	.x1(s_x1) ,	// output  x1_sig
	.x2(s_x2) 	// output  x2_sig
);

registro #(.N(N)) 
R1 (
	.clk(~dAux) ,	// input  clk_sig ** Reloj lento
	.rst(~rst_n) ,	// input  rst_sig
	.Len(1'b0) ,	// input  Len_sig
	.data_in(s_x1) ,	// input [N-1:0] data_in_sig
	.data_out(x1) 	// output [N-1:0] data_out_sig
);

registro #(.N(N)) 
R2 (
	.clk(~dAux) ,	// input  clk_sig ** Reloj lento
	.rst(~rst_n) ,	// input  rst_sig
	.Len(1'b0) ,	// input  Len_sig
	.data_in(s_x2) ,	// input [N-1:0] data_in_sig
	.data_out(x2) 	// output [N-1:0] data_out_sig
);

endmodule
