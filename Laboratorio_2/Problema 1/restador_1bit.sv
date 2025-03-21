module restador_1bit (
    input  logic A,       // Minuendo
    input  logic B,       // Sustraendo
    input  logic Cin,     // Acarreo de entrada (préstamo)
    output logic D,       // Diferencia
    output logic Cout     // Acarreo de salida (préstamo)
);
    assign D = A ^ B ^ Cin; 
    assign Cout = (~A & B) | ((A ^ B) & Cin);
endmodule
