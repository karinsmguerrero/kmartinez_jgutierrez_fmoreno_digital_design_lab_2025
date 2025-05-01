

// image generator of a road and a sky 640x480 @ 60 fps

////////////////////////////////////////////////////////////////////////
module smiley_test(
	input clk,           // 50 MHz
	input logic reset,
	output VGA_HS,      // horizontal sync
	output VGA_VS,	     // vertical sync
	output [7:0] VGA_R,
	output [7:0] VGA_B,
	output [7:0] VGA_G, 
	output logic VGA_CLK, 
	output logic VGA_BLANK_N, VGA_SYNC_N
);

	reg [9:0] counter_x = 0;  // horizontal counter
	reg [9:0] counter_y = 0;  // vertical counter
	reg [7:0] r_red = 0;
	reg [7:0] r_blue = 0;
	reg [7:0] r_green = 0;
	
	
	wire clk25MHz;

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// clk divider 50 MHz to 25 MHz
	clock_50_25 clk_divider(
		.rst(reset),
		.refclk(clk),
		.outclk_0(clk25MHz),
		.locked()
		); 
	// end clk divider 50 MHz to 25 MHz

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// counter and sync generation
	always @(posedge clk25MHz)  // horizontal counter
		begin 
			if (counter_x < 799)
				counter_x <= counter_x + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
			else
				counter_x <= 0;              
		end  // always 
	
	always @ (posedge clk25MHz)  // vertical counter
		begin 
			if (counter_x == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (counter_y < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						counter_y <= counter_y + 1;
				else
						counter_y <= 0;              
				end  // if (counter_x...
		end  // always
	// end counter and sync generation  

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// hsync and vsync output assignments
	assign VGA_HS = (counter_x >= 0 && counter_x < 96) ? 1:0;  // hsync high for 96 counts                                                 
	assign VGA_VS = (counter_y >= 0 && counter_y < 2) ? 1:0;   // vsync high for 2 counts
	//assign VGA_BLANK_N = 0;
	//assign VGA_BLANK_N = (counter_x >= 0 && counter_x < 144) ? 0:1;
	logic hori_valid, vert_valid;
	assign hori_valid = (counter_x < (800 - 16) && counter_x >= 34)? 1:0;
   assign vert_valid = (counter_y < (525 - 11) && counter_y >= 34)? 1:0;
   assign VGA_BLANK_N = hori_valid && vert_valid;
	assign VGA_CLK = clk25MHz;
	// end hsync and vsync output assignments

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// pattern generate
		always @ (posedge clk25MHz)
		begin
			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
			if (counter_y < 135)
				begin              
					r_red <= 8'hFF;    // white
					r_blue <= 8'hFF;
					r_green <= 8'hFF;
				end  // if (counter_y < 135)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
			else if (counter_y >= 135 && counter_y < 205)
				begin 
					if (counter_x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (counter_x < 324)
					else if (counter_x >= 324 && counter_x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 324 && counter_x < 604)
					else if (counter_x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 604)
					end  // else if (counter_y >= 135 && counter_y < 205)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 2
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 3
			else if (counter_y >= 205 && counter_y < 217)
				begin 
					if (counter_x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (counter_x < 324)
					else if (counter_x >= 324 && counter_x < 371)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 324 && counter_x < 371)
					else if (counter_x >= 371 && counter_x < 383)
						begin 
							r_red <= 8'h00;    // black
							r_blue <= 8'h00;
							r_green <= 8'h00;
						end  // else if (counter_x >= 371 && counter_x < 383)
					else if (counter_x >= 383 && counter_x < 545)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 383 && counter_x < 545)
					else if (counter_x >= 545 && counter_x < 557)
						begin 
							r_red <= 8'h00;    // black
							r_blue <= 8'h00;
							r_green <= 8'h00;
						end  // else if (counter_x >= 545 && counter_x < 557)
					else if (counter_x >= 557 && counter_x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 557 && counter_x < 604)
					else if (counter_x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 604)
				end  // else if (counter_y >= 205 && counter_y < 217)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
			else if (counter_y >= 217 && counter_y < 305)
				begin
					if (counter_x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (counter_x < 324)
					else if (counter_x >= 324 && counter_x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 324 && counter_x < 604)
					else if (counter_x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 604)	
				end  // else if (counter_y >= 217 && counter_y < 305)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 4
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
			else if (counter_y >= 305 && counter_y < 310)
				begin
					if (counter_x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (counter_x < 324)
					else if (counter_x >= 324 && counter_x < 371)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 324 && counter_x < 371)
					else if (counter_x >= 371 && counter_x < 557)
						begin 
							r_red <= 8'h00;    // black
							r_blue <= 8'h00;
							r_green <= 8'h00;
						end  // else if (counter_x >= 371 && counter_x < 557)
					else if (counter_x >= 557 && counter_x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 557 && counter_x < 604)
					else if (counter_x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 604)	
				end  // else if (counter_y >= 217 && counter_y < 305)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 5
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 6
			else if (counter_y >= 305 && counter_y < 414)
				begin
					if (counter_x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (counter_x < 324)
					else if (counter_x >= 324 && counter_x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 324 && counter_x < 604)
					else if (counter_x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (counter_x >= 604)	
				end  // else if (counter_y >= 305 && counter_y < 414)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 6
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 7
			else if (counter_y <= 414)
				begin              
					r_red <= 8'hFF;    // white
					r_blue <= 8'hFF;
					r_green <= 8'hFF;
				end  // if (counter_y >= 414)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 7
		end  // always
						
	// end pattern generate

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// color output assignments
	// only output the colors if the counters are within the adressable video time constraints
	assign VGA_R = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red : 8'hFF;
	assign VGA_B = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue : 8'hFF;
	assign VGA_G = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 8'hFF;
	// end color output assignments
	
endmodule  // VGA_image_gen