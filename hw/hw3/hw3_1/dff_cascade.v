/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
// D-flipflop

module dff_cascade #(
 parameter REG_WIDTH =16	
	)
	(q, d, clk, rst);

    output [REG_WIDTH -1:0]  q;
    input  [REG_WIDTH -1:0]  d;
    input          clk;
    input          rst;


  dff reg_inst[REG_WIDTH-1:0] ( .d(d), .clk(clk), .rst(rst), .q(q)); 
endmodule
// DUMMY LINE FOR REV CONTROL :0:
