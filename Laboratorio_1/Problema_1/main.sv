module main( 

		//input   logic [ 3: 0]   bin,  
      ///////// Seg7 /////////
      output  logic [ 6: 0]   HEX0,
      output  logic [ 6: 0]   HEX1,
		
		///////// SW /////////
      input    [ 9: 0]   SW,
		
		///////// KEY /////////
      //input    [ 3: 0]   KEY
); 

	logic [11:0] bcd;
	
	//BinToBCD converter(bin, bcd); 
	BinToBCD converter(SW[3:0], bcd);
	seven_segment_driver seg0(bcd[3:0], HEX0);
	seven_segment_driver seg1(bcd[7:4], HEX1);
	 
endmodule