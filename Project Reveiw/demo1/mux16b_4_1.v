
module mux16b_4_1 (
	input  [15:0] InA,
	input  [15:0] InB,
	input  [15:0] InC,
	input  [15:0] InD,
	input  [1:0]  S,
	output [15:0] Out );

//Internal Variable declaration//


//Logic//


mux4_1 inst_0  ( .InA(InA[0 ]), .InB(InB[0 ]), .InC(InC[0 ]), .InD(InD[0 ]), .S(S), .Out(Out[0 ]) );
mux4_1 inst_1  ( .InA(InA[1 ]), .InB(InB[1 ]), .InC(InC[1 ]), .InD(InD[1 ]), .S(S), .Out(Out[1 ]) );
mux4_1 inst_2  ( .InA(InA[2 ]), .InB(InB[2 ]), .InC(InC[2 ]), .InD(InD[2 ]), .S(S), .Out(Out[2 ]) );
mux4_1 inst_3  ( .InA(InA[3 ]), .InB(InB[3 ]), .InC(InC[3 ]), .InD(InD[3 ]), .S(S), .Out(Out[3 ]) );
mux4_1 inst_4  ( .InA(InA[4 ]), .InB(InB[4 ]), .InC(InC[4 ]), .InD(InD[4 ]), .S(S), .Out(Out[4 ]) );
mux4_1 inst_5  ( .InA(InA[5 ]), .InB(InB[5 ]), .InC(InC[5 ]), .InD(InD[5 ]), .S(S), .Out(Out[5 ]) );
mux4_1 inst_6  ( .InA(InA[6 ]), .InB(InB[6 ]), .InC(InC[6 ]), .InD(InD[6 ]), .S(S), .Out(Out[6 ]) );
mux4_1 inst_7  ( .InA(InA[7 ]), .InB(InB[7 ]), .InC(InC[7 ]), .InD(InD[7 ]), .S(S), .Out(Out[7 ]) );
mux4_1 inst_8  ( .InA(InA[8 ]), .InB(InB[8 ]), .InC(InC[8 ]), .InD(InD[8 ]), .S(S), .Out(Out[8 ]) );
mux4_1 inst_9  ( .InA(InA[9 ]), .InB(InB[9 ]), .InC(InC[9 ]), .InD(InD[9 ]), .S(S), .Out(Out[9 ]) );
mux4_1 inst_10 ( .InA(InA[10]), .InB(InB[10]), .InC(InC[10]), .InD(InD[10]), .S(S), .Out(Out[10]) );
mux4_1 inst_11 ( .InA(InA[11]), .InB(InB[11]), .InC(InC[11]), .InD(InD[11]), .S(S), .Out(Out[11]) );
mux4_1 inst_12 ( .InA(InA[12]), .InB(InB[12]), .InC(InC[12]), .InD(InD[12]), .S(S), .Out(Out[12]) );
mux4_1 inst_13 ( .InA(InA[13]), .InB(InB[13]), .InC(InC[13]), .InD(InD[13]), .S(S), .Out(Out[13]) );
mux4_1 inst_14 ( .InA(InA[14]), .InB(InB[14]), .InC(InC[14]), .InD(InD[14]), .S(S), .Out(Out[14]) );
mux4_1 inst_15 ( .InA(InA[15]), .InB(InB[15]), .InC(InC[15]), .InD(InD[15]), .S(S), .Out(Out[15]) );



endmodule
	
