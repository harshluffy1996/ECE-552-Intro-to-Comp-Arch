module shift_left (In, ShAmt, Out);
   
   input [15:0] In;
   input [3:0]  ShAmt;
   output [15:0] Out;
   wire [15:0] m1_out;
   wire [15:0] m2_out;
   wire [15:0] m3_out;
   
   //2:1 muxes instantiation 
   mux2_1 m1(.in_1(In), .in_2({In[14:0], 1'b0}), .ctrl(ShAmt[0]), .mux_out(m1_out));
   mux2_1 m2(.in_1(m1_out), .in_2({m1_out[13:0], 2'b0}), .ctrl(ShAmt[1]), .mux_out(m2_out));
   mux2_1 m3(.in_1(m2_out), .in_2({m2_out[11:0], 4'b0}), .ctrl(ShAmt[2]), .mux_out(m3_out));
   mux2_1 m4(.in_1(m3_out), .in_2({m3_out[7:0], 8'b0}), .ctrl(ShAmt[3]), .mux_out(Out));

 
endmodule

