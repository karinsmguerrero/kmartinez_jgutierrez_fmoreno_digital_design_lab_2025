module divisor_nbit #(parameter N = 8) (
    input  logic [N-1:0] dividend,  
    input  logic [N-1:0] divisor,   
    output logic [N-1:0] quotient,  
    output logic [N-1:0] remainder,
    output logic Z, neg
);

    always_comb begin
        if (divisor != 0) begin
            quotient  = dividend / divisor;
            remainder = dividend % divisor;
        end else begin
            quotient  = '0;  
            remainder = '0;
        end
    end

    // Calcular flags
    assign Z = (quotient == 0);
    assign neg = quotient[N-1];

endmodule
