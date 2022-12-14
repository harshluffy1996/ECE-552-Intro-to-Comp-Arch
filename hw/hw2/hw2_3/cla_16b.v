/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1
    
    a 16-bit CLA module
*/
module cla_16b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 16;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;

    wire [3:1]W;
  
  cla_4b FLL0_3 (sum[3:0] , W[1] , a[3:0] , b[3:0] , c_in);
  cla_4b FLL4_7 (sum[7:4] , W[2] , a[7:4] , b[7:4] , W[1]);
  cla_4b FLL8_11 (sum[11:8] , W[3] , a[11:8] , b[11:8] , W[2]);
  cla_4b FLL12_15 (sum[15:12] , c_out , a[15:12] , b[15:12] , W[3]);


endmodule
