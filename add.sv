module add (input logic [3:0] num1, num2, output logic
Cout, output logic [3:0] Resul); //pag 218 del libro sale el ejemplo en system verilog para parametrizar
//en los testbench  
	logic [4:0] Cin;
	logic [3:0] Couto, s;
	assign Cin[0] = 0;
	generate
		genvar i;
		for(i=0;i<4;i=i+1)begin: forloop
			add1bit misumador(.a(num1[i]),.b(num2[i]),.Cin(Cin[i]),.Cout(Couto[i]),.s(s[i]));
			assign Resul[i]=s[i];//
			assign Cin[i+1]=Couto[i];
		//supongo que el cout se queda como el ultimo resultado.
//buscar el generate para crear n sumadores de 1 bit
		end
  endgenerate
  assign Cout = Couto[3];
endmodule