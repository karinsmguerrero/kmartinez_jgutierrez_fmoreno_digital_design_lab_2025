module subtractor_tb;
    
    parameter N1 = 2;
    parameter N2 = 4;
    parameter N3 = 6;
    
    logic clk, rst, dec_btn;
    logic [N1-1:0] init2, count2;
    logic [N2-1:0] init4, count4;
    logic [N3-1:0] init6, count6;

    // Instancias del restador para N=2, N=4 y N=6
    subtractor #(N1) uut2 (.clk(clk), .rst(rst), .dec_btn(dec_btn), .init(init2), .count(count2));
    subtractor #(N2) uut4 (.clk(clk), .rst(rst), .dec_btn(dec_btn), .init(init4), .count(count4));
    subtractor #(N3) uut6 (.clk(clk), .rst(rst), .dec_btn(dec_btn), .init(init6), .count(count6));

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        dec_btn = 1;

        // Casos de prueba para diferentes valores de N

        // Test para N=2
        init2 = 2'b11; // Inicializa en 3
        #10 rst = 0;   // Aplicar reset
        #10 rst = 1;   // Liberar reset
        repeat (4) begin
            #10 dec_btn = 0; #10 dec_btn = 1; // Pulsar decremento
            assert (count2 == count2 - 1) else $error("ERROR en N=2: %b", count2);
        end

        // Test para N=4
        init4 = 4'b1101; // Inicializa en 13
        #10 rst = 0;
        #10 rst = 1;
        repeat (6) begin
            #10 dec_btn = 0; #10 dec_btn = 1;
            assert (count4 == count4 - 1) else $error("ERROR en N=4: %b", count4);
        end

        // Test para N=6
        init6 = 6'b101010; // Inicializa en 42
        #10 rst = 0;
        #10 rst = 1;
        repeat (8) begin
            #10 dec_btn = 0; #10 dec_btn = 1;
            assert (count6 == count6 - 1) else $error("ERROR en N=6: %b", count6);
        end
        
        $display("✅ Test completado con éxito para N=2, N=4 y N=6.");
        $stop;
    end
endmodule
