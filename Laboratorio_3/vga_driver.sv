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
	
	parameter imgSize = 24300;   // image data : 90 * 90 *3 bytes
	reg [7 : 0]   total_memory [0 : imgSize-1];// memory to store  8-bit data image
	initial begin
		$readmemh("./img/tile.hex",total_memory,0,imgSize-1);
	end			

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// pattern generate
		always @ (posedge clk25MHz)
		begin
			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
			if (y < 135)
				begin              
					r_red <= 8'hFF;    // white
					r_blue <= 8'hFF;
					r_green <= 8'hFF;
				end  // if (y < 135)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
			else if (y >= 135 && y < 205)
				begin 
					if (x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (x < 324)
					else if (x >= 324 && x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 324 && x < 604)
					else if (x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (x >= 604)
					end  // else if (y >= 135 && y < 205)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 2
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 3
			else if (y >= 205 && y < 217)
				begin 
					if (x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (x < 324)
					else if (x >= 324 && x < 371)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 324 && x < 371)
					else if (x >= 371 && x < 383)
						begin 
							r_red <= 8'h00;    // black
							r_blue <= 8'h00;
							r_green <= 8'h00;
						end  // else if (x >= 371 && x < 383)
					else if (x >= 383 && x < 545)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 383 && x < 545)
					else if (x >= 545 && x < 557)
						begin 
							r_red <= 8'h00;    // black
							r_blue <= 8'h00;
							r_green <= 8'h00;
						end  // else if (x >= 545 && x < 557)
					else if (x >= 557 && x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 557 && x < 604)
					else if (x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (x >= 604)
				end  // else if (y >= 205 && y < 217)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
			else if (y >= 217 && y < 305)
				begin
					if (x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (x < 324)
					else if (x >= 324 && x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 324 && x < 604)
					else if (x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (x >= 604)	
				end  // else if (y >= 217 && y < 305)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 4
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
			else if (y >= 305 && y < 310)
				begin
					if (x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (x < 324)
					else if (x >= 324 && x < 371)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 324 && x < 371)
					else if (x >= 371 && x < 557)
						begin 
							r_red <= 8'h00;    // black
							r_blue <= 8'h00;
							r_green <= 8'h00;
						end  // else if (x >= 371 && x < 557)
					else if (x >= 557 && x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 557 && x < 604)
					else if (x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (x >= 604)	
				end  // else if (y >= 217 && y < 305)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 5
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 6
			else if (y >= 305 && y < 414)
				begin
					if (x < 324)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // if (x < 324)
					else if (x >= 324 && x < 604)
						begin 
							r_red <= 8'hFF;    // yellow
							r_blue <= 8'h00;
							r_green <= 8'hFF;
						end  // else if (x >= 324 && x < 604)
					else if (x >= 604)
						begin 
							r_red <= 8'hFF;    // white
							r_blue <= 8'hFF;
							r_green <= 8'hFF;
						end  // else if (x >= 604)	
				end  // else if (y >= 305 && y < 414)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 6
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 7
			else if (y <= 414)
				begin              
					r_red <= 8'hFF;    // white
					r_blue <= 8'hFF;
					r_green <= 8'hFF;
				end  // if (y >= 414)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 7
		end  // always
						
	// end pattern generate

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// color output assignments
	// only output the colors if the counters are within the adressable video time constraints
	assign VGA_R = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_red : 8'hFF;
	assign VGA_B = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_blue : 8'hFF;
	assign VGA_G = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_green : 8'hFF;
	// end color output assignments
	
endmodule  // VGA_image_gen