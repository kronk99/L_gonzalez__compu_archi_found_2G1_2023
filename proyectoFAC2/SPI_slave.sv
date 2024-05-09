module SPI_slave(
	input logic MOSI, CS, sclk, rst,
	output logic MISO, );
	//existe la duda si mosi es una señal unica o debe de ser un array de bits
	
	logic d; //señal para enviar respuesta al master
	logic [10:0] instruc_M //codigo enviado por el maestro.
	
	assign d = MOSI & CS &~rst; //d es 1 cuando haya algo en el mosi
	//cs sea 1, y reset sea 0, mosi no debe de contar, puesto que por mosi le voy a pasar
	//un array de datos dato_recibido <= {MOSI, MOSI, MOSI, MOSI} es para leer
	//el array de bits que se van a enviar, se van a enviar en total, cambiarlo a futuro
	instruct_M <={MOSI, MOSI, MOSI, MOSI,MOSI,MOSI,MOSI,MOSI,MOSI,MOSI,MOSI}
	//va a leer 11 bits
	
	assign MISO= rst == 1 ? 255:d; //si es 1 , establece miso en 255, si no 
	//establece miso como d, high o low , considerando el codigo de mariana, donde 
	//cualquier dato mayor que 15 se considera reset, y se desconecta.
	//SALIDA
	
	
	//colocar acá la alu y el pmw
endmodule