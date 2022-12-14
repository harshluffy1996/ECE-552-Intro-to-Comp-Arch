module cla_4b (i_add1, i_add2, Cin_4_bit, Sum_4_bit, Cout_4_bit);
  
   input [3:0]  i_add1;
   input [3:0]  i_add2;
   input Cin_4_bit;
   output [3:0] Sum_4_bit;
   output Cout_4_bit;
   
     
  wire [4:0]    w_C;
  wire [3:0]    w_G, w_P, Sum_4_bit;
  
  // Instatiation of 1-bit full adders 
  fullAdder_1b full_adder_bit_0
    ( 
      .i_bit1(i_add1[0]),
      .i_bit2(i_add2[0]),
      .i_carry(w_C[0]),
      .o_sum(Sum_4_bit[0]),
      .o_carry()
      );
 
  fullAdder_1b full_adder_bit_1
    ( 
      .i_bit1(i_add1[1]),
      .i_bit2(i_add2[1]),
      .i_carry(w_C[1]),
      .o_sum(Sum_4_bit[1]),
      .o_carry()
      );
 
  fullAdder_1b full_adder_bit_2
    ( 
      .i_bit1(i_add1[2]),
      .i_bit2(i_add2[2]),
      .i_carry(w_C[2]),
      .o_sum(Sum_4_bit[2]),
      .o_carry()
      );
   
  fullAdder_1b full_adder_bit_3
    ( 
      .i_bit1(i_add1[3]),
      .i_bit2(i_add2[3]),
      .i_carry(w_C[3]),
      .o_sum(Sum_4_bit[3]),
      .o_carry()
      );
   
  // Create the Generate (G) Terms:  Gi=Ai*Bi
  assign w_G[0] = i_add1[0] & i_add2[0];
  assign w_G[1] = i_add1[1] & i_add2[1];
  assign w_G[2] = i_add1[2] & i_add2[2];
  assign w_G[3] = i_add1[3] & i_add2[3];
 
  // Create the Propagate Terms: Pi=Ai+Bi
  assign w_P[0] = i_add1[0] | i_add2[0];
  assign w_P[1] = i_add1[1] | i_add2[1];
  assign w_P[2] = i_add1[2] | i_add2[2];
  assign w_P[3] = i_add1[3] | i_add2[3];
 
  // Create the Carry Terms:
  assign w_C[0] = Cin_4_bit; 
  assign w_C[1] = w_G[0] | (w_P[0] & w_C[0]);
  assign w_C[2] = w_G[1] | (w_P[1] & w_C[1]);
  assign w_C[3] = w_G[2] | (w_P[2] & w_C[2]);
  assign w_C[4] = w_G[3] | (w_P[3] & w_C[3]);
   
  //assign o_result = {w_C[4], Sum_4_bit};   // Verilog Concatenation
  assign Cout_4_bit = w_C[4];
 
endmodule 
