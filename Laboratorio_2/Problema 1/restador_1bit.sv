module restador_1bit (
    input  logic A,       // Minuendo
    input  logic B,       // Sustraendo
    input  logic Cin,     // Acarreo de entrada (préstamo)
    output logic D,       // Diferencia
    output logic Cout_rest     // Acarreo de salida (préstamo)
);
    assign D = A ^ B ^ Cin; 
    assign Cout_rest = (~A & B) | ((A ^ B) & Cin);
endmodule
