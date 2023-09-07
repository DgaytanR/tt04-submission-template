module BCD(
   input [3:0] data_in,
	output reg [6:0] data_out
);

always @(*) begin
  case (data_in)
   4'd0: data_out = 7'b1000000;
	4'd1: data_out = 7'b1111001;
	4'd2: data_out = 7'b0100100;
	4'd3: data_out = 7'b0110000;
	4'd4: data_out = 7'b0011001;
	4'd5: data_out = 7'b0010010;
	4'd6: data_out = 7'b0000010;
	4'd7: data_out = 7'b1111000;
	4'd8: data_out = 7'b0000000;
	4'd9: data_out = 7'b0011000;
	4'd10: data_out = 7'b0001000;
	4'd11: data_out = 7'b0000011;
	4'd12: data_out = 7'b1000110;
	4'd13: data_out = 7'b0100001;
	4'd14: data_out = 7'b0000110;
	4'd15: data_out = 7'b0001110;
	default: data_out = 7'b1111111;
	
	endcase

end

endmodule