module FULL_ADDER2(
    input [1:0] A,
    input [1:0] B,
    input Cin,
    output [1:0] Sum,
    output Cout
);
    wire carry_internal;

    // First Full Adder (bit 0)
    FULL_ADDER FA0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Cout(carry_internal)
    );

    // Second Full Adder (bit 1)
    FULL_ADDER FA1 (
        .A(A[1]),
        .B(B[1]),
        .Cin(carry_internal),
        .Sum(Sum[1]),
        .Cout(Cout)
    );
endmodule