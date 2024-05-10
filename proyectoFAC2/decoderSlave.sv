module decoderSlave(input logic clk ,rst,enable, mosi ,output logic [3:0] num1,
num2, oper , Ain );
//modulo que servirá como decoder y como registro, esto con la decision de no hacer
//un modulo adicional solo para fragmentar el array recibido de arduino.
	reg[3:0] Rnum1=4'b0000;
	reg[3:0] Rnum2=4'b0000;
	reg [3:0] operacion=4'b0000;
	reg [3:0]next_state=4'b0000;
	always_ff @ (posedge clk or posedge rst)begin
		//faltan los reset.                     //si enable activo,  tome de las instrucciones, si no mantenga su valor
		 Rnum1 <= (rst) ? 4'b0000 : (enable == 1'b1) ? {Rnum1[3:0], mosi} : Rnum1;
       Rnum2 <= (rst) ? 4'b0000 : (enable == 1'b1) ? {Rnum2[3:0], Rnum1[3:0]} : Rnum2;
       operacion <= (rst) ? 4'b0000 : (enable == 1'b1) ? {operacion[3:0], Rnum2[3:0]} : operacion;
       next_state <= (rst) ? 4'b0000 : (enable == 1'b1) ? {next_state[3:0], operacion[3:0]} :next_state;
    end
	//cambiar esto con compuertas.
	assign num1 = Rnum1;
	assign num2 = Rnum2;
	assign oper = operacion;
	assign Ain = next_state;
	//el decoder slave proporciona datos tanto a la alu como a la fsm del next state, que
	//es el último bit que produce la señal recibida
endmodule