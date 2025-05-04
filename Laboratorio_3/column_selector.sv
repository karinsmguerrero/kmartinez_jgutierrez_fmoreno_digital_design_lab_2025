module column_selector (
    input  logic clk,
    input  logic reset,
    input  logic move_left,     // Señal para mover a la izquierda
    input  logic move_right,    // Señal para mover a la derecha
    output logic [2:0] col_pos  // Posición actual seleccionada (0-6)
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            col_pos <= 3'd0; // Comenzar desde la columna 0
        end else begin
            if (move_left && col_pos > 0)
                col_pos <= col_pos - 1;
            else if (move_right && col_pos < 3'd6)
                col_pos <= col_pos + 1;
        end
    end

endmodule
