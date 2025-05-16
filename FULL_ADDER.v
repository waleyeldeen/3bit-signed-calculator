module FULL_ADDER(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    wire w1, w2, w3;

    XOR xor1(.A(A), .B(B), .F(w1));
    XOR xor2(.A(w1), .B(Cin), .F(Sum));
    AND and1(.A(A), .B(B), .F(w2));
    AND and2(.A(w1), .B(Cin), .F(w3));
    OR or1(.A(w2), .B(w3), .F(Cout));
endmodule