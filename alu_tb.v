// ============================================================
//  Testbench for 4-bit ALU
//  Tests all 8 operations with sample inputs.
//  Prints results to terminal and dumps waveform for GTKWave.
// ============================================================

`timescale 1ns / 1ps

module alu_tb;

    // ---- Declare signals ----
    reg  [3:0] A, B;
    reg  [2:0] opcode;
    wire [4:0] result;
    wire       zero, carry;

    // ---- Instantiate DUT ----
    alu dut (
        .A      (A),
        .B      (B),
        .opcode (opcode),
        .result (result),
        .zero   (zero),
        .carry  (carry)
    );

    // ---- Waveform dump ----
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);
    end

    // ---- Task: apply inputs, wait, and display result ----
    task apply_test;
        input [3:0] a_in, b_in;
        input [2:0] op_in;
        input [63:0] op_name;  // just for display
        begin
            A      = a_in;
            B      = b_in;
            opcode = op_in;
            #10;  // wait 10ns for combinational logic to settle
        end
    endtask

    // ---- Stimulus ----
    initial begin
        $display("============================================================");
        $display("  4-bit ALU Testbench Results");
        $display("============================================================");
        $display("  Op       A     B     Result  Zero  Carry");
        $display("------------------------------------------------------------");

        // ADD: 5 + 3 = 8
        A = 4'd5; B = 4'd3; opcode = 3'b000; #10;
        $display("  ADD      %0d     %0d     %0d       %b     %b", A, B, result, zero, carry);

        // ADD with carry: 15 + 3 = 18 (overflow into carry)
        A = 4'd15; B = 4'd3; opcode = 3'b000; #10;
        $display("  ADD(ov)  %0d    %0d     %0d      %b     %b", A, B, result, zero, carry);

        // SUBTRACT: 9 - 4 = 5
        A = 4'd9; B = 4'd4; opcode = 3'b001; #10;
        $display("  SUB      %0d     %0d     %0d       %b     %b", A, B, result, zero, carry);

        // SUBTRACT: 4 - 4 = 0 (zero flag should be 1)
        A = 4'd4; B = 4'd4; opcode = 3'b001; #10;
        $display("  SUB(0)   %0d     %0d     %0d       %b     %b", A, B, result, zero, carry);

        // AND: 1100 & 1010 = 1000
        A = 4'b1100; B = 4'b1010; opcode = 3'b010; #10;
        $display("  AND      %b  %b  %b   %b     %b", A, B, result[3:0], zero, carry);

        // OR: 1100 | 1010 = 1110
        A = 4'b1100; B = 4'b1010; opcode = 3'b011; #10;
        $display("  OR       %b  %b  %b   %b     %b", A, B, result[3:0], zero, carry);

        // XOR: 1100 ^ 1010 = 0110
        A = 4'b1100; B = 4'b1010; opcode = 3'b100; #10;
        $display("  XOR      %b  %b  %b   %b     %b", A, B, result[3:0], zero, carry);

        // NOT A: ~1111 = 0000 (zero flag should be 1)
        A = 4'b1111; B = 4'b0000; opcode = 3'b101; #10;
        $display("  NOT A    %b  ----  %b   %b     %b", A, result[3:0], zero, carry);

        // Left Shift: 0011 << 1 = 0110
        A = 4'b0011; B = 4'b0000; opcode = 3'b110; #10;
        $display("  LSHIFT   %b  ----  %b   %b     %b", A, result[3:0], zero, carry);

        // Right Shift: 1100 >> 1 = 0110
        A = 4'b1100; B = 4'b0000; opcode = 3'b111; #10;
        $display("  RSHIFT   %b  ----  %b   %b     %b", A, result[3:0], zero, carry);

        $display("------------------------------------------------------------");
        $display("  Simulation complete.");
        $finish;
    end

endmodule
