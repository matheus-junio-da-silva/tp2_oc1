all:
	iverilog -o saidas/outdp pc.v adicionar.v alu.v controleDaAlu.v control.v memoriaDeDados.v caminhoDeDados.v geradorImediato.v memoriaDeInstrucao.v mux.v memoriaRegistro.v

run:
	vvp saidas/outdp

gtk:
	gtkwave saidas/testeCaminho.vcd