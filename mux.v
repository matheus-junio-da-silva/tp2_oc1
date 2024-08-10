module modMux2Entrada(
    entrada1, 
    entrada2, 
    out, 
    controle
    );

    input [31:0] entrada1, 
    entrada2;

    output [31:0] out;

    input controle;

    assign out = 
    (controle == 1'b0) 
    ? entrada1 : entrada2;

endmodule