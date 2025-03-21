module divisor_nbit #(parameter N = 8) (
    input  logic [N-1:0] dividend,  // Dividendo
    input  logic [N-1:0] divisor,   // Divisor
    output logic [N-1:0] quotient,  // Cociente
    output logic [N-1:0] remainder  // Residuo
);

    always_comb begin
        if (divisor != 0) begin
            quotient  = dividend / divisor;
            remainder = dividend % divisor;
        end else begin
            quotient  = '0;  // Si el divisor es 0, resultado indefinido
            remainder = '0;
        end
    end

endmodule
