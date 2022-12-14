/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1
    
    a 1-bit full adder
*/
module fullAdder_1b( a, b, c_in, s, c_out);
     	input  a, b;
      input  c_in;
	output s;
      output c_out;

    wire w1, w2, w3;

     xor2 N1( .in1(a), .in2(b), .out(w1));
     xor2 N2( .in1(w1), .in2(c_in), .out(s));
     nand2 NA1( .in1(a), .in2(b), .out(w2));
     nand2 NA2( .in1(c_in), .in2(w1), .out(w3));
     nand2 NA3( .in1(w2), .in2(w3), .out(c_out));

endmodule
