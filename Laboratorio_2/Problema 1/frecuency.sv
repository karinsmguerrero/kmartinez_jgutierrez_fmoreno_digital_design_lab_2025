module frecuency(
	input logic Cin, Cout_rest,
   input logic Z_rest, N_rest, V_rest, C_rest,

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
	  .D(D_2),
	  .Cin(Cin),  
	  .Cout_rest(Cout_rest), 
	  .Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest)
	);
		 
	alu #(.N(4)) alu_4 (
	  .A(A_4), 
	  .B(B_4), 
	  .D(D_4), 
	  .Cin(Cin),
	  .Cout_rest(Cout_rest),
	  .Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest)
	);

	alu #(.N(8)) alu_8 (
	  .A(A_8), 
	  .B(B_8), 
	  .D(D_8), 
	  .Cin(Cin),
	  .Cout_rest(Cout_rest),
	  .Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest)
	);

	alu #(.N(16)) alu_16 (
	  .A(A_16), 
	  .B(B_16), 
	  .D(D_16), 
	  .Cin(Cin),
	  .Cout_rest(Cout_rest),
	  .Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest)
	);

	alu #(.N(32)) alu_32 (
	  .A(A_32), 
	  .B(B_32), 
	  .D(D_32), 
	  .Cin(Cin),
	  .Cout_rest(Cout_rest),
	  .Z_rest(Z_rest), .N_rest(N_rest), .V_rest(V_rest), .C_rest(C_rest)
	);
endmodule