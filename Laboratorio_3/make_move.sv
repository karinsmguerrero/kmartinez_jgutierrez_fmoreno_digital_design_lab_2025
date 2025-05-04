module make_move (
    input  logic clk,
    input  logic reset,
    input  logic move_enable,          // Señal para hacer el movimiento
    input  logic [2:0] col_input,      // Columna donde se quiere jugar (0-6)
    input  logic player_turn,          // 0: Jugador 1, 1: Jugador 2
    output logic valid_move,
    output logic [2:0] row_output,
    output logic [1:0] board_out[5:0][6:0]
);

    logic [1:0] player_id;

    // Traducir 0 o 1 a 1 o 2 (jugador)
    always_comb begin
        player_id = player_turn + 1;
    end

    board_manager bm (
        .clk(clk),
        .reset(reset),
        .write_enable(move_enable),
        .col(col_input),
        .player_id(player_id),
        .row_written(row_output),
        .valid_move(valid_move),
        .board(board_out)
    );

endmodule
