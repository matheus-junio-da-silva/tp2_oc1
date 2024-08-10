module pc(
    entradaDoPc, 
    saidaDoPc, 
    clock, 
    pcReset
    );

    input [31:0] entradaDoPc;

    input clock, pcReset;

    output [31:0] saidaDoPc;

    reg [31:0] saidaDoPc;
    
    always @(posedge clock)

        if (!pcReset) saidaDoPc <= 0;

        else saidaDoPc <= entradaDoPc;
        
endmodule