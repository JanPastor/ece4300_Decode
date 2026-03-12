`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 11:34:03 AM
// Design Name: 
// Module Name: decode_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module decode_tb();
    reg clk, rst, wb_reg_write;
    reg [4:0] wb_write_reg_location;
    reg [31:0] mem_wb_write_data, if_id_instr, if_id_npc;

    wire [1:0]  id_ex_wb;
    wire [2:0]  id_ex_mem;
    wire [3:0]  id_ex_execute;
    wire [31:0] id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;
    wire [4:0]  id_ex_instr_bits_20_16, id_ex_instr_bits_15_11;

    // Unit Under Test (UUT)
    decode uut (
        .clk(clk), .rst(rst),
        .wb_reg_write(wb_reg_write),
        .wb_write_reg_location(wb_write_reg_location),
        .mem_wb_write_data(mem_wb_write_data),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),
        .id_ex_wb(id_ex_wb),
        .id_ex_mem(id_ex_mem),
        .id_ex_execute(id_ex_execute),
        .id_ex_npc(id_ex_npc),
        .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Reset
        rst = 1; wb_reg_write = 0; if_id_instr = 0; if_id_npc = 0;
        #15 rst = 0;

        // Step 1: Pre-write a value to Register 1 (needed for reading later)
        wb_reg_write = 1;
        wb_write_reg_location = 5'd1;
        mem_wb_write_data = 32'hC0FFEE00;
        #10;
        wb_reg_write = 0;

        // Step 2: Test R-Format Instruction (ADD $3, $1, $2)
        // Opcode=0, rs=1, rt=2, rd=3, shamt=0, funct=0x20
        if_id_instr = 32'h00221820; 
        if_id_npc = 32'h00000004;
        #10;

        // Step 3: Test LW Instruction (LW $4, 8($1))
        // Opcode=0x23, rs=1, rt=4, imm=8
        if_id_instr = 32'h8C240008;
        #10;

        #50 $finish;
    end
endmodule