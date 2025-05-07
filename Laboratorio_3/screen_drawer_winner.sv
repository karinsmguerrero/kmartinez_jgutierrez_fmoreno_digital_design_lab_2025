module screen_drawer_winner(
	input  logic [9:0] x,y,
	input  logic clk,
	input  logic [2:0] player,
	output logic [23:0] rgb_color
);

parameter offset_x = 184;
parameter offset_y = 54;
parameter hori_back  = 144;
parameter vert_back  = 34;

always @ (posedge clk)
		begin
			// First row
			if(y > 54 && y <= 674)
				begin
					//First col
					if(x >= 184 && x < 674) begin
						//Checks if the position has a token and its color
						if(player == 2'b01)
							rgb_color <= 24'hED1B24;
						else 
						   rgb_color <= 24'hFFC90D;
					end
					else
						rgb_color <= 24'hFFFFFF;
				end
			//Border
			else
				rgb_color = 24'hFFFFFF;
		end
endmodule