module lfsr_3bit (
    input  logic clk,
    input  logic reset,
    output logic [2:0] rnd_col
);
    logic [2:0] lfsr;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            lfsr <= 3'b001;
        else
            lfsr <= {lfsr[1] ^ lfsr[0], lfsr[2], lfsr[1]};
    end

    assign rnd_col = lfsr % 7; // Para limitarlo a columnas 0-6
endmodule
