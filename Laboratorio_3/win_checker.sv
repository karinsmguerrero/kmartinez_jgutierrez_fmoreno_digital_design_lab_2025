module win_checker (
    input  logic        clk,
    input  logic        reset,
    input  logic [1:0]  board [5:0][6:0],
    output logic        win_detected
);

    logic win;

    always_comb begin
        win = 0;

        // Horizontal
        for (int r = 0; r < 6; r++)
            for (int c = 0; c <= 3; c++)
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r][c+1] &&
                    board[r][c] == board[r][c+2] &&
                    board[r][c] == board[r][c+3])
                    win = 1;

        // Vertical
        for (int c = 0; c < 7; c++)
            for (int r = 0; r <= 2; r++)
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r+1][c] &&
                    board[r][c] == board[r+2][c] &&
                    board[r][c] == board[r+3][c])
                    win = 1;

        // Diagonal ↘
        for (int r = 0; r <= 2; r++)
            for (int c = 0; c <= 3; c++)
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r+1][c+1] &&
                    board[r][c] == board[r+2][c+2] &&
                    board[r][c] == board[r+3][c+3])
                    win = 1;

        // Diagonal ↙
        for (int r = 3; r < 6; r++)
            for (int c = 0; c <= 3; c++)
                if (board[r][c] != 2'b00 &&
                    board[r][c] == board[r-1][c+1] &&
                    board[r][c] == board[r-2][c+2] &&
                    board[r][c] == board[r-3][c+3])
                    win = 1;
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            win_detected <= 0;
        else
            win_detected <= win;
    end

endmodule
