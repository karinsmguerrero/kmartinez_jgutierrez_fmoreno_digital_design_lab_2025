module top_module #(parameter N = 4) (
    input logic [N-1:0] A, B, 
    input logic Cin,  // Acarreo de entrada para el restador
    input logic [$clog2(N):0] shift_amount,
    output logic [N-1:0] D, quotient, remainder,  // Salidas del restador y divisor
    output logic Cout,  // Acarreo de salida del restador
    output logic [N-1:0] and_out, or_out, xor_out, shift_left_out, shift_right_out
);

    // Instancias de los módulos existentes
    restador_nbit #(.N(N)) u_restador (.A(A), .B(B), .Cin(Cin), .D(D), .Cout(Cout));
    divisor_nbit #(.N(N)) u_divisor (.dividend(A), .divisor(B), .quotient(quotient), .remainder(remainder));

    // Instancias de los nuevos módulos
    and_nbit #(.N(N)) u_and (.A(A), .B(B), .Y(and_out));
    or_nbit #(.N(N)) u_or (.A(A), .B(B), .Y(or_out));
    xor_nbit #(.N(N)) u_xor (.A(A), .B(B), .Y(xor_out));
    shift_left_nbit #(.N(N)) u_shift_left (.A(A), .shift_amount(shift_amount), .Y(shift_left_out));
    shift_right_nbit #(.N(N)) u_shift_right (.A(A), .shift_amount(shift_amount), .Y(shift_right_out));

endmodule
