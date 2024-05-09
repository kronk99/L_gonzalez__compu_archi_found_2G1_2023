module decoderSlave(input logic clk ,input logic [10:0] instruct ,output logic [3:0] num1,
num2, output logic [1:0] oper , output logic Ain );
//modulo que servirá como decoder y como registro, esto con la decision de no hacer
//un modulo adicional solo para fragmentar el array recibido de arduino.
	reg[4:0] Rnum1,Rnum2;
	reg [1:0] operacion;
	reg next_state;
	always_ff @ (posedge clk or posedge rst)begin
		//faltan los reset.
		
		Rnum1 <= instruct[10:7]; //asigna los numeros a los registros
      Rnum2 <= instruct[6:3];
      operacion <= instruct[2:1];
      next_state <= instruct[0];

	end
	//cambiar esto con compuertas.
	assign num1 = Rnum1;
	assign num2 = Rnum2;
	assign oper = operacion;
	assign Ain = next_state
	//el decoder slave proporciona datos tanto a la alu como a la fsm del next state, que
	//es el último bit que produce la señal recibida
endmodule