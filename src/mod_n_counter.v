module mod_n_counter #(parameter M=6, parameter N=3)
(
   input clk, rst, en,
	output [N-1:0] count, 
	output max_count
 
);

//parameter M = 6;
//localparam N = $clog2(M-1); //funcion de sistema

//registro
reg [N-1:0] val_reg;
wire [N-1:0] val_next;

always @(posedge clk, posedge rst) begin
  if (rst)
    val_reg <= {N{1'b0}};
	else if (en)
	 val_reg <= val_next;
end

//logica del estado siguiente

assign val_next = (val_reg == (M - 1)) ? {N{1'b0}} : val_reg +1;

//Logica de salida

assign count = val_reg;
assign max_count = (val_reg == (M - 1)) ? 1'b1 : 1'b0;


endmodule