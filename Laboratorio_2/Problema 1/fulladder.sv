//este full adder se reemplaza por la parte de Fabiana

//full adder using data-flow modeling
module fulladder (
    input a,b,cin,
    output sum,carry
);

assign sum = a ^ b ^ cin;
assign carry = (a & b) | (b & cin)  | (cin & a) ;

endmodule