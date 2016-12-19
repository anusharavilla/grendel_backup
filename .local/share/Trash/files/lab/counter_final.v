
module counter ( clock, in, latch, dec, zero );
  input [3:0] in;
  input clock, latch, dec;
  output zero;
  wire   sub_42_S2_A_0_, sub_42_S2_A_1_, sub_42_S2_A_2_, sub_42_S2_A_3_, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51;

  DFF_X1 value_reg_0_ ( .D(n32), .CK(clock), .Q(sub_42_S2_A_0_) );
  DFF_X1 value_reg_1_ ( .D(n50), .CK(clock), .Q(sub_42_S2_A_1_), .QN(n36) );
  DFF_X1 value_reg_2_ ( .D(n33), .CK(clock), .Q(sub_42_S2_A_2_) );
  DFF_X1 value_reg_3_ ( .D(n51), .CK(clock), .Q(sub_42_S2_A_3_), .QN(n31) );
  NOR2_X2 U5 ( .A1(sub_42_S2_A_2_), .A2(sub_42_S2_A_1_), .ZN(n41) );
  NAND2_X2 U9 ( .A1(in[3]), .A2(latch), .ZN(n46) );
  AOI221_X2 U13 ( .B1(latch), .B2(in[0]), .C1(sub_42_S2_A_0_), .C2(n48), .A(
        n42), .ZN(n49) );
  NOR2_X2 U14 ( .A1(n35), .A2(sub_42_S2_A_0_), .ZN(n42) );
  NOR2_X2 U15 ( .A1(latch), .A2(n47), .ZN(n48) );
  NOR3_X2 U16 ( .A1(zero), .A2(latch), .A3(n37), .ZN(n47) );
  NOR4_X2 U17 ( .A1(sub_42_S2_A_0_), .A2(sub_42_S2_A_1_), .A3(sub_42_S2_A_2_), 
        .A4(sub_42_S2_A_3_), .ZN(zero) );
  INV_X4 U18 ( .A(n49), .ZN(n32) );
  INV_X4 U19 ( .A(n38), .ZN(n33) );
  INV_X4 U20 ( .A(n40), .ZN(n34) );
  INV_X4 U21 ( .A(n47), .ZN(n35) );
  INV_X4 U22 ( .A(dec), .ZN(n37) );
  AOI21_X2 U23 ( .B1(n47), .B2(sub_42_S2_A_0_), .A(n48), .ZN(n43) );
  OAI21_X2 U24 ( .B1(n43), .B2(n36), .A(n44), .ZN(n50) );
  AOI22_X2 U25 ( .A1(in[1]), .A2(latch), .B1(n42), .B2(n36), .ZN(n44) );
  OAI21_X2 U26 ( .B1(n35), .B2(n36), .A(n43), .ZN(n39) );
  OAI21_X2 U27 ( .B1(n45), .B2(n31), .A(n46), .ZN(n51) );
  AOI21_X2 U28 ( .B1(sub_42_S2_A_2_), .B2(n47), .A(n39), .ZN(n45) );
  AOI21_X2 U29 ( .B1(n39), .B2(sub_42_S2_A_2_), .A(n34), .ZN(n38) );
  AOI22_X2 U30 ( .A1(n41), .A2(n42), .B1(latch), .B2(in[2]), .ZN(n40) );
endmodule

