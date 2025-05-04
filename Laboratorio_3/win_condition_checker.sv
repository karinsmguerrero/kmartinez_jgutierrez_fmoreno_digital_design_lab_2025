module win_condition_checker(
    input logic clk,
    input logic check,
    input logic [1:0] current_player,
    output logic win_detected
);
    always_ff @(posedge clk) begin
        if (check) begin
            // Simula condición de victoria para jugador 2 por ahora (ejemplo)
            if (current_player == 2'd1) 
                win_detected <= 1;
            else
                win_detected <= 0;
        end else begin
            win_detected <= 0;
        end
    end
endmodule
