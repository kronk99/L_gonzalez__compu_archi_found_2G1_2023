module fsm_tb;

    // Parámetros
    parameter CLK_PERIOD = 10; // Periodo del reloj
    
    // Se definen las señales o los cables a utilizar
    logic clk;
    logic rst;
    logic Ain, Bin, Cin;
    logic info, Alu, pmw;

    // Instancia de la FSM
    FSM dut (
        .clk(clk),
        .rst(rst),
        .Ain(Ain),
        .Bin(Bin),
        .Cin(Cin),
        .info(info),
        .Alu(Alu),
        .pmw(pmw)
    );

    // Codigo para generar el reloj
    always #(CLK_PERIOD/2) clk = ~clk;

    // pruebas, se debe de hacer un reset
    initial begin
        clk = 0;
        rst = 1;
        Ain = 0;
        Bin = 0;
        Cin = 0;
        #20; // Esperar un poco después del reset
        rst = 0; // Desactivar el reset

        // Secuencia de prueba 1
        #10; // Esperar un ciclo de reloj
        Ain = 1; // se pone Ain a 1 para ir a 01
        #10; // Esperar un ciclo de reloj
        // En el estado 01, Info deberia ser 1
		  
		  // Secuencia de prueba 1.5.1 para ver si un estado es invalido , hacerlo bien
        #10; // Esperar un ciclo de reloj
        Ain = 0; // se pone Ain a 0 para  mantener ir a 01
        #10; // Esperar un ciclo de reloj
        // En el estado 10, Info deberia ser 1
		  
		  // Secuencia de prueba 1.5.2
        #10; // Esperar un ciclo de reloj
        Ain = 1; // se pone Ain a 1 para ir a 10
        #10; // Esperar un ciclo de reloj
        // En el estado 10, Info deberia ser 1
		  
        // Secuencia de prueba 2
        Ain = 0;
        Bin = 1; // Se establece Bin a 1 para ir a 11 , estado de la alu
        #10; // Esperar un ciclo de reloj
        
        // Secuencia de prueba 3
        Bin = 0;
        Cin = 1; // Establecer Cin a 1 para ir a 01
        #10; // Esperar un ciclo de reloj
        // Verificar que pmw sea 1 y info, Alu sean 0
        
        $finish; // Terminar la simulación
    end
endmodule