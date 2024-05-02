module PWM_tb;

// Definición de señales
reg clk;
reg rst;
reg [3:0] value;
wire pwm;

// Instanciación del módulo PWM
PWM pwm_inst (
    .clk(clk),
    .rst(rst),
    .value(value),
    .pwm(pwm)
);

// Generación del clock
always #5 clk = ~clk;

// Testbench
initial begin
    // Inicialización de señales
    clk = 0;
    rst = 0;
    value = 4'd0;
    
    // Reset inicial
    rst = 1;
    #10;
    rst = 0;
    
    // Simulación de valores de entrada
    repeat (16) begin
        #100;
        value = value + 1;
    end
    
    // Finalizar simulación
    #100;
    $finish;
end

endmodule


