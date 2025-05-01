module vga_driver(
	input clk,           // 50 MHz
	output VGA_HS,      // horizontal sync
	output VGA_VS,	     // vertical sync
	output [7:0] VGA_R,
	output [7:0] VGA_B,
	output [7:0] VGA_G,
	output logic VGA_CLK
);

	clock_50_25 clk_divider(
		.rst(reset),
		.refclk(clk),
		.outclk_0(clk25MHz),
		.locked()
		);
		
	reg [9:0] CounterX;
	reg [8:0] CounterY;
	wire CounterXmaxed = (CounterX==767);

	always @(posedge clk25MHz)
	if(CounterXmaxed)
	  CounterX <= 0;
	else
	  CounterX <= CounterX + 1;

	always @(posedge clk25MHz)
	if(CounterXmaxed)
		 CounterY <= CounterY + 1;
		 
	reg vga_HS, vga_VS;
	always @(posedge clk25MHz)
	begin
	  vga_HS <= (CounterX[9:4]==0);   // active for 16 clocks
	  vga_VS <= (CounterY==0);   // active for 768 clocks
	end
	
	assign VGA_HS = vga_HS;
	assign VGA_VS = vga_VS;
	assign VGA_CLK = clk25MHz;
	
	assign VGA_R = CounterY[3] | (CounterX==256);
	assign VGA_G = (CounterX[5] ^ CounterX[6]) | (CounterX==256);
	assign VGA_B = CounterX[4] | (CounterX==256);
	 
endmodule