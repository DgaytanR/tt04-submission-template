
module MullerC(
  input ia, ib, nrst,
  output c
);

wire w1, w2, w3, w4;

assign w1= ~(ia & ib);
assign w2= ia | ib;
assign w3= ~(w2 & c);
assign w4= ~(w1 & w3);
assign c = nrst & w4;

endmodule