// ============================================================
//  4-bit Arithmetic Logic Unit (ALU)
//  Tool: Icarus Verilog
//  Operations selected by 3-bit opcode:
//    000 - ADD
//    001 - SUBTRACT
//    010 - AND
//    011 - OR
//    100 - XOR
//    101 - NOT A
//    110 - Left Shift A by 1
//    111 - Right Shift A by 1
// ============================================================

module alu (
    input  wire [3:0] A,        // 4-bit input A
    input  wire [3:0] B,        // 4-bit input B
    input  wire [2:0] opcode,   // 3-bit operation selector
    output reg  [4:0] result,   // 5-bit result (extra bit for carry/overflow)
    output reg        zero,     // Zero flag: 1 if result == 0
    output reg        carry     // Carry flag: set on addition overflow
);

    always @(*) begin
        // Default flags
        zero  = 0;
        carry = 0;

        case (opcode)
            3'b000: begin  // ADD
                {carry, result[3:0]} = A + B;
                result[4] = carry;
            end

            3'b001: begin  // SUBTRACT
                result = A - B;
                carry  = 0;        // carry not used for subtraction
            end

            3'b010: begin  // AND
                result = A & B;
            end

            3'b011: begin  // OR
                result = A | B;
            end

            3'b100: begin  // XOR
                result = A ^ B;
            end

            3'b101: begin  // NOT A
                result = ~A;
            end

            3'b110: begin  // Left Shift A by 1
                result = A << 1;
            end

            3'b111: begin  // Right Shift A by 1
                result = A >> 1;
            end

            default: result = 5'b00000;
        endcase

        // Set zero flag if lower 4 bits of result are zero
        zero = (result[3:0] == 4'b0000) ? 1 : 0;
    end

endmodule
