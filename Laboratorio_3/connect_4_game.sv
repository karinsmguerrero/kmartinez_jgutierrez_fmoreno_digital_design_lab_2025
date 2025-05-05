module connect_4_game(	
	input  logic clk,// 50 MHz
	///////// KEY /////////
	input    [ 3: 0]   KEY,

	///////// SW /////////
	input    [ 9: 0]   SW,

	///////// LED /////////
	output   [ 9: 0]   LEDR,

	///////// Seg7 /////////
	output   [ 6: 0]   HEX0,
	output   [ 6: 0]   HEX1,
	output   [ 6: 0]   HEX2,
	output   [ 6: 0]   HEX3,
	output   [ 6: 0]   HEX4,
	output   [ 6: 0]   HEX5,
	
	///////// VGA /////////
	output             VGA_CLK,
	output             VGA_HS,
	output             VGA_VS,
	output   [ 7: 0]   VGA_R,
	output   [ 7: 0]   VGA_G,
	output   [ 7: 0]   VGA_B,
	output             VGA_BLANK_N
);	

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CLOCK DIVIDER 50 MHz to 25 MHz
clock_50_25 clk_divider(
	.rst(SW[9]),
	.refclk(clk),
	.outclk_0(VGA_CLK),
	.locked()
	); 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FSM
logic move_made = 0, move_left = 0, move_right = 0, win_detected = 0, player_turn = 0;
logic [2:0]  state;
logic [2:0]  col_input;	
logic [1:0]  board [5:0][6:0];

connect4_fsm fsm(
	.clk(VGA_CLK),
	.reset(SW[9]),
	.move_made(move_made),
	.move_left(move_left),
	.move_right(move_right),
	.win_detected(win_detected),
	.state(state),
	.player_turn(player_turn),
	.col_input(col_input),
	.board(board)
);



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// VIDEO OUTPUT

// Holds the current state of the player´s tokens
logic [0:5][0:6][1:0] tiles;
logic [1:0] tile_value;

/*assign tiles = {{2'd0,2'd2,2'd0,2'd1,2'd1,2'd0,2'd0},
					 {2'd0,2'd2,2'd0,2'd1,2'd0,2'd1,2'd0},
					 {2'd0,2'd2,2'd0,2'd1,2'd0,2'd2,2'd0},
					 {2'd0,2'd2,2'd0,2'd2,2'd0,2'd1,2'd0},
					 {2'd0,2'd1,2'd0,2'd2,2'd0,2'd1,2'd0},
					 {2'd0,2'd1,2'd1,2'd2,2'd0,2'd1,2'd1}};*/

vga_driver driver(
	.reset(SW[9]),
	.tiles(tiles),
	.VGA_HS(VGA_HS),      
	.VGA_VS(VGA_VS),	    
	.VGA_R(VGA_R),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G), 
	.VGA_CLK(VGA_CLK), 
	.VGA_BLANK_N(VGA_BLANK_N)
);



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PLAYER CONTROLS					 
logic accept_btn_prev;
logic left_btn_prev;
logic right_btn_prev;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SEVEN SEGMENT TIMER
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
	.reset(SW[9]),
	.enable(enable),
	.seconds(tics)
);

//--------- OTHERS -----------
logic [3:0] pushes = 0;
logic [11:0] bcd_pushes;
logic sel_btn_prev;

BinToBCD count(pushes, bcd_pushes);

assign seg_4 = bcd_pushes[7:4];
assign seg_5 = bcd_pushes[11:8];
		
assign enable = (state == 3'b001)? 1'b1:1'b0;                                                                                                                                  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// GAME LOOP				 
always @ (posedge VGA_CLK)
	begin
	
		/*for (int r = 0; r < 6; r++) begin
			for (int c = 0; c < 7; c++) begin
				tile_value <= board[(r-5)*(-1)][(c-6)*(-1)];
				tiles[r][c] <= tile_value;
			end
		end*/
		
		if (sel_btn_prev && !KEY[3]) // Detecta flanco de bajada (1 → 0)
			 begin
				pushes <= pushes + 1;
				if(pushes > 15)
					pushes <= 0;
			 end
		sel_btn_prev <= KEY[3];
		
		
		if (left_btn_prev && !KEY[0]) // Detecta flanco de bajada (1 → 0)
				move_left <= 1;
		else
			move_left <= 0;
			
		left_btn_prev <= KEY[0];
		
		if (right_btn_prev && !KEY[1]) // Detecta flanco de bajada (1 → 0)
				move_right <= 1;
		else
			move_right <= 0;
			
		right_btn_prev <= KEY[1];
		
		if (accept_btn_prev && !KEY[2]) // Detecta flanco de bajada (1 → 0)
			begin
				move_made <= 1;
				tiles[2][2] <= 2'b10;
			end
		else
			move_made <= 0;
			
		accept_btn_prev <= KEY[2];		
		
	end
					 


endmodule