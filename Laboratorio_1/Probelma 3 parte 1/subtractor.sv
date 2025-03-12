module subtractor #(parameter N = 6) (
    input logic clk,
    input logic rst,        // Reset activo en bajo
    input logic dec_btn,    // Botón para decrementar (activo en bajo)
    input logic [N-1:0] init, // Switches para establecer el valor inicial
    output logic [N-1:0] count
);

    logic dec_btn_prev; // Almacena el estado anterior del botón

    always_ff @(posedge clk) begin
        if (!rst)
            count <= init;   // Cuando rst se activa (bajo), se toma el valor de los switches
        else if (dec_btn_prev && !dec_btn) // Detecta flanco de bajada (1 → 0)
            count <= count - 1;

        // Guardamos el estado anterior del botón
        dec_btn_prev <= dec_btn;
    end
endmodule
