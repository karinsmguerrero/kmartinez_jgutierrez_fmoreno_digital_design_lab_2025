module player_switcher(
    input  logic current_player,   // Jugador actual: 0 o 1
    output logic next_player       // Jugador siguiente
);
    always_comb begin
        next_player = ~current_player; // Alternar entre 0 y 1
    end
endmodule
