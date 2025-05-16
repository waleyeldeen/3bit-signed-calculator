module alu (
    input [2:0] A,
    input [2:0] B,
    input [1:0] op,
    input sub_en,               // Control bit for add_sub: 0 = add, 1 = sub
    output reg signed [4:0] R    // Final output 5 bits signed (largest operation decides)
);

    wire signed [3:0] add_sub_result; // 4-bit signed output
    wire signed [4:0] mul_result;     // 5-bit signed output
    wire signed [2:0] rem_result;     // 3-bit signed output

    // Instantiate add_sub module
    add_sub u_add_sub (
        .A(A),
        .B(B),
        .op(sub_en),
        .C(add_sub_result)
    );

    // Instantiate mul module
    mul u_mul (
        .A(A),
        .B(B),
        .R(mul_result)
    );

    // Instantiate rem module
    rem u_rem (
        .A(A),
        .B(B),
        .R(rem_result)
    );

    // Multiplexer to select output based on op
    always @(*) begin
        case (op)
            2'b00: R = {{1{add_sub_result[3]}}, add_sub_result}; // Sign-extend 4 bits -> 5 bits
            2'b01: R = mul_result; // Already 5 bits
            2'b10: R = {{2{rem_result[2]}}, rem_result}; // Sign-extend 3 bits -> 5 bits
            default: R = 5'b0; // Default output
        endcase
    end

endmodule