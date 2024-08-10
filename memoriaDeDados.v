/*module teste_tb;
    reg _lerMemoria, 
    _escreverNaMemoria;

    reg _clock;

    reg [31:0] _endereco, 
    _dadosEscrita;

    wire [31:0] _lerDados;

    memoriaDeDados dm(_clock, 
    _lerMemoria, 
    _escreverNaMemoria, 
    _endereco, 
    _dadosEscrita, 
    _lerDados
    );

    initial _clock = 0;

    always #5 _clock <= !(_clock);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(2,teste_tb);
        $dumpvars(0,dm.memoriaDeDados[0]);
        $dumpvars(0,dm.memoriaDeDados[1]);
        $dumpvars(0,dm.memoriaDeDados[2]);
        _lerMemoria <= 0; _escreverNaMemoria = 1;
        _endereco = 0;
        _dadosEscrita = 32'b1101;
        #10
        _endereco = 4;
        _dadosEscrita = 32'b111;
        #10 
        _lerMemoria = 1; _escreverNaMemoria = 0; 
        _endereco = 0;
        #10
        $display("%b", _lerDados);
        _endereco = 4;
        #10
        $display("%b", _lerDados);
        #200 $finish;
    end

endmodule*/

module memoriaDeDados(
    clock, 
    lerMemoria, 
    escreverNaMemoria, 
    endereco, 
    dadosEscrita, 
    lerDados
    );

    input clock, 
    lerMemoria, 
    escreverNaMemoria;

    input [31:0] endereco, 
    dadosEscrita;

    output reg [31:0] lerDados;

    reg [31:0] memoriaDeDados [0:512];


    always @(*)
    begin
        if (lerMemoria) lerDados 
        = memoriaDeDados[endereco[31:2]];
    end

    always @(negedge clock)
    begin
        if (escreverNaMemoria) memoriaDeDados[endereco[31:2]] 
        <= dadosEscrita;
    end
    
endmodule