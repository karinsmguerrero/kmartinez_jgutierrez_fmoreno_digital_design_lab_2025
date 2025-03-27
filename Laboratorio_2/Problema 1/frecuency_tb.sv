module frecuency_tb;
    
	logic Cin, Cout_rest, clk;
   logic Z_rest, N_rest, V_rest, C_rest;

	// ------- ALU 2 bits -----------
	logic [1:0] A_2, B_2, D_2;
	// ------- ALU 4 bits -----------
	logic [3:0] A_4, B_4, D_4;
	// ------- ALU 8 bits -----------
	logic [7:0] A_8, B_8, D_8;
	// ------- ALU 16 bits -----------
	logic [15:0] A_16, B_16, D_16;
	// ------- ALU 32 bits -----------
	logic [31:0] A_32, B_32, D_32;
	
	frecuency dut(
		.Cin(Cin), .Cout_rest(Cout_Rest),
   	.Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest),
		.A_2(A_2), .B_2(B_2), .D_2(D_2),
		.A_4(A_4), .B_4(B_4), .D_4(D_4),
		.A_8(A_8), .B_8(B_8), .D_8(D_8),
		.A_16(A_16), .B_16(B_16), .D_16(D_16),
		.A_32(A_32), .B_32(B_32), .D_32(D_32)

	);
	
	// Generador de reloj
	//always #5 clk = ~clk;

	initial begin

		// Test 1 
		A_2 = 2'b11;
		B_2 = 2'b10;
		Cin = 0; 
		#10;
		$display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_2, B_2, Cin, D_2, Cout_rest, Z_rest, N_rest, V_rest, C_rest);
		$display("------------------------------------------------");

		// Test 2 
		A_4 = 4'b1111;
		B_4 = 4'b1000;
		Cin = 0; 
		#10;
		$display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_4, B_4, Cin, D_4, Cout_rest, Z_rest, N_rest, V_rest, C_rest);
		$display("------------------------------------------------");

		// Test 3 
		A_8 = 8'b11111111;
		B_8 = 8'b10000000;
		Cin = 0; 
		#10;
		$display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_8, B_8, Cin, D_8, Cout_rest, Z_rest, N_rest, V_rest, C_rest);
		$display("------------------------------------------------");
	end
endmodule
