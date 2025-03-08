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

module bin2bcd
 #( parameter                W = 4)  // input width
  ( input      [W-1      :0] bin   ,  // binary
    output reg [W+(W-4)/3:0] bcd   ); // bcd {...,thousands,hundreds,tens,ones}

  integer i,j;

  always @(bin) begin
    for(i = 0; i <= W+(W-4)/3; i = i+1) bcd[i] = 0;     // initialize with zeros
    bcd[W-1:0] = bin;                                   // initialize with input vector
    for(i = 0; i <= W-4; i = i+1)                       // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1)                     // iterate on structure width
        if (bcd[W-i+4*j -: 4] > 4)                      // if > 4
          bcd[W-i+4*j -: 4] = bcd[W-i+4*j -: 4] + 4'd3; // add 3
  end

endmodule