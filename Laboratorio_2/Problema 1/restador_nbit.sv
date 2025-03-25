module restador_nbit #(parameter N = 4) (
    input  logic [N-1:0] A,     // Minuendo
    input  logic [N-1:0] B,     // Sustraendo
    input  logic Cin,           // Acarreo de entrada
    output logic [N-1:0] D,     // Diferencia
    output logic Cout,          // Acarreo de salida
    output logic Z, neg, V        // Flags Zero, Negativo y Overflow
);

    logic [N-1:0] B_complement;  // Complemento de B
    assign B_complement = ~B + 1; // Complemento a 2 de B

    // Operación de resta con acarreo
    assign {Cout, D} = A + B_complement + Cin;

    // Calcular flags
    assign Z = (D == 0);                   // Flag de cero
    assign neg = D[N-1];                     // Flag de negativo (MSB de D)
    assign V = (A[N-1] != B[N-1]) && (A[N-1] != D[N-1]); // Overflow

endmodule
