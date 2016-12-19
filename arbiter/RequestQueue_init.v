
module RequestQueue ( clock, reset, R0, R1, G0, G1 );
  input clock, reset, R0, R1;
  output G0, G1;
  wire   n1, n2, n5, n6, n7, n8, n9, n10, n11, n12, n16, n15, n17, \U4/Z_0 ,
         \U4/Z_1 , \U4/CONTROL4 , \U4/CONTROL3 , \U4/CONTROL2 , \U4/CONTROL1 ,
         \U4/DATA3_0 , \U4/DATA3_1 ;

  \**SEQGEN**  \current_state_reg[1]  ( .clear(n17), .preset(1'b0), 
        .next_state(\U4/Z_1 ), .clocked_on(clock), .data_in(1'b0), .enable(
        1'b0), .Q(n16), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \current_state_reg[0]  ( .clear(n17), .preset(1'b0), 
        .next_state(\U4/Z_0 ), .clocked_on(clock), .data_in(1'b0), .enable(
        1'b0), .Q(n15), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  GTECH_OR2 C98 ( .A(n8), .B(n5), .Z(G0) );
  GTECH_OR2 C102 ( .A(n12), .B(n2), .Z(\U4/DATA3_0 ) );
  GTECH_OR2 C105 ( .A(n12), .B(n1), .Z(\U4/DATA3_1 ) );
  GTECH_NOT I_0 ( .A(reset), .Z(n17) );
  GTECH_AND2 C124 ( .A(R0), .B(R1), .Z(n12) );
  GTECH_NOT I_1 ( .A(n16), .Z(n11) );
  GTECH_NOT I_2 ( .A(n15), .Z(n10) );
  GTECH_NOT I_3 ( .A(n9), .Z(n8) );
  GTECH_NOT I_4 ( .A(n7), .Z(n6) );
  GTECH_BUF B_4 ( .A(n6), .Z(G1) );  assign n9 = (n16 | n10);
  assign \U4/CONTROL4  = (n16 & n15);
  assign n1 = (R1 & ~n12 & ~R0);
  assign \U4/CONTROL3  = G1;
  assign n2 = (~n12 & R0);
  assign n5 = (n16 & n15);
  assign n7 = (n15 | n11);
  assign \U4/CONTROL2  = n8;
  assign \U4/CONTROL1  = (n10 & n11);
  assign \U4/Z_1  = (1'b0 | (\U4/CONTROL1  & \U4/DATA3_1 ) | (\U4/CONTROL2  & 
        \U4/DATA3_1 ) | (\U4/CONTROL3  & \U4/DATA3_1 ) | (\U4/CONTROL4  & 1'b1
        ));
  assign \U4/Z_0  = (1'b0 | (\U4/CONTROL1  & \U4/DATA3_0 ) | (\U4/CONTROL2  & 
        \U4/DATA3_0 ) | (\U4/CONTROL3  & \U4/DATA3_0 ) | (\U4/CONTROL4  & 1'b0
        ));

endmodule

