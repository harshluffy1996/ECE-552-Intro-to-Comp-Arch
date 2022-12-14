module demux1_2_tb();

reg Inp, S;
wire OutA, OutB;
wire w1,w2,w3;

demux1_2 iDUT(.Inp(Inp), .S(S), .OutA(OutA), .OutB(OutB));

initial begin
#10
Inp =0;
S=0;

#10
Inp =1;
S=0;

#10
Inp =1;
S=1;

#10
Inp =0;
S=1;

#10
$stop();
end
endmodule
