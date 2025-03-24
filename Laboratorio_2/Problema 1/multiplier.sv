module multiplier
#(parameter N = 4)
( 
	input  logic clk,rst,
	input  logic [N-1:0] A, 
	input  logic [N-1:0] B, 
	output logic [N*2 +1 : 0] result
);

integer i, length;
assign last = N*2 -1;

always@(posedge clk or posedge rst)
	begin
		if (rst)
			begin
				result=0;
			end
		else 
			begin
				result[N*2 -1:N] = 0;
				result[N-1:0] = B;
				for (i=0;i<N;i=i+1)
					begin
						if(result[0]==1'b1)
							begin
								result[N*2: N]=result[N*2:N] + A;
								
							end
						result = result >> 1;
					end
			end
	end
endmodule