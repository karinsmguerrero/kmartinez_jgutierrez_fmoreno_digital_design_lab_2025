module connect_4_game(	
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
	
logic clk25MHz;

// clk divider 50 MHz to 25 MHz
clock_50_25 clk_divider(
	.rst(reset),
	.refclk(clk),
	.outclk_0(clk25MHz),
	.locked()
	); 

assign VGA_CLK = clk25MHz;	

logic [0:5][0:6][1:0] tiles;

// Holds the current state of the player´s tokens
assign tiles = {{2'd0,2'd2,2'd0,2'd1,2'd1,2'd0,2'd0},
					 {2'd0,2'd2,2'd0,2'd1,2'd0,2'd1,2'd0},
					 {2'd0,2'd2,2'd0,2'd1,2'd0,2'd2,2'd0},
					 {2'd0,2'd2,2'd0,2'd2,2'd0,2'd1,2'd0},
					 {2'd0,2'd1,2'd0,2'd2,2'd0,2'd1,2'd0},
					 {2'd0,2'd1,2'd1,2'd2,2'd0,2'd1,2'd1}};
			 
vga_driver driver(
	.reset(reset),
	.tiles(tiles),
	.VGA_HS(VGA_HS),      
	.VGA_VS(VGA_VS),	    
	.VGA_R(VGA_R),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G), 
	.VGA_CLK(VGA_CLK), 
	.VGA_BLANK_N(VGA_BLANK_N)
);

endmodule