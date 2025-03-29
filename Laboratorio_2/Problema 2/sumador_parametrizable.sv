module sumador_parametrizable #(
    parameter int WIDTH = 4  // Ancho de los operandos
)(
    input  logic [WIDTH-1:0] A, B,  // Entradas
    input  logic Cin,               // Acarreo de entrada
    output logic [WIDTH-1:0] S,      // Resultado de la suma
    output logic carry_out,          // Acarreo de salida
    output logic overflow_suma       // Flag de overflow
);
    logic [WIDTH-1:0] suma_parcial, acarreo_intermedio;  // Suma sin acarreo y acarreo intermedio
    logic acarreo_interno;  // Acarreo que se propaga durante la suma
    integer i;

    always_comb begin
        suma_parcial = A ^ B;      // Suma parcial sin acarreo
        acarreo_intermedio = A & B;    // Acarreos intermedios
        S = suma_parcial;          // Inicializar resultado con la suma sin acarreo
        acarreo_interno = Cin; // Inicializar el acarreo con Cin

        // Propagación del acarreo manualmente
        for (i = 0; i < WIDTH; i = i + 1) begin
            logic suma_bit;
            suma_bit = suma_parcial[i] ^ acarreo_interno;  // Suma del bit actual con el acarreo
            acarreo_intermedio[i] = (suma_parcial[i] & acarreo_interno) | acarreo_intermedio[i]; // Propagación del acarreo
            S[i] = suma_bit;
            acarreo_interno = acarreo_intermedio[i];  // Actualizar el acarreo para el siguiente bit
        end

        carry_out = acarreo_interno;  // El acarreo final es el carry_out
        overflow_suma = (A[WIDTH-1] == B[WIDTH-1]) && (S[WIDTH-1] != A[WIDTH-1]); // Overflow en complemento a dos
    end
endmodule
