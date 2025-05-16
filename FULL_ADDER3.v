module FULL_ADDER3(
    input [2:0] A,
    input [2:0] B,
    input Cin,
    output [2:0] Sum,
    output Cout
);
    wire carry1, carry2;

    // First Full Adder (bit 0)
    FULL_ADDER FA0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Cout(carry1)
    );

    // Second Full Adder (bit 1)
    FULL_ADDER FA1 (
        .A(A[1]),
        .B(B[1]),
        .Cin(carry1),
        .Sum(Sum[1]),
        .Cout(carry2)
    );

    // Third Full Adder (bit 2)
    FULL_ADDER FA2 (
        .A(A[2]),
        .B(B[2]),
        .Cin(carry2),
        .Sum(Sum[2]),
        .Cout(Cout)
    );
endmodule
