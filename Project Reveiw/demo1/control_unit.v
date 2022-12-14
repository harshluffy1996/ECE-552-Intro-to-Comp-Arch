module control_unit (
   
   	clk,
	rst,
	instruction,
	AeqB,
	AltB,
	AgtB,
	Cout,
   
   
        ALU_control_op,
        comp_value_out, //TODO:logic
   	regdst,
	branch_and,
	jump,
	memread,
	memtoreg,
	ALUop,
	memwrite,
	ALUsrc,
	regwrite,
	regload,
	trunc,
	hlt,
	rti,
	siic
   );

   input clk;
   input rst;
   input AeqB;
   input AltB;
   input AgtB;
   input Cout;
   input  [15:0] instruction;
   output [ 3:0] ALU_control_op;
   output reg    comp_value_out;
   output [ 1:0] regdst     ;
   output        branch_and ;
   output [ 1:0] jump       ;
   output        memread    ;
   output        memtoreg   ;
   output [ 2:0] ALUop      ;
   output        memwrite   ;
   output [ 1:0] ALUsrc     ;
   output        regwrite   ;
   output [ 1:0] regload    ;
   output [ 1:0] trunc      ;      
   output        hlt        ;      
   output        rti        ;      
   output        siic        ;      

reg [1:0] regdst_i   ;
reg       branch_i   ;
reg [1:0] jump_i     ;
reg       memread_i  ;
reg       memtoreg_i ;
reg [2:0] ALUop_i    ;
reg       memwrite_i ;
reg [1:0] ALUsrc_i   ;
reg       regwrite_i ;
reg [1:0] regload_i  ;
reg [1:0] trunc_i    ;     
reg       hlt_i      ;     
reg       rti_i      ;     
reg       siic_i      ;     
reg       branch_alu_out;
wire branch;
wire [1:0] jump;
reg [3:0] ALU_control;  
wire [6:0] ALUcontrol_in;  


assign regdst   = regdst_i  ;
assign branch   = branch_i  ;
assign jump     = jump_i    ;
assign memread  = memread_i ;
assign memtoreg = memtoreg_i;
assign ALUop    = ALUop_i   ;
assign memwrite = memwrite_i;
assign ALUsrc   = ALUsrc_i  ;
assign regwrite = regwrite_i;
assign regload  = regload_i ;
assign trunc    = trunc_i   ;
assign hlt      = hlt_i     ;
assign rti      = rti_i     ;
assign siic     = siic_i    ;

   always @* begin
	   casex (instruction[15:11])
		   5'b00000: begin
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b1 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b00001: begin
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b00010: begin //SIIC
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b1 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ; 
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b1;	
		end	
		   5'b00011: begin //RTI
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b1 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ; 
   			rti_i      <= 1'b1 ;  
		        siic_i     <= 1'b0;	
		end	
		   5'b00100: begin
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b1 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b00101: begin //JR
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b10 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b111 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b1 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b00110: begin
   			regdst_i   <= 2'b10 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b1 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b11 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b10 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b00111: begin //JALR
   			regdst_i   <= 2'b10 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b10 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b1 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b1 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b10 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b010??: begin
   			regdst_i   <= 2'b11 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b11 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b11 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= {instruction[12],1'b0} ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b011??: begin //branch
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b1 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b10 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b10001: begin //LD
   			regdst_i   <= 2'b11 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b1 ;
			memtoreg_i <= 1'b1 ;
			ALUop_i    <= 3'b1 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b11 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b10000: begin //ST
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b1 ;
			memwrite_i <= 1'b1 ;
			ALUsrc_i   <= 2'b11 ;
			regwrite_i <= 1'b0 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b10011: begin //STU
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b1 ;
			memwrite_i <= 1'b1 ;
			ALUsrc_i   <= 2'b11 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b101??: begin
   			regdst_i   <= 2'b11 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b100 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b1 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b1 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11000: begin //LBI
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b1 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b10010: begin //SLBI
   			regdst_i   <= 2'b0 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b10 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b10 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11001: begin
   			regdst_i   <= 2'b1 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b1 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11010: begin
   			regdst_i   <= 2'b1 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b1 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11011: begin
   			regdst_i   <= 2'b1 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b0 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b0 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11100: begin //SEQ
   			regdst_i   <= 2'b1 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b101 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b11 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11101: begin //SLT
   			regdst_i   <= 2'b1 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b110 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b11 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11110: begin //SLE
   			regdst_i   <= 2'b1 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b110 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b11 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
		   5'b11111: begin //SCO
   			regdst_i   <= 2'b1 ;  
			branch_i   <= 1'b0 ;
			jump_i     <= 2'b0 ;
			memread_i  <= 1'b0 ;
			memtoreg_i <= 1'b0 ;
			ALUop_i    <= 3'b101 ;
			memwrite_i <= 1'b0 ;
			ALUsrc_i   <= 2'b0 ;
			regwrite_i <= 1'b1 ;
			regload_i  <= 2'b11 ;
   			trunc_i    <= 2'b0 ;  
   			hlt_i      <= 1'b0 ;  
   			rti_i      <= 1'b0 ;  
		        siic_i     <= 1'b0;	
		end
	endcase
