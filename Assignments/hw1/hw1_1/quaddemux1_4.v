module quaddemux1_4(Inp, S, OutA, OutB, OutC, OutD);

input [3:0] Inp;		     //Four Bit Input
input [1:0] S;			     // Two Bit Select Lines
output [3:0] OutA, OutB, OutC, OutD; //Output

//Instantiatiing demux1_4
demux1_4 DEM1(.Inp(Inp[0]), .S(S[1:0]), .OutA(OutA[0]), .OutB(OutB[0]), .OutC(OutC[0]), .OutD(OutD[0])); 
demux1_4 DEM2(.Inp(Inp[1]), .S(S[1:0]), .OutA(OutA[1]), .OutB(OutB[1]), .OutC(OutC[1]), .OutD(OutD[1])); 
demux1_4 DEM3(.Inp(Inp[2]), .S(S[1:0]), .OutA(OutA[2]), .OutB(OutB[2]), .OutC(OutC[2]), .OutD(OutD[2])); 
demux1_4 DEM4(.Inp(Inp[3]), .S(S[1:0]), .OutA(OutA[3]), .OutB(OutB[3]), .OutC(OutC[3]), .OutD(OutD[3])); 
endmodule 