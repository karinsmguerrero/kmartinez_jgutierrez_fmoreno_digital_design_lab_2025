module counter #(parameter N) (
	input clk,
	input enable,
	input reset, 
	input [N-1:0] max,
	output done,
	output reg [N-1:0] q
);

assign done = (q == max);

always @(posedge clk) begin
	if(reset)
		q <= 0;
	else begin
		if(enable) begin
			if (q==max) begin
				q <= 0;
			end else begin
				q <= q+1;
			end
		end
	end
end

endmodule