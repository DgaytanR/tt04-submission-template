module mod_u_counter #(parameter M = 10, parameter N = 4)
(
   input clk, rst, en, syn_clear, up, load,
	input [N-1:0] data_in,
	output [N-1:0] count
);

//localparam N = $clog2(M-1); //funcion de sistema

//registro
reg [N-1:0] val_reg;
reg [N-1:0] val_next;

always @(posedge clk, negedge rst) begin
  if (~rst)
    val_reg <= {N{1'b0}};
	else if (en)
	 val_reg <= val_next;
end

//logica del estado siguiente
always @(*) begin
 if (syn_clear | ~rst)
   val_next <= {N{1'b0}};
  else 
   if (load == 1)
   val_next <= data_in;
   else 
	  if (up == 1)
	  val_next <= (val_reg == (M - 1)) ? {N{1'b0}} : val_reg + 1'b1;
	  else
	  val_next <= (val_reg == 0) ? M-1 : val_reg - 1'b1;  
 
end

//Logica de salida

assign count = val_reg;


endmodule