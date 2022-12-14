module alu (A, B, Cin, Cout, Op, invA, invB, sign, Out, Ofl, Z, AltB, AgtB, AeqB);
   
        input [15:0] A;
        input [15:0] B;
        input Cin;
        input [3:0] Op;
        input invA;
        input invB;
        input sign;
        output [15:0] Out;
        output Ofl;
        output Z;
	  output Cout;
        output AltB;
        output AgtB;
        output AeqB;

wire [15:0] A_int;	
wire [15:0] B_int;	
wire [15:0] A_int_i;	
wire [15:0] notA_int;	
wire        Cin_i;
wire [15:0] cla_Sout;	
wire  cla_Cout;
wire [15:0] Out_barrel_shifter;
wire [15:0] Out_or;
wire [15:0] Out_xor;
wire [15:0] Out_andn;
wire Ofl_det;

localparam OP_ROT_LEFT = 4'b0000 ;    
localparam OP_SFT_LEFT = 4'b0001 ;    
localparam OP_SFT_RT_A = 4'b0010 ;    
localparam OP_SFT_RT_L = 4'b0011 ;    
localparam OP_ADD      = 4'b0100 ;    
localparam OP_OR       = 4'b0101 ;    
localparam OP_XOR      = 4'b0110 ;    
localparam OP_ANDN     = 4'b0111 ; 
localparam OP_COMP     = 4'b1000 ;


localparam OP_ROT_RIGHT= 4'b1100; 
localparam OP_SUB      = 4'b1101; 
localparam OP_BITR     = 4'b1110; 
localparam OP_SLT      = 4'b1111; 

assign A_int   = invA ? ~A : A;
assign B_int   = invB ? ~B : B;
assign notA_int = ~A_int;
assign A_int_i = (Op == OP_SUB) ? notA_int : A_int;
assign Cin_i   = (Op == OP_SUB) ? 1'b1 : Cin;

cla_16b cla_16_inst (
	.in_1(A_int_i),
	.in_2(B_int),
	.Cin(Cin_i),
	.Sum(cla_Sout),
	.Cout(cla_Cout)
);



shifter barrel_shifter (
	.In  (A_int),
	.Cnt (B_int[3:0]),
	.Op  (Op[3:0]),
	.Out (Out_barrel_shifter)
);

//magnitude instantiation
mag mag_inst (.A(A_int), .B(B_int), .AgtB(AgtB), .AltB(AltB), .AeqB(AeqB));

assign Out_or  = A_int | B_int;
assign Out_xor = A_int ^ B_int;
assign Out_andn = A_int & ~ B_int;


assign Z   = (Out == 16'b0) ? 1'b1 : 1'b0 ;
assign Ofl_det =  sign ? (~A_int[15] & ~B_int[15] & cla_Sout[15]) | (A_int[15] & B_int[15] & ~cla_Sout[15]) : cla_Cout   ;
assign Ofl = (Op == OP_ADD|| Op == OP_SLT) ? Ofl_det : 1'b0 ; 

assign Out = (Op[3:2] == 2'b0 || Op == OP_ROT_RIGHT || Op == OP_BITR) ? Out_barrel_shifter : 
	     ((Op == OP_ADD || Op == OP_SUB || Op == OP_SLT) ? cla_Sout :
	     ((Op == OP_OR)  ? Out_or  :
	     ((Op == OP_XOR) ? Out_xor :
	     //((Op == OP_SLBI) ? Out_barrel_shifter :
	     ((Op == OP_ANDN) ? Out_andn : 16'b0 ))));


    
endmodule
