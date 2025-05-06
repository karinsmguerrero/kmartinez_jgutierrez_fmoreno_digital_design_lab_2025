module connect_4_game(
    input  logic clk,
    input  logic [3:0] KEY,
    input  logic [9:0] SW,

    output logic [9:0] LEDR,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
    output logic [6:0] HEX2,
    output logic [6:0] HEX3,
    output logic [6:0] HEX4,
    output logic [6:0] HEX5,

    output logic VGA_CLK,
    output logic VGA_HS,
    output logic VGA_VS,
    output logic [7:0] VGA_R,
    output logic [7:0] VGA_G,
    output logic [7:0] VGA_B,
    output logic VGA_BLANK_N
);

clock_50_25 clk_divider(
    .rst(SW[9]),
    .refclk(clk),
    .outclk_0(VGA_CLK),
    .locked()
);

logic btn0_clean, btn1_clean, btn2_clean, btn3_clean;
debounce db0(.clk(clk), .btn_in(KEY[0]), .btn_out(btn0_clean));
debounce db1(.clk(clk), .btn_in(KEY[1]), .btn_out(btn1_clean));
debounce db2(.clk(clk), .btn_in(KEY[2]), .btn_out(btn2_clean));
debounce db3(.clk(clk), .btn_in(KEY[3]), .btn_out(btn3_clean));

logic move_made = 0, move_left = 0, move_right = 0, win_flag = 0, player_turn = 0;
logic [2:0]  state;
logic [2:0]  col_input;
logic [1:0]  board [5:0][6:0];
logic        global_reset;

win_checker wc_inst (
    .clk(VGA_CLK),
    .reset(global_reset),
    .board(board),
    .win_detected(win_detected)
);

connect4_fsm fsm(
    .clk(VGA_CLK),
    .reset(global_reset),
    .move_made(move_made),
    .move_left(move_left),
    .move_right(move_right),
    .win_detected(win_flag),
    .state(state),
    .player_turn(player_turn),
    .col_input(col_input),
    .board(board)
);

logic [0:5][0:6][1:0] tiles;
vga_driver driver(
    .reset(global_reset),
    .tiles(tiles),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_R(VGA_R),
    .VGA_B(VGA_B),
    .VGA_G(VGA_G),
    .VGA_CLK(VGA_CLK),
    .VGA_BLANK_N(VGA_BLANK_N)
);

logic [11:0] bcd_time;
logic [3:0] seg_0, seg_1, seg_2, seg_3, seg_4, seg_5 = 0;
logic [3:0] tics;
logic [3:0] max_time = 4'b1010;
logic enable;

seven_segment_driver seg0(seg_0, HEX0);
seven_segment_driver seg1(seg_1, HEX1);
seven_segment_driver seg2(seg_2, HEX2);
seven_segment_driver seg3(seg_3, HEX3);
seven_segment_driver seg4(seg_4, HEX4);
seven_segment_driver seg5(seg_5, HEX5);

BinToBCD res_converter(tics, bcd_time);
assign seg_0 = bcd_time[7:4];
assign seg_1 = bcd_time[11:8];

timer timer_count (
    .clk(VGA_CLK), 
    .reset(global_reset),
    .enable(enable),
    .seconds(tics)
);

logic [3:0] pushes = 0;
logic [11:0] bcd_pushes;
BinToBCD count(pushes, bcd_pushes);
assign seg_4 = bcd_pushes[7:4];
assign seg_5 = bcd_pushes[11:8];
assign enable = (state == 3'b001);

logic accept_btn_prev, left_btn_prev, right_btn_prev, reset_btn_prev;
always_ff @(posedge VGA_CLK) begin
    // RESET MANUAL O POR VICTORIA
    if ((reset_btn_prev && !btn3_clean) || win_detected)
        global_reset <= 1;
    else
        global_reset <= 0;
    reset_btn_prev <= btn3_clean;

    if (left_btn_prev && !btn0_clean)
        move_left <= 1;
    else
        move_left <= 0;
    left_btn_prev <= btn0_clean;

    if (right_btn_prev && !btn1_clean)
        move_right <= 1;
    else
        move_right <= 0;
    right_btn_prev <= btn1_clean;

    if (accept_btn_prev && !btn2_clean)
        move_made <= 1;
    else
        move_made <= 0;
    accept_btn_prev <= btn2_clean;

    for (int r = 0; r < 6; r++) begin
        for (int c = 0; c < 7; c++) begin
            tiles[r][c] <= board[r][(6 - c)];
        end
    end
end

endmodule