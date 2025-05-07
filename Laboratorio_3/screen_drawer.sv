module screen_drawer(
	input  logic [9:0] x,y,
	input  logic clk,
	input  logic [0:5][0:6][1:0] tiles,
	output logic [23:0] rgb_color
);

parameter IMAGE_WH = 70;
parameter IMAGE_SIZE = 4900;
parameter offset_x = 184;
parameter offset_y = 54;
parameter hori_back  = 144;
parameter vert_back  = 34;

logic [23:0] memory [0:4899];
logic [23:0] memory_red [0:4899];    //Player 1
logic [23:0] memory_yellow [0:4899]; //Player 2
logic [23:0] memory_green [0:4899];
logic [12:0] address;

//image pixel colors				 
sprite_tile tile(
	.mem(memory),
	.mem_red(memory_red),
	.mem_yellow(memory_yellow),
	.mem_green(memory_green));

always @ (posedge clk)
		begin
			// First row
			if(y > 54 && y <= 124)
				begin
					//First col
					if(x >= 184 && x < 254) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x);
						//Checks if the position has a token and its color
						if(tiles[0][0] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[0][0] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					//Second col
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH;
						if(tiles[0][1] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[0][1] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					//Third col
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2;
						if(tiles[0][2] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[0][2] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					//Forth col
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3;
						if(tiles[0][3] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[0][3] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4;
						if(tiles[0][4] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[0][4] == 2'b10)
							rgb_color <= memory_yellow[address];
						else
						   rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5;
						if(tiles[0][5] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[0][5] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6;
						if(tiles[0][6] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[0][6] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else
						rgb_color <= 24'hFFFFFF;
				end
			// Second row
			else if(y > 124 && y <= 194)
				begin
					if(x >= 184 && x < 254) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_SIZE;
						if(tiles[1][0] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[1][0] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE;
						if(tiles[1][1] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[1][1] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE;
						if(tiles[1][2] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[1][2] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE;
						if(tiles[1][3] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[1][3] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE;
						if(tiles[1][4] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[1][4] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE;
						if(tiles[1][5] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[1][5] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE;
						if(tiles[1][6] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[1][6] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else
						rgb_color <= 24'hFFFFFF;
				end
			// Third row
			else if(y > 194 && y <= 264)
								begin
					if(x >= 184 && x < 254) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_SIZE*2;
						if(tiles[2][0] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[2][0] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*2;
						if(tiles[2][1] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[2][1] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*2;
						if(tiles[2][2] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[2][2] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*2;
						if(tiles[2][3] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[2][3] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*2;
						if(tiles[2][4] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[2][4] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*2;
						if(tiles[2][5] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[2][5] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*2;
						if(tiles[2][6] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[2][6] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else
						rgb_color <= 24'hFFFFFF;
				end
			// Forth row
			else if(y > 264 && y <= 334)
				begin
					if(x >= 184 && x < 254) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_SIZE*3;
						if(tiles[3][0] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[3][0] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*3;
						if(tiles[3][1] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[3][1] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*3;
						if(tiles[3][2] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[3][2] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*3;
						if(tiles[3][3] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[3][3] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*3;
						if(tiles[3][4] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[3][4] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*3;
						if(tiles[3][5] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[3][5] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*3;
						if(tiles[3][6] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[3][6] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else
						rgb_color <= 24'hFFFFFF;
				end
			// Fifth row
			else if(y > 334 && y <= 404)
								begin
					if(x >= 184 && x < 254) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_SIZE*4;
						if(tiles[4][0] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[4][0] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*4;
						if(tiles[4][1] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[4][1] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*4;
						if(tiles[4][2] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[4][2] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*4;
						if(tiles[4][3] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[4][3] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*4;
						if(tiles[4][4] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[4][4] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*4;
						if(tiles[4][5] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[4][5] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*4;
						if(tiles[4][6] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[4][6] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else
						rgb_color <= 24'hFFFFFF;
				end
			//Sixth row
			else if(y > 404 && y <= 474)
								begin
					if(x >= 184 && x < 254) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_SIZE*5;
						if(tiles[5][0] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[5][0] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*5;
						if(tiles[5][1] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[5][1] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*5;
						if(tiles[5][2] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[5][2] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*5;
						if(tiles[5][3] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[5][3] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*5;
						if(tiles[5][4] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[5][4] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*5;
						if(tiles[5][5] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[5][5] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*5;
						if(tiles[5][6] == 2'b01)
							rgb_color <= memory_red[address];
						else if(tiles[5][6] == 2'b10)
							rgb_color <= memory_yellow[address];
						else 
						   rgb_color <= memory[address];
					end
					else
						rgb_color <= 24'hFFFFFF;
				end
			//Border
			else
				begin
					rgb_color = 24'hFFFFFF;
				end
		end
endmodule