module multiplier_nbit
#(parameter N = 4)
( 
	input  logic clk,rst,
	input  logic [N-1:0] A, 
	input  logic [N-1:0] B, 
	output logic [N-1:0] result,
	output logic overflow, zero, carry_out, negative
);

integer i;
logic [N*2: 0] S;

always@(posedge clk or posedge rst)
	begin
		if (rst)
			begin
				result=0;
				S=0;
				overflow=0;
				zero = 0;
				carry_out = 0;
				negative = 0;
			end
		else 
			begin
				S[N*2 -1:N] = 0;
				S[N-1:0] = B;
				negative = 0;
				for (i=0;i<N;i=i+1)
					begin
						if(S[0]==1'b1)
							begin
								S[N*2: N]=S[N*2 -1:N] + A;
								
							end
						S = S >> 1;
					end
				if(S[N*2 -1:N] === 0)
					begin
						overflow = 0;
						carry_out = 0;
						result = S[N-1:0];
						if(result === 0)
							begin
								zero = 1;
							end
						else
							zero = 0;
					end
				else
					begin
						overflow = 1;
						carry_out = 1;
						result = S[N-1:0];
						if(result === 0)
							begin
								zero = 1;
							end
						else
							zero = 0;
					end
			end
	end
endmodule