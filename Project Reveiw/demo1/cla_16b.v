module cla_16b(in_1, in_2, Cin, Sum, Cout);
	input [15:0] in_1;
	input [15:0] in_2;
	input Cin;
	output [15:0] Sum;
	output Cout;
	
	wire [3:0] sum_0_3_bits;
	wire carry_1;
	
	wire [3:0] sum_4_7_bits;
	wire carry_2;
	
	wire [3:0] sum_8_11_bits;
	wire carry_3;
	
	wire [3:0] sum_12_15_bits;
	wire carry_4;
	
//Instantiation of 4 bit cla adders
	cla_4b cla_0_3_bits(.i_add1(in_1[3:0]), .i_add2(in_2[3:0]), .Cin_4_bit(Cin), .Sum_4_bit(sum_0_3_bits),.Cout_4_bit(carry_1));	
	cla_4b cla_4_7_bits(.i_add1(in_1[7:4]), .i_add2(in_2[7:4]), .Cin_4_bit(carry_1), .Sum_4_bit(sum_4_7_bits),.Cout_4_bit(carry_2));
	cla_4b cla_8_11_bits(.i_add1(in_1[11:8]), .i_add2(in_2[11:8]), .Cin_4_bit(carry_2), .Sum_4_bit(sum_8_11_bits),.Cout_4_bit(carry_3));
	cla_4b cla_12_15_bits(.i_add1(in_1[15:12]), .i_add2(in_2[15:12]), .Cin_4_bit(carry_3), .Sum_4_bit(sum_12_15_bits),.Cout_4_bit(Cout));
	
	assign Sum = {sum_12_15_bits, sum_8_11_bits, sum_4_7_bits, sum_0_3_bits};
	
endmodule
