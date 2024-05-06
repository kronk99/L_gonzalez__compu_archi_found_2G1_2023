module orGate (
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [3:0] result
);

    // Operación OR bit a bit entre a y b
    assign result = a | b;

endmodule
