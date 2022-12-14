module demux1_2(Inp, S, OutA, OutB);

input Inp, S;   	//Input Signal
output OutA, OutB;	//1 BIT OUTPUTS A AND B

wire W1, W2, W3;


//Instantiating Gates
nand2 N1(.in1(Inp), .in2(S), .out(W1)); 	 
nand2 N2(.in1(Inp), .in2(W3), .out(W2));	
not1  No3(.in1(S),  .out(W3));			
not1  No1(.in1(W1), .out(OutA));		
not1  No2(.in1(W2), .out(OutB));	

endmodule


