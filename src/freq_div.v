module freq_div #(parameter F_in = 125000000, parameter F_out = 25000000, parameter N = 3)
(
  input clk_in, rst,
  output reg clk_out,
  output [N-1:0] count
);

localparam RATIO = F_in/F_out;
//parameter N = $clog2 (RATIO -1 );
//localparam N = 1;

reg [N-1:0] val_reg;
wire [N-1:0] val_next;
wire clk_out_s;
//Registro
always @ (posedge clk_in, posedge rst) begin
   if (rst)
	val_reg <= -1;
	else
	val_reg <= val_next;
end

//logica del estado siguiente

assign val_next = (val_reg == (RATIO - 1)) ? {N{1'b0}} : val_reg + 1;

//logica de salida
//agregar un flip-flop
assign clk_out_s = (val_reg < (RATIO/2)) ? 1'b0 : 1'b1;

assign count = val_reg;

always @ (posedge clk_in, posedge rst) begin
   if (rst)
		clk_out <= 0;
	else
		clk_out<= clk_out_s;
end

endmodule