module pseudo_random (
    input  logic        clk,
    input  logic        reset,
    output logic [2:0]  rand_col
);
    logic [2:0] counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 3'd0;
        else
            counter <= (counter == 3'd6) ? 3'd0 : counter + 1;
    end

    assign rand_col = counter;
endmodule
