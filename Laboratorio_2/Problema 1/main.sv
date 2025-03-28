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
logic [N-1:0] multiplication, division, substraction, addition, remainder, mod_out;
logic [N-1:0] and_out, or_out, xor_out, shift_left_out, shift_right_out;


//--------- MODULE FLAGS -----------
logic cin, cout;
logic Z_rest, N_rest, V_rest, C_rest;  		// Substraction
logic Z_mult, N_mult, V_mult, C_mult;        // Multiplication
logic Z_add = 0, V_add, C_sum, cin_add;		// Addition 
logic Z_div, N_div;                  			// Division
logic Z_mod, N_mod;                    		// Module
logic Z_and, N_and;                    		// AND
logic Z_or, N_or;                      		// OR
logic Z_xor, N_xor;                    		// XOR
logic Z_shl, N_shl;                    		// Shift Left
logic Z_shr, N_shr;                    		// Shift Right

//--------- ALU MODULE INSTANTIATION -----------
sumador_parametrizable #(.WIDTH(N)) u_sumador (
  .A(SW[3:0]), 
  .B(SW[7:4]),
  .Cin(cin_Add), 
  .S(addition),
  .carry_out(C_add),
  .overflow_suma(V_add)
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

divisor_nbit #(.N(N)) u_divisor (
  .dividend(SW[3:0]), 
  .divisor(SW[7:4]),
  .quotient(division),
  .remainder(remainder),
  .Z(Z_div),
  .neg(N_div)
);

modulo_nbit #(.N(N)) u_modulo (
  .dividend(SW[3:0]),
  .divisor(SW[7:4]),
  .remainder(mod_out),
  .Z(Z_mod),
  .neg(N_mod)
);

and_nbit #(.N(N)) u_and (
  .A(SW[3:0]), 
  .B(SW[7:4]),
  .Y(and_out),
  .Z(Z_and), 
  .neg(N_and)
);

or_nbit #(.N(N)) u_or (
  .A(SW[3:0]), 
  .B(SW[7:4]),
  .Y(or_out),
  .Z(Z_or), 
  .neg(N_or)
);

xor_nbit #(.N(N)) u_xor (
  .A(SW[3:0]), 
  .B(SW[7:4]),
  .Y(xor_out),
  .Z(Z_xor), 
  .neg(N_xor)
);

shift_left_nbit #(.N(N)) u_shift_left (
  .A(SW[3:0]), 
  .shift_amount(SW[7:4]), 
  .Y(shift_left_out),
  .Z(Z_shl), 
  .neg(N_shl)
);

shift_right_nbit #(.N(N)) u_shift_right (
  .A(SW[3:0]), 
  .shift_amount(SW[7:4]), 
  .Y(shift_right_out),
  .Z(Z_shr), 
  .neg(N_shr)
);


//--------- GLOBAL FLAGS -----------
logic overflow, negative, zero, carry_out;
assign LEDR[0] = overflow; 
assign LEDR[1] = negative;
assign LEDR[2] = zero;
assign LEDR[3] = carry_out;

//--------- SEVEN SEGMENT INITIALIZATION -----------
logic [3:0] seg_0, seg_1, seg_2, seg_3, seg_4 = 0, seg_5 = 0;
seven_segment_driver seg0(seg_0, HEX0);
seven_segment_driver seg1(seg_1, HEX1);
seven_segment_driver seg2(seg_2, HEX2);
seven_segment_driver seg3(seg_3, HEX3);
seven_segment_driver seg4(seg_4, HEX4);
seven_segment_driver seg5(seg_5, HEX5);

//--------- OTHERS -----------
logic [3:0] counter = 0;
logic [3:0] result = 0;
logic [11:0] bcd_op, bcd_res;
logic sel_btn_prev;

BinToBCD op_converter(counter, bcd_op);
BinToBCD res_converter(result, bcd_res);

//--------- OPERATION SELECTION -----------
always@(posedge CLOCK_50)
	begin
		seg_4 = bcd_op[7:4];
		seg_5 = bcd_op[11:8];

		//if(!KEY[0])
		if (sel_btn_prev && !KEY[0]) // Detecta flanco de bajada (1 → 0)
			 begin
				counter = counter + 1;
				if(counter > 9)
					counter = 0;
			 end
		sel_btn_prev <= KEY[0];
		case(counter)
			4'b0000:	begin
					carry_out = C_add;
					zero = Z_add;
					negative = 0;
					overflow = V_add;
					result = addition[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b0001:	begin
					carry_out = C_rest;
					zero = Z_rest;
					negative = N_rest;
					overflow = V_rest;
					result = substraction[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b0010:	begin
					carry_out = C_mult;
					zero = Z_mult;
					negative = N_mult;
					overflow = V_mult;
					result = multiplication[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b0011:	begin
					carry_out = 0; 
					zero = Z_div;
					negative = N_div;
					overflow = 0; 
					result = division[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = remainder[3:0];
					seg_3 = 4'b0000;
				end
			4'b0100:	begin
					carry_out = 0;
					zero = Z_mod;
					negative = 0;
					overflow = 0;
					result = mod_out[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b0101:	begin
					carry_out = 0;
					zero = Z_and;
					negative = N_and;
					overflow = 0;
					result = and_out[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b0110:	begin
					carry_out = 0;
					zero = Z_or;
					negative = N_or;
					overflow = 0;
					result = or_out[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b0111:	begin
					carry_out = 0;
					zero = Z_xor;
					negative = N_xor;
					overflow = 0;
					result = xor_out[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b1000:	begin
					carry_out = 0;
					zero = Z_shl;
					negative = N_shl;
					overflow = 0;
					result = shift_left_out[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
				end
			4'b1001:	begin
					carry_out = 0;
					zero = Z_shr;
					negative = N_shr;
					overflow = 0;
					result = shift_right_out[3:0];
					seg_0 = bcd_res[7:4];
					seg_1 = bcd_res[11:8];
					seg_2 = 4'b1111;
					seg_3 = 4'b1111;
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