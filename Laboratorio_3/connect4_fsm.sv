module connect4_fsm (
    input  logic clk,
    input  logic reset,
    input  logic move_made,           // Jugador solicita hacer movimiento
    input  logic [2:0] col_input,     // Columna elegida por el jugador
    input  logic win_detected,        // Desde el checker de victoria
    output logic [2:0] state,
    output logic player_turn,         // 0 = Jugador 1, 1 = Jugador 2
    output logic [1:0] board[5:0][6:0] // Tablero actualizado
);

    typedef enum logic [2:0] {
        IDLE,
        PLAYER_TURN,
        MAKE_MOVE,
        CHECK_WIN,
        SWITCH_PLAYER,
        GAME_OVER
    } state_t;

    state_t current_state, next_state;

    // Cambio de jugador
    logic next_player;
    player_switcher player_switch (
        .current_player(player_turn),
        .next_player(next_player)
    );

    // Señales para make_move
    logic valid_move;
    logic [2:0] row_output;

    make_move mover (
        .clk(clk),
        .reset(reset),
        .move_enable(current_state == MAKE_MOVE),
        .col_input(col_input),
        .player_turn(player_turn),
        .valid_move(valid_move),
        .row_output(row_output),
        .board_out(board)
    );

    // Máquina de estados - transición
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            player_turn <= 0;
        end else begin
            current_state <= next_state;

            if (current_state == SWITCH_PLAYER) begin
                player_turn <= next_player;
            end
        end
    end

    // Máquina de estados - lógica de transición
    always_comb begin
        next_state = current_state;

        case (current_state)
            IDLE: begin
                next_state = PLAYER_TURN;
            end

            PLAYER_TURN: begin
                if (move_made) begin
                    next_state = MAKE_MOVE;
                end
            end

            MAKE_MOVE: begin
                if (valid_move)
                    next_state = CHECK_WIN;
                else
                    next_state = PLAYER_TURN;  // Movimiento inválido
            end

            CHECK_WIN: begin
                if (win_detected)
                    next_state = GAME_OVER;
                else
                    next_state = SWITCH_PLAYER;
            end

            SWITCH_PLAYER: begin
                next_state = PLAYER_TURN;
            end

            GAME_OVER: begin
                next_state = GAME_OVER;
            end

            default: next_state = IDLE;
        endcase
    end

    assign state = current_state;

    // Debug opcional
    always_ff @(posedge clk) begin
        case (current_state)
            IDLE:
                $display("[%0t ns] Estado = IDLE", $time);
            PLAYER_TURN:
                $display("[%0t ns] Estado = PLAYER_TURN | Turno del jugador %0d", $time, player_turn + 1);
            MAKE_MOVE:
                $display("[%0t ns] Estado = MAKE_MOVE | Columna seleccionada: %0d", $time, col_input);
            CHECK_WIN:
                $display("[%0t ns] Estado = CHECK_WIN", $time);
            SWITCH_PLAYER:
                $display("[%0t ns] Estado = SWITCH_PLAYER | Cambio a jugador %0d", $time, next_player + 1);
            GAME_OVER:
                $display("[%0t ns] Estado = GAME_OVER | Juego terminado", $time);
        endcase
    end

endmodule
