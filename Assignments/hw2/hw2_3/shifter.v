/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 2
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the 'Oper' value that is passed in.  It uses these
    shifts to shift the value any number of bits.
 */
module shifter (In, ShAmt, Oper, Out);

    // declare constant for size of inputs, outputs, and # bits to shift
    parameter OPERAND_WIDTH = 16;
    parameter SHAMT_WIDTH   =  4;
    parameter NUM_OPERATIONS = 2;

    input  [OPERAND_WIDTH -1:0] In   ; // Input operand
    input  [SHAMT_WIDTH   -1:0] ShAmt; // Amount to shift/rotate
    input  [NUM_OPERATIONS-1:0] Oper ; // Operation type
    output reg [OPERAND_WIDTH -1:0] Out  ; // Result of shift/rotate

   wire [15:0] case_0_out, case_1_out, case_2_out, case_3_out;
   
   rotate_left Op1 (.In(In), .ShAmt(ShAmt), .Out(case_0_out));
   shift_left Op2 (.In(In), .ShAmt(ShAmt), .Out(case_1_out));
   shift_right_arithmatic Op3 (.In(In), .ShAmt(ShAmt), .Out(case_2_out));
   shift_right_logical Op4 (.In(In), .ShAmt(ShAmt), .Out(case_3_out));

   always @(*)
   	begin
	    case (Oper)
	      2'b00 : Out = case_0_out;
	      2'b01 : Out = case_1_out;
	      2'b10 : Out = case_2_out;
	      2'b11 : Out = case_3_out;
	      default : Out = 16'b0; 
	    endcase
	end
   
endmodule
