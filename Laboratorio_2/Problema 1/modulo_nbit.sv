module modulo_nbit #(parameter N = 4) (
    input logic [N-1:0] dividend,
    input logic [N-1:0] divisor,
    output logic [N-1:0] remainder,
    output logic Z, neg
);
    always_comb begin
        if (divisor == 0)
            remainder = 0;
        else
            remainder = dividend % divisor;
    end

    assign Z = (remainder == 0);
    assign neg = remainder[N-1];

endmodule
