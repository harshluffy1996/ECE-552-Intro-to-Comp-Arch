//2:1 Mux

module mux2_1(
	input  InA,
	input  InB,
	input  S,
	output Out );

//Internal Variable declaration//

wire notS;
wire pdt1;
wire pdt2;

//Logic//


not1  not_inst    (
	.in1(S), 
	.out(notS)
);

nand2 nand_inst_1 (
	.in1(S), 
	.in2(InB), 
	.out(pdt1)
);

nand2 nand_inst_2 (
	.in1(notS), 
	.in2(InA), 
	.out(pdt2)
);

nand2 nand_inst_3 (
	.in1(pdt1), 
	.in2(pdt2), 
	.out(Out)
);

endmodule
	
