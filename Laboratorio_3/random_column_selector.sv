module random_column_selector (
    input  logic clk,
    input  logic reset,
    input  logic generate_random,  // Señal para generar nueva posición aleatoria
    output logic [2:0] col_pos     // Posición aleatoria seleccionada (0-6)
);

    // Registro para el generador de números pseudoaleatorios
    logic [15:0] lfsr = 16'hACE1;  // Semilla inicial (puede ser cualquier valor distinto de cero)
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            col_pos <= 3'd0;       // Valor inicial al resetear
            lfsr <= 16'hACE1;      // Reiniciar el LFSR con la semilla
        end else begin
            // Actualizar el LFSR continuamente para mejor aleatoriedad
            lfsr <= {lfsr[14:0], lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]};
            
            // Generar nueva posición aleatoria cuando se solicite
            if (generate_random) begin
                // Usar los bits menos significativos para obtener un valor entre 0-6
                col_pos <= lfsr[2:0] % 7;
            end
        end
    end

endmodule