module FSM(input logic clk,rst,Ain,Bin,Cin,output logic info,Alu ,pmw);
	logic [1:0] state, next_state , out; //Necesito 2 bits porque son 4 estados

//Reset
	always_ff @ (posedge clk or posedge rst)begin
	//cambiar esto con compuertas.
		if (rst)begin
			state = 2'b00;
		end 
		else begin
			state = next_state;
		end

//Logica del siguiente estado
	always_comb begin
	//bit menos significativo.
	//vea a state[1] como la x, state de 0 como la y.
	//asignacion de Y de next state
	// Asignacion de Y de next state
		out[0] = (((!(state[1]))&(state[0] ^ Ain)) | ((state[1]) & !(state[0]) & Bin) |((state[1]) & (state[0])));
// Asignacion de X de next state
		out[1] = ((!(state[1]) & (state[0]) & Ain) |(!(state[0]) & (state[1])) |((state[0]) & (state[1])& !Cin));
	 //asignacion del siguiente estado:
		next_state = out;
	end
//output logic
	assign info = (state == 2'b01);// El timer se hace 1 para indicar que se debe iniciar la cuenta de 15 segundos para el turno del jugador
	assign Alu = (state == 4'b10); // Es 1 cuando es el turno del jugador
	assign pmw = (state == 4'b11); //Turno de la PC
 //estado comprobacion de victoria pc;
endmodule