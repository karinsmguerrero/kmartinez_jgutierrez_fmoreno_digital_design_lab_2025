/*Diseñe un decodificador que permita convertir un numero de 4 bits en binario a su respec-
tiva representaci´on en BCD (binary-coded decimal ), mediante modelo de comportamiento
en SystemVerilog. El diseño debe contemplar las tablas de verdad. No se permite el uso
de case para convertir el numero a BCD.*/

////////////////////////////////////////////////////////////////////////////////////
//                 bin2bcd.v:  Parametric  Binary to BCD Converter                // 
//                 Using Double Dabble / Shift and Add 3 Algorithm                //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

module BinToBCD
  ( input  logic [3      : 0] bin   ,  // binary
    output logic [11: 0] bcd); // bcd {...,thousands,hundreds,tens,ones}
	 

  integer i, shifts;
  logic done = 0;

	always @(bin) 
		begin
			for(i = 0; i <= 11 ; i=i+1) 
				begin
					// initialize with zeros
					bcd[i] = 0; 
				end
			
			bcd[3:0] = bin;
			shifts = 0;
			for(i = 0; i <= 8; i=i+1)
				begin
					if(shifts < 4) 
						begin
							if(bcd[7:4] > 4)
                            begin
                                bcd[7:4] = bcd[7:4] + 3;
                            end
							if(bcd[11:8] > 4)
                            begin
                                bcd[11:8] = bcd[11:8] + 3;
                            end
							bcd = bcd << 1;
							shifts = shifts + 1;
						end
					else 
						begin
							done = 1;
						end
				end
		end

endmodule