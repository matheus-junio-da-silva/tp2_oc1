/*module alu_tb;
    reg [31:0] 
    aluentrada1_, 
    aluentrada2_;

    reg [3:0] ControleDeAlu_;

    wire [31:0] rusultadoDaAlu_;

    wire zeroo_;

    alu alutb(
    aluentrada1_, 
    aluentrada2_, 
    ControleDeAlu_, 
    rusultadoDaAlu_, 
    zeroo_
    );

    initial begin
        $dumpfile("teste.vcd");
        $dumpvars(2, alu_tb);
        #5 ControleDeAlu_ 
        <= 4'b0010; aluentrada1_ 
        <= 32'hFFFFFFFF; aluentrada2_ 
        <= 32'h2;

        #5 ControleDeAlu_ 
        <= 4'b0110; aluentrada1_ 
        <= 32'h5; aluentrada2_ 
        <= 32'hFFFFFFFF;

        #5 ControleDeAlu_ 
        <= 4'b0011; aluentrada1_ 
        <= 32'h0; aluentrada2_ 
        <= 32'hFFFFFFFF;

        #5 ControleDeAlu_ 
        <= 4'b0100; aluentrada1_ 
        <= 32'hFFFFFFFF; aluentrada2_ 
        <= 32'h9;

        #5 $finish;
    end
endmodule*/

module alu(
    aluentrada1, 
    aluentrada2, 
    ControleDeAlu, 
    rusultadoDaAlu, 
    zeroo
    );

    input [31:0] 
    aluentrada1, 
    aluentrada2;

    input [3:0] ControleDeAlu;

    output reg [31:0] rusultadoDaAlu;

    output zeroo;

    assign zeroo = (rusultadoDaAlu == 0) ? 1 : 0;

    always @(*)
    begin
        case (ControleDeAlu)
            4'b0010: rusultadoDaAlu 
            <= aluentrada1 + aluentrada2;// adicionar

            4'b0110: rusultadoDaAlu 
            <= aluentrada1 - aluentrada2;// sub

            4'b0011: rusultadoDaAlu 
            <= aluentrada1 ^ aluentrada2;// xor

            4'b0100: rusultadoDaAlu 
            <= aluentrada1 >> aluentrada2;// srl

            default: rusultadoDaAlu <= 31'bx;
        endcase
    end
endmodule