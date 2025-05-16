`timescale 1ns/1ps
module mul_tb;
  reg  A2, A1, A0, B2, B1, B0;
  wire P4, P3, P2, P1, P0;
  integer f, i;

  reg signed [2:0] A_dec, B_dec;
  reg [3:0] P_mag;
  reg signed [4:0] P_dec;
  reg ZF, EF, OF;

  mul dut (
    .A2(A2), .A1(A1), .A0(A0),
    .B2(B2), .B1(B1), .B0(B0),
    .P4(P4), .P3(P3), .P2(P2), .P1(P1), .P0(P0)
  );

  function signed [2:0] signed2;
    input sign, b1, b0;
    reg [1:0] mag;
    begin
      mag = {b1,b0};
      signed2 = sign ? -mag : mag;
    end
  endfunction

  initial begin
    f = $fopen("mul.txt","w");
    $fwrite(f," A2 A1 A0 B2 B1 B0 | P4 P3 P2 P1 P0 |  A_dec  B_dec  P_dec | ZF EF OF\n");
    $fwrite(f,"-----------------------------------------------------------------------\n");
    
    for (i = 0; i < 64; i = i + 1) begin
      {A2,A1,A0,B2,B1,B0} = i;
      #10;
      A_dec = signed2(A2,A1,A0);
      B_dec = signed2(B2,B1,B0);
      P_mag = {P3,P2,P1,P0};
      P_dec = P4 ? -P_mag : P_mag;
      
      ZF = (P_dec == 0) ? 1 : 0;
      EF = (P_dec[0] == 0) ? 1 : 0;
      OF = (P_dec[0] == 1) ? 1 : 0;

      $fwrite(f,"  %b  %b  %b  %b  %b  %b |   %b  %b  %b  %b  %b |",
        A2,A1,A0, B2,B1,B0,
        P4,P3,P2,P1,P0
      );
      
      if (A_dec < 0) $fwrite(f,"  -%0d", -A_dec);
      else  $fwrite(f,"  +%0d",  A_dec);
      
      if (B_dec < 0) $fwrite(f,"  -%0d", -B_dec);
      else $fwrite(f,"  +%0d",  B_dec);
      
      if (P_dec < 0) $fwrite(f,"  -%0d |", -P_dec);
      else  $fwrite(f,"  +%0d |",  P_dec);
      
      $fwrite(f,"  %b  %b  %b\n", ZF, EF, OF);
      #10;
    end
    $fclose(f);
    #10 $finish;
  end
endmodule