module frecuency(
   input logic Z_flag, N_flag, V_flag, C_flag,
	input logic rst, clk_2, clk_4, clk_8, clk_16, clk_32,

	// ------- ALU 2 bits -----------
	input logic [1:0] A_2, B_2,
	output logic [1:0] D_2,
	// ------- ALU 4 bits -----------
	input logic [3:0] A_4, B_4,
	output logic [3:0] D_4,
	// ------- ALU 8 bits -----------
	input logic [7:0] A_8, B_8,
	output logic [7:0] D_8,
	// ------- ALU 16 bits -----------
	input logic [15:0] A_16, B_16,
	output logic [15:0] D_16,
	// ------- ALU 32 bits -----------
	input logic [31:0] A_32, B_32,
	output logic [31:0] D_32	
);

	alu #(.N(2)) alu_2 (
	  .A(A_2), 
	  .B(B_2), 
	  .mult_out(D_2), 
	  .Z_mult(Z_flag), .N_mult(N_flag), .V_mult(V_flag), .C_mult(C_flag),
	  .rst(rst), .clk(clk_2)
	);
		 
	alu #(.N(4)) alu_4 (
	  .A(A_4), 
	  .B(B_4), 
	  .mult_out(D_4), 
	  .Z_mult(Z_flag), .N_mult(N_flag), .V_mult(V_flag), .C_mult(C_flag),
	  .rst(rst), .clk(clk_4)
	);

	alu #(.N(8)) alu_8 (
	  .A(A_8), 
	  .B(B_8), 
	  .mult_out(D_8), 
	  .Z_mult(Z_flag), .N_mult(N_flag), .V_mult(V_flag), .C_mult(C_flag),
	  .rst(rst), .clk(clk_8)
	);

	alu #(.N(16)) alu_16 (
	  .A(A_16), 
	  .B(B_16), 
	  .mult_out(D_16), 
	  .Z_mult(Z_flag), .N_mult(N_flag), .V_mult(V_flag), .C_mult(C_flag),
	  .rst(rst), .clk(clk_16)
	);

	alu #(.N(32)) alu_32 (
	  .A(A_32), 
	  .B(B_32), 
	  .mult_out(D_32), 
	  .Z_mult(Z_flag), .N_mult(N_flag), .V_mult(V_flag), .C_mult(C_flag),
	  .rst(rst), .clk(clk_32)
	);
endmodule