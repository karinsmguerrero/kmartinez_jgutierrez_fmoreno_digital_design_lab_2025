module random_column_gen(
    input  logic clk,
    input  logic reset,
    input  logic trigger,
    output logic [2:0] random_col
);

    logic [2:0] counter;

    // Contador pseudoaleatorio (ciclo de 0 a 6)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 3'd0;
        else
            counter <= (counter == 3'd6) ? 3'd0 : counter + 3'd1;
    end

    // Captura el valor del contador cuando se activa el trigger
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            random_col <= 3'd0;
        else if (trigger)
            random_col <= counter;
    end

endmodule
