module shift_right_nbit #(parameter N = 4) (
    input logic [N-1:0] A,
    input logic [$clog2(N):0] shift_amount,
    output logic [N-1:0] Y,
    output logic Z, neg
);
    assign Y = A >> shift_amount;
    assign Z = (Y == 0);
    assign neg = Y[N-1];
endmodule
