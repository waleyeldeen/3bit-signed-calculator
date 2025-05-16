`timescale 1ns/1ps

module rem_tb;
  reg  A2, A1, A0, B2, B1, B0;
  wire R2, R1, R0;
  integer f, i;
  reg [1:0] A_mag, B_mag, R_mag;
  reg signed [2:0] A_dec, B_dec, R_dec;
  reg ZF, EF, OF, DZF;

  rem dut (
    .A2(A2), .A1(A1), .A0(A0),
    .B2(B2), .B1(B1), .B0(B0),
    .R2(R2), .R1(R1), .R0(R0)
  );

  initial begin
    f = $fopen("rem.txt","w");
    $fwrite(f," A2 A1 A0 B2 B1 B0 | R2 R1 R0 |  A_dec  B_dec  R_dec | ZF EF OF DZF\n");
    $fwrite(f,"-------------------------------------------------------------------\n");
    
    for (i = 0; i < 64; i = i + 1) begin
      {A2,A1,A0,B2,B1,B0} = i;
      #10;
      A_mag = {A1,A0};
      B_mag = {B1,B0};
      R_mag = {R1,R0};
      A_dec = A2 ? -A_mag : A_mag;
      B_dec = B2 ? -B_mag : B_mag;
      R_dec = R2 ? -R_mag : R_mag;
      
      ZF = (R_dec == 0) ? 1 : 0;
      EF = (R_dec[0] == 0) ? 1 : 0;
      OF = (R_dec[0] == 1) ? 1 : 0;
      DZF = (B_dec == 0) ? 1 : 0;

      $fwrite(f,"  %b  %b  %b  %b  %b  %b |  %b  %b  %b |",
        A2,A1,A0, B2,B1,B0,
        R2,R1,R0
      );

      if (A_dec < 0) $fwrite(f,"  -%0d", -A_dec);
      else           $fwrite(f,"  +%0d",  A_dec);

      if (B_dec < 0) $fwrite(f,"   -%0d", -B_dec);
      else           $fwrite(f,"   +%0d",  B_dec);

      if (R_dec < 0) $fwrite(f,"   -%0d |", -R_dec);
      else           $fwrite(f,"   +%0d |",  R_dec);

      $fwrite(f,"  %b  %b  %b  %b\n", ZF, EF, OF, DZF);

      #10;
    end
    
    $fclose(f);
    #10 $finish;
  end
endmodule