/*
   CS/ECE 552 Spring '20
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
module fetch ( err,
	   instruction,
	   PC_adder_out,clk, rst,
	   branch_and,
	   ALU_out,
	   adder_ex_out,
	   jump,
	   hlt,
	   rti,
	   siic);

   // TODO: Your code here
   input clk;
   input rst;
   input branch_and;
   input [15:0] ALU_out;
   input [15:0] adder_ex_out;
   input [1:0] jump;
   input       hlt ;
   input       rti ;
   input       siic ;



   output err;
   output [15:0] instruction;
   output [15:0] PC_adder_out;

   wire [15:0] mux5_out;
wire [15:0] jump_shift;
wire [15:0] jump_adder_out;

wire [15:0] PC_in;
wire [15:0] PC_in_i;
wire [15:0] PC_out;
wire [15:0] EPC_reg;




assign jump_shift = {{5{instruction[10]}},instruction[10:0]}; 
mux16b_4_1 mux4 (.InB(jump_adder_out), .InA(mux5_out), .InC(ALU_out), .InD(16'b0),  .S(jump), .Out(PC_in_i) );//TODO change order

mux16b_2_1 mux5 (.InA(PC_adder_out), .InB(adder_ex_out), .S(branch_and), .Out(mux5_out) );


alu adder0 (.A(PC_out),
              .B(16'h2),
	      .Cin(1'b0),
	      .Op(4'b0100),
	      .invA(1'b0),
	      .invB(1'b0),
	      .sign(1'b0),
	      .Out(PC_adder_out),
	      .Ofl(),
	      .Z(),
	      .Cout(),
	      .AltB(),
	      .AgtB(),
	      .AeqB()
      );

alu adderjump (.A(jump_shift),
              .B(PC_adder_out),
	      .Cin(1'b0),
	      .Op(4'b0100),
	      .invA(1'b0),
	      .invB(1'b0),
	      .sign(1'b0),
	      .Out(jump_adder_out),
	      .Ofl(),
	      .Z(),
	      .Cout(),
	      .AltB(),
	      .AgtB(),
	      .AeqB()
      );



reg_16b epc_reg_inst (.readData(EPC_reg),.err(),.clk(clk),.rst(rst),.writeData(PC_adder_out),.writeEn(siic));

memory2c iMem(.data_out(instruction), .enable(1'b1), .wr(1'b0), .addr(PC_out), .clk(clk), .rst(rst), .data_in(), .createdump());

assign PC_in = siic ? 16'b10 : (rti ? EPC_reg : PC_in_i);


pc pc_inst ( .clk(clk),
       	     .rst(rst),
	     .en(~hlt), //TODO
	    // .en(1'b1),
       	     .pc_in(PC_in),
       	     .pc_out(PC_out)
);

endmodule
