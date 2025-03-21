module tb_top_module;
    logic [3:0] A, B, dividend, divisor;
    logic Cin;
    logic [3:0] D, quotient, remainder;
    logic Cout;

    // Instancia del módulo top-level
    top_module uut (
        .A(A),
        .B(B),
        .dividend(dividend),
        .divisor(divisor),
        .Cin(Cin),
        .D(D),
        .Cout(Cout),
        .quotient(quotient),
        .remainder(remainder)
    );

    initial begin
        $display("===============================================");
        $display(" Testbench para Top Module de 4 Bits ");
        $display("===============================================");

        // Test para la operación de resta
        A = 4'b1001; B = 4'b0011; Cin = 0; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b", A, B, Cin, D, Cout);

        // Test para la operación de división
        dividend = 4'b1010; divisor = 4'b0011; #10;
        $display("Dividend=%b, Divisor=%b -> División: Quotient=%b, Remainder=%b", dividend, divisor, quotient, remainder);

        // Otro conjunto de pruebas para la resta
        A = 4'b0110; B = 4'b0101; Cin = 0; #10;
        $display("A=%b, B=%b, Cin=%b -> Resta: D=%b, Cout=%b", A, B, Cin, D, Cout);

        // Otro conjunto de pruebas para la división
        dividend = 4'b1100; divisor = 4'b0011; #10;
        $display("Dividend=%b, Divisor=%b -> División: Quotient=%b, Remainder=%b", dividend, divisor, quotient, remainder);

        // Caso de división por 0
        dividend = 4'b1010; divisor = 4'b0000; #10;
        $display("Dividend=%b, Divisor=%b -> División por 0: Quotient=%b, Remainder=%b", dividend, divisor, quotient, remainder);

        $display("\nTest completo.");
        $finish;
    end
endmodule
