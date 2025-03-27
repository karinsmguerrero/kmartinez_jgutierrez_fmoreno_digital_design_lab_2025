module alu_tb;
    parameter N = 4;
    logic [N-1:0] A, B, D, quotient, remainder, mod_out, and_out, or_out, xor_out, shift_left_out, shift_right_out, mult_out, sum_out;
    logic Cin, Cout_rest, rst, clk, carry_out_sum, overflow_sum;
    logic [$clog2(N):0] shift_amount;
    logic Z_rest, N_rest, V_rest, C_rest;
    logic Z_div, N_div;
    logic Z_mod, N_mod;
    logic Z_and, N_and;
    logic Z_or, N_or;
    logic Z_xor, N_xor;
    logic Z_shl, N_shl;
    logic Z_shr, N_shr;
	 logic Z_mult, N_mult, C_mult, V_mult;

    // Instancia del top_module
    alu #(.N(N)) uut (
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .shift_amount(shift_amount),
        .D(D), 
        .Cout_rest(Cout_rest), 
        .quotient(quotient), 
        .remainder(remainder),
        .mod_out(mod_out),
        .Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest),
        .Z_div(Z_div), .N_div(N_div),
        .Z_mod(Z_mod), .N_mod(N_mod),
        .Z_and(Z_and), .N_and(N_and),
        .Z_or(Z_or), .N_or(N_or),
        .Z_xor(Z_xor), .N_xor(N_xor),
        .Z_shl(Z_shl), .N_shl(N_shl),
        .Z_shr(Z_shr), .N_shr(N_shr),
		  .Z_mult(Z_mult), .N_mult(N_mult), .C_mult(C_mult), .V_mult(V_mult),
        .and_out(and_out), 
        .or_out(or_out), 
        .xor_out(xor_out), 
        .shift_left_out(shift_left_out),
        .shift_right_out(shift_right_out),
        .mult_out(mult_out),
        .sum_out(sum_out),
        .carry_out_sum(carry_out_sum),
        .overflow_sum(overflow_sum),
        .clk(clk),
        .rst(rst)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        $display("===============================================");
        $display(" Testbench para ALU de 4 Bits ");
        $display("===============================================");

        // Test 1 - Resta, División y Módulo
        A = 4'b0101; B = 4'b0011; Cin = 0; shift_amount = 2; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A, B, Cin, D, Cout_rest, Z_rest, N_rest, V_rest, C_rest);
        $display("Division: cociente=%b, residuo=%b | Flags: Z=%b, N=%b", quotient, remainder, Z_div, N_div);
        $display("Modulo: %b | Flags: Z=%b, N=%b", mod_out, Z_mod, N_mod);
        $display("AND: %b | Flags: Z=%b, N=%b", and_out, Z_and, N_and);
        $display("OR: %b | Flags: Z=%b, N=%b", or_out, Z_or, N_or);
        $display("XOR: %b | Flags: Z=%b, N=%b", xor_out, Z_xor, N_xor);
        $display("Shift Left (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_left_out, Z_shl, N_shl);
        $display("Shift Right (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_right_out, Z_shr, N_shr);
        $display("Suma: %b | Carry: %b, Overflow: %b", sum_out, carry_out_sum, overflow_sum);
        $display("------------------------------------------------");

        // Test 2 - Otra combinación de valores
        A = 4'b0101; B = 4'b1001; Cin = 0; shift_amount = 1; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A, B, Cin, D, Cout_rest, Z_rest, N_rest, V_rest, C_rest);
        $display("Division: cociente=%b, residuo=%b | Flags: Z=%b, N=%b", quotient, remainder, Z_div, N_div);
        $display("Modulo: %b | Flags: Z=%b, N=%b", mod_out, Z_mod, N_mod);
        $display("AND: %b | Flags: Z=%b, N=%b", and_out, Z_and, N_and);
        $display("OR: %b | Flags: Z=%b, N=%b", or_out, Z_or, N_or);
        $display("XOR: %b | Flags: Z=%b, N=%b", xor_out, Z_xor, N_xor);
        $display("Shift Left (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_left_out, Z_shl, N_shl);
        $display("Shift Right (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_right_out, Z_shr, N_shr);
        $display("Suma: %b | Carry: %b, Overflow: %b", sum_out, carry_out_sum, overflow_sum);
        $display("------------------------------------------------");

        // Test 3 - División y módulo por 0
        A = 4'b1010; B = 4'b0000; #10;
        $display("Division por 0: cociente=%b, residuo=%b", quotient, remainder);
        $display("Módulo por 0: %b", mod_out);
        $display("------------------------------------------------");
		  
			//Test multiplicación
		  	clk = 0;
			rst = 1;
			#5;
			
			rst = 0;
			A = 4'b0101;
			B = 4'b0010;
			#50;
			assert (mult_out[3:0] == 4'b1010) $display ("A=%b, B=%b -> Multiplicación: Resultado=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A, B, mult_out, Z_mult, N_mult, V_mult, C_mult);
			else $error("Failed multiplication: 1");
			rst = 1;
			#5;
			
			rst = 0;
			A = 4'b1011;
			B = 4'b0010;
			#50;
			assert (mult_out[3:0] == 4'b0110) $display("A=%b, B=%b -> Multiplicación: Resultado=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A, B, mult_out, Z_mult, N_mult, V_mult, C_mult);
			else $error("Failed multiplication: 2");
			rst = 1;
        
        $display("\nTest completo.");
    end
endmodule
