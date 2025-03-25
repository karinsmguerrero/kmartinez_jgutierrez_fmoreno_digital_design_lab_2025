module xor_nbit #(parameter N = 4) (
    input logic [N-1:0] A, B,
    output logic [N-1:0] Y
);
    assign Y = A ^ B;
endmodule
