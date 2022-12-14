module reg_16b (readData, err, clk, rst, writeData, writeEn);
   
   parameter SIZE=16;

   input         clk, rst, writeEn;
   input[SIZE-1:0]  writeData;

   output         err;
   output [SIZE-1:0] readData;

   
   wire[SIZE-1:0] in;
   assign in = (writeEn) ? writeData : readData;

   dff ff[SIZE-1:0](.q(readData) ,.d(in), .clk(clk), .rst(rst));   
   

endmodule