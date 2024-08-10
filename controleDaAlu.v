/*module test_tb;
    wire [3:0] alucontroleAcontrole_;

    reg [1:0] aluOpAcontrole_;
    
    reg [3:0] f3f7Acontrole_;

    controleDaAlu controleDaAlu(
    f3f7Acontrole_, 
    aluOpAcontrole_, 
    alucontroleAcontrole_
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(2,test_tb);
        #5 aluOpAcontrole_ <= 2'b00; f3f7Acontrole_ <= 4'b1000;
        #5 aluOpAcontrole_ <= 2'b10; f3f7Acontrole_ <= 4'b1101;
        #5 aluOpAcontrole_ <= 2'b01; f3f7Acontrole_ <= 4'b1000;
        #5 $finish;
    end
    
endmodule*/

module controleDaAlu(
    f3f7Acontrole, 
    aluOpAcontrole, 
    alucontroleAcontrole
    );

    output reg [3:0] alucontroleAcontrole;

    input [1:0] aluOpAcontrole;

    input [3:0] f3f7Acontrole;

    wire funct7Acontrole;

    wire [2:0] funct3Acontrole;

    assign funct7Acontrole = f3f7Acontrole[3];

    assign funct3Acontrole = f3f7Acontrole[2:0];

    always @(*)
    begin
        case (aluOpAcontrole)
            2'b00: alucontroleAcontrole 
            <= 4'b0010; // 00 - adicionar (addi, lw, sw)

            2'b01: alucontroleAcontrole 
            <= 4'b0110; // 01 - sub (beq)

            2'b10: begin
                case (funct3Acontrole)
                
                    3'b000: alucontroleAcontrole 
                    <= 4'b0110; // sub (sub)

                    3'b100: alucontroleAcontrole 
                    <= 4'b0011; // xor (xor)

                    3'b101: alucontroleAcontrole 
                    <= 4'b0100; // srl (srl)

                endcase
            end
        endcase
    end
endmodule