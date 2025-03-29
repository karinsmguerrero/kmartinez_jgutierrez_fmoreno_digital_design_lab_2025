module sumador_nbit #(parameter N = 4)(
    input logic [N-1:0] A, 
    input logic [N-1:0] B,
    input logic Cin,
    output logic [N-1:0] Sum,
    output logic Cout,
    output logic overflow
);

    logic [N:0] carry; 
    assign carry[0] = Cin;

    // Implementación bit a bit sin el uso de '+'
    always_comb begin
        for (int i = 0; i < N; i++) begin
            // Suma de cada bit: Sum = A ^ B ^ carry_in
            Sum[i] = A[i] ^ B[i] ^ carry[i];
            // Calculo del carry siguiente: carry_out = (A & B) | (A & carry_in) | (B & carry_in)
            carry[i+1] = (A[i] & B[i]) | (A[i] & carry[i]) | (B[i] & carry[i]);
        end
    end

    assign Cout = carry[N];
    // Overflow: cuando el carry del bit más significativo es distinto al carry del bit anterior
    assign overflow = carry[N] ^ carry[N-1];

endmodule