end

assign branch_and = branch & branch_alu_out;

   assign ALUcontrol_in = {ALUop,instruction[12:11],instruction[1:0]};

 always @(ALUcontrol_in)  begin
	 casex (ALUcontrol_in)
  		 7'b000_0100: ALU_control=4'b1110; //BTR 
  		 7'b000_1100: ALU_control=4'b0100; //ADD 
  		 7'b000_1101: ALU_control=4'b1101; //SUB
 		 7'b000_1110: ALU_control=4'b0110; //XOR 
 		 7'b000_1111: ALU_control=4'b0111; //ANDN 
 		 7'b000_1000: ALU_control=4'b0000; //ROL 
 		 7'b000_1001: ALU_control=4'b0001; //SLL 
 		 7'b000_1010: ALU_control=4'b1100; //ROR 
 		 7'b000_1011: ALU_control=4'b0011; //SRL 
		 
		 7'b001_xxxx: ALU_control=4'b0100;  
		 
		// 7'b010_00xx: ALU_control=4'b; //BEQZ  
		// 7'b010_01xx: ALU_control=4'b; //BNEZ  
		// 7'b010_10xx: ALU_control=4'b; //BLTZ  
		// 7'b010_11xx: ALU_control=4'b; //BGEZ

		 7'b011_00xx: ALU_control=4'b0100; //ADDI  
		 7'b011_01xx: ALU_control=4'b1101; //SUBI  
		 7'b011_10xx: ALU_control=4'b0110; //XORI  
		 7'b011_11xx: ALU_control=4'b0111; //ANDNI
		 
		 7'b100_00xx: ALU_control=4'b0000; //ROLI  
		 7'b100_01xx: ALU_control=4'b0001; //SLLI  
		 7'b100_10xx: ALU_control=4'b1100; //RORI  
		 7'b100_11xx: ALU_control=4'b0011; //SRLI
		 7'b111_01xx: ALU_control=4'b0100; //JR
		 
		// 7'b101_00xx: ALU_control=4'b; //SEQ  
		 7'b110_01xx: ALU_control=4'b1111; //SLT  
		 7'b110_10xx: ALU_control=4'b1111; //SLE  
		// 7'b101_11xx: ALU_control=4'b; //SCO
	         	 
 		// 6'b1000xx: ALU_control=4'b;  
  		 default:   ALU_control=4'b0000;  
	 endcase
 end
assign ALU_control_op = ALU_control;

       always @(*)  begin
			branch_alu_out = 1'b0;
			comp_value_out = 1'b0;
         casex ({ALUop,instruction[12:11]})
                 5'b10100: comp_value_out=AeqB; //SEQ
                 5'b11001: comp_value_out=AltB; //SLT
                 5'b11010: comp_value_out=AltB|AeqB; //SLE
                 5'b10111: comp_value_out=Cout; //SCO
                 5'b01000: branch_alu_out=AeqB; //BEQZ
                 5'b01001: branch_alu_out=~AeqB; //BNEZ
                 5'b01010: branch_alu_out=AltB; //BLTZ
                 5'b01011: branch_alu_out=AgtB|AeqB; //BGEZ
		default: begin
			branch_alu_out = 1'b0;
			comp_value_out = 1'b0;
		end
	 endcase
 end




endmodule 
