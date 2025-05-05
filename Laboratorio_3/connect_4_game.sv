module connect_4_game(	
	input  logic clk, // 50 MHz

	// INPUTS
	input    [3:0]    KEY,
	input    [9:0]    SW,

	// OUTPUTS
	output   [9:0]    LEDR,
	output   [6:0]    HEX0,
	output   [6:0]    HEX1,
	output   [6:0]    HEX2,
	output   [6:0]    HEX3,
	output   [6:0]    HEX4,
	output   [6:0]    HEX5,

	output            VGA_CLK,
	output            VGA_HS,
	output            VGA_VS,
	output   [7:0]    VGA_R,
	output   [7:0]    VGA_G,
	output   [7:0]    VGA_B,
	output            VGA_BLANK_N
);

//////////////////////////////////////////////////////////
// Clock Divider
clock_50_25 clk_divider(
	.rst(SW[9]),
	.refclk(clk),
	.outclk_0(VGA_CLK),
	.locked()
);

//////////////////////////////////////////////////////////
// Debouncers
logic btn0_clean, btn1_clean, btn2_clean, btn3_clean;
debounce db0(.clk(clk), .btn_in(KEY[0]), .btn_out(btn0_clean));
debounce db1(.clk(clk), .btn_in(KEY[1]), .btn_out(btn1_clean));
debounce db2(.clk(clk), .btn_in(KEY[2]), .btn_out(btn2_clean));
debounce db3(.clk(clk), .btn_in(KEY[3]), .btn_out(btn3_clean));

//////////////////////////////////////////////////////////
// Game FSM
logic move_made = 0, move_left = 0, move_right = 0, win_detected = 0, player_turn = 0;
logic [2:0]  state;
logic [2:0]  col_input;	
logic [1:0]  board [5:0][6:0];
logic        global_reset;

connect4_fsm fsm(
	.clk(VGA_CLK),
	.reset(global_reset),
	.move_made(move_made),
	.move_left(move_left),
	.move_right(move_right),
	.win_detected(win_detected),
	.state(state),
	.player_turn(player_turn),
	.col_input(col_input),
	.board(board)
);

//////////////////////////////////////////////////////////
// VGA Output
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

//////////////////////////////////////////////////////////
// Timer and 7-segment
logic [3:0] seg_0, seg_1 = 0;
logic [3:0] tics;
logic [3:0] max_time = 4'b1010;
logic enable;
logic [11:0] bcd_time;

seven_segment_driver seg0(seg_0, HEX0);
seven_segment_driver seg1(seg_1, HEX1);
BinToBCD res_converter(tics, bcd_time);

assign seg_0 = bcd_time[7:4];
assign seg_1 = bcd_time[11:8];

timer timer_count (
	.clk(VGA_CLK), 
	.reset(global_reset),
	.enable(enable),
	.seconds(tics)
);                                                                                                                                  

//////////////////////////////////////////////////////////
// Internal state for detecting button edges
logic accept_btn_prev, left_btn_prev, right_btn_prev, reset_btn_prev;

always_ff @(posedge VGA_CLK) begin
	// Control reset global con KEY[3]
	if (reset_btn_prev && !btn3_clean)
		global_reset <= 1;
	else
		global_reset <= 0;
	reset_btn_prev <= btn3_clean;

	// Control movimiento izquierda
	if (left_btn_prev && !btn0_clean)
		move_left <= 1;
	else
		move_left <= 0;
	left_btn_prev <= btn0_clean;

	// Control movimiento derecha
	if (right_btn_prev && !btn1_clean)
		move_right <= 1;
	else
		move_right <= 0;
	right_btn_prev <= btn1_clean;

	// Confirmar movimiento
	if (accept_btn_prev && !btn2_clean)
		move_made <= 1;
	else
		move_made <= 0;
	accept_btn_prev <= btn2_clean;

	// Copiar board → tiles (invertido verticalmente)
	for (int r = 0; r < 6; r++) begin
		for (int c = 0; c < 7; c++) begin
			tiles[r][c] <= board[(5 - r)][(6 - c)];
		end
	end
end

endmodule
