/*
   CS/ECE 552 Spring '20
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
module execute (err, 
   adder_ex_out,
   zero_out,
   ALU_out,
	AeqB,
	AltB,
	AgtB,
	Cout,
   clk,
   rst,
   PC_adder_out,
   ALUsrc,
   trunc,
   ALU_control_op,
   ALUop,
   instruction,
   se_instruction_7_0,
   ze_instruction_7_0,
   se_instruction_4_0,
   read1Data,
   read2Data);

   input clk;
   input rst;
   input [15:0] PC_adder_out;
   input [15:0] instruction;
   input [15:0] se_instruction_7_0;
   input [15:0] ze_instruction_7_0;
   input [15:0] se_instruction_4_0;
   input [15:0] read1Data;
   input [15:0] read2Data;
   input [3:0] ALU_control_op;
   input [1:0] ALUsrc   ;
   input [2:0] ALUop    ;
   input [1:0] trunc    ; 
   
   output AeqB;
   output AltB;
   output AgtB;
   output Cout;

   output err;
   output [15:0] adder_ex_out;
   output zero_out;
   output [15:0] ALU_out;

   
wire       Cout;


reg branch_alu_out;
wire invA;
wire AltB_i;
wire AgtB;
wire AeqB_i;

wire [15:0] instruction;

wire [15:0] mux8_out;
wire [15:0] mux9_out;
wire mux_select;
wire [15:0] mux1_in0;
wire [15:0] mux1_in1;
wire [15:0] ALU_in2;
wire [15:0] ALU_out_i;


wire [15:0] Out_barrel_0;
wire [15:0] Out_barrel_1;
reg comp_value_out; //TODO: move to control module
//reg [15:0] diff_i;
//reg sign_of_diff_i;
//reg eq;

assign mux_select = ~instruction[15]&instruction[14]&instruction[13];


		   

//Ex
mux16b_2_1 mux9 (.InB(mux1_in0), .InA(16'b0), .S(~mux_select), .Out(mux9_out) );//TODO change order
mux16b_4_1 mux1 (.InA(mux9_out), .InB(mux1_in1), .InC({8'b0,instruction[7:0]}), .InD(mux8_out),  .S(ALUsrc), .Out(ALU_in2) );


//EX
//MUX to select between Reg2 16bits and 4bits
mux16b_2_1 mux6 (.InA(read2Data), .InB({12'b0,read2Data[3:0]}), .S(trunc[0]), .Out(mux1_in0) );

//MUX to select between Instruction 16bits and 4bits
mux16b_2_1 mux7 (.InA(se_instruction_7_0), .InB({12'b0,instruction[3:0]}), .S(trunc[0]), .Out(mux1_in1) );


mux16b_2_1 mux8 (.InA(se_instruction_4_0), .InB({11'b0,instruction[4:0]}), .S(trunc[1]), .Out(mux8_out) );


alu adderex (.A(Out_barrel_0),
              .B(PC_adder_out),
	      .Cin(1'b0),
	      .Op(4'b0100),
	      .invA(1'b0),
	      .invB(1'b0),
	      .sign(1'b0),
	      .Out(adder_ex_out),
	      .Ofl(),
	      .Z(),
	      .Cout(),
	      .AltB(),
	      .AgtB(),
	      .AeqB()
      );
assign invA = (ALU_control_op == 4'b1111) ? 1'b1 : 1'b0;

alu aluinst (.A(read1Data),
              .B(ALU_in2),
	      .Cin(invA),
	      .Op(ALU_control_op),
	      .invA(invA),
	      .invB(1'b0),
	      .sign(invA),
	      .Out(ALU_out_i),
	      .Cout(Cout),
	      .Ofl(),
	      .Z(),
	      .AltB(),
	      .AgtB(),
	      .AeqB()
      );

assign ALU_out = (instruction[15:11] == 5'b10010) ? {read1Data[7:0],instruction[7:0]} : ALU_out_i;


shifter barrel_shifter_0 ( //TODO:remove
	.In  (se_instruction_7_0),
	.Cnt (4'b0),
	.Op  (4'b1),
	.Out (Out_barrel_0)
);

shifter barrel_shifter_1 ( //TODO check
	.In  ({5'b0,instruction[10:0]}),
	.Cnt (4'b0),
	.Op  (4'b1),
	.Out (Out_barrel_1)
);


endmodule
