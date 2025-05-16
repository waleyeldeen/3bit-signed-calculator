module mul (
    input  A2, A1, A0, B2, B1, B0,
    output P4, P3, P2, P1, P0
);
  wire   t1, t2, t3, t4, t5;

  assign t1 = A0 & B0;
  assign t2 = A0 & B1;            ////////////////\   
  assign t3 = A1 & B0;           ///   HOSS   ///\\\
  assign t4 = A1 & B1;          ////////////////  \\\

  assign P0 = t1;
  assign P1 = t2 ^ t3;
  assign t5  = t2 & t3;
  assign P2 = t5  ^ t4;
  assign P3 = t5  & t4;
  assign P4 = A2 ^ B2;
endmodule