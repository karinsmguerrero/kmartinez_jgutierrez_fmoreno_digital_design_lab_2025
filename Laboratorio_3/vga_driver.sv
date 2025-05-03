// image generator of a road and a sky 640x480 @ 60 fps

////////////////////////////////////////////////////////////////////////
module vga_driver(
	input  logic clk,           // 50 MHz
	input  logic reset,
	output logic VGA_HS,      // horizontal sync
	output logic VGA_VS,	     // vertical sync
	output logic [7:0] VGA_R,
	output logic [7:0] VGA_B,
	output logic [7:0] VGA_G, 
	output logic VGA_CLK, 
	output logic VGA_BLANK_N
);

	logic [9:0] x = 0;  // horizontal counter
	logic [9:0] y = 0;  // vertical counter
	logic [9:0] x_max = 799;
	logic [9:0] y_max = 524;
	parameter hori_back  = 144;
	parameter vert_back  = 34;
	logic done;
	
	logic [7:0] r_red = 0;
	logic [7:0] r_blue = 0;
	logic [7:0] r_green = 0;

	
	logic clk25MHz;

	// clk divider 50 MHz to 25 MHz
	clock_50_25 clk_divider(
		.rst(reset),
		.refclk(clk),
		.outclk_0(clk25MHz),
		.locked()
		); 
	assign VGA_CLK = clk25MHz;

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// counter and sync generation	
	video_sync_generator video_sync (
		.vga_clk(VGA_CLK),
      .reset(reset),
		.blank_n(VGA_BLANK_N),
		.HS(VGA_HS),
		.VS(VGA_VS));
		

	counter #(10) counter_x(.clk(clk25MHz), .enable(1), .reset(reset), .max(x_max), .done(done), .q(x));
	counter #(10) counter_y(.clk(clk25MHz), .enable(done), .reset(reset), .max(y_max), .done(), .q(y));
	
	parameter IMAGE_WIDTH = 90;
   parameter IMAGE_HEIGHT = 90;
	

	logic [23:0] memory [0:8099];
	sprite_tile tile(.mem(memory));
	
	logic [23:0] outputData;
	logic [7:0] RVal, BVal, GVal;
	logic [12:0] address;
	integer offset_x = 10;
	integer offset_y = 10;
	
	always @ (posedge clk25MHz)
		begin
			// First tile
			if(x > (hori_back + offset_x) && x < (IMAGE_WIDTH*1 + hori_back + offset_x) && y > (vert_back + offset_y) && y < (IMAGE_HEIGHT*1 + vert_back + offset_y))
				begin
					address <= ((y - vert_back - offset_y) * (IMAGE_WIDTH)) + (x - hori_back - offset_x);
					outputData <= memory[address];
					RVal <= outputData[23:16];
					GVal <= outputData[15:8];
					BVal <= outputData[7:0];
				end
			// Second tile
			else if (x > (hori_back + offset_x + IMAGE_WIDTH*1) && x < (IMAGE_WIDTH*2 + hori_back + offset_x) && y > (vert_back + offset_y) && y < (IMAGE_HEIGHT*1 + vert_back + offset_y))
				begin
					address <= ((y - vert_back - offset_y) * (IMAGE_WIDTH)) + (x - hori_back - offset_x);
					outputData <= memory[address];
					RVal <= outputData[23:16];
					GVal <= outputData[15:8];
					BVal <= outputData[7:0];
				end
			// Third tile
			else if(x > (hori_back + offset_x + IMAGE_WIDTH*2) && x < (IMAGE_WIDTH*3 + hori_back + offset_x) && y > (vert_back + offset_y) && y < (IMAGE_HEIGHT*1 + vert_back + offset_y))
				begin
					address <= ((y - vert_back - offset_y) * (IMAGE_WIDTH)) + (x - hori_back - offset_x);
					outputData <= memory[address];
					RVal <= outputData[23:16];
					GVal <= outputData[15:8];
					BVal <= outputData[7:0];
				end
			else if(x > (hori_back + offset_x + IMAGE_WIDTH*3) && x < (IMAGE_WIDTH*4 + hori_back + offset_x) && y > (vert_back + offset_y) && y < (IMAGE_HEIGHT*1 + vert_back + offset_y))
				begin
					address <= ((y - vert_back - offset_y) * (IMAGE_WIDTH)) + (x - hori_back - offset_x);
					outputData <= memory[address];
					RVal <= outputData[23:16];
					GVal <= outputData[15:8];
					BVal <= outputData[7:0];
				end
			else if(x > (hori_back + offset_x + IMAGE_WIDTH*4) && x < (IMAGE_WIDTH*5 + hori_back + offset_x) && y > (vert_back + offset_y) && y < (IMAGE_HEIGHT*1 + vert_back + offset_y))
				begin
					address <= ((y - vert_back - offset_y) * (IMAGE_WIDTH)) + (x - hori_back - offset_x);
					outputData <= memory[address];
					RVal <= outputData[23:16];
					GVal <= outputData[15:8];
					BVal <= outputData[7:0];
				end
			else if(x > (hori_back + offset_x + IMAGE_WIDTH*5) && x < (IMAGE_WIDTH*6 + hori_back + offset_x) && y > (vert_back + offset_y) && y < (IMAGE_HEIGHT*1 + vert_back + offset_y))
				begin
					address <= ((y - vert_back - offset_y) * (IMAGE_WIDTH)) + (x - hori_back - offset_x);
					outputData <= memory[address];
					RVal <= outputData[23:16];
					GVal <= outputData[15:8];
					BVal <= outputData[7:0];
				end
			else if(x > (hori_back + offset_x + IMAGE_WIDTH*6) && x < (IMAGE_WIDTH*7 + hori_back + offset_x) && y > (vert_back + offset_y) && y < (IMAGE_HEIGHT*1 + vert_back + offset_y))
				begin
					address <= ((y - vert_back - offset_y) * (IMAGE_WIDTH)) + (x - hori_back - offset_x);
					outputData <= memory[address];
					RVal <= outputData[23:16];
					GVal <= outputData[15:8];
					BVal <= outputData[7:0];
				end
			else
				begin
					RVal <= 8'hFF;
					GVal <= 8'hFF;
					BVal <= 8'hFF;
				end

		end
          

	
	assign VGA_R = RVal;
	assign VGA_G = GVal;
	assign VGA_B = BVal;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// color output assignments
	// only output the colors if the counters are within the adressable video time constraints
	//assign VGA_R = (x > 144 && x <= 783 && y > 35 && y <= 514) ? pixelOutR : 8'hFF;
	//assign VGA_G = (x > 144 && x <= 783 && y > 35 && y <= 514) ? pixelOutG : 8'hFF;
	//assign VGA_B = (x > 144 && x <= 783 && y > 35 && y <= 514) ? pixelOutB : 8'hFF;

	// end color output assignments
	
endmodule  // VGA_image_gen