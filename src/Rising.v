module Rising 
(
 input In, rst, clk,
 output R
);

reg Q;

always @(posedge clk, posedge rst)
if(rst)
 Q<=1'b0;
else 
 Q<=In;
 
assign R = In & ~Q;

endmodule 