module mux2_1(in_1, in_2, ctrl, mux_out);
	input [15:0] in_1;
	input [15:0] in_2;
	input ctrl;
	output [15:0] mux_out;
	
	assign mux_out = ctrl ? in_2: in_1;
	
endmodule
