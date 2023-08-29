module registro #(parameter N=16)
(
    input clk, rst, Len,
	input [N-1:0] data_in, 
	output [N-1:0] data_out
);

reg [N-1:0] data_reg;
wire [N-1:0] w1, w2;

always @(posedge clk, posedge rst) begin
  if (rst)
     data_reg <= {N{1'b0}};
  else
     data_reg <= w2; 
end

assign data_out = data_reg;
assign w1 = data_out;
assign w2 = Len ? w1 : data_in;

endmodule