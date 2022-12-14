module demux1_4_tb();

reg Inp;
reg [1:0] S;
wire OutA, OutB, OutC, OutD;
wire w1;

demux1_4 iDUT(.Inp(Inp), 
	      .S(S[1:0]), 
              .OutA(OutA), 
              .OutB(OutB), 
              .OutC(OutC), 
              .OutD(OutD));

initial begin
 #100;
 Inp = 1;
 S = 0;    #100;
 S = 1;    #100;
 S = 2;    #100;
 S = 3;    #100;
 Inp = 0;
 #100;
end
endmodule
