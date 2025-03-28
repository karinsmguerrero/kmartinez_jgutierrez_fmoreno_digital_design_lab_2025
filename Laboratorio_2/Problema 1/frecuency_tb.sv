module frecuency_tb;
    
	logic rst, clk_2, clk_4, clk_8, clk_16, clk_32;
   logic Z_flag, N_flag, V_flag, C_flag;

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
		.clk_2(clk_2), .clk_4(clk_4), .clk_8(clk_8), .clk_16(clk_16), .clk_32(clk_32),
   	.Z_flag(Z_flag), .N_flag(N_flag), .V_flag(V_flag), .C_flag(C_flag),
		.A_2(A_2), .B_2(B_2), .D_2(D_2),
		.A_4(A_4), .B_4(B_4), .D_4(D_4),
		.A_8(A_8), .B_8(B_8), .D_8(D_8),
		.A_16(A_16), .B_16(B_16), .D_16(D_16),
		.A_32(A_32), .B_32(B_32), .D_32(D_32)

	);
	
	// Generador de reloj
	always #5 clk_2 = ~clk_2;
	always #5 clk_4 = ~clk_4;
	always #5 clk_8 = ~clk_8;
	always #5 clk_16 = ~clk_16;
	always #5 clk_32 = ~clk_32;

	initial begin
		clk_2 = 0;
		clk_4 = 0;
		clk_8 = 0;
		clk_16 = 0;
		clk_32 = 0;
		
		rst = 1;
		#5;
		
		// Test 1 
		rst = 0;
		A_2 = 2'b10;
		B_2 = 2'b01;
		#20;
		$display("A=%b, B=%b -> Result: D=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_2, B_2, D_2, Z_flag, N_flag, V_flag, C_flag);
		rst = 1;
		#5;
		$display("------------------------------------------------");

		// Test 2 
		rst = 0;
		A_4 = 4'b1000;
		B_4 = 4'b0100;
		#10;
		$display("A=%b, B=%b -> Result: D=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_4, B_4, D_4, Z_flag, N_flag, V_flag, C_flag);
		rst = 1;
		#5;
		$display("------------------------------------------------");

		// Test 3 
		rst = 0;
		A_8 = 8'b11000000;
		B_8 = 8'b01000000;
		#10;
		$display("A=%b, B=%b -> Result: D=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_8, B_8, D_8, Z_flag, N_flag, V_flag, C_flag);
		rst = 1;
		#5;
		$display("------------------------------------------------");
		
		
		// Test 3 
		rst = 0;
		A_16 = 16'b1111000000000000;
		B_16 = 16'b0100000000000000;
		#10;
		$display("A=%b, B=%b -> Result: D=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_16, B_16, D_16, Z_flag, N_flag, V_flag, C_flag);
		rst = 1;
		#5;
		$display("------------------------------------------------");
		
		
		// Test 3 
		rst = 0;
		A_32 = 32'b11111111111111110000000000000000;
		B_32 = 32'b00100000000000000000000000100000;
		#10;
		$display("A=%b, B=%b -> Result: D=%b | Flags: Z=%b, N=%b, V=%b, C=%b", A_32, B_32, D_32, Z_flag, N_flag, V_flag, C_flag);
		rst = 1;
		#5;
		$display("------------------------------------------------");
		
	end
endmodule
