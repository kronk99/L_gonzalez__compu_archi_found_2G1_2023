module SPI_slave(input logic MOSI, CS, sclk, rst,output logic MISO);
	//existe la duda si mosi es una señal unica o debe de ser un array de bits
	
	logic [3:0] instruc_M; // Cambiado a 4 bits para soportar hasta F en hexadecimal
   logic d; // Señal para enviar respuesta al maestro

    always_ff @(posedge sclk or posedge rst) begin
        if (!rst) begin
            instruc_M <= 0; // Reinicia el registro de instrucción en 0 durante el reset
        end else begin
            if (CS == 1'b0) begin // Cuando CS está activo
                instruc_M <= {instruc_M[2:0], MOSI}; // Desplaza y almacena el bit de entrada
            end
        end
    end

    assign d = MOSI & CS & ~rst; // d es 1 cuando hay algo en MOSI mientras CS está activo y no hay reset
    // Si la instrucción es mayor que 15, se considera un reset y se desconecta (no está implementado aquí)
    assign MISO = rst == 1 ? 8'b1111 : d; // Si hay reset, MISO se establece en todo 1, de lo contrario, toma el valor de d
	//colocar acá la alu y el pmw
endmodule
 