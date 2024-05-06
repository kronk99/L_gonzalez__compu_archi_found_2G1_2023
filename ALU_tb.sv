module ALU_tb;

    // Parámetros
    parameter DELAY = 10;

    // Señales de entrada
    logic [3:0] num1;
    logic [3:0] num2;
    logic [1:0] opcode;

    // Señales de salida
    logic [3:0] result;
    logic carry_out;
    logic overflow;
    logic negative;
    logic zero;

    // Instancia del módulo bajo prueba
    ALU uut (
        .num1(num1),
        .num2(num2),
        .opcode(opcode),
        .result(result),
        .carry_out(carry_out),
        .overflow(overflow),
        .negative(negative),
        .zero(zero)
    );

    // Estímulo
    initial begin
        // Establecer valores iniciales
        num1 = 4'b0001;
        num2 = 4'b0010;
        opcode = 2'b00; // Suma

        // Esperar un tiempo
        #DELAY;

        // Cambiar los valores de entrada
        num1 = 4'b1111;
        num2 = 4'b0001;
        opcode = 2'b01; // Resta

        // Esperar un tiempo
        #DELAY;

        // Cambiar los valores de entrada
        num1 = 4'b1100;
        num2 = 4'b1010;
        opcode = 2'b10; // OR

        // Esperar un tiempo
        #DELAY;

        // Cambiar los valores de entrada
        num1 = 4'b1100;
        num2 = 4'b1010;
        opcode = 2'b11; // AND

        // Esperar un tiempo
        #DELAY;

        // Finalizar la simulación
        $finish;
    end

endmodule
