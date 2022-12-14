module fulladder16(A, B, S, Cout);

input [15:0] A, B;
output [15:0] S;
output Cout;

wire c0, c1, c2;

fulladder4 FA1(.A(A[3:0]), .B(B[3:0]), .Cout(c0), .S(S[3:0]), .Cin(0));
fulladder4 FA2(.A(A[7:4]), .B(B[7:4]), .Cout(c1), .S(S[7:4]), .Cin(c0));
fulladder4 FA3(.A(A[11:8]), .B(B[11:8]), .Cout(c2), .S(S[11:8]), .Cin(c1));
fulladder4 FA4(.A(A[15:12]), .B(B[15:12]), .Cout(Cout), .S(S[15:12]), .Cin(c2));

endmodule