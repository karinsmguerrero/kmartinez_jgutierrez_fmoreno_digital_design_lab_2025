module modulo_nbit #(parameter N = 4) (
    input logic [N-1:0] dividend,
    input logic [N-1:0] divisor,
    output logic [N-1:0] remainder
);
    always_comb begin
        if (divisor == 0)
            remainder = 0; // Evita división por cero
        else
            remainder = dividend % divisor;
    end
endmodule
