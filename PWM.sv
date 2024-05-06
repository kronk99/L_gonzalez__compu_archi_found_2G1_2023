module PWM(
    input clk,             // Clock de entrada
    input rst,             // Reset
    input [3:0] value,     // Valor de entrada (4 bits)
    output reg pwm         // Salida PWM
);

// Parámetros
parameter PWM_WIDTH = 4;  // Ancho del PWM (4 bits)

// Contador
reg [3:0] counter;         // Contador de 4 bits

// Valor de comparación (ciclo de trabajo)
reg [3:0] compare_value;   // Valor de comparación

// Tabla de conversion
reg [3:0] conversion_table [0:15] = '{   // Se utiliza asignación de agregado
    4'b1111, // 15 -> 100%
    4'b1110, // 14 -> 93.33%
    4'b1101, // 13 -> 86.67%
    4'b1100, // 12 -> 80%
    4'b1011, // 11 -> 73.33%
    4'b1010, // 10 -> 66.67%
    4'b1001, // 9 -> 60%
    4'b1000, // 8 -> 53.33%
    4'b0111, // 7 -> 46.67%
    4'b0110, // 6 -> 40%
    4'b0101, // 5 -> 33.33%
    4'b0100, // 4 -> 26.67%
    4'b0011, // 3 -> 20%
    4'b0010, // 2 -> 13.33%
    4'b0001, // 1 -> 6.67%
    4'b0000  // 0 -> 0%
};

always @*
begin
    // Obtiene el valor de comparación desde la tabla de conversión
    compare_value = conversion_table[value]; 
end

always @(posedge clk or posedge rst)
begin
    // Si se activa el reset
    counter <= (rst) ? 4'b0000 : (counter == 4'b1111) ? 4'b0000 : counter + 1;
end

// Genera el pulso PWM
always @(posedge clk or posedge rst)
begin
    // Si se activa el reset
    pwm <= (rst) ? 1'b0 : (counter < compare_value) ? 1'b1 : 1'b0;
end

endmodule

