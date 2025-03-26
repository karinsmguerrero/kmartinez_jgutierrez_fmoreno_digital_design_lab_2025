module main #(parameter N = 4) (
		///////// CLOCK /////////
      input              CLOCK_50,

      ///////// KEY /////////
      input    [ 3: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LED /////////
      output   [ 9: 0]   LEDR,

      ///////// Seg7 /////////
      output   [ 6: 0]   HEX0,
      output   [ 6: 0]   HEX1,
      output   [ 6: 0]   HEX2,
      output   [ 6: 0]   HEX3,
      output   [ 6: 0]   HEX4,
      output   [ 6: 0]   HEX5
);

//--------- RESULT REGISTERS -----------
logic [N-1:0] multiplication, division, substraction, addition;


//--------- MODULE FLAGS -----------
logic cin, cout;
logic Z_rest, N_rest, V_rest, C_rest;  		// Substraction
logic Z_mult, N_mult, V_mult, C_mult;        // Multiplication

integer counter = 0;

// Instancias de los módulos
multiplier_nbit #(.N(4)) mult_inst(
  .clk(CLOCK_50),
  .rst(SW[9]),
  .A(SW[3:0]), 
  .B(SW[7:4]),
  .result(multiplication),
  .overflow(V_mult),
  .zero(Z_mult),
  .carry_out(C_mult),
  .negative(N_mult)
);


restador_nbit #(.N(4)) u_restador (
  .A(SW[3:0]), 
  .B(SW[7:4]),
  .Cin(cin),
  .D(substraction),
  .Cout_rest(C_rest), 
  .Z(Z_rest), 
  .neg(N_rest), 
  .V(V_rest)
);

//--------- GLOBAL FLAGS -----------
logic overflow, negative, zero, carry_out;
assign LEDR[0] = overflow; 
assign LEDR[1] = negative;
assign LEDR[2] = zero;
assign LEDR[3] = carry_out;

//--------- SEVEN SEGMENT INITIALIZATION -----------
logic [3:0] seg_0, seg_1, seg_2, seg_3, seg_4, seg_5;
seven_segment_driver seg0(seg_0, HEX0);
seven_segment_driver seg1(seg_1, HEX1);
seven_segment_driver seg2(seg_2, HEX2);
seven_segment_driver seg3(seg_3, HEX3);
seven_segment_driver seg4(seg_4, HEX4);
seven_segment_driver seg5(seg_5, HEX5);

//--------- OPERATION SELECTION -----------
always@(posedge CLOCK_50 or negedge KEY[0])
	begin
		if(!KEY[0])
			 begin
				seg_1 = 4'b1000;
				counter = counter + 1;
				if(counter > 3)
					counter = 0;
			 end
		case(counter)
			1'd0:	begin
					carry_out = C_mult;
					zero = Z_mult;
					negative = N_mult;
					overflow = V_mult;
					seg_0 = multiplication[3:0];
					seg_1 = 4'b1111;
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
					seg_4 = 4'b1111;
					seg_5 = 4'b1111;
				end
			1'd1:	begin
					carry_out = C_rest;
					zero = Z_rest;
					negative = N_rest;
					overflow = V_rest;
					seg_0 = substraction[3:0];
					seg_1 = 4'b1111;
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
					seg_4 = 4'b1111;
					seg_5 = 4'b1111;
				end
			default: begin
					carry_out = 0;
					zero = 0;
					negative = 0;
					overflow = 0;
					seg_0 = 4'b1111;
					seg_1 = 4'b1111;
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
					seg_4 = 4'b1111;
					seg_5 = 4'b1111;
				end
		endcase
	end



endmodule