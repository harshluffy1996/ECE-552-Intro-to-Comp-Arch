module fulladder4(A, B, Cin, Cout, S);

input [3:0] A, B;
input Cin;
output [3:0] S;
output Cout;

wire w1, w2, w3;

fulladder1 F1(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]),  .Cout(w1));
fulladder1 F2(.A(A[1]), .B(B[1]), .Cin(w1),  .S(S[1]),  .Cout(w2));
fulladder1 F3(.A(A[2]), .B(B[2]), .Cin(w2),  .S(S[2]),  .Cout(w3));
fulladder1 F4(.A(A[3]), .B(B[3]), .Cin(w3),  .S(S[3]),  .Cout(Cout));
endmodule