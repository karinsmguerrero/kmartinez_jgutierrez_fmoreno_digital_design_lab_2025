`timescale 1ns/1ps

module tb_connect_4_game;

    logic clk;
    logic [3:0] KEY;
    logic [9:0] SW;
    logic [9:0] LEDR;
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic VGA_CLK, VGA_HS, VGA_VS;
    logic [7:0] VGA_R, VGA_G, VGA_B;
    logic VGA_BLANK_N;

    connect_4_game uut (
        .clk(clk),
        .KEY(KEY),
        .SW(SW),
        .LEDR(LEDR),
        .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2),
        .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5),
        .VGA_CLK(VGA_CLK), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS),
        .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B),
        .VGA_BLANK_N(VGA_BLANK_N)
    );

    // Clock generation
    initial clk = 0;
    always #10 clk = ~clk; // 50MHz clock

    // Reset all inputs
    initial begin
        KEY = 4'b1111;   // Todos los botones no presionados
        SW = 10'b0000000000;
    end

    // Task para simular un "botón presionado"
    task press_button(input int key_idx);
        begin
            KEY[key_idx] = 0;
            #40; // Tiempo del botón presionado
            KEY[key_idx] = 1;
            #100000; // Esperar a que se procese la jugada
        end
    endtask

    // Task para mover ficha a la izquierda o derecha varias veces
    task move_piece(input int steps, input bit to_right);
        for (int i = 0; i < steps; i++) begin
            if (to_right)
                press_button(1); // KEY[1] = derecha
            else
                press_button(0); // KEY[0] = izquierda
        end
    endtask

    // Task para imprimir el estado actual del tablero
    task print_board;
        $display("Estado del tablero:");
        for (int r = 0; r < 6; r++) begin
            $write("| ");
            for (int c = 0; c < 7; c++) begin
                $write("%0d ", uut.board[r][c]);
            end
            $write("|\n");
        end
        $display("---------------------\n");
    endtask

    // Simulación principal
    initial begin
        $display("Iniciando simulación del juego Connect 4");
        SW[9] = 1; #40; SW[9] = 0; // Hacer reset

        repeat (5) @(posedge clk); // Esperar

        // Jugada 1: Jugador 1 en columna 3
        move_piece(3, 1);  // Mover derecha 3 veces
        press_button(2);   // KEY[2] = aceptar jugada
        print_board();

        // Jugada 2: Jugador 2 en columna 2
        move_piece(1, 0);  // Mover izquierda 1 vez
        press_button(2);
        print_board();

        // Jugada 3: Jugador 1 en columna 4
        move_piece(2, 1);
        press_button(2);
        print_board();

        // Jugada 4: Jugador 2 en columna 2
        move_piece(0, 0);
        press_button(2);
        print_board();

        // Jugada 5: Jugador 1 en columna 5
        move_piece(1, 1);
        press_button(2);
        print_board();

        // Jugada 6: Jugador 2 en columna 2 (tercera vez)
        move_piece(0, 0);
        press_button(2);
        print_board();

        // Jugada 7: Jugador 1 en columna 6
        move_piece(1, 1);
        press_button(2);
        print_board();

        // Simulación final
        $display("Fin de la partida simulada.");
        $stop;
    end

endmodule
