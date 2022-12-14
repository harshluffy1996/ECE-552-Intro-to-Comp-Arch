module shift_right_arithmatic (In, ShAmt, Out);
   
   input [15:0] In;
   input [3:0]  ShAmt;
   output [15:0] Out;
   
   wire [15:0] m5_out;
   wire [15:0] m6_out;
   wire [15:0] m7_out;

   //2:1 muxes instantiation
   mux2_1 m5(.in_1(In), .in_2({In[15], In[15:1]}), .ctrl(ShAmt[0]), .mux_out(m5_out));
   mux2_1 m6(.in_1(m5_out), .in_2({{2{In[15]}}, m5_out[15:2]}), .ctrl(ShAmt[1]), .mux_out(m6_out));
   mux2_1 m7(.in_1(m6_out), .in_2({{4{In[15]}}, m6_out[15:4]}), .ctrl(ShAmt[2]), .mux_out(m7_out));
   mux2_1 m8(.in_1(m7_out), .in_2({{8{In[15]}}, m7_out[15:8]}), .ctrl(ShAmt[3]), .mux_out(Out));
   

 
endmodule

