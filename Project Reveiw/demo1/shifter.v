module shifter (In, Cnt, Op, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   input [3:0]  Op;
   output reg [15:0] Out;

wire select;
wire append;
reg [15:0] stage_0;
reg [15:0] stage_1;
reg [15:0] stage_2;
wire [15:0] In_rev;

	  assign select = Op[1] & ~Op[0];
	  assign append = select ? In[15] : 1'b0;


assign In_rev[0] = In[15];
assign In_rev[1] = In[14];
assign In_rev[2] = In[13];
assign In_rev[3] = In[12];
assign In_rev[4] = In[11];
assign In_rev[5] = In[10];
assign In_rev[6] = In[9];
assign In_rev[7] = In[8];
assign In_rev[8] = In[7];
assign In_rev[9] = In[6];
assign In_rev[10] = In[5];
assign In_rev[11] = In[4];
assign In_rev[12] = In[3];
assign In_rev[13] = In[2];
assign In_rev[14] = In[1];
assign In_rev[15] = In[0];


  always @(*) begin
	 
	  case (Op) 
		  4'b0000 : begin  //ROL
			  stage_0  = Cnt[0] ? { In[14:0]      ,      In[15]    }: In;
			  stage_1  = Cnt[1] ? { stage_0[13:0] , stage_0[15:14] }: stage_0;
			  stage_2  = Cnt[2] ? { stage_1[11:0] , stage_1[15:12] }: stage_1;
			  Out      = Cnt[3] ? { stage_2 [7:0] , stage_2[15:8]  }: stage_2;
		  end
		  4'b0001 : begin  //SL
			  stage_0 =  Cnt[0] ? ({In[14:0],1'b0}) :  In[15:0] ;
			  stage_1 =  Cnt[1] ? ({stage_0[13:0],2'b0}) :  stage_0[15:0] ;
			  stage_2 =  Cnt[2] ? ({stage_1[11:0],4'b0}) :  stage_1[15:0] ;
			  Out     =  Cnt[3] ? ({stage_2[7:0],8'b0})  :  stage_2[15:0] ;
  		    end
		  4'b0010,4'b0011 : begin //SRA,SRL
			  stage_0 =  Cnt[0] ? ({append,In[15:1]}) :  In[15:0] ;
			  stage_1 =  Cnt[1] ? ({{2{append}},stage_0[15:2]}) :  stage_0[15:0] ;
			  stage_2 =  Cnt[2] ? ({{4{append}},stage_1[15:4]}) :  stage_1[15:0] ;
			  Out     =  Cnt[3] ? ({{8{append}},stage_2[15:8]})  :  stage_2[15:0] ;
			    
		  end
		  4'b1100 : begin  //ROR
			  stage_0  = Cnt[0] ? { In[0]        , In[15:1]      }: In;
			  stage_1  = Cnt[1] ? { stage_0[1:0] , stage_0[15:2] }: stage_0;
			  stage_2  = Cnt[2] ? { stage_1[3:0] , stage_1[15:4] }: stage_1;
			  Out      = Cnt[3] ? { stage_2[7:0] , stage_2[15:8] }: stage_2;
		  end
		  4'b1110 : begin  //BITR
			  Out      = In_rev ;
		  end
		
		  default : begin
			  Out = {16{1'b0}};
		  end
  endcase
  end


endmodule

