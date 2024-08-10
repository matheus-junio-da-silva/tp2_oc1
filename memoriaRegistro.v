//`timescale 1ns/1ps
module registerMem_tb;
    reg _clock, _registradorDeEscrita;

    reg [4:0] _lerRegistrador1, 
    _lerRegistrador2, 
    _idRegistradorEscrita;

    reg [31:0] _dadoWr;

    wire [31:0] _dadoLeitura, 
    _dadoLeitura2;

    registerMem rm(
    _clock, 
    _registradorDeEscrita, 
    _lerRegistrador1, 
    _lerRegistrador2, 
    _idRegistradorEscrita, 
    _dadoWr, 
    _dadoLeitura, 
    _dadoLeitura2
    );

    initial begin 
        _clock <= 0; 
        _registradorDeEscrita = 1;
    end

    always #1 _clock <=(!_clock);

    initial begin
        #10 _registradorDeEscrita = 1; 
        _idRegistradorEscrita = 5; 
        _dadoWr = 50; 

        #10 _lerRegistrador1 = 5; 
        _registradorDeEscrita = 0;

        #100 $finish;
    end

endmodule

module registerMem(
    clock, 
    registradorDeEscrita, 
    lerRegistrador1, 
    lerRegistrador2, 
    idRegistradorEscrita, 
    dadoWr,
    dadoLeitura, 
    dadoLeitura2
    );

    input clock, 
    registradorDeEscrita;

    input [4:0] lerRegistrador1, 
    lerRegistrador2, 
    idRegistradorEscrita;

    input [31:0] dadoWr;

    output reg [31:0] dadoLeitura, 
    dadoLeitura2;

    reg [31:0] registradores [0:31];

    integer i;

    initial begin
        for (i = 0; i < 32; i = i +1) begin
            registradores[i] = 0;
        end
    end

    always @(registradores[0]) registradores[0] = 0;

    always @(posedge clock) begin

        if (registradorDeEscrita == 1) 
        registradores[idRegistradorEscrita] <= dadoWr;
        
    end

    always @(lerRegistrador1, registradores[lerRegistrador1]) 

    begin
        dadoLeitura 
        <= registradores[lerRegistrador1];
    end

    always @(lerRegistrador2, registradores[lerRegistrador1])

    begin
        dadoLeitura2 
        <= registradores[lerRegistrador2];
    end

endmodule