module top_module (
    input  logic [3:0] A,     // Minuendo para la resta
    input  logic [3:0] B,     // Sustraendo para la resta
    input  logic [3:0] dividend, // Dividendo para la división
    input  logic [3:0] divisor,  // Divisor para la división
    input  logic Cin,         // Acarreo de entrada para la resta
	 input  logic clk,rst,
//--------------------------------------------------------------------------------
    output logic [3:0] D,     // Diferencia (resultado de la resta)
    output logic Cout,        // Acarreo de salida (resultado de la resta)
    output logic [3:0] quotient, // Cociente (resultado de la división)
    output logic [3:0] remainder, // Residuo (resultado de la división)
	 output logic [3:0] multiplication,  //Resultado de la multiplicación
	 output logic overflow
);

    // Instancia del restador de 4 bits
    restador_nbit #(.N(4)) restador_inst (
        .A(A),
        .B(B),
        .Cin(Cin),
        .D(D),
        .Cout(Cout)
    );

    // Instancia del divisor parametrizable de 4 bits
    divisor_nbit #(.N(4)) divisor_inst (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );
	 
	 multiplier #(.N(4)) mult_inst(
	 	.clk(clk),
		.rst(rst),
		.A(A), 
		.B(B),
		.result(multiplication),
		.overflow(overflow)
	 );

endmodule
