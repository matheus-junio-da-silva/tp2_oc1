/*module teste_tb;
    reg [31:0] _EnderecoDeLeitura;

    reg [8*25:0] _nomeArquivo;

    wire [31:0] _Instrucao;

    memoriaDeInstrucao im(_EnderecoDeLeitura, 
    _nomeArquivo, 
    _Instrucao
    );

    initial begin
        _nomeArquivo = "testetxt.txt";
        _EnderecoDeLeitura = 8;
    end

endmodule*/

module memoriaDeInstrucao(
    EnderecoDeLeitura, 
    nomeArquivo, 
    Instrucao, 
    arquivoFinalDele
    );

    input [31:0] EnderecoDeLeitura;

    input [8*25:0] nomeArquivo;

    output reg [31:0] Instrucao;

    output reg arquivoFinalDele;

    integer arquivo;
    integer error;
    reg [31:0] linha;

    always @(nomeArquivo)

    begin

        arquivo 
        = $fopen(nomeArquivo, "r");

    end

    always @(EnderecoDeLeitura)

    begin

        if (EnderecoDeLeitura 
            === 32'bx) begin

            Instrucao = 0;
            arquivoFinalDele = 1;

        end
        else begin

            error 
            = $fseek(arquivo, EnderecoDeLeitura*8 + EnderecoDeLeitura/4, 0);

            error 
            = $fscanf(arquivo, "%b", linha);

            if (error != -1) 
            Instrucao = linha;

            else Instrucao = 0;
        end
    end
endmodule