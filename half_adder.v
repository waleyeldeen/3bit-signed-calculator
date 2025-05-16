module half_adder (
    input A, B,
    output sum, carry
);

    assign sum = A ^ B;
    assign carry = A & B;
endmodule