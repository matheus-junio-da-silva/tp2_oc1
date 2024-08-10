/*module teste;
    wire Branchcontrole_, 
    lermemControle_, 
    MemToRegC_, 
    memoriaDeEscritaC_, 
    ALUSrc_, 
    registradorDeEscritaC_;

    wire [1:0] controlealuop_;

    reg [6:0] Instrucaocontrole_;

    control controle(Instrucaocontrole_, 
    Branchcontrole_, 
    lermemControle_, 
    MemToRegC_, 
    controlealuop_, 
    memoriaDeEscritaC_, 
    ALUSrc_, 
    registradorDeEscritaC_
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(2,teste);
        #5 Instrucaocontrole_ <= 7'b0000011;
        #5 Instrucaocontrole_ <= 7'b0110011;
        #5 $finish;
    end
endmodule*/

module control(
    Instrucaocontrole, 
    Branchcontrole, 
    lermemControle, 
    MemToRegC,
    controlealuop, 
    memoriaDeEscritaC, 
    ALUSrc, 
    registradorDeEscritaC
    );

    input [6:0] Instrucaocontrole;

    output Branchcontrole, 
    lermemControle, 
    MemToRegC, 
    memoriaDeEscritaC, 
    ALUSrc, 
    registradorDeEscritaC;

    output [1:0] controlealuop;

    reg [7:0] controleSaida;

    assign {ALUSrc, 
    MemToRegC, 
    registradorDeEscritaC, 
    lermemControle, 
    memoriaDeEscritaC, 
    Branchcontrole, 
    controlealuop} = controleSaida;

    always @(Instrucaocontrole)
    begin
        case (Instrucaocontrole)
            7'b0000011: controleSaida 
            <=  8'b11110000; // lw   - I

            7'b0100011: controleSaida 
            <=  8'b10001000; // sw   - S

            7'b0110011: controleSaida 
            <=  8'b00100010; // sub, xor, srl  - R

            7'b0010011: controleSaida 
            <=  8'b10100000; // addi - I

            7'b1100011: controleSaida 
            <=  8'b00000101; // beq  - SB

            default: controleSaida <=  8'bxxxxxxxx;
        endcase
    end
endmodule