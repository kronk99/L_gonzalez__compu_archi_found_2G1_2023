module inversor ( //Se utiliza para invertir el numero
    input logic [3:0] in,
    output logic [4:0] out
);
	 //logics para el sumador
	 logic Couto;
	 
	 logic  [3:0] Result;
	 logic  [3:0] uno;//declaracion del numero 1 en su forma de N bits
	 //necesario ára sumarle 1 al numero de N bits
	 logic  [3:0] numInvertido;
    logic [3:0] intermediate_out;
	 //el codigo es para definir el 1, si N es 1 no se realiza.
	 always_comb begin
        uno = (4 == 1) ? 1'b1 : {{4-1{1'b0}}, 1'b1};
    end
	 //fin del codigo.
    genvar i;
    generate
        for (i = 0; i < 4; i++) begin: loop
            nand_d #(2) nand_inst (
                .a(in[i]),
                .b(1'b1),
                .y(intermediate_out[i])
            );
        end
    endgenerate
	
	 //assign out = intermediate_out; //esto me produce un resultado al que hay que sumarle
	 //1 entonces
	 add misumador(.num1(intermediate_out), .num2(uno), .Cout(Couto), .Resul(Result));
	 genvar j;
    generate
        for (j = 0; j < 4; j++) begin: loop2
           assign numInvertido[j]=Result[j];
        end
    endgenerate
	 //assign numInvertido[N]=Couto;
	 assign out = numInvertido;
endmodule

module nand_d #(parameter WIDTH = 1) (
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    output logic [WIDTH-1:0] y
);

    assign y = ~(a & b);

endmodule