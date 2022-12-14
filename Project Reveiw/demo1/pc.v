
module pc (pc_out, clk, rst,en, pc_in );

   input clk;
   input rst;
   input en;

   input [15:0] pc_in;
   output [15:0] pc_out;

 

dff_cascade_en pc_inst ( .d(pc_in), .clk(clk), .en(en),.rst(rst), .q(pc_out)); 

endmodule 

