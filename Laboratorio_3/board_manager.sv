module board_manager (
    input  logic clk,
    input  logic reset,
    input  logic write_enable,             // Habilita la escritura
    input  logic [2:0] col,                // Columna seleccionada (0 a 6)
    input  logic [1:0] player_id,          // 1 = Jugador 1, 2 = Jugador 2
    output logic [2:0] row_written,        // Fila donde se colocó la ficha
    output logic valid_move,              // 1 si se pudo colocar la ficha
    output logic [1:0] board[5:0][6:0]     // Matriz del tablero (6x7)
);

    integer i, j;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 6; i = i + 1)
                for (j = 0; j < 7; j = j + 1)
                    board[i][j] <= 0;
            valid_move <= 0;
            row_written <= 0;
        end else if (write_enable) begin
            valid_move <= 0;
            row_written <= 0;
            // Buscar desde la fila inferior hacia arriba
            for (i = 5; i >= 0; i = i - 1) begin
                if (board[i][col] == 0 && !valid_move) begin
                    board[i][col] <= player_id;
                    row_written <= i;
                    valid_move <= 1;
                end
            end
        end else begin
            valid_move <= 0;
        end
    end

endmodule
