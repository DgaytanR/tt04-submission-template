
module Toggle(
   input i, nrst,
	output t1, t2
);

wire w1, w2, w3, w4;

assign w1= i & ~t2;
assign w2= ~(i & t2);
assign w3= ~(i | ~t1);
assign w4= i | t1;

MullerC MC0 (
  .ia(w1),
  .ib(w2),
  .nrst(nrst),
  .c(t1)
);

MullerC MC1 (
  .ia(w3),
  .ib(w4),
  .nrst(nrst),
  .c(t2)
);

endmodule