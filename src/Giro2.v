module Giro2(
   input clk, rst, 
	input d1,d2,
	output x1, x2
);

localparam IDLE = 0;
localparam S1=1;
localparam S2=2;
localparam S3=3;
localparam S4=4;

wire [1:0] d;
assign d = {d2,d1};

//registro
reg [2:0] state_reg;
reg [2:0] state_next;
always @(posedge clk, posedge rst) begin 
   if(rst)
	 state_reg <= IDLE;
	else
	 state_reg <= state_next;
end


//logica del estado siguiente
always @(*) begin
  case (state_reg)
    IDLE: 
	   if (d == 2'b01)
		  state_next = S1;
		 else if (d == 2'b10)
		   state_next = S2;
			else 
			state_next = IDLE;
	 S1: 
	   if (d == 2'b00)
		  state_next = S3;
		 else
		   state_next = S1;
	 S3: 
	   if (d == 2'b01)
		  state_next = S1;
		 else
		   state_next = IDLE;
	 S2: 
	   if (d == 2'b00)
		  state_next = S4;
		else
		   state_next = S2;
	 S4: 
	   if (d == 2'b10)
		  state_next = S2;
		 else
		   state_next = IDLE;
			
	default: state_next = IDLE;
  
  endcase
end

//Logica de salida
reg [1:0] x_reg;
assign x1= x_reg [0];
assign x2= x_reg [1];
always @(*) begin
  case(state_reg)
   IDLE: x_reg = 2'b00;
	S1: x_reg = 2'b01;
	S3: x_reg = 2'b01;
	S2: x_reg = 2'b10;
	S4: x_reg = 2'b10;
	default: x_reg = 2'b00;
 endcase
 end
endmodule