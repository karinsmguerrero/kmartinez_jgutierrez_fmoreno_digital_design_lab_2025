`timescale 1ns/1ps

module connect4_fsm_tb;

    logic clk;
    logic reset;
    logic move_made;
    logic move_left;
    logic move_right;
    logic times_up;

    logic win_flag;
    logic [2:0] state;
    logic player_turn;
    logic [2:0] col_input;
    logic [1:0] board [5:0][6:0];

    // Clock generation
    always #5 clk = ~clk;

    // DUT
    connect4_fsm dut (
        .clk(clk),
        .reset(reset),
        .move_made(move_made),
        .move_left(move_left),
        .move_right(move_right),
        .times_up(times_up),
        .win_flag(win_flag),
        .state(state),
        .player_turn(player_turn),
        .col_input(col_input),
        .board(board)
    );

    // Print del tablero
    task print_board;
        $display("Tablero (Turno: %0d):", player_turn ? 2 : 1);
        for (int r = 0; r < 6; r++) begin
            for (int c = 0; c < 7; c++) begin
                $write("%0d ", board[r][c]);
            end
            $display("");
        end
        $display("--------------");
    endtask

    // Monitor para imprimir solo cuando realmente hay un movimiento
    always @(posedge clk) begin
        if (dut.current_state == dut.MAKE_MOVE) begin
            print_board();
        end
    end

    // Procedimiento mejorado para hacer movimientos
    task make_move_in_col(input logic [2:0] col);
        begin
            force dut.current_col = col;
            wait (state == 3'd1); // Espera a PLAYER_TURN
            #2 move_made = 1;
            #10 move_made = 0;
            
            // Espera hasta que se complete el movimiento
            wait (state != 3'd2); 
            
            // Espera adicional para asegurar que se complete la lógica de victoria
            #50;
            
            release dut.current_col;
        end
    endtask

    // Monitor específico para la victoria
    always @(posedge win_flag) begin
        if (win_flag) begin
            $display("\n=================================");
            $display("¡VICTORIA DETECTADA CORRECTAMENTE!");
            $display("Jugador %0d ha ganado!", player_turn ? 2 : 1);
            $display("=================================\n");
            print_board();
        end
    end

    initial begin
        clk = 0;
        reset = 1;
        move_made = 0;
        move_left = 0;
        move_right = 0;
        times_up = 0;

        #20;
        reset = 0;

        $display("Iniciando partida...");

        // Secuencia de movimientos
        make_move_in_col(3'd2); // J1
        make_move_in_col(3'd3); // J2
        make_move_in_col(3'd2); // J1
        make_move_in_col(3'd3); // J2
        make_move_in_col(3'd2); // J1
        make_move_in_col(3'd3); // J2
        make_move_in_col(3'd1); // J1 
        make_move_in_col(3'd3); // J2 (debería ganar aquí)

        // Espera final para asegurar que todo se complete
        #200;
        
        if (!win_flag) begin
            $display("Error: No se detectó victoria cuando debería haberla");
        end
        
        $display("Fin de simulación.");
        $finish;
    end
endmodule