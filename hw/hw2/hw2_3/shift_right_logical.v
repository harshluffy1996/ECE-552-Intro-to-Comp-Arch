module shift_right_logical (In, ShAmt, Out);
   
   input [15:0] In;
   input [3:0]  ShAmt;
   output [15:0] Out;
   wire [15:0] m1_out;
   wire [15:0] m2_out;
   wire [15:0] m3_out;
   
   //2:1 muxes instantiation
   mux2_1 m1(.in_1(In), .in_2({1'b0, In[15:1]}), .ctrl(ShAmt[0]), .mux_out(m1_out));
   mux2_1 m2(.in_1(m1_out), .in_2({2'b0, m1_out[15:2]}), .ctrl(ShAmt[1]), .mux_out(m2_out));
   mux2_1 m3(.in_1(m2_out), .in_2({4'b0, m2_out[15:4]}), .ctrl(ShAmt[2]), .mux_out(m3_out));
   mux2_1 m4(.in_1(m3_out), .in_2({8'b0, m3_out[15:8]}), .ctrl(ShAmt[3]), .mux_out(Out));

 
endmodule

