/*
   CS/ECE 552 Spring '20
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
module memory (writeData, aluResult, memRead, memWrite, halt, clk, rst, readData);
 
  input [15:0] writeData;
  input [15:0] aluResult;
  input memRead, memWrite;
  input halt;
  input clk, rst;
  output [15:0] readData;
wire memReadorWrite;
  assign memReadorWrite = memRead | memWrite;

  memory2c DATA_MEM (.data_out(readData), .data_in(writeData), .addr(aluResult), .enable(memReadorWrite), .wr(memWrite), .createdump(halt), .clk(clk), .rst(rst));
endmodule
