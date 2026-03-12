# MIPS Pipeline: Instruction Decode (ID) Stage

## Project Overview
This repository contains the Verilog implementation of the **Instruction Decode (ID) Stage** for a 32-bit MIPS pipeline processor. [cite_start]The primary objective of this stage is to translate raw 32-bit instructions into functional control signals and operand data required for the subsequent Execution (EX) stage[cite: 49, 50, 51].

## Key Components Implemented
* [cite_start]**Control Unit (`control.v`)**: Decodes the 6-bit opcode to generate `WB`, `MEM`, and `EX` control signals for R-format, LW, SW, and BEQ instructions[cite: 59, 60, 61, 62, 63, 64].
* [cite_start]**Register File (`regfile.v`)**: A 32x32-bit register array capable of simultaneous dual-read and single-write operations[cite: 37, 38].
* [cite_start]**Sign Extender (`signExt.v`)**: Converts 16-bit immediate values into 32-bit values while preserving the sign bit[cite: 34, 35].
* [cite_start]**ID/EX Latch (`idExLatch.v`)**: A pipeline register that synchronizes and passes all decoded data and control signals to the next stage[cite: 42, 43, 44].

## Verification Methodology
[cite_start]The functionality was verified using a custom testbench (`decode_tb.v`) targeting the following scenarios[cite: 66, 69]:

### 1. Register Data Integrity (The "Coffee" Test)
[cite_start]To verify that the **Register File** correctly stores and retrieves data, Register 1 was initialized with the hexadecimal constant `32'hC0FFEE00`[cite: 74]. [cite_start]Subsequent instructions successfully read this value, confirming that the internal memory array is stable and the read-enable logic is functional[cite: 39, 40].

### 2. R-Format Decoding
[cite_start]An `ADD` instruction (`32'h00221820`) was processed to verify[cite: 75]:
* [cite_start]Correct extraction of `rs`, `rt`, and `rd` addresses[cite: 54, 56].
* [cite_start]Activation of the `ALUOp` and `RegDst` signals in the `EX` control bus[cite: 60, 61].

### 3. I-Format Decoding (Load Word)
[cite_start]An `LW` instruction (`32'h8C240008`) was processed to verify[cite: 76]:
* [cite_start]**Sign Extension**: Converting the immediate value `0008` to `00000008`[cite: 35, 53].
* [cite_start]**Memory Control**: Enabling `MemRead` and setting `RegWrite` to prepare for the Write Back phase[cite: 61, 62].

## Simulation Results
[cite_start]The timing diagram (`timing_diagram_DECODE.png`) illustrates that all control signals and register outputs transition exactly one clock cycle after the instruction arrives at the `if_id_instr` input, as dictated by the synchronous nature of the pipeline latch[cite: 44, 47, 48].
