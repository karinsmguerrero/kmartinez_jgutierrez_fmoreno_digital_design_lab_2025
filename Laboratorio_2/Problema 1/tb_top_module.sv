module tb_top_module;
    parameter N = 4;
    logic [N-1:0] A, B, D, quotient, remainder, mod_out, and_out, or_out, xor_out, shift_left_out, shift_right_out;
    logic Cin, Cout;
    logic [$clog2(N):0] shift_amount;

    // Instancia del top_module
    top_module #(.N(N)) uut (
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .shift_amount(shift_amount),
        .D(D), 
        .Cout(Cout), 
        .quotient(quotient), 
        .remainder(remainder),
        .mod_out(mod_out),
        .and_out(and_out), 
        .or_out(or_out), 
        .xor_out(xor_out), 
        .shift_left_out(shift_left_out),
        .shift_right_out(shift_right_out)
    );

    initial begin
        $display("===============================================");
        $display(" Testbench para Top Module de 4 Bits ");
        $display("===============================================");

        // Test 1 - Resta, División y Módulo
        A = 4'b1001; B = 4'b0011; Cin = 0; shift_amount = 2; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b", A, B, Cin, D, Cout);
        $display("Division: cociente=%b, resioduo=%b", quotient, remainder);
        $display("Modulo: %b", mod_out);
        $display("AND: %b", and_out);
        $display("OR: %b", or_out);
        $display("XOR: %b", xor_out);
        $display("Shift Left (%d): %b", shift_amount, shift_left_out);
        $display("Shift Right (%d): %b", shift_amount, shift_right_out);
        $display("------------------------------------------------");

        // Test 2 - Resta, División y Módulo
        A = 4'b0110; B = 4'b0101; Cin = 0; shift_amount = 1; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b", A, B, Cin, D, Cout);
        $display("Divisionn: cociente=%b, resioduo=%b", quotient, remainder);
        $display("Modulo: %b", mod_out);
        $display("AND: %b", and_out);
        $display("OR: %b", or_out);
        $display("XOR: %b", xor_out);
        $display("Shift Left (%d): %b", shift_amount, shift_left_out);
        $display("Shift Right (%d): %b", shift_amount, shift_right_out);
        $display("------------------------------------------------");

        // Test 3 - División y módulo por 0
        A = 4'b1010; B = 4'b0000; #10;
        $display("Division por 0: cociente=%b, resioduo=%b", quotient, remainder);
        $display("Módulo por 0: %b", mod_out);
        $display("------------------------------------------------");

        $display("\nTest completo.");
        $finish;
    end
endmodule
