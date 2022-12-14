
/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here */

  // --- Wires --- 
  wire err_execute, err_decode;

  // Fetch
  wire [15:0] instr;
  wire halt;
  wire [15:0] newPC, nextPC;

  // Decode
  wire [15:0] SExt5, ZExt5, SExt8, ZExt8, SExt11;
  wire SExt;
  wire [15:0] A, B;
  wire [1:0] sourceALU;
  wire nA, nB, Cin;
  wire siic;

  // Execute
  wire [15:0] aluResult;
  wire enJAL;

  // WB
  wire [15:0] readData, writeData;
  wire memWrite;
  wire mem_to_reg;

  // --- Code ---
  assign err = 1'b0;

  fetch fetch0 (
    .newPC(newPC), 
    .halt(halt), 
    .clk(clk), 
    .rst(rst), 
    .nextPC(nextPC), 
    .instr(instr)
  );

  decode decode0 (
    .instr(instr), 
    .writeData(writeData), 
    .clk(clk), 
    .rst(rst), 
    .SExt5(SExt5), 
    .ZExt5(ZExt5), 
    .SExt8(SExt8), 
    .ZExt8(ZExt8), 
    .SExt11(SExt11), 
    .SExt(SExt),
    .A(A), 
    .B(B), 
    .sourceALU(sourceALU), 
    .memWrite(memWrite), 
    .mem_to_reg(mem_to_reg), 
    .nA(nA), 
    .nB(nB), 
    .Cin(Cin), 
    .halt(halt)
  );

  execute execute0 (
    .instr(instr), 
    .A(A), 
    .B(B), 
    .nextPC(nextPC), 
    .SExt5(SExt5), 
    .ZExt5(ZExt5), 
    .SExt8(SExt8), 
    .ZExt8(ZExt8), 
    .SExt11(SExt11), 
    .SExt(SExt),
    .sourceALU(sourceALU), 
    .nA(nA), 
    .nB(nB), 
    .Cin(Cin), 
    .aluResult(aluResult), 
    .newPC(newPC), 
    .enJAL(enJAL)
  );

  memory memory0 (
    .writeData(B), 
    .aluResult(aluResult), 
    .memRead(mem_to_reg), 
    .memWrite(memWrite), 
    .halt(halt), 
    .clk(clk), 
    .rst(rst), 
    .readData(readData)
  );

  wb wb0 (
    .aluResult(aluResult), 
    .readData(readData), 
    .nextPC(nextPC), 
    .enJAL(enJAL), 
    .mem_to_reg(mem_to_reg), 
    .writeData(writeData)
  );
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
