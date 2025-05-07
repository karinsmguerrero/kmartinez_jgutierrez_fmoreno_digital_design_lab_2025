module win_checker (
    input  logic        clk,
    input  logic        reset,
    input  logic [1:0]  board [5:0][6:0],
    output logic        win_detected,
    output logic [2:0]  win_coords_row [3:0],
    output logic [2:0]  win_coords_col [3:0]
);

    logic win;
    logic [2:0] temp_coords_row [3:0];
    logic [2:0] temp_coords_col [3:0];

    always_comb begin
        win = 0;

        // Default all to zero
        for (int i = 0; i < 4; i++) begin
            temp_coords_row[i] = 3'd0;
            temp_coords_col[i] = 3'd0;
        end

        // Horizontal
        for (int r = 0; r < 6; r++) begin
            for (int c = 0; c <= 3; c++) begin
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r][c+1] &&
                    board[r][c] == board[r][c+2] &&
                    board[r][c] == board[r][c+3]) begin

                    win = 1;
                    temp_coords_row = '{r, r, r, r};
                    temp_coords_col = '{c, c+1, c+2, c+3};
                end
            end
        end

        // Vertical
        for (int c = 0; c < 7; c++) begin
            for (int r = 0; r <= 2; r++) begin
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r+1][c] &&
                    board[r][c] == board[r+2][c] &&
                    board[r][c] == board[r+3][c]) begin

                    win = 1;
                    temp_coords_row = '{r, r+1, r+2, r+3};
                    temp_coords_col = '{c, c, c, c};
                end
            end
        end

        // Diagonal ↘
        for (int r = 0; r <= 2; r++) begin
            for (int c = 0; c <= 3; c++) begin
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r+1][c+1] &&
                    board[r][c] == board[r+2][c+2] &&
                    board[r][c] == board[r+3][c+3]) begin

                    win = 1;
                    temp_coords_row = '{r, r+1, r+2, r+3};
                    temp_coords_col = '{c, c+1, c+2, c+3};
                end
            end
        end

        // Diagonal ↙
        for (int r = 3; r < 6; r++) begin
            for (int c = 0; c <= 3; c++) begin
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r-1][c+1] &&
                    board[r][c] == board[r-2][c+2] &&
                    board[r][c] == board[r-3][c+3]) begin

                    win = 1;
                    temp_coords_row = '{r, r-1, r-2, r-3};
                    temp_coords_col = '{c, c+1, c+2, c+3};
                end
            end
        end
    end

    // Actualización de salidas sincronizadas
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            win_detected <= 0;
            for (int i = 0; i < 4; i++) begin
                win_coords_row[i] <= 3'd0;
                win_coords_col[i] <= 3'd0;
            end
        end else begin
            win_detected <= win;
            for (int i = 0; i < 4; i++) begin
                win_coords_row[i] <= temp_coords_row[i];
                win_coords_col[i] <= temp_coords_col[i];
            end
        end
    end

endmodule
