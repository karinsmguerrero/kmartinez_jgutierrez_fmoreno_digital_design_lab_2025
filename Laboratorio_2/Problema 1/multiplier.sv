module multiplier
#(parameter N = 4)
( 
	input  logic clk,rst,
	input  logic [N-1:0] A, 
	input  logic [N-1:0] B, 
	output logic [N-1:0] result,
	output logic overflow_mutli
);

integer i;
logic [N*2: 0] S;

always@(posedge clk or posedge rst)
	begin
		if (rst)
			begin
				result=0;
				S=0;
				overflow_mutli=0;
			end
		else 
			begin
				S[N*2 -1:N] = 0;
				S[N-1:0] = B;
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
						overflow_mutli = 0;
						result = S[N-1:0];
					end
				else
					begin
						overflow_mutli = 1;
						result = S[N-1:0];
					end
			end
	end
endmodule