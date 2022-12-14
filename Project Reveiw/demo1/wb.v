/*
   CS/ECE 552 Spring '20
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
module wb ( err, writeData, clk, rst, mem_rd_data1, mem_rd_data2, se_instruction_7_0, 
memread, memtoreg, memwrite, regload, PC_adder_out, comp_value_out);

   // TODO: Your code here
   input clk;
   input rst;
   input [15:0] mem_rd_data1;//mem_rd_data
   input [15:0] mem_rd_data2;//ALU_out
   input [15:0] se_instruction_7_0;
   input       memread  ;
   input       memtoreg ;
   input       memwrite ;
   input [1:0] regload  ;
   input [15:0] PC_adder_out;
   input comp_value_out;

   output err;
   output [15:0] writeData;

wire [15:0] mux3_out;


//WB
mux16b_4_1 mux2 (.InA(mux3_out), .InB(se_instruction_7_0), .InC(PC_adder_out), .InD({15'b0,comp_value_out}),  .S(regload), .Out(writeData) );

mux16b_2_1 mux3 (.InB(mem_rd_data1), .InA(mem_rd_data2), .S(memtoreg), .Out(mux3_out) );


endmodule
