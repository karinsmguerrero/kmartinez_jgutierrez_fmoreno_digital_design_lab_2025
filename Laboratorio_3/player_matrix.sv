module player_matrix(
	input logic [1:0] x, y,
	output logic [1:0] value
);
logic [5:0][6:0][1:0] tiles;
assign tiles = {{2'd0,2'd2,2'd0,2'd1,2'd1,2'd0,2'd0},
					 {2'd0,2'd2,2'd0,2'd1,2'd0,2'd1,2'd0},
					 {2'd0,2'd2,2'd0,2'd1,2'd0,2'd2,2'd0},
					 {2'd0,2'd2,2'd0,2'd2,2'd0,2'd1,2'd0},
					 {2'd0,2'd1,2'd0,2'd2,2'd0,2'd1,2'd0},
					 {2'd0,2'd1,2'd1,2'd2,2'd0,2'd1,2'd1}};
					 
assign value = tiles[y][x];
endmodule