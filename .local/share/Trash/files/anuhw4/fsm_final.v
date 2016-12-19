/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Sep 18 21:25:09 2015
/////////////////////////////////////////////////////////////


module fsm ( clock, reset, start, done_flag, match_address, inc_flag, location, 
        outcell );
  input [8:0] match_address;
  output [8:0] location;
  output [8:0] outcell;
  input clock, reset, start, done_flag;
  output inc_flag;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, U4_Z_0, n51, n52, n53;

  NOR2_X2 U3 ( .A1(n52), .A2(n53), .ZN(n8) );
  XNOR2_X2 U4 ( .A(match_address[7]), .B(match_address[8]), .ZN(n52) );
  OAI22_X2 U12 ( .A1(done_flag), .A2(n53), .B1(inc_flag), .B2(n51), .ZN(U4_Z_0) );
  INV_X4 U13 ( .A(start), .ZN(n51) );
  DFF_X2 outcell_reg_0_ ( .D(location[0]), .CK(clock), .Q(outcell[0]) );
  DFF_X2 outcell_reg_1_ ( .D(n1), .CK(clock), .Q(outcell[1]) );
  DFF_X2 outcell_reg_2_ ( .D(n2), .CK(clock), .Q(outcell[2]) );
  DFF_X2 outcell_reg_3_ ( .D(n3), .CK(clock), .Q(outcell[3]) );
  DFF_X2 outcell_reg_4_ ( .D(n4), .CK(clock), .Q(outcell[4]) );
  DFF_X2 outcell_reg_5_ ( .D(n5), .CK(clock), .Q(outcell[5]) );
  DFF_X2 outcell_reg_6_ ( .D(n6), .CK(clock), .Q(outcell[6]) );
  DFF_X2 outcell_reg_7_ ( .D(n7), .CK(clock), .Q(outcell[7]) );
  DFF_X2 outcell_reg_8_ ( .D(n8), .CK(clock), .Q(outcell[8]) );
  DFFR_X2 current_state_reg ( .D(U4_Z_0), .CK(clock), .RN(reset), .Q(inc_flag), 
        .QN(n53) );
  AND2_X4 U23 ( .A1(match_address[8]), .A2(inc_flag), .ZN(location[8]) );
  AND2_X4 U24 ( .A1(inc_flag), .A2(match_address[7]), .ZN(location[7]) );
  AND2_X4 U25 ( .A1(match_address[6]), .A2(inc_flag), .ZN(location[6]) );
  AND2_X4 U26 ( .A1(match_address[5]), .A2(inc_flag), .ZN(location[5]) );
  AND2_X4 U27 ( .A1(match_address[4]), .A2(inc_flag), .ZN(location[4]) );
  AND2_X4 U28 ( .A1(match_address[3]), .A2(inc_flag), .ZN(location[3]) );
  AND2_X4 U29 ( .A1(match_address[2]), .A2(inc_flag), .ZN(location[2]) );
  XOR2_X1 U30 ( .A(location[7]), .B(location[6]), .Z(n7) );
  XOR2_X1 U31 ( .A(location[6]), .B(location[5]), .Z(n6) );
  XOR2_X1 U32 ( .A(location[5]), .B(location[4]), .Z(n5) );
  XOR2_X1 U33 ( .A(location[4]), .B(location[3]), .Z(n4) );
  XOR2_X1 U34 ( .A(location[3]), .B(location[2]), .Z(n3) );
  AND2_X4 U35 ( .A1(match_address[0]), .A2(inc_flag), .ZN(location[0]) );
  XOR2_X1 U36 ( .A(location[2]), .B(location[1]), .Z(n2) );
  XOR2_X1 U37 ( .A(location[1]), .B(location[0]), .Z(n1) );
  AND2_X4 U38 ( .A1(match_address[1]), .A2(inc_flag), .ZN(location[1]) );
endmodule

