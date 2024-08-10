`timescale 1ns/1ps

module datapath_tb;
    reg CDclock_, 
    CDreset_;

    reg [8*25:0] nomeArquivoInstDP_;

    integer error;

    integer i;

    reg signed [31:0] valorReg;

    wire fimArquivo;

    caminhoDeDadosRiscV dpR5(
    CDclock_, 
    CDreset_, 
    nomeArquivoInstDP_, 
    fimArquivo
    );

    initial begin
        nomeArquivoInstDP_ = "inputs/input3.txt";
        $dumpfile("saidas/testeCaminho.vcd");
        $dumpvars(3, datapath_tb);
    end

    initial CDclock_ <= 0;
    always #1 CDclock_ <=(!CDclock_);

    always #1 begin
        if (fimArquivo) begin
            for (i = 0; i < 32; i = i + 1) begin
                valorReg = dpR5.regMem.registradores[i];
                if (valorReg[31])
                    $display("registrador |%2d|: %15d <decimal<| %b <binario>", i, valorReg, valorReg);
                else
                    $display("registrador |%2d|: %15d <decimal>| %b <binario>", i, valorReg, valorReg);
            end
            $finish;
        end
    end

    initial begin
        CDreset_ <= 0;
        #5 CDreset_ <= 1;
        #100 CDreset_ <= 0;
    end

endmodule

module caminhoDeDadosRiscV(
    CDclock, 
    CDreset, 
    CDnomeArquivo, 
    fimArquivo
    );

    input [8*25:0] CDnomeArquivo;

    input CDclock, 
    CDreset;

    wire [31:0] CDentradaPc, 
    CDsaidaPc, 
    CDinstrucao, 
    CDG_imediatoSaida, 
    CDsoma4Saida,
    CDsomaDesvio, 
    CDleituraDados, 
    CDleituraDados2, 
    CDmuxAluSaida, 
    CDaluSaida, 
    CDleituraMemoria, 
    CDdadosEscritaReg;

    wire CDdesvio, 
    CDleituraMem, 
    CDmemoriaParaReg, 
    CDescritaMem, 
    CDaluSrc, 
    CDescritaRegistrador,
    CDaluZero, 
    CDsaidaE;

    wire [1:0] CDaluOp;
    wire [3:0] CDcontroleAlu;
    wire [3:0] CDcontroleF3F7Alu;
    output fimArquivo;

    assign CDsaidaE = CDdesvio & CDaluZero;
    assign CDcontroleF3F7Alu = {CDinstrucao[30], CDinstrucao[14:12]};

    pc pcDP(CDentradaPc, CDsaidaPc, CDclock, CDreset);

    memoriaDeInstrucao insMem(CDsaidaPc, CDnomeArquivo, CDinstrucao, fimArquivo); // 

    control controleDP(CDinstrucao[6:0], CDdesvio, CDleituraMem, CDmemoriaParaReg, CDaluOp,
     CDescritaMem, CDaluSrc, CDescritaRegistrador);

    registerMem regMem(CDclock, CDescritaRegistrador, CDinstrucao[19:15], CDinstrucao[24:20],
     CDinstrucao[11:7], CDdadosEscritaReg, CDleituraDados, CDleituraDados2); //

    G_imm G_imm(CDinstrucao, CDG_imediatoSaida); //

    controleDaAlu controleDaAlu(CDcontroleF3F7Alu, CDaluOp, CDcontroleAlu); //

    adicionar add4(32'h4, CDsaidaPc, CDsoma4Saida);

    adicionar addBranch(CDsaidaPc, CDG_imediatoSaida, CDsomaDesvio);

    alu alu(CDleituraDados, CDmuxAluSaida, CDcontroleAlu, CDaluSaida, CDaluZero);

    memoriaDeDados dataMem(CDclock, CDleituraMem, CDescritaMem, CDaluSaida, CDleituraDados2, CDleituraMemoria);

    modMux2Entrada muxAdds(CDsoma4Saida, CDsomaDesvio, CDentradaPc, CDsaidaE);

    modMux2Entrada muxAlu(CDleituraDados2, CDG_imediatoSaida, CDmuxAluSaida, CDaluSrc);

    modMux2Entrada muxDataMem(CDaluSaida, CDleituraMemoria, CDdadosEscritaReg, CDmemoriaParaReg);

endmodule