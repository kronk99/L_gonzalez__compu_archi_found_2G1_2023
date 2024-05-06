module sub (input logic [3:0] num1, num2, output logic
Carryout, output logic [3:0] Result);
		logic [3:0] int_res;
		logic [3:0] int_resO;
		logic [3:0] int_resI;
		logic [3:0] num2C;
    // Se convierte en complemento 1 el numero negativo
    inversor inverter (
        .in(num2),
        .out(num2C)
    );
	 
	 add sumador1(.num1(num1), 
	 .num2(num2C), .Cout(Carryout), 
	 .Resul(int_res)
	 );
	 
	 always_comb begin
		if (Carryout == 1) begin
			int_resO = 'b0;
			Result = int_res;
		end
		else begin
			int_resO = int_res;
			Result = int_resI;
			end
		end
	 inversor inverter2 (
			  .in(int_resO),
			  .out(int_resI)
		 );

endmodule