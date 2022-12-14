/*
   CS/ECE 552 Spring '20
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
module memory ( err, mem_rd_data, clk, rst, read2Data, memwrite, memread, memaddr);

   // TODO: Your code here
   
   input clk;
   input rst;
   input [15:0] read2Data;
   input [15:0] memaddr;
   input        memwrite ;
   input        memread ;

   output err;
   output [15:0] mem_rd_data;

//data memory
memory2c dMem(.data_out(mem_rd_data), .data_in(read2Data), .addr(memaddr), .enable(memread | memwrite), .wr(memwrite), .clk(clk), .rst(rst), .createdump());

endmodule
