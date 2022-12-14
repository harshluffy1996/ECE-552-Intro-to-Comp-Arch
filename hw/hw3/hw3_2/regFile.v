/*
   CS/ECE 552, Fall '22
   Homework #3, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module regFile (
                // Outputs
                read1Data, read2Data, err,
                // Inputs
                clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                );
localparam REG_WIDTH = 16;
   input        clk, rst;
   input [2:0]  read1RegSel;
   input [2:0]  read2RegSel;
   input [2:0]  writeRegSel;
   input [REG_WIDTH -1:0] writeData;
   input        writeEn;

   output reg [REG_WIDTH -1:0] read1Data;
   output reg [REG_WIDTH -1:0] read2Data;
   output reg      err;

   /* YOUR CODE HERE */
wire [REG_WIDTH -1:0] R0;
wire [REG_WIDTH -1:0] R1;
wire [REG_WIDTH -1:0] R2;
wire [REG_WIDTH -1:0] R3;
wire [REG_WIDTH -1:0] R4;
wire [REG_WIDTH -1:0] R5;
wire [REG_WIDTH -1:0] R6;
wire [REG_WIDTH -1:0] R7;


wire write0,write1,write2,write3,write4,write5,write6,write7;

assign write0 = ~writeRegSel[2] & ~writeRegSel[1] & ~writeRegSel[0] & writeEn;
assign write1 = ~writeRegSel[2] & ~writeRegSel[1] &  writeRegSel[0] & writeEn;
assign write2 = ~writeRegSel[2] &  writeRegSel[1] & ~writeRegSel[0] & writeEn;
assign write3 = ~writeRegSel[2] &  writeRegSel[1] &  writeRegSel[0] & writeEn;
assign write4 =  writeRegSel[2] & ~writeRegSel[1] & ~writeRegSel[0] & writeEn;
assign write5 =  writeRegSel[2] & ~writeRegSel[1] &  writeRegSel[0] & writeEn;
assign write6 =  writeRegSel[2] &  writeRegSel[1] & ~writeRegSel[0] & writeEn;
assign write7 =  writeRegSel[2] &  writeRegSel[1] &  writeRegSel[0] & writeEn;

reg_16b r0(.in(writeData),.clk(clk),.rst(rst),.out(R0), .write(write0));
reg_16b r1(.in(writeData),.clk(clk),.rst(rst),.out(R1), .write(write1));
reg_16b r2(.in(writeData),.clk(clk),.rst(rst),.out(R2), .write(write2));
reg_16b r3(.in(writeData),.clk(clk),.rst(rst),.out(R3), .write(write3));
reg_16b r4(.in(writeData),.clk(clk),.rst(rst),.out(R4), .write(write4));
reg_16b r5(.in(writeData),.clk(clk),.rst(rst),.out(R5), .write(write5));
reg_16b r6(.in(writeData),.clk(clk),.rst(rst),.out(R6), .write(write6));
reg_16b r7(.in(writeData),.clk(clk),.rst(rst),.out(R7), .write(write7));


always @(*)
 begin
   case(read1RegSel)
     3'b000 : read1Data = R0;
     3'b001 : read1Data = R1;
     3'b010 : read1Data = R2;
     3'b011 : read1Data = R3;
     3'b100 : read1Data = R4;
     3'b101 : read1Data = R5;
     3'b110 : read1Data = R6;
     3'b111 : read1Data = R7;
     default : err =1;
   endcase
end

always @(*)
 begin
   case(read2RegSel)
     3'b000 : read2Data = R0;
     3'b001 : read2Data = R1;
     3'b010 : read2Data = R2;
     3'b011 : read2Data = R3;
     3'b100 : read2Data = R4;
     3'b101 : read2Data = R5;
     3'b110 : read2Data = R6;
     3'b111 : read2Data = R7;
     default : err=1;
   endcase
end 

endmodule
