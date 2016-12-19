/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Sep 18 21:25:07 2015
/////////////////////////////////////////////////////////////


module fsm ( clock, reset, start, done_flag, match_address, inc_flag, location, 
        outcell );
  input [8:0] match_address;
  output [8:0] location;
  output [8:0] outcell;
  input clock, reset, start, done_flag;
  output inc_flag;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, \U5/Z_0 , \U5/Z_1 , \U5/Z_2 ,
         \U5/Z_3 , \U5/Z_4 , \U5/Z_5 , \U5/Z_6 , \U5/Z_7 , \U5/Z_8 ,
         \U5/DATA2_0 , \U5/DATA2_1 , \U5/DATA2_2 , \U5/DATA2_3 , \U5/DATA2_4 ,
         \U5/DATA2_5 , \U5/DATA2_6 , \U5/DATA2_7 , \U5/DATA2_8 , \U4/Z_0 ,
         \U4/DATA1_0 , n51, n52, n53;
  assign location[0] = \U5/Z_0 ;
  assign location[1] = \U5/Z_1 ;
  assign location[2] = \U5/Z_2 ;
  assign location[3] = \U5/Z_3 ;
  assign location[4] = \U5/Z_4 ;
  assign location[5] = \U5/Z_5 ;
  assign location[6] = \U5/Z_6 ;
  assign location[7] = \U5/Z_7 ;
  assign location[8] = \U5/Z_8 ;
  assign \U5/DATA2_0  = match_address[0];
  assign \U5/DATA2_1  = match_address[1];
  assign \U5/DATA2_2  = match_address[2];
  assign \U5/DATA2_3  = match_address[3];
  assign \U5/DATA2_4  = match_address[4];
  assign \U5/DATA2_5  = match_address[5];
  assign \U5/DATA2_6  = match_address[6];
  assign \U5/DATA2_7  = match_address[7];
  assign \U5/DATA2_8  = match_address[8];
  assign \U4/DATA1_0  = start;

  NOR2_X2 U3 ( .A1(n52), .A2(n53), .ZN(n8) );
  XNOR2_X2 U4 ( .A(\U5/DATA2_7 ), .B(\U5/DATA2_8 ), .ZN(n52) );
  OAI22_X2 U12 ( .A1(done_flag), .A2(n53), .B1(inc_flag), .B2(n51), .ZN(
        \U4/Z_0 ) );
  INV_X4 U13 ( .A(\U4/DATA1_0 ), .ZN(n51) );
  DFF_X2 \outcell_reg[0]  ( .D(\U5/Z_0 ), .CK(clock), .Q(outcell[0]) );
  DFF_X2 \outcell_reg[1]  ( .D(n1), .CK(clock), .Q(outcell[1]) );
  DFF_X2 \outcell_reg[2]  ( .D(n2), .CK(clock), .Q(outcell[2]) );
  DFF_X2 \outcell_reg[3]  ( .D(n3), .CK(clock), .Q(outcell[3]) );
  DFF_X2 \outcell_reg[4]  ( .D(n4), .CK(clock), .Q(outcell[4]) );
  DFF_X2 \outcell_reg[5]  ( .D(n5), .CK(clock), .Q(outcell[5]) );
  DFF_X2 \outcell_reg[6]  ( .D(n6), .CK(clock), .Q(outcell[6]) );
  DFF_X2 \outcell_reg[7]  ( .D(n7), .CK(clock), .Q(outcell[7]) );
  DFF_X2 \outcell_reg[8]  ( .D(n8), .CK(clock), .Q(outcell[8]) );
  DFFR_X2 current_state_reg ( .D(\U4/Z_0 ), .CK(clock), .RN(reset), .Q(
        inc_flag), .QN(n53) );
  AND2_X4 U23 ( .A1(\U5/DATA2_8 ), .A2(inc_flag), .ZN(\U5/Z_8 ) );
  AND2_X4 U24 ( .A1(inc_flag), .A2(\U5/DATA2_7 ), .ZN(\U5/Z_7 ) );
  AND2_X4 U25 ( .A1(\U5/DATA2_6 ), .A2(inc_flag), .ZN(\U5/Z_6 ) );
  AND2_X4 U26 ( .A1(\U5/DATA2_5 ), .A2(inc_flag), .ZN(\U5/Z_5 ) );
  AND2_X4 U27 ( .A1(\U5/DATA2_4 ), .A2(inc_flag), .ZN(\U5/Z_4 ) );
  AND2_X4 U28 ( .A1(\U5/DATA2_3 ), .A2(inc_flag), .ZN(\U5/Z_3 ) );
  AND2_X4 U29 ( .A1(\U5/DATA2_2 ), .A2(inc_flag), .ZN(\U5/Z_2 ) );
  XOR2_X1 U30 ( .A(\U5/Z_7 ), .B(\U5/Z_6 ), .Z(n7) );
  XOR2_X1 U31 ( .A(\U5/Z_6 ), .B(\U5/Z_5 ), .Z(n6) );
  XOR2_X1 U32 ( .A(\U5/Z_5 ), .B(\U5/Z_4 ), .Z(n5) );
  XOR2_X1 U33 ( .A(\U5/Z_4 ), .B(\U5/Z_3 ), .Z(n4) );
  XOR2_X1 U34 ( .A(\U5/Z_3 ), .B(\U5/Z_2 ), .Z(n3) );
  AND2_X4 U35 ( .A1(\U5/DATA2_0 ), .A2(inc_flag), .ZN(\U5/Z_0 ) );
  XOR2_X1 U36 ( .A(\U5/Z_2 ), .B(\U5/Z_1 ), .Z(n2) );
  XOR2_X1 U37 ( .A(\U5/Z_1 ), .B(\U5/Z_0 ), .Z(n1) );
  AND2_X4 U38 ( .A1(\U5/DATA2_1 ), .A2(inc_flag), .ZN(\U5/Z_1 ) );
endmodule

