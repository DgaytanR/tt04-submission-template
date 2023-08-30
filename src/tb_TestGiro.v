`default_nettype none
`timescale 1ns/1ps
`include "tt_um_TestGiro.v"
`include "Giro2.v"
`include "DebounceCircuit.v"
`include "mod_n_counter.v"
`include "MullerC.v"
`include "PulsosReg.v"
`include "registro.v"
`include "Rising.v"
`include "Toggle.v"

module tb_TestGiro();
parameter CLK_PERIOD=500000; //500000 -> 2Khz
parameter CLK_PERIOD2=100; // 10 Mhz

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
tt_um_TestGiro TestGiro
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
 #(CLK_PERIOD2/2);
 clk = 0;
 #(CLK_PERIOD2/2);
end

initial begin
    ui_in[0] = 0;
    #(CLK_PERIOD/4);
	 repeat (6)
    #(CLK_PERIOD/2) ui_in[0] = ~ui_in[0];
	 #(CLK_PERIOD/2)
	 repeat (6)
    #(CLK_PERIOD/2) ui_in[0] = ~ui_in[0];
end

always begin
 ui_in[1] = 1;
 #(CLK_PERIOD/2);
 ui_in[1] = 0;
 #(CLK_PERIOD/2);
end

// estimulos 
initial begin

// Proceso para verificar el dut
$dumpfile("tb_TestGiro.vcd");
$dumpvars(0, tb_TestGiro);
rst_n = 0;
assign ui_in[7:2] = 6'b000000;
assign uio_in = 8'b00000000;
#(1*CLK_PERIOD2);
rst_n = 1;
#(10*CLK_PERIOD);


$finish;

end

endmodule
