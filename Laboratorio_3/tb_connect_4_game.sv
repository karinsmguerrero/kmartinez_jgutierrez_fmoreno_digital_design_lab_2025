module tb_connect_4_game;
    // Definir señales de entrada
    reg clk;
    reg [3:0] KEY;      // Entradas de botones
    reg serial_in;

    // Definir señales de salida
    wire [6:0] HEX0, HEX1, HEX4, HEX5;
    wire VGA_CLK, VGA_HS, VGA_VS;
    wire [7:0] VGA_R, VGA_G, VGA_B;
    wire VGA_BLANK_N;

    // Instanciar el módulo connect_4_game
    connect_4_game uut (
        .clk(clk),
        .KEY(KEY),
        .serial_in(serial_in),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX4(HEX4),
        .HEX5(HEX5),
        .VGA_CLK(VGA_CLK),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
        .VGA_BLANK_N(VGA_BLANK_N)
    );

    // Variables para simular las señales
    reg [5:0][6:0] board; // Tablero de 6x7
    integer i, j;

    // Generar el reloj
    always begin
        #5 clk = ~clk; // Reloj de 10 ns (100 MHz)
    end

    // Inicialización del testbench
    initial begin
        // Inicializar señales
        clk = 0;
        KEY = 4'b0000;
        serial_in = 0;

        // Inicializar tablero a 0 (vacío)
        for (i = 0; i < 6; i = i + 1) begin
            for (j = 0; j < 7; j = j + 1) begin
                board[i][j] = 0; // 0 es vacío
            end
        end

        // Verificar la inicialización
        $display("---- Inicialización del tablero ----");
        print_board();

        // Comenzar la simulación de jugadas
        #10;
        
        // Jugada 1: Jugador 1 mueve en la columna 2 (KEY = 4'b0010)
        KEY = 4'b0010;
        #10;
        
        // Verificar estado del tablero después de la jugada 1
        $display("---- Estado del tablero después de la jugada 1 ----");
        print_board();

        // Jugada 2: Jugador 2 mueve en la columna 3 (KEY = 4'b0100)
        KEY = 4'b0100;
        #10;
        
        // Verificar estado del tablero después de la jugada 2
        $display("---- Estado del tablero después de la jugada 2 ----");
        print_board();

        // Jugada 3: Jugador 1 mueve en la columna 2 (KEY = 4'b0010)
        KEY = 4'b0010;
        #10;
        
        // Verificar estado del tablero después de la jugada 3
        $display("---- Estado del tablero después de la jugada 3 ----");
        print_board();

        // Jugada 4: Jugador 2 mueve en la columna 4 (KEY = 4'b0100)
        KEY = 4'b0100;
        #10;

        // Verificar estado del tablero después de la jugada 4
        $display("---- Estado del tablero después de la jugada 4 ----");
        print_board();

        // Añadir más jugadas aquí si es necesario
        // ...

        // Finalizar la simulación
        $stop;
    end

    // Tarea para imprimir el estado del tablero
    task print_board;
        begin
            $display("---- BOARD STATE ----");
            for (i = 0; i < 6; i = i + 1) begin
                $display("Fila %0d: %b", i, board[i]);
            end
            $display("---------------------");
        end
    endtask
endmodule
