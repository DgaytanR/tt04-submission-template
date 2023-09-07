`default_nettype none

module tt_um_mod_u_cnt_BCD (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire clk1s;
wire [3:0] data_in = ui_in [3:0];
wire en = ui_in [4];
wire syn_clear = ui_in [5];
wire up = ui_in [6];
wire load = ui_in [7];
wire [3:0] count_S;
wire [6:0] BCD_out;

assign uo_out[6:0] = ~BCD_out;
assign uo_out[7] = 1'b0;

// use bidirectionals as outputs
assign uio_oe = 8'b11111111;
assign uio_out = 8'b00000000;


freq_div #(.F_in(10000000), .F_out(1), .N(24))
freq_div_inst(
	.clk_in(clk), 
	.rst(~rst_n),
   .clk_out(clk1s),
	.count()
);

mod_u_counter #(.M(16), .N(4))
contador_inst(
	.clk(clk1s),
	.rst(rst_n),
	.en(en),
	.syn_clear(~syn_clear),
	.up(up),
	.load(load),
	.data_in(data_in),
	.count(count_S)
);

BCD disp7
(
	.data_in(count_S),
	.data_out(BCD_out)
);

endmodule