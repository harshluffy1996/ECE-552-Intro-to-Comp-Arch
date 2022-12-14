//4:1 Mux using 2:1 Muxes

module mux4_1 (
	input       InA,
	input       InB,
	input       InC,
	input       InD,
	input [1:0] S,
	output      Out );

//Internal Variable declaration//

wire Out_1;
wire Out_2;

//Logic//

mux2_1 inst_1 (
	.InA(InA),
	.InB(InB),
	.S(S[0]),
	.Out(Out_1)
);
       	        
mux2_1 inst_2 (
	.InA(InC),
	.InB(InD),
	.S(S[0]),
	.Out(Out_2)
);

mux2_1 inst_3 (
	.InA(Out_1),
	.InB(Out_2),
	.S(S[1]),
	.Out(Out)
);

endmodule
	
