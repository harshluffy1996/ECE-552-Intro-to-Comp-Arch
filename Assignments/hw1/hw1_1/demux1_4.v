module demux1_4(Inp, S, OutA, OutB, OutC, OutD);

input Inp;			//Input Signal
input [1:0] S;			//Select Sig
output OutA, OutB, OutC, OutD;  //Output
wire W1, W2;

//Instantiating demux1_2
demux1_2 D1(.Inp(Inp), .S(S[1]), .OutA(w1), .OutB(W2));   
demux1_2 D2(.Inp(W1), .S(S[0]), .OutA(OutD), .OutB(OutC)); 
demux1_2 D3(.Inp(W2), .S(S[0]), .OutA(OutB), .OutB(OutA)); 
endmodule
