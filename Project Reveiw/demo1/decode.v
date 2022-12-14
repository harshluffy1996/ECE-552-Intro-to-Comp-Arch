/*
   CS/ECE 552 Spring '20
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
module decode (err,
          read1Data,
          read2Data,
          se_instruction_7_0,
          ze_instruction_7_0,
          se_instruction_4_0,
          ALU_control_op,
          comp_value_out, 
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
	  siic,
	  clk, rst,
	  instruction,

          Cout,
	  writeData);


input clk;
   input rst;
   input [15:0] instruction;
   input [15:0] writeData;
   input Cout;


   
   output err;
   output [15:0] read1Data;
   output [15:0] read2Data;
   output [15:0] se_instruction_7_0;
   output [15:0] ze_instruction_7_0;
   output [15:0] se_instruction_4_0;
   output [ 3:0] ALU_control_op;
   output        comp_value_out;
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


 // TODO: Your code here
  wire [3:0] mux0_out;
wire err_reg_mod;


assign se_instruction_7_0 = {{ 8{instruction[7]}},instruction[7:0]};
assign se_instruction_4_0 = {{11{instruction[4]}},instruction[4:0]};
assign ze_instruction_7_0 = {8'b0,instruction[7:0]};

quadmux4_1   mux0 (.InA({1'b0,instruction[10:8]}), .InB({1'b0,instruction[4:2]}), .InC(4'b0111), .InD({1'b0,instruction[7:5]}),  .S(regdst), .Out(mux0_out) );


//Register module
regFile reg_inst (.clk(clk),
       	       	  .rst(rst),
		  .read1Data(read1Data),
		  .read2Data(read2Data),
		  .err(err_reg_mod),
		  .read1RegSel(instruction[10:8]),
		  .read2RegSel(instruction[7:5]),
		  .writeRegSel(mux0_out[2:0]),
		  .writeData(writeData),
		  .writeEn(regwrite)
	  );


wire [15:0] operand;
wire AltB;
wire AgtB;
wire AeqB;
wire zero_out;
reg [15:0] diff_i;
reg sign_of_diff_i;
reg eq;

mux16b_2_1 mux_op (.InA(16'b0), .InB(read2Data), .S(instruction[15]), .Out(operand) );
	  
wire [15:0] difference = read1Data - operand;
wire sign_of_difference = difference[15];
assign AltB = (ALU_control_op == 4'b1111) ? (sign_of_diff_i) : (sign_of_difference ? 1'b1 : 1'b0)  ;
assign AgtB = ~AltB;
assign AeqB = zero_out;
assign zero_out = (ALU_control_op == 4'b1111) ? (eq) : ((difference==16'b0) ? 1'b1 : 1'b0);



always @* begin
	sign_of_diff_i = 1'b0;
	eq = 1'b0;
	diff_i = 16'h0;
	//TODO: default case
	case({read1Data[15],operand[15]})
		2'b00,2'b11: begin
		   diff_i = read1Data - operand;
		   eq = ((read1Data == operand) ? 1'b1 : 1'b0);
		   sign_of_diff_i = diff_i[15];
	   end
	   2'b01: begin
		   sign_of_diff_i = 1'b0;
	   end
	   2'b10: begin
		   sign_of_diff_i = 1'b1;
	   end
   endcase
   end
//Control module
control_unit control_unit_inst ( .clk            ( clk ),
                                 .rst            ( rst ),
                                 .instruction    ( instruction ),
	                         .AeqB           (zero_out),
	                         .AltB           (AltB),
	                         .AgtB           (AgtB),
	                         .Cout           (Cout),
				 .ALU_control_op (ALU_control_op),
				 .comp_value_out (comp_value_out),
	                         .branch_and     (branch_and),
                                 .regdst         ( regdst ),
                                 .jump           ( jump ),
                                 .memread        ( memread ),
                                 .memtoreg       ( memtoreg ),
                                 .ALUop          ( ALUop ),
                                 .memwrite       ( memwrite ),
                                 .ALUsrc         ( ALUsrc ),
                                 .regwrite       ( regwrite ),
                                 .regload        ( regload ),
                                 .trunc          ( trunc   ), 
                                 .hlt            ( hlt   ), 
                                 .rti            ( rti   ), 
                                 .siic           ( siic  ) 
			 );    
 
endmodule
