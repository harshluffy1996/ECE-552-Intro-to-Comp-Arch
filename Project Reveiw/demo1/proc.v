/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */
   
   
  wire [1:0] regdst   ;
wire       branch   ;
wire [1:0] jump     ;
wire       memread  ;
wire       memtoreg ;
wire [2:0] ALUop    ;
wire       memwrite ;
wire [1:0] ALUsrc   ;
wire       regwrite ;
wire [1:0] regload  ;
wire [1:0] trunc    ; 
wire       hlt      ; 
wire       siic      ; 
wire       rti      ; 
wire       Cout;


wire branch_and;
wire zero_out;
reg branch_alu_out;
wire AltB;
wire AgtB;
wire AeqB;
wire [3:0] ALU_control_op;

wire [15:0] instruction;
wire [15:0] se_instruction_7_0;
wire [15:0] ze_instruction_7_0;
wire [15:0] se_instruction_4_0;

wire [15:0] ALU_out;
wire [15:0] PC_adder_out;
wire [15:0] adder_ex_out;
wire [15:0] jump_shift;
wire [15:0] mem_rd_data;
wire [15:0] read1Data;
wire [15:0] read2Data;
wire [15:0] writeData;
wire comp_value_out;

wire err_reg_mod;


fetch fetch_inst (.clk(clk),
		  .rst(rst),
		  .branch_and(branch_and),
		  .ALU_out(ALU_out),
		  .adder_ex_out(adder_ex_out),
		  .jump(jump),
                  .siic           (siic),
	          .rti            (rti),
		  .hlt(hlt),
		  .err(),
		  .instruction(instruction),
		  .PC_adder_out(PC_adder_out)
);

decode decode_inst (
         .err        (),
         .clk        ( clk ),
	 .rst        ( rst ),
         .read1Data  ( read1Data ),
         .read2Data  ( read2Data ),
	 .Cout       (Cout),
         .se_instruction_7_0(se_instruction_7_0),
         .ze_instruction_7_0(ze_instruction_7_0),
         .se_instruction_4_0(se_instruction_4_0),
	 .instruction( instruction ),
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
         .siic           (siic),
	 .rti            (rti),
	 .hlt            ( hlt   ), 
	 .writeData      ( writeData )   
   );

execute exec_inst (
	.err               (), 
        .adder_ex_out      (adder_ex_out),
        .PC_adder_out      (PC_adder_out),
	.zero_out          (zero_out),
        .ALU_control_op    (ALU_control_op),
        .ALUsrc            ( ALUsrc ),
        .trunc             ( trunc   ), 
        .ALUop             ( ALUop ),
	.ALU_out           (ALU_out),
	.AeqB              (AeqB),
	.AltB              (AltB),
	.AgtB              (AgtB),
	.Cout              (Cout),
        .clk               (clk),
        .rst               (rst),
        .instruction       (instruction),
        .se_instruction_7_0(se_instruction_7_0),
        .ze_instruction_7_0(ze_instruction_7_0),
        .se_instruction_4_0(se_instruction_4_0),
        .read1Data         (read1Data),
        .read2Data         (read2Data)        
   );

memory memory_inst (
	.err               (), 
        .clk               (clk),
        .rst               (rst),
        .mem_rd_data       (mem_rd_data),
        .read2Data         (read2Data),
        .memwrite          (memwrite),
        .memread           (memread),
        .memaddr           (ALU_out)
   );

wb writeback_inst (
	.err                (), //TODO
        .clk                (clk),
        .rst                (rst),
        .writeData          (writeData), 
        .mem_rd_data1       (mem_rd_data),
        .mem_rd_data2       (ALU_out),
        .se_instruction_7_0 (se_instruction_7_0),
        .memread            (memread),  
        .memtoreg           (memtoreg),
        .memwrite           (memwrite),
        .regload            (regload), 
        .PC_adder_out       (PC_adder_out),
        .comp_value_out     (comp_value_out)

);  
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
