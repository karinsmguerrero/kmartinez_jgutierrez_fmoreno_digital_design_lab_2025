module ALU_Time_Analisis #(parameter N = 32) (
    input logic clk, rst,                   
    output logic [N-1:0] result,
    output logic N_flag, Z_flag, C_flag, V_flag
);

    logic [N-1:0] reg_A, reg_B;
    logic Cin;
    logic [$clog2(N):0] shift_amount;

    // Registro A y B con valores de prueba (usando el reloj para sincronizar)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_A <= 4'b1010;
            reg_B <= 4'b0101;
            Cin <= 1'b0;
            shift_amount <= 0;
        end else begin
            reg_A <= reg_A; 
            reg_B <= reg_B;
            Cin <= Cin;
            shift_amount <= shift_amount;
        end
    end

    // Instancia de la ALU 
    alu #(N) u_alu (
        .A(reg_A),
        .B(reg_B),
        .Cin(Cin),
        .shift_amount(shift_amount),
        .clk(clk),       
        .rst(rst),

       
        .D(result),       
        .quotient(),
        .remainder(),     
        .mod_out(),      
        .Cout_rest(C_flag),
        .Z_rest(Z_flag),
        .N_rest(N_flag),
        .V_rest(V_flag),
        .Z_div(),         
        .N_div(),         
        .Z_mod(),        
        .N_mod(),        
        .Z_and(),         
        .N_and(),         
        .Z_or(),          
        .N_or(),          
        .Z_xor(),        
        .N_xor(),       
        .Z_shl(),        
        .N_shl(),       
        .Z_shr(),       
        .N_shr(),         
        .Z_mult(),        
        .N_mult(),       
        .C_mult(),        
        .V_mult(),       
        .and_out(),       
        .or_out(),        
        .xor_out(),       
        .shift_left_out(),
        .shift_right_out(),
        .mult_out(),     
        .sum_out(),       
        .carry_out_sum(),
        .overflow_sum()   
    );

endmodule
