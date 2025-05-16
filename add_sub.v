module add_sub (
    input wire [2:0] A,
    input wire [2:0] B,
    input wire op,
    output wire [3:0] C
);

    wire w0; wire w1; wire w2; wire w3; wire w4; wire w5; wire w6; wire w7; wire w8; wire w9; wire w10; wire w11;
    wire [3:0] compout;
    wire [1:0] sum0; wire [2:0] sum1;
    wire cout1; wire cout2;

    XOR xor1 (A[2], op, w0);
    NOT not1 (B[2], w1);
    NOT not2 (w0, w9);

    AND and1 (w0, w1, w7);
    NOR nor1 (w0, w1, w8);
    AND and2 (w9, w1, w3);
    NOR nor2 (w7, w8, w2);
    NOT not3 (w2, w10);

    // complement
    XOR xor2 (A[0], w7, compout[0]);
    XOR xor3 (A[1], w7, compout[1]);
    XOR xor4 (B[0], w8, compout[2]);
    XOR xor5 (B[1], w8, compout[3]);
    wire [1:0] A_CORRECTED;
    wire [1:0] B_CORRECTED;
    assign A_CORRECTED = {compout[1], compout[0]};
    assign B_CORRECTED = {compout[3], compout[2]};

    FULL_ADDER2 FA1(A_CORRECTED, B_CORRECTED, 1'b0, sum0, cout1);


    AND and3(cout1, w10, w6);
    NOR nor3(w6, w3, C[3]);
    NOR nor4(cout1, w2, w5);
    NOT not4(w6, w11);

    wire [2:0] A2_CORRECTED;
    wire [2:0] B2_CORRECTED;
    assign A2_CORRECTED = {cout1, sum0[1], w6};
    assign B2_CORRECTED = {1'b0, 1'b0, sum0[0]};

    FULL_ADDER3 FA2(A2_CORRECTED, B2_CORRECTED, 1'b0, sum1, cout2);

    AND and4(cout1, w11, C[2]);
    XOR xor6(sum1[0], w5, C[0]);
    XOR xor7(sum1[1], w5, C[1]);

endmodule
