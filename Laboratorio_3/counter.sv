module counter #(parameter N = 8)(
	input logic rst, clk, enable,
	output logic [N-1:0] Q
);

always_ff @(negedge clk or posedge rst)
	if(rst) Q = 8'b0;
	else if(enable) Q = Q + 1'b1;

endmodule