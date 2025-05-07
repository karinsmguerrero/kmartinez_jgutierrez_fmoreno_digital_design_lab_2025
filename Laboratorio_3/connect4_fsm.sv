module connect4_fsm (
    input  logic        clk,
    input  logic        reset,
    input  logic        move_made,
    input  logic        move_left,
    input  logic        move_right,
    input  logic        times_up,

    output logic        win_flag,
    output logic [2:0]  state,
    output logic        player_turn,
    output logic [2:0]  col_input,
	 output logic [2:0] win_coords_row [3:0],
	 output logic [2:0] win_coords_col [3:0],

    output logic [1:0]  board [5:0][6:0]
);

    typedef enum logic [2:0] {
        IDLE          = 3'd0,
        PLAYER_TURN   = 3'd1,
        MAKE_MOVE     = 3'd2,
        CHECK_WIN     = 3'd3,
        SWITCH_PLAYER = 3'd4,
        GAME_OVER     = 3'd5
    } state_t;

    state_t current_state, next_state;
    logic [1:0] board_reg [5:0][6:0];
    logic [2:0] drop_row;
    logic       valid_move;
    logic [2:0] current_col;
    logic       is_column_full;
    logic       random_move_active;  // Indica si se está haciendo un movimiento aleatorio
    logic [2:0] selected_col;        // Columna seleccionada (manual o aleatoria)
logic [2:0] wc_row [3:0];
logic [2:0] wc_col [3:0];

    // Flanco de subida para move_made y times_up
    logic move_made_d, times_up_d;
    logic move_made_rise, times_up_rise;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            move_made_d <= 0;
            times_up_d  <= 0;
        end else begin
            move_made_d <= move_made;
            times_up_d  <= times_up;
        end
    end

    assign move_made_rise = move_made & ~move_made_d;
    assign times_up_rise  = times_up  & ~times_up_d;

    // Instancia del módulo win_checker
    logic win_detected;
	win_checker wc (
		.clk(clk),
		.reset(reset),
		.board(board_reg),
		.win_detected(win_detected),
		.win_coords_row(wc_row),
		.win_coords_col(wc_col)
	);


    assign win_flag = win_detected;

	 
	 always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        for (int i = 0; i < 4; i++) begin
            win_coords_row[i] <= 3'd0;
            win_coords_col[i] <= 3'd0;
        end
    end else if (win_detected) begin
        for (int i = 0; i < 4; i++) begin
            win_coords_row[i] <= wc_row[i];
            win_coords_col[i] <= wc_col[i];
        end
    end
end

    // Instancia del selector de columna manual
    column_selector manual_selector (
        .clk(clk),
        .reset(reset),
        .move_left(move_left),
        .move_right(move_right),
        .col_pos(current_col)
    );

    // Instancia del selector de columna aleatoria
    logic [2:0] random_col;
    random_column_selector random_selector (
        .clk(clk),
        .reset(reset),
        .generate_random(times_up_rise && (current_state == PLAYER_TURN)),
        .col_pos(random_col)
    );

    // Lógica para manejar la selección de columna
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            selected_col <= 3'd0;
            random_move_active <= 1'b0;
        end else if (current_state == PLAYER_TURN) begin
            if (times_up_rise) begin
                selected_col <= random_col;
                random_move_active <= 1'b1;
            end else if (move_made_rise) begin
                selected_col <= current_col;
                random_move_active <= 1'b0;
            end
        end
    end

    assign col_input = selected_col;
    assign state = current_state;

    // Verifica si la columna seleccionada está llena
    always_comb begin
        is_column_full = 1'b1;
        for (int r = 0; r < 6; r++) begin
            if (board_reg[r][col_input] == 2'b00) begin
                is_column_full = 1'b0;
            end
        end
    end

    // Transición de estados
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE:           next_state = PLAYER_TURN;
            PLAYER_TURN:    if ((move_made_rise || times_up_rise) && !is_column_full)
                                next_state = MAKE_MOVE;
            MAKE_MOVE:      next_state = CHECK_WIN;
            CHECK_WIN:      next_state = win_detected ? GAME_OVER : SWITCH_PLAYER;
            SWITCH_PLAYER:  next_state = PLAYER_TURN;
            GAME_OVER:      next_state = GAME_OVER;
        endcase
    end

    // Alternancia de turno
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            player_turn <= 0;
        end else if (current_state == SWITCH_PLAYER) begin
            player_turn <= ~player_turn;
        end
    end

    // Inicialización del tablero y aplicación de jugada
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int r = 0; r < 6; r++) begin
                for (int c = 0; c < 7; c++) begin
                    board_reg[r][c] <= 2'b00;
                end
            end
        end else if (current_state == MAKE_MOVE) begin
            valid_move = 0;
            for (int r = 5; r >= 0; r--) begin
                if (!valid_move && board_reg[r][col_input] == 2'b00) begin
                    board_reg[r][col_input] <= (player_turn == 0) ? 2'b01 : 2'b10;
                    drop_row = r;
                    valid_move = 1;
                end
            end
        end
    end

    // Actualización de salida del tablero
    always_ff @(posedge clk) begin
        for (int r = 0; r < 6; r++) begin
            for (int c = 0; c < 7; c++) begin
                board[r][c] <= board_reg[r][c];
            end
        end
    end

endmodule
