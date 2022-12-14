/*
    CS/ECE 552 FALL'22
    Homework #2, Problem 1
    
    a 4-bit CLA module
*/
module cla_4b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;

  wire [0:3]P; 
  wire [0:3]G;
  wire [4:1]C;
  wire y1, y2, y3, y4, y5, y6, y7, y8, y9, y10;



    ///  Ps
  xor p0(P[0] , a[0] , b[0]);
  xor p1(P[1] , a[1] , b[1]);
  xor p2(P[2] , a[2] , b[2]);
  xor p3(P[3] , a[3] , b[3]);
  
  ///  Gs 
  and g0(G[0] , a[0] , b[0]);
  and g1(G[1] , a[1] , b[1]);
  and g2(G[2] , a[2] , b[2]);
  and g3(G[3] , a[3] , b[3]);
  
  ///  C1
  and carry_11(y1 , P[0] , c_in);
  xor carry_12(C[1] , G[0] , y1);
  
  ///  C2
  and carry_21(y2 , P[1] , G[0]);
  and carry_22(y3 , P[1] , P[0] , c_in);
  xor carry_23(C[2] , y2 , y3 , G[1]);
  
  ///  C3
  and carry_31(y4 , P[2] , G[1]);
  and carry_32(y5 , P[2] , P[1] , G[0]);
  and carry_33(y6 , P[2] , P[1] , P[0] , c_in);
  xor carry_34(C[3] , y4 , y5 , y6 , G[2]);
  
  ///  C4
  and c41(y7 , P[3] , G[2]);
  and c42(y8 , P[3] , P[2] , G[1]);
  and c43(y9 , P[3] , P[2] , P[1] , G[0]);
  and c44(y10 , P[3] , P[2] , P[1] , P[0] , c_in);
  xor c45(c_out , y7 , y8 , y9 , y10 , G[3]);
 
    fullAdder_1b iDUT_1( .a(a[0]),.b(b[0]),.c_in(c_in), .s(sum[0]),.c_out());
 
   fullAdder_1b iDUT_2( .a(a[1]),.b(b[1]),.c_in(C[1]),.s(sum[1]),.c_out());
 
   fullAdder_1b iDUT_3( .a(a[2]),.b(b[2]),.c_in(C[2]),.s(sum[2]),.c_out());
  
   fullAdder_1b iDUT_4( .a(a[3]),.b(b[3]),.c_in(C[3]),.s(sum[3]),.c_out());

   assign c_out = C[4];
  
 


endmodule
