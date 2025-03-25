module multiplier_tb;
	logic clk, rst, overflow;
	logic [3:0] A;
	logic [3:0] B;
	logic [3:0] result;

	multiplier dut(clk, rst, A, B, result, overflow);


	// Generador de reloj
	always #5 clk = ~clk;

	initial begin
		clk = 0;
		rst = 1;
		#5;
		
		rst = 0;
		A = 4'b0101;
		B = 4'b0010;
		#50;
		assert (result[3:0] == 4'b1010) $display ("Passed");
		else $error("Failed: 1");
		rst = 1;
		#5;
		
		rst = 0;
		A = 4'b1011;
		B = 4'b0010;
		#50;
		assert (result[3:0] == 4'b0110) $display ("Passed");
		else $error("Failed: 2");
		rst = 1;
		#5;
		
		rst = 0;
		A = 4'b1001;
		B = 4'b0101;
		#50;
		assert (result[3:0] == 4'b1101) $display ("Passed");
		else $error("Failed: 3");
		rst = 1;
		#5;
		
		rst = 0;
		A = 4'b1111;
		B = 4'b1111;
		#50;
		assert (result[3:0] == 4'b0001) $display ("Passed");
		else $error("Failed: 4");
		rst = 1;
		//#5;
	end
endmodule