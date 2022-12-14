/*

    CS/ECE 552 FALL '22
    Homework #2, Problem 3

    A multi-bit ALU module (defaults to 16-bit). It is designed to choose
    the correct operation to perform on 2 multi-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the multi-bit result
    of the operation, as well as drive the output signals Zero and Overflow
    (OFL).

*/

module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl);

    parameter OPERAND_WIDTH = 16;   
    parameter NUM_OPERATIONS = 3;
    input  [OPERAND_WIDTH -1:0] InA ; // Input operand A
    input  [OPERAND_WIDTH -1:0] InB ; // Input operand B
    input                       Cin ; // Carry in
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    input                       invA; // Signal to invert A
    input                       invB; // Signal to invert B
    input                       sign; // Signal for signed operation
    output [OPERAND_WIDTH -1:0] Out ; // Result of computation
    output                      Ofl ; // Signal if overflow occured
    output                      Zero; // Signal if Out is 0

wire cout;
wire [15:0] An;
wire [15:0] Bn;
wire [15:0] shifter_out;
wire [15:0] sum;
 
assign An = invA ? ~InA : InA;
assign Bn = invB ? ~InB : InB;

shifter shifterr(.Out (shifter_out), .In(An), .Oper(Oper[1:0]), .ShAmt(Bn[3:0]));
cla_16b adderr (.a(An), .b(Bn), .c_in(Cin), .sum(sum), .c_out(cout));

assign Ofl = sign ? sum[15]^An[15]^Bn[15]^cout : cout;

assign Out =
            (Oper == 3'b110) ? An|Bn :
            (Oper == 3'b111) ? An^Bn :
            (Oper == 3'b101) ? An&Bn :
            (Oper == 3'b000) ? shifter_out :
            (Oper == 3'b001) ?  shifter_out :
            (Oper == 3'b010) ? shifter_out :
            (Oper == 3'b011) ? shifter_out : sum ;

assign Zero = (Out == 16'h0000) ? 1'b1 : 1'b0;
endmodule


