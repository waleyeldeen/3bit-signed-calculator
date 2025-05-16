// module rem(
//   input  A2, A1, A0,           ///////////////
//   input  B2, B1, B0,          ///  KERO   ///
//   output R2, R1, R0          ///////////////
// );
//   assign R2 = A2;
//   assign R1 = A1 & ~A0 & B1 & B0;
//   assign R0 = (B1 & ~B0 & A0) | (B1 & B0 & ~A1 & A0);
// endmodule


module rem (A2, A1, A0, B2, B1, B0, sf, R3, R2, R1, R0, DZf, zf);

    input A2, A1, A0, B2, B1, B0;
    output sf, R3, R2, R1, R0, DZf, zf;

    
    assign DZf = ~(B1 | B0); 

    assign R0 = A0 & B1 & (~(A1 & B0));
    assign R1 = A1 & (~A0) & B0 & B1;
    assign R2 = 0;
    assign R3 = 0;
    assign sf = A2;
    assign zf = ~(R1 | R0);

endmodule