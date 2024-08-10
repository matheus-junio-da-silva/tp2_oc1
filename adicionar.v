module adicionar(
    x, 
    y, 
    saida
    );

    input[31:0] 
    x, 
    y;

    output[31:0] saida;

    assign saida = x + y;
endmodule