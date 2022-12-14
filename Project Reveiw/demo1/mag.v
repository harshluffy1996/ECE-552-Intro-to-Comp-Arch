module mag(
  input [15:0] A, // number to compare
  input [15:0] B, // number to compare
  output AgtB,    // A>B
  output AeqB,    // A==B
  output AltB   // A<B
);


  wire [15:0] gt_vec; 
  wire [15:0] eq_vec;  
  wire [15:0] lt_vec;  
  

  cmp1bit iCMP[15:0](.A(A), .B(B), .AgtBi({gt_vec[14:0],1'b0}),
                     .AeqBi({eq_vec[14:0],1'b1}), .AltBi({lt_vec[14:0],1'b0}),
           .AgtBo(gt_vec), .AeqBo(eq_vec), .AltBo(lt_vec));
  assign AgtB = gt_vec[15];
  assign AeqB = eq_vec[15];
  assign AltB = lt_vec[15];
  
          
endmodule


module cmp1bit(
  input   A,        // incoming A-bit to compare
  input   B,        // incoming B-bit to compare
  input   AgtBi,      // bit below was greater
  input   AeqBi,      // bit below was equal
  input   AltBi,      // bit below was less
  output  AgtBo,      // outgoing compare result
  output  AeqBo,      // outgoing compare result
  output  AltBo     // outgoing compare resul
);



  assign AgtBo = ( A & ~B ) | (~(A ^ B) & AgtBi);
  assign AeqBo = AeqBi & (( A & B ) | (~A & ~B));
  assign AltBo = ( B & ~A ) | (~(A ^ B) & AltBi);

endmodule

