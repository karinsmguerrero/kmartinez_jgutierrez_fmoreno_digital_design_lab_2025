module sumador_1bit (
    input  logic A,       // Operando A
    input  logic B,       // Operando B
    input  logic Cin,     // Acarreo de entrada
    output logic S,       // Suma (bit resultante)
    output logic Cout     // Acarreo de salida
);
    assign S = A ^ B ^ Cin; 
    assign Cout = (A & B) | (A & Cin) | (B & Cin); 
endmodule
