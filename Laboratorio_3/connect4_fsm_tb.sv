	`timescale 1ns/1ps

module connect4_fsm_tb;

    logic clk;
    logic reset;
    logic move_made;
    logic move_left;
    logic move_right;
    logic win_detected;
    logic [2:0] state;
    logic player_turn;
    logic [2:0] col_input;

    logic [1:0] board_tb[5:0][6:0];

    connect4_fsm dut (
        .clk(clk),
        .reset(reset),
        .move_made(move_made),
        .move_left(move_left),
        .move_right(move_right),
        .win_detected(win_detected),
        .state(state),
        .player_turn(player_turn),
        .col_input(col_input),
        .board(board_tb)
    );

    always #5 clk = ~clk;

    int jugada = 0;
    logic jugada_realizada = 0;
    int movimientos_derecha;
    int movimientos_izquierda;

    localparam IDLE          = 3'd0;
    localparam PLAYER_TURN   = 3'd1;
    localparam MAKE_MOVE     = 3'd2;
    localparam CHECK_WIN     = 3'd3;
    localparam SWITCH_PLAYER = 3'd4;
    localparam GAME_OVER     = 3'd5;

    task print_board();
        $display("--- Estado del tablero ---");
        for (int r = 0; r < 6; r++) begin
            for (int c = 0; c < 7; c++) begin
                $write("%0d ", board_tb[r][c]);
            end
            $write("\n");
        end
        $display("--------------------------\n");
    endtask

    initial begin
        $display("=== Inicio del Testbench FSM Connect4 con Movimiento ===");

        clk = 0;
        reset = 1;
        move_made = 0;
        move_left = 0;
        move_right = 0;
        win_detected = 0;
        movimientos_derecha = 0;
        movimientos_izquierda = 0;

        #10 reset = 0;

        #100;

        fork
            begin
                forever begin
                    @(posedge clk);

                    $display("[%0t ns] Estado = %0d | Turno = Jugador %0d | Columna actual = %0d",
                             $time, state, player_turn ? 2 : 1, col_input);

                    if (win_detected) begin
                        $display("*** ¡Victoria detectada! ***");
                        print_board();
                        $stop;
                    end else begin
                        if (state == PLAYER_TURN && !jugada_realizada) begin
                            // Alternar entre moverse a la derecha y a la izquierda
                            movimientos_derecha = (jugada % 2 == 0) ? jugada : 0;
                            movimientos_izquierda = (jugada % 2 != 0) ? jugada : 0;

                            // Simula movimientos a la derecha
                            repeat (movimientos_derecha) begin
                                move_right = 1;
                                @(posedge clk);
                                move_right = 0;
                                @(posedge clk);
                            end

                            // Simula movimientos a la izquierda
                            repeat (movimientos_izquierda) begin
                                move_left = 1;
                                @(posedge clk);
                                move_left = 0;
                                @(posedge clk);
                            end

                            // Mostrar los movimientos realizados
                            if (movimientos_derecha > 0 || movimientos_izquierda > 0)
                                $display(">> Movimiento lateral realizado: %0d derecha, %0d izquierda",
                                         movimientos_derecha, movimientos_izquierda);

                            // Hacer jugada
                            move_made = 1;
                            jugada_realizada = 1;
                        end else if (jugada_realizada) begin
                            move_made = 0;
                        end

                        if ((state == CHECK_WIN || state == SWITCH_PLAYER) && jugada_realizada) begin
                            jugada++;
                            jugada_realizada = 0;
                            print_board();

                            if (jugada == 7) begin
                                win_detected = 1;
                            end
                        end
                    end
                end
            end

            begin
                #3000;
                $display("=== Tiempo agotado ===");
                $stop;
            end
        join
    end

endmodule
