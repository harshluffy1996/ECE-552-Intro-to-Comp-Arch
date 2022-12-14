module reg_16b(input  [15:0] in, input clk , input rst , output  [15:0] out , input write );

wire [15:0] w;
wire [15:0] outwire;

mux2_1 m1(.A(outwire), .B(in), .S(write), .out(w));

dff g1[15:0](.q(outwire), .d(w), .clk(clk), .rst(rst));

assign out = outwire;
endmodule
