`timescale 1ns / 1ps

module alu_tb;

    reg [2:0] A;
    reg [2:0] B;
    reg [1:0] S;

    wire [4:0] R;
    wire SF;
    wire ZF;
    wire DZF;
    wire EF;
    wire OF;

    alu dut (
        .A(A),
        .B(B),
        .S(S),
        .R(R),
        .SF(SF),
        .ZF(ZF),
        .DZF(DZF),
        .EF(EF),
        .OF(OF)
    );

    function [2:0] to_signed3(input integer val);
        if (val >= 0) to_signed3 = val[2:0];
        else to_signed3 = ~(-val) + 1;
    endfunction

    function [15:0] get_op_name(input [1:0] sel);
        case (sel)
            2'b00: get_op_name = "ADD";
            2'b01: get_op_name = "SUB";
            2'b10: get_op_name = "MUL";
            2'b11: get_op_name = "REM";
            default: get_op_name = "UNKNOWN";
        endcase
    endfunction

    integer i;
    integer file;

    initial begin
        file = $fopen("alu_test_results.txt", "w");
        if (!file) begin
            $display("Error: Could not open log file.");
            $finish;
        end

        $fdisplay(file, "ALU Test Results");
        $fdisplay(file, "-------------------------------------------------------------");
        $fdisplay(file, "OP    | A(dec) | B(dec) | Result | SF | ZF | DZF | EF | OF");
        $fdisplay(file, "------|--------|--------|--------|----|----|-----|----|----");

        for (i = 0; i < 4; i = i + 1) begin
            S = i;
            $display("\nTesting %s Operation", get_op_name(S));
        
            for (integer a = -3; a <= 3; a = a + 1) begin
                for (integer b = -3; b <= 3; b = b + 1) begin
                    A = to_signed3(a);
                    B = to_signed3(b);
                    #10; // Wait
                    $fdisplay(file, "%4s | %4d   | %4d   | %4d   | %1b  | %1b  | %1b   | %1b  | %1b",
                        get_op_name(S), a, b, $signed(R), SF, ZF, DZF, EF, OF);
                end
            end
        end

        $fclose(file);
        $display("\nTest completed. Results saved to alu_test_results.txt.");
        $finish;
    end
endmodule