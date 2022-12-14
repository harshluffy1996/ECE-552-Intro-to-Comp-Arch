/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
// D-flipflop

module dff_cascade_en #(
 parameter REG_WIDTH =16	
	)
	(q, d, en, clk, rst);

    output [REG_WIDTH -1:0]  q;
    input  [REG_WIDTH -1:0]  d;
    input          en;
    input          clk;
    input          rst;

    wire [REG_WIDTH -1:0] d_next;

    assign d_next = en ? d : q;
  dff reg_inst[REG_WIDTH-1:0] ( .d(d_next), .clk(clk), .rst(rst), .q(q)); 
endmodule
// DUMMY LINE FOR REV CONTROL :0:
