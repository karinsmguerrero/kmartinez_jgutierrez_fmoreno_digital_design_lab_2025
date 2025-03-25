module tb_top_module;
    parameter N = 4;
    logic [N-1:0] A, B, D, quotient, remainder, mod_out, and_out, or_out, xor_out, shift_left_out, shift_right_out, mult_out;
    logic Cin, Cout, overflow, rst, clk;
    logic [$clog2(N):0] shift_amount;
    logic Z_rest, N_rest, V_rest, C_rest;
    logic Z_div, N_div;
    logic Z_mod, N_mod;
    logic Z_and, N_and;
    logic Z_or, N_or;
    logic Z_xor, N_xor;
    logic Z_shl, N_shl;
    logic Z_shr, N_shr;

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
        .Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest),
        .Z_div(Z_div), .N_div(N_div),
        .Z_mod(Z_mod), .N_mod(N_mod),
        .Z_and(Z_and), .N_and(N_and),
        .Z_or(Z_or), .N_or(N_or),
        .Z_xor(Z_xor), .N_xor(N_xor),
        .Z_shl(Z_shl), .N_shl(N_shl),
        .Z_shr(Z_shr), .N_shr(N_shr),
        .and_out(and_out), 
        .or_out(or_out), 
        .xor_out(xor_out), 
        .shift_left_out(shift_left_out),
        .shift_right_out(shift_right_out),
		  .mult_out(mult_out),
		  .overflow(overflow),
		  .clk(clk),
		  .rst(rst)
    );
	 
	 // Generador de reloj
	always #5 clk = ~clk;

	initial begin
        $display("===============================================");
        $display(" Testbench para Top Module de 4 Bits ");
        $display("===============================================");

        // Test 1 - Resta, División y Módulo
        A = 4'b1001; B = 4'b0011; Cin = 0; shift_amount = 2; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A, B, Cin, D, Cout, Z_rest, N_rest, V_rest, C_rest);
        $display("Division: cociente=%b, residuo=%b | Flags: Z=%b, N=%b", quotient, remainder, Z_div, N_div);
        $display("Modulo: %b | Flags: Z=%b, N=%b", mod_out, Z_mod, N_mod);
        $display("AND: %b | Flags: Z=%b, N=%b", and_out, Z_and, N_and);
        $display("OR: %b | Flags: Z=%b, N=%b", or_out, Z_or, N_or);
        $display("XOR: %b | Flags: Z=%b, N=%b", xor_out, Z_xor, N_xor);
        $display("Shift Left (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_left_out, Z_shl, N_shl);
        $display("Shift Right (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_right_out, Z_shr, N_shr);
        $display("------------------------------------------------");

        // Test 2 - Otra combinación de valores
        A = 4'b0110; B = 4'b0101; Cin = 0; shift_amount = 1; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A, B, Cin, D, Cout, Z_rest, N_rest, V_rest, C_rest);
        $display("Division: cociente=%b, residuo=%b | Flags: Z=%b, N=%b", quotient, remainder, Z_div, N_div);
        $display("Modulo: %b | Flags: Z=%b, N=%b", mod_out, Z_mod, N_mod);
        $display("AND: %b | Flags: Z=%b, N=%b", and_out, Z_and, N_and);
        $display("OR: %b | Flags: Z=%b, N=%b", or_out, Z_or, N_or);
        $display("XOR: %b | Flags: Z=%b, N=%b", xor_out, Z_xor, N_xor);
        $display("Shift Left (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_left_out, Z_shl, N_shl);
        $display("Shift Right (%d): %b | Flags: Z=%b, N=%b", shift_amount, shift_right_out, Z_shr, N_shr);
        $display("------------------------------------------------");

        // Test 3 - División y módulo por 0
        A = 4'b1010; B = 4'b0000; #10;
        $display("Division por 0: cociente=%b, residuo=%b", quotient, remainder);
        $display("Módulo por 0: %b", mod_out);
        $display("------------------------------------------------");

        //Pruebas para la multiplicación
		  	clk = 0;
			rst = 1;
			#5;
			
			rst = 0; 
			A = 4'b0101;
			B = 4'b0010;
			#50;
			assert (mult_out[3:0] == 4'b1010) $display ("A=%b, B=%b, -> Multiplicación: resultado=%b, overflow=%b", A, B, mult_out, overflow);
			else $error("Multiplicación fallida: 1");
			rst = 1;
			#5;
			
			rst = 0;																																																											
			A = 4'b1111;
			B = 4'b1111;
			#50;
			assert (mult_out[3:0] == 4'b0001) $display ("A=%b, B=%b, -> Multiplicación: resultado=%b, overflow=%b", A, B, mult_out, overflow);
			else $error("Multiplicación fallida: 2");
			rst = 1;
			#5;
        $display("\nTest completo.");
		  
		  
        //$finish;
    end
endmodule
