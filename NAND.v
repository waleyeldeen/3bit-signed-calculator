module NAND(input A, input B, output F);
  assign F = ~(A & B);
endmodule