module restador_nbit #(parameter N = 4) (
    input  logic [N-1:0] A,     // Minuendo
    input  logic [N-1:0] B,     // Sustraendo
    input  logic Cin,           // Acarreo de entrada
    output logic [N-1:0] D,     // Diferencia
    output logic Cout           // Acarreo de salida
);

    logic [N-1:0] B_complement;  // Complemento de B

    // Complemento a 2 de B (para hacer la resta)
    assign B_complement = ~B + 1;

    // Sumar A + (complemento de B) + Cin
    assign {Cout, D} = A + B_complement + Cin;

endmodule
