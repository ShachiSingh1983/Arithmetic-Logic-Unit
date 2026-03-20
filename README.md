# 4-bit Arithmetic Logic Unit (ALU) — Verilog HDL

A 4-bit ALU implemented in Verilog HDL, capable of performing 8 arithmetic 
and logic operations selected via a 3-bit opcode. Designed with a modular 
architecture and verified using a self-checking testbench in Icarus Verilog.

## Operations

| Opcode | Operation      | Description                     |
|--------|----------------|---------------------------------|
| 000    | ADD            | A + B (with carry flag)         |
| 001    | SUBTRACT       | A - B (with zero flag)          |
| 010    | AND            | A & B (bitwise)                 |
| 011    | OR             | A \| B (bitwise)                |
| 100    | XOR            | A ^ B (bitwise)                 |
| 101    | NOT            | ~A (bitwise complement)         |
| 110    | Left Shift     | A << 1                          |
| 111    | Right Shift    | A >> 1                          |

## Status Flags

| Flag  | Description                                  |
|-------|----------------------------------------------|
| zero  | Set to 1 when result is 0x0000               |
| carry | Set to 1 when addition overflows 4 bits      |

## Simulation Waveform

![Waveform](waveform.png)

Each 10ns window represents one operation being tested. The opcode steps 
through 000 to 111, with A, B, and result shown in hexadecimal. 
Note the carry flag going high at t=10ns when 15+3=18 overflows 4 bits.

## Tools Used
- Verilog HDL
- Icarus Verilog (simulation)
- GTKWave (waveform viewer)

## How to Run
```bash
iverilog -o alu_sim.out alu_tb.v alu.v
vvp alu_sim.out
gtkwave alu.vcd
```

## Expected Terminal Output
```
============================================================
  4-bit ALU Testbench Results
============================================================
  Op       A     B     Result  Zero  Carry
------------------------------------------------------------
  ADD      5     3     8       0     0
  ADD(ov)  15    3     18      0     1
  SUB      9     4     5       0     0
  SUB(0)   4     4     0       1     0
  AND      1100  1010  1000    0     0
  OR       1100  1010  1110    0     0
  XOR      1100  1010  0110    0     0
  NOT A    1111  ----  0000    1     0
  LSHIFT   0011  ----  0110    0     0
  RSHIFT   1100  ----  0110    0     0
------------------------------------------------------------
  Simulation complete.
```

## Key Concepts
- Purely combinational design (no clock required)
- 3-bit opcode selects operation via a case statement
- 5-bit result output to accommodate carry/overflow bit
- Zero flag and carry flag for downstream use in a CPU datapath
- Fully parameterized and synthesizable RTL code
