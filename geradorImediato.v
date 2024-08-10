/*module G_imm_tb;
    reg [31:0] instr_;

    wire [31:0] GImm_;

    G_imm imG(
        instr_,
        GImm_
        );

    initial begin
        $dumpfile("teste.vcd");

        $dumpvars(2, G_imm_tb);

        instr_ <= 32'h03052283;

        #5 instr_ <= 32'h00552023;
        #5 instr_ <= 32'h00552823;
        #5 instr_ <= 32'h80230293;
        #5 instr_ <= 32'b01111111100001001000111111100011;
        #5 instr_ <= 32'b11111111100001001000111111100011;

        #5 $finish;
    end
endmodule*/

module G_imm(
    instr, 
    GImm
    );

    input [31:0] instr;

    output reg [31:0] GImm;

    always @(instr)
    begin
        case (instr[6:0])

            7'b0000011: GImm 
            <= {{21{instr[31]}}, 
            instr[30:20]}; // lw - I

            7'b0100011: GImm 
            <= {{21{instr[31]}}, 
            instr[30:25], 
            instr[11:7]}; // sw - S

            7'b0010011: GImm 
            <= {{21{instr[31]}}, 
            instr[30:20]}; // addi - I

            7'b1100011: GImm 
            <= {{20{instr[31]}}, 
            instr[7], 
            instr[30:25], 
            instr[11:8], 
            {1{1'b0}}}; // beq - SB

            default: GImm <= 32'bx;
        endcase
    end
endmodule