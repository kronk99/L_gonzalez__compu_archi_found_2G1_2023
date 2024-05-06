module ALU (
    input logic [3:0] num1,
    input logic [3:0] num2,
    input logic [1:0] opcode,
    output logic [3:0] result,
    output logic carry_out,
    output logic overflow,
    output logic negative,
    output logic zero
);

    logic [3:0] sum_result;
    logic [3:0] sub_result;
    logic [3:0] or_result;
    logic [3:0] and_result;
    logic carry_out_add;
    logic carry_out_sub;

    // Módulos de operaciones básicas
    add adder (.num1(num1), .num2(num2), .Cout(carry_out_add), .Resul(sum_result));
    sub subtractor (.num1(num1), .num2(num2), .Carryout(carry_out_sub), .Result(sub_result));
    orGate or_gate (.a(num1), .b(num2), .result(or_result));
    andGate and_gate (.a(num1), .b(num2), .result(and_result));

    // Selección de operación basada en el opcode
    always_comb begin
        case(opcode)
            2'b00: begin // Suma
                result = sum_result;
                carry_out = carry_out_add;
                overflow = carry_out_add; // Overflow ocurre si hay carry
                negative = 1'b0; // El bit más significativo indica si es negativo
                zero = (result == 4'b0000) ? 1'b1 : 1'b0; // Zeroflag es 1 si el resultado es cero
            end
            2'b01: begin // Resta
                result = sub_result;
                carry_out = ~carry_out_sub; // Invierte el carry de la resta
                overflow = ~carry_out_sub; // Overflow ocurre si hay carry
                negative = result[3]; // El bit más significativo indica si es negativo
                zero = (result == 4'b0000) ? 1'b1 : 1'b0; // Zeroflag es 1 si el resultado es cero
            end
            2'b10: begin // OR
                result = or_result;
                carry_out = 1'b0; // No se usa para OR
                overflow = 1'b0; // No se usa para OR
                negative = 1'b0; // No se usa para OR
                zero = (result == 4'b0000) ? 1'b1 : 1'b0; // Zeroflag es 1 si el resultado es cero
            end
            2'b11: begin // AND
                result = and_result;
                carry_out = 1'b0; // No se usa para AND
                overflow = 1'b0; // No se usa para AND
                negative = 1'b0; // No se usa para AND
                zero = (result == 4'b0000) ? 1'b1 : 1'b0; // Zeroflag es 1 si el resultado es cero
            end
            default: begin
                result = 4'bxxxx; // Valor indefinido si el opcode no es válido
                carry_out = 1'bx; // Valor indefinido si el opcode no es válido
                overflow = 1'bx; // Valor indefinido si el opcode no es válido
                negative = 1'bx; // Valor indefinido si el opcode no es válido
                zero = 1'bx; // Valor indefinido si el opcode no es válido
            end
        endcase
    end

endmodule
