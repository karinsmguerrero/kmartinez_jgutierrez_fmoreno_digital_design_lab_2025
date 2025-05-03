module screen_drawer(
	input  logic [9:0] x,y,
	input  logic clk,
	output logic [23:0] rgb_color
);

parameter IMAGE_WH = 70;
parameter IMAGE_SIZE = 4900;
parameter offset_x = 184;
parameter offset_y = 54;
parameter hori_back  = 144;
parameter vert_back  = 34;

logic [23:0] memory [0:4899];
logic [12:0] address;
logic [5:0][6:0] tiles;

sprite_tile tile(.mem(memory));

always @ (posedge clk)
		begin
			// First row
			if(y > 54 && y <= 124)
				begin
					if(x >= 184 && x < 254) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x);
						rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH;
						rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2;
						rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3;
						rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4;
						rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5;
						rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6;
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
						rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE;
						rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE;
						rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE;
						rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE;
						rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE;
						rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE;
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
						rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*2;
						rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*2;
						rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*2;
						rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*2;
						rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*2;
						rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*2;
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
						rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*3;
						rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*3;
						rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*3;
						rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*3;
						rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*3;
						rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*3;
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
						rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*4;
						rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*4;
						rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*4;
						rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*4;
						rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*4;
						rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*4;
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
						rgb_color <= memory[address];
					end
					else if(x >= 244 && x < 324) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH - IMAGE_SIZE*5;
						rgb_color <= memory[address];
					end
					else if(x >= 324 && x < 394) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*2 - IMAGE_SIZE*5;
						rgb_color <= memory[address];
					end
					else if(x >= 394 && x < 464) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*3 - IMAGE_SIZE*5;
						rgb_color <= memory[address];
					end
					else if(x >= 464 && x < 534) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*4 - IMAGE_SIZE*5;
						rgb_color <= memory[address];
					end
					else if(x >= 534 && x < 604) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*5 - IMAGE_SIZE*5;
						rgb_color <= memory[address];
					end
					else if(x >= 604 && x < 674) begin
						address <= ((y - offset_y) * (IMAGE_WH)) + (x - offset_x) - IMAGE_WH*6 - IMAGE_SIZE*5;
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