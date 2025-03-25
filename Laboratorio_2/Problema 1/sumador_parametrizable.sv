module sumador_parametrizable #(
    parameter int WIDTH = 4  // Ancho de los operandos
)(
    input  logic [WIDTH-1:0] A, B,  // Entradas
    input  logic Cin,               // Acarreo de entrada
    output logic [WIDTH-1:0] S,      // Resultado de la suma
    output logic carry_out,          // Acarreo de salida
    output logic overflow            // Flag de overflow
);
    logic [WIDTH-1:0] sum, carry;
    logic carry_internal;  // Variable auxiliar para el acarreo
    integer i;

    always_comb begin
        sum = A ^ B;      // Suma parcial sin acarreo
        carry = A & B;    // Acarreos intermedios
        S = sum;          // Inicializar salida
        carry_internal = Cin; // Inicializar el acarreo con Cin

        // Propagación del acarreo manualmente
        for (i = 0; i < WIDTH; i = i + 1) begin
            logic temp;
            temp = S[i] ^ carry_internal;  // Suma con acarreo actual
            carry[i] = (S[i] & carry_internal) | carry[i]; // Propagación del acarreo
            S[i] = temp;
            carry_internal = carry[i];  // Actualizar el acarreo para el siguiente bit
        end

        carry_out = carry_internal;  // Último acarreo es el carry_out
        overflow = (A[WIDTH-1] == B[WIDTH-1]) && (S[WIDTH-1] != A[WIDTH-1]); // Overflow en complemento a dos
    end
endmodule
