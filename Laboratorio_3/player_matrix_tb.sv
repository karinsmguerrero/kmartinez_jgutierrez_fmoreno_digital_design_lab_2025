module player_matrix_tb;

logic [1:0] x, y, value;

player_matrix matrix(.x(x), .y(y), .value(value));

initial begin
	x = 0;
	y = 0;
	display("Value %d: ", value);
	
	x = 1;
	y = 0;
	display("Value %d: ", value);
	
	x = 2;
	y = 0;
	display("Value %d: ", value);
end
endmodule