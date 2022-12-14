/*
   CS/ECE 552 Spring '20
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
module fetch (newPC, halt, clk, rst, nextPC, instr);
 
  input [15:0] newPC;
  input halt;
  input clk, rst;

  output [15:0] nextPC;
  output [15:0] instr;

  wire [15:0] pcCurrent; 

  
  reg_16b PC_REG (.clk(clk), .rst(rst), .en(~halt), .in(newPC), .out(pcCurrent));

 
  memory2c INSTR_MEM (.data_out(instr), .data_in(16'h0000), .addr(pcCurrent), .enable(1'b1), .wr(1'b0), .createdump(halt), .clk(clk), .rst(rst));

  
  cla_16b PC_INC (.A(pcCurrent), .B(16'h0002), .Cin(1'b0), .sum(nextPC), .Cout(), .Pout(), .Gout());
endmodule
