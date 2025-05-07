module random_column_selector (
    input  logic clk,
    input  logic reset,
    input  logic select_random,      // Señal que activa una nueva selección aleatoria
    output logic [2:0] col_pos       // Columna seleccionada aleatoriamente (0 a 6)
);

    logic [3:0] lfsr;  // Registro de desplazamiento para pseudoaleatoriedad

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr    <= 4'b0001;  // Valor inicial no nulo
            col_pos <= 3'd0;
        end else if (select_random) begin
            // LFSR de 4 bits con taps en 4 y 3 (retroalimentación XOR)
            lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[2]};
            
            // Solo permitir valores entre 0 y 6
            if (lfsr[2:0] <= 3'd6)
                col_pos <= lfsr[2:0];
            else
                col_pos <= lfsr[2:0] % 7;  // Reducción segura (aunque rara vez necesario)
        end
    end

endmodule
