//Quad 4:1 Mux by instantiating 4 4:1 muxes

module quadmux4_1 (
	input  [3:0] InA,
	input  [3:0] InB,
	input  [3:0] InC,
	input  [3:0] InD,
	input  [1:0] S,
	output [3:0] Out );

//Internal Variable declaration//

wire Out_1;
wire Out_2;

//Logic//


mux4_1 inst_0 ( .InA(InA[0]), .InB(InB[0]), .InC(InC[0]), .InD(InD[0]), .S(S), .Out(Out[0]) );
mux4_1 inst_1 ( .InA(InA[1]), .InB(InB[1]), .InC(InC[1]), .InD(InD[1]), .S(S), .Out(Out[1]) );
mux4_1 inst_2 ( .InA(InA[2]), .InB(InB[2]), .InC(InC[2]), .InD(InD[2]), .S(S), .Out(Out[2]) );
mux4_1 inst_3 ( .InA(InA[3]), .InB(InB[3]), .InC(InC[3]), .InD(InD[3]), .S(S), .Out(Out[3]) );



endmodule
	
