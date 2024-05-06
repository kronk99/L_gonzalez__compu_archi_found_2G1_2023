module andGate (
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [3:0] result
);

    // Operación AND bit a bit entre a y b
    assign result = a & b;

endmodule