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
	// position counter and sync generation	
	video_sync_generator video_sync (
		.vga_clk(VGA_CLK),
      .reset(reset),
		.blank_n(VGA_BLANK_N),
		.HS(VGA_HS),
		.VS(VGA_VS));
		
	counter #(10) counter_x(.clk(clk25MHz), .enable(1), .reset(reset), .max(x_max), .done(done), .q(x));
	counter #(10) counter_y(.clk(clk25MHz), .enable(done), .reset(reset), .max(y_max), .done(), .q(y));
	

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// pattern generate
	logic [23:0] rgb_color;
          
	screen_drawer screen( 
		.x(x), 
		.y(y), 
		.clk(VGA_CLK), 
		.rgb_color(rgb_color));
	
	assign VGA_R = rgb_color[23:16];
	assign VGA_G = rgb_color[15:8];
	assign VGA_B = rgb_color[7:0];
	
	
endmodule  // VGA_image_gen