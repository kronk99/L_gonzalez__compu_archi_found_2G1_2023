module aluRegister(input logic clk, rst, enable, zero,of,neg,
input logic [4:0] resultado, output logic  [4:0] Oresultado,
output logic Ozero,Oof,Oneg);
	reg [3:0] aluresult;
	reg Izero,Ineg,Iof;
	//este modulo funcionara como registro de la la alu, de el se tomará el resultado 
	//de la alu y las banderas para los leds
	always_ff @ (posedge clk or posedge rst)begin
	//cambiar esto con compuertas o muxes
		 aluresult <= (rst) ? 4'b0 :
                     (enable) ? resultado : //es como un if pero con muxes
                     aluresult;
        Izero     <= (rst) ? 1'b0 :
                     (enable) ? zero :
                     Izero;
        Ineg      <= (rst) ? 1'b0 :
                     (enable) ? neg :
                     Ineg; //si no ineg se mantiene
        Iof       <= (rst) ? 1'b0 :
                     (enable) ? of :
                     Iof;
	end
	assign Oresultado = aluresult;
	assign Ozero = Izero;
	assign Oof = Iof;
	assign Oneg = Ineg;
endmodule