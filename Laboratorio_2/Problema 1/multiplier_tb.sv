module multiplier_tb;
	logic clk, rst;
	logic [3:0] A;
	logic [3:0] B;
	wire [8:0] result;

	multiplier dut(clk, rst, A, B, result);


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
		assert (result[8:0] == 9'b000001010) $display ("Passed");
		else $error("Failed: 1");
		rst = 1;
		#5;
		
		rst = 0;
		A = 4'b1011;
		B = 4'b0010;
		#50;
		assert (result[8:0] == 9'b000010110) $display ("Passed");
		else $error("Failed: 2");
		rst = 1;
		#5;
		
		rst = 0;
		A = 4'b1001;
		B = 4'b0101;
		#50;
		assert (result[8:0] == 9'b000101101) $display ("Passed");
		else $error("Failed: 3");
	end
endmodule