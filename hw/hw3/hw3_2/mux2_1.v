module mux2_1 (input [15:0] A, input [15:0]B , input S , output [15:0] out);

assign out = S ? B : A;

endmodule 
