module connect_4_game(
    input  logic clk,
    input  logic [3:0] KEY,
	 input  logic serial_in,

    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
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
 
clock_div clock_divider(
	.clk_in(clk),
	.clk_out(VGA_CLK));

logic btn0_clean, btn1_clean, btn2_clean, btn3_clean;
debounce db0(.clk(clk), .btn_in(KEY[0]), .btn_out(btn0_clean));
debounce db1(.clk(clk), .btn_in(KEY[1]), .btn_out(btn1_clean));
debounce db2(.clk(clk), .btn_in(KEY[2]), .btn_out(btn2_clean));
debounce db3(.clk(clk), .btn_in(KEY[3]), .btn_out(btn3_clean));

logic move_made = 0,times_up = 0, move_left = 0, move_right = 0, win_flag = 0, player_turn = 0;
logic [2:0]  state;
logic [2:0]  col_input;
logic [1:0]  board [5:0][6:0];
logic        global_reset;

logic [7:0] data_out;

													
UART_RX UART_Receiver (	
	.clk(VGA_CLK),
	.rstn(global_reset),
	.serial_dat_in(serial_in), 
	.data(data_out));
	
connect4_fsm fsm(
    .clk(VGA_CLK),
    .reset(global_reset),
    .move_made(move_made),
    .move_left(move_left),
    .move_right(move_right),
	 .times_up(times_up),

    .win_flag(win_flag),
    .state(state),
    .player_turn(player_turn),
    .col_input(col_input),
    .board(board)
);

logic [0:5][0:6][1:0] tiles;
vga_driver driver(
    .reset(global_reset),
    .tiles(tiles),
	 .win(win_flag),
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
logic timer_reset; // NUEVO

seven_segment_driver seg0(seg_0, HEX0);
seven_segment_driver seg1(seg_1, HEX1);

seven_segment_driver seg4(data_out[3:0], HEX4);
seven_segment_driver seg5(data_out[7:4], HEX5);

BinToBCD res_converter(tics, bcd_time);
assign seg_0 = bcd_time[7:4];
assign seg_1 = bcd_time[11:8];

timer timer_count (
    .clk(VGA_CLK), 
    .reset(global_reset | timer_reset), // MODIFICADO
    .enable(enable),
    .seconds(tics)
);

logic auto_move_triggered = 0;
logic auto_move_pulse = 0;

assign enable = (state == 3'b001);

logic accept_btn_prev, left_btn_prev, right_btn_prev, reset_btn_prev;
logic move_made_prev = 0; // NUEVO
logic [23:0] win_delay_counter = 0;
logic win_flag_prev = 0;
logic win_reset_pending = 0;

always_ff @(posedge VGA_CLK) begin
    win_flag_prev <= win_flag;

    if (win_flag && !win_flag_prev) begin
        win_reset_pending <= 1;
        win_delay_counter <= 0;
    end

	 // Activar jugada automática cuando se agota el tiempo
	 if (state == 3'b001 && tics == 4'd10 && !auto_move_triggered) begin
		 auto_move_pulse <= 1;
		 auto_move_triggered <= 1;
	 end else begin
		 auto_move_pulse <= 0;
	 end

	 if (tics < 4'd10) begin
		 auto_move_triggered <= 0;
	 end

    // RESET MANUAL O POST-VICTORIA
    if (win_reset_pending) begin
        win_delay_counter <= win_delay_counter + 1;
        if (win_delay_counter == 24'd12_500_000) begin
            global_reset <= 1;
            win_reset_pending <= 0;
        end else begin
            global_reset <= 0;
        end
    end else if (reset_btn_prev && !btn3_clean) begin
        global_reset <= 1;
    end else begin
        global_reset <= 0;
    end
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

    if (auto_move_pulse) begin
	     times_up <= 1;
        move_made <= 1;
    end else begin
        times_up <= 0;
    end

    // DETECTAR FLANCO PARA RESETEAR TIMER
    move_made_prev <= move_made;
    timer_reset <= move_made && !move_made_prev; // NUEVO

    accept_btn_prev <= btn2_clean;

    // Actualizar tiles VGA
    for (int r = 0; r < 6; r++) begin
        for (int c = 0; c < 7; c++) begin
            tiles[r][c] <= board[r][(6 - c)];
        end
    end

		/*if(serial_data == 3'd1)
			move_right <= 1;
		
		if(serial_data == 3'd2)
			move_left <= 1;
			
		if(serial_data == 3'd3)
			move_made <= 1;
		else 
			move_made <= 0;*/
end

endmodule
