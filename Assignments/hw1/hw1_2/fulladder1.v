module fulladder1(A, B, Cin, S, Cout);
input A, B, Cin;
input S;
output Cout;
wire w1, w2, w3;

 xor2 N1( .in1(A), .in2(B), .out(w1));
 xor2 N2( .in1(w1), .in2(Cin), .out(S));
 nand2 NA1( .in1(w1), .in2(Cin), .out(w2));
 nand2 NA2( .in1(A), .in2(B), .out(w3));
 nand2 NA3( .in1(w2), .in2(w3), .out(Cout));

endmodule

