module add_sub_tb;

    reg [2:0] A;
    reg [2:0] B;
    reg op;
    wire [3:0] C;

    integer outfile;
    integer i, j, k;
    integer A_dec, B_dec, C_dec; // Now C_dec also separately stored

    // Instantiate your add_sub module
    add_sub uut (
        .A(A),
        .B(B),
        .op(op),
        .C(C)
    );

    initial begin
        outfile = $fopen("add_sub_results.txt", "w");
        if (outfile == 0) begin
            $display("Error: Cannot open file.");
            $stop;
        end

        // Table Header
        $fdisplay(outfile, "--------------------------------------------------------------------------------");
        $fdisplay(outfile, "| A[2:0] | A(dec) | B[2:0] | B(dec) | op |  C[3:0] | C(dec) |");
        $fdisplay(outfile, "--------------------------------------------------------------------------------");

        // Loop all combinations
        for (k = 0; k <= 1; k = k + 1) begin
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    A = i;
                    B = j;
                    op = k;
                    #5; // Wait for outputs to stabilize

                    // Decode A
                    case (A)
                        3'b000: A_dec = 0;
                        3'b001: A_dec = 1;
                        3'b010: A_dec = 2;
                        3'b011: A_dec = 3;
                        3'b100: A_dec = 0;
                        3'b101: A_dec = -1;
                        3'b110: A_dec = -2;
                        3'b111: A_dec = -3;
                        default: A_dec = 0;
                    endcase

                    // Decode B
                    case (B)
                        3'b000: B_dec = 0;
                        3'b001: B_dec = 1;
                        3'b010: B_dec = 2;
                        3'b011: B_dec = 3;
                        3'b100: B_dec = 0;
                        3'b101: B_dec = -1;
                        3'b110: B_dec = -2;
                        3'b111: B_dec = -3;
                        default: B_dec = 0;
                    endcase

                    // Decode C
                    case (C)
                        4'b0000: C_dec = 0;
                        4'b0001: C_dec = 1;
                        4'b0010: C_dec = 2;
                        4'b0011: C_dec = 3;
                        4'b0100: C_dec = 4;
                        4'b0101: C_dec = 5;
                        4'b0110: C_dec = 6;
                        4'b0111: C_dec = 7;
                        4'b1000: C_dec = 0;
                        4'b1001: C_dec = -1;
                        4'b1010: C_dec = -2;
                        4'b1011: C_dec = -3;
                        4'b1100: C_dec = -4;
                        4'b1101: C_dec = -5;
                        4'b1110: C_dec = -6;
                        4'b1111: C_dec = -7;
                        default: C_dec = 0;
                    endcase

                    // Display everything into the file
                    $fdisplay(outfile, "|  %03b  |  %4d  |  %03b  |  %4d  |  %1b |  %04b  |  %4d  |",
                        A, A_dec, B, B_dec, op, C, C_dec);
                end
            end
        end

        $fdisplay(outfile, "--------------------------------------------------------------------------------");

        $fclose(outfile);
        $display("Simulation finished. Results saved to add_sub_results.txt");

        $stop;
    end

endmodule