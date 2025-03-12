////////////////////////////////////////////////////////////////////////////////////
//          bin2bcd_test.v: Test  circuit for  the binary to BCD circuit          //
//                          Using DE2-115 Development board / Cyclone IV          //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

module BinToBCD_tb();

	logic [3:0] bin;
	logic [11:0] bcd;

	BinToBCD dut(bin, bcd);

	initial begin  
		bin = 4'b0000;
		#40
		assert (bcd[11:4] == 8'b00000000) $display ("Passed");
		else $error("Failed: 0");
		
		bin = 4'b0001;
		#40
		assert (bcd[11:4] == 8'b00000001) $display ("Passed");
		else $error("Failed: 1");
		
		bin = 4'b0010;
		#40
		assert (bcd[11:4] == 8'b00000010) $display ("Passed");
		else $error("Failed: 2");
		
		bin = 4'b0011;
		#40
		assert (bcd[11:4] == 8'b00000011) $display ("Passed");
		else $error("Failed: 3");
		
		bin = 4'b0100;
		#40
		assert (bcd[11:4] == 8'b00000100) $display ("Passed");
		else $error("Failed: 4");
		
		bin = 4'b0101;
		#40
		assert (bcd[11:4] == 8'b00000101) $display ("Passed");
		else $error("Failed: 5");
		
		bin = 4'b0110;
		#40
		assert (bcd[11:4] == 8'b00000110) $display ("Passed");
		else $error("Failed: 6");
		
		bin = 4'b0111;
		#40
		assert (bcd[11:4] == 8'b00000111) $display ("Passed");
		else $error("Failed: 7");
		
		bin = 4'b1000;
		#40
		assert (bcd[11:4] == 8'b00001000) $display ("Passed");
		else $error("Failed: 8");
		
		bin = 4'b1001;
		#40
		assert (bcd[11:4] == 8'b00001001) $display ("Passed");
		else $error("Failed: 9");
		
		bin = 4'b1010;
		#40
		assert (bcd[11:4] == 8'b00010000) $display ("Passed");
		else $error("Failed: 10");
		
		bin = 4'b1100;
		#40
		assert (bcd[11:4] == 8'b00010010) $display ("Passed");
		else $error("Failed: 11");
		
		bin = 4'b1101;
		#40
		assert (bcd[11:4] == 8'b00010011) $display ("Passed");
		else $error("Failed: 12");
		
		bin = 4'b1110;
		#40
		assert (bcd[11:4] == 8'b00010100) $display ("Passed");
		else $error("Failed: 13");
		
		bin = 4'b1111;
		#40
		assert (bcd[11:4] == 8'b00010101) $display ("Passed");
		else $error("Failed: 14");
		
	end
endmodule

/*
0 | 0000
1 | 0001
2 | 0010
3 | 0011
4 | 0100
5 | 0101
6 | 0110
7 | 0111
8 | 1001
9 | 1001
*/