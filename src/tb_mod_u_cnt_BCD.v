`default_nettype none
`timescale 10ns/1ns
`include "BCD.v"
`include "freq_div.v"
`include "mod_u_counter.v"
`include "tt_um_mod_u_cnt_BCD.v"

module tb_mod_u_cnt_BCD();

parameter CLK_PERIOD=10;

// wire up the inputs and outputs
    reg  clk;
    reg  rst_n;
    reg  ena;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;

    //wire [6:0] segments = uo_out[6:0];
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

// instancia del DUT
tt_um_mod_u_cnt_BCD DUT
(	
	// include power ports for the Gate Level test
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .ui_in      (ui_in),    // Dedicated inputs
        .uo_out     (uo_out),   // Dedicated outputs
        .uio_in     (uio_in),   // IOs: Input path
        .uio_out    (uio_out),  // IOs: Output path
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena        (ena),      // enable - goes high when design is selected
        .clk        (clk),      // clock
        .rst_n      (rst_n)     // not reset
);

//generacion de relog
always begin
 clk = 1;
 #(CLK_PERIOD/2);
 clk = 0;
 #(CLK_PERIOD/2);
end

//estimulos
initial begin
	$dumpfile("tb_mod_u_cnt_BCD.vcd");
	$dumpvars(0, tb_mod_u_cnt_BCD);
	rst_n=1;
	ui_in [3:0] = 4'b0000; // data_in
	ui_in [4] = 1; // en
	ui_in [5] = 1; // syn_clear
	ui_in [6] = 0; // up
	ui_in [7] = 0; // load
	#(2*CLK_PERIOD);
	rst_n=0;
	#(2*CLK_PERIOD);
	rst_n=1;
	#(20000000*CLK_PERIOD);

	$stop;
end

endmodule