`timescale 1ns/1ps

module connect4_fsm_tb;

    logic clk;
    logic reset;
    logic move_made;
    logic win_detected;
    logic [2:0] state;
    logic player_turn;  // 0 para jugador 1, 1 para jugador 2
    logic [2:0] col_input;

    // Tablero de 6 filas x 7 columnas
    logic [2:0] board[5:0][6:0];  // [fila][columna]

    // Instancia del DUT
    connect4_fsm dut (
        .clk(clk),
        .reset(reset),
        .move_made(move_made),
        .win_detected(win_detected),
        .state(state),
        .player_turn(player_turn),
        .col_input(col_input)
    );

    // Clock
    always #5 clk = ~clk;

    // Control de jugadas
    int i = 0;
    int cols[7] = '{3, 3, 4, 4, 5, 5, 6};
    logic jugada_realizada = 0;

    // Estados nombrados para imprimir
    localparam IDLE         = 3'd0;
    localparam PLAYER_TURN  = 3'd1;
    localparam CHECK_WIN    = 3'd2;
    localparam SWITCH_PLAYER= 3'd3;
    localparam GAME_OVER    = 3'd4;

    // Imprimir estado actual del tablero
    task print_board();
        $display("--- Estado del tablero ---");
        for (int r = 0; r < 6; r++) begin
            for (int c = 0; c < 7; c++) begin
                $write("%0d ", board[r][c]);
            end
            $write("\n");
        end
        $display("--------------------------\n");
    endtask

    // Simulación principal
// Simulación principal
initial begin
    $display("=== Inicio del Testbench FSM Connect4 ===");

    clk = 0;
    reset = 1;
    move_made = 0;
    win_detected = 0;
    col_input = 0;
    player_turn = 0;  // Empezamos con el jugador 1 (0)

    // Inicializar el tablero
    for (int r = 0; r < 6; r++)
        for (int c = 0; c < 7; c++)
            board[r][c] = 0;

    #10;
    reset = 0;
    #100;

    fork
        // Simulación de jugadas y estado de FSM
        begin
            forever begin
                @(posedge clk);

                $display("[%0t ns] Estado = %0d", $time, state);
                $display("[%0t ns] Turno del Jugador %0d", $time, player_turn ? 2 : 1); // Muestra quién está jugando

                // Verificar si la victoria fue detectada
                if (win_detected) begin
                    $display("[%0t ns] *** ¡Victoria detectada! ***", $time); // Mensaje de victoria
                    $display("=== Fin de la Simulación ===");
                    $stop;  // Detener la simulación al detectar victoria
                end
                else begin  // Solo evalúa jugadas si no se ha detectado victoria
                    if (state == PLAYER_TURN && !jugada_realizada) begin
                        col_input = cols[i];
                        move_made = 1;
                        jugada_realizada = 1;

                        // Simular que la FSM coloca la ficha en el tablero
                        for (int row = 5; row >= 0; row--) begin
                            if (board[row][col_input] == 0) begin
                                board[row][col_input] = player_turn ? 2 : 1;  // Coloca la ficha del jugador
                                $display("Jugador %0d jugó en columna %0d, fila %0d", player_turn ? 2 : 1, col_input, row);
                                break;
                            end
                        end

                        print_board();
                    end
                    else if (jugada_realizada) begin
                        move_made = 0;
                    end

                    if ((state == CHECK_WIN || state == SWITCH_PLAYER) && jugada_realizada) begin
                        i++;
                        jugada_realizada = 0;

                        // Cambiar de turno
                        player_turn = ~player_turn;

                        if (i == 7)
                            win_detected = 1;
                    end
                end
            end
        end

        // Fin de simulación
        begin
            #3000;
            $display("=== Fin del Testbench ===");
            $stop;
        end
    join
end

endmodule
