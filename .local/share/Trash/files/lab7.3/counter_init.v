
module counter ( clock, in, latch, dec, zero );
  input [3:0] in;
  input clock, latch, dec;
  output zero;
  wire   \U4/DATA1_0 , \U4/DATA1_1 , \U4/DATA1_2 , \U4/DATA1_3 ,
         \sub_42_S2/A[0] , \sub_42_S2/A[1] , \sub_42_S2/A[2] ,
         \sub_42_S2/A[3] , n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51;
  assign \U4/DATA1_0  = in[0];
  assign \U4/DATA1_1  = in[1];
  assign \U4/DATA1_2  = in[2];
  assign \U4/DATA1_3  = in[3];

  DFF_X1 \value_reg[0]  ( .D(n32), .CK(clock), .Q(\sub_42_S2/A[0] ) );
  DFF_X1 \value_reg[1]  ( .D(n50), .CK(clock), .Q(\sub_42_S2/A[1] ), .QN(n36)
         );
  DFF_X1 \value_reg[2]  ( .D(n33), .CK(clock), .Q(\sub_42_S2/A[2] ) );
  DFF_X1 \value_reg[3]  ( .D(n51), .CK(clock), .Q(\sub_42_S2/A[3] ), .QN(n31)
         );
  NOR2_X2 U5 ( .A1(\sub_42_S2/A[2] ), .A2(\sub_42_S2/A[1] ), .ZN(n41) );
  NAND2_X2 U9 ( .A1(\U4/DATA1_3 ), .A2(latch), .ZN(n46) );
  AOI221_X2 U13 ( .B1(latch), .B2(\U4/DATA1_0 ), .C1(\sub_42_S2/A[0] ), .C2(
        n48), .A(n42), .ZN(n49) );
  NOR2_X2 U14 ( .A1(n35), .A2(\sub_42_S2/A[0] ), .ZN(n42) );
  NOR2_X2 U15 ( .A1(latch), .A2(n47), .ZN(n48) );
  NOR3_X2 U16 ( .A1(zero), .A2(latch), .A3(n37), .ZN(n47) );
  NOR4_X2 U17 ( .A1(\sub_42_S2/A[0] ), .A2(\sub_42_S2/A[1] ), .A3(
        \sub_42_S2/A[2] ), .A4(\sub_42_S2/A[3] ), .ZN(zero) );
  INV_X4 U18 ( .A(n49), .ZN(n32) );
  INV_X4 U19 ( .A(n38), .ZN(n33) );
  INV_X4 U20 ( .A(n40), .ZN(n34) );
  INV_X4 U21 ( .A(n47), .ZN(n35) );
  INV_X4 U22 ( .A(dec), .ZN(n37) );
  AOI21_X2 U23 ( .B1(n47), .B2(\sub_42_S2/A[0] ), .A(n48), .ZN(n43) );
  OAI21_X2 U24 ( .B1(n43), .B2(n36), .A(n44), .ZN(n50) );
  AOI22_X2 U25 ( .A1(\U4/DATA1_1 ), .A2(latch), .B1(n42), .B2(n36), .ZN(n44)
         );
  OAI21_X2 U26 ( .B1(n35), .B2(n36), .A(n43), .ZN(n39) );
  OAI21_X2 U27 ( .B1(n45), .B2(n31), .A(n46), .ZN(n51) );
  AOI21_X2 U28 ( .B1(\sub_42_S2/A[2] ), .B2(n47), .A(n39), .ZN(n45) );
  AOI21_X2 U29 ( .B1(n39), .B2(\sub_42_S2/A[2] ), .A(n34), .ZN(n38) );
  AOI22_X2 U30 ( .A1(n41), .A2(n42), .B1(latch), .B2(\U4/DATA1_2 ), .ZN(n40)
         );
endmodule

