module xor_nbit #(parameter N = 4) (
    input logic [N-1:0] A, B,
    output logic [N-1:0] Y,
    output logic Z, neg
);
    assign Y = A ^ B;
    assign Z = (Y == 0);
    assign neg = Y[N-1];
endmodule
