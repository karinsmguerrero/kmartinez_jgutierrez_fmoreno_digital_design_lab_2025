module top_module #(parameter N = 4) (
    input logic [N-1:0] A, B, 
    input logic Cin,  
    input logic [$clog2(N):0] shift_amount,
    output logic [N-1:0] D, quotient, remainder, mod_out,  
    output logic Cout,  
    output logic Z_rest, N_rest, V_rest, C_rest,  // Flags de la resta
    output logic Z_div, N_div,                    // Flags de la división
    output logic Z_mod, N_mod,                    // Flags del módulo
    output logic Z_and, N_and,                    // Flags AND
    output logic Z_or, N_or,                      // Flags OR
    output logic Z_xor, N_xor,                    // Flags XOR
    output logic Z_shl, N_shl,                    // Flags Shift Left
    output logic Z_shr, N_shr,                    // Flags Shift Right
    output logic [N-1:0] and_out, or_out, xor_out, shift_left_out, shift_right_out
);

    // Instancias de los módulos
    restador_nbit #(.N(N)) u_restador (
        .A(A), .B(B), .Cin(Cin), .D(D), .Cout(C_rest), 
        .Z(Z_rest), .neg(N_rest), .V(V_rest)
    );

    divisor_nbit #(.N(N)) u_divisor (
        .dividend(A), .divisor(B), .quotient(quotient), .remainder(remainder),
        .Z(Z_div), .neg(N_div)
    );

    modulo_nbit #(.N(N)) u_modulo (
        .dividend(A), .divisor(B), .remainder(mod_out),
        .Z(Z_mod), .neg(N_mod)
    );

    and_nbit #(.N(N)) u_and (
        .A(A), .B(B), .Y(and_out),
        .Z(Z_and), .neg(N_and)
    );

    or_nbit #(.N(N)) u_or (
        .A(A), .B(B), .Y(or_out),
        .Z(Z_or), .neg(N_or)
    );

    xor_nbit #(.N(N)) u_xor (
        .A(A), .B(B), .Y(xor_out),
        .Z(Z_xor), .neg(N_xor)
    );

    shift_left_nbit #(.N(N)) u_shift_left (
        .A(A), .shift_amount(shift_amount), .Y(shift_left_out),
        .Z(Z_shl), .neg(N_shl)
    );

    shift_right_nbit #(.N(N)) u_shift_right (
        .A(A), .shift_amount(shift_amount), .Y(shift_right_out),
        .Z(Z_shr), .neg(N_shr)
    );

endmodule
