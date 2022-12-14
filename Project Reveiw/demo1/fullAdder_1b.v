//1- bit full adder

module fullAdder_1b (i_bit1, i_bit2, i_carry, o_sum, o_carry);
	input i_bit1;
	input i_bit2;
	input i_carry;
	output o_sum;
	output o_carry;
	
	assign o_sum = i_bit1 ^ i_bit2 ^ i_carry;
	assign o_carry = i_bit1 & i_bit2 | i_carry & (i_bit1 ^ i_bit2);
	
endmodule
