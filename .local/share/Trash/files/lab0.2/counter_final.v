
module counter ( clock, in, latch, dec, zero, divide_by_two );
  input [7:0] in;
  input clock, latch, dec, divide_by_two;
  output zero;
  wire   U4_DATA3_1, U4_DATA3_2, U4_DATA3_3, U4_DATA3_5, U4_DATA3_6, n87, n90,
         n92, n93, n94, net324, net326, net327, net336, net338, net346, net352,
         net358, net376, net388, net386, net464, net463, net461, net947,
         net958, net959, net968, net967, net972, net971, net368, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144;

  DFF_X2 value_reg_4_ ( .D(net461), .CK(clock), .Q(U4_DATA3_3), .QN(net352) );
  DFF_X2 value_reg_5_ ( .D(n107), .CK(clock), .QN(net358) );
  DFF_X2 value_reg_2_ ( .D(net958), .CK(clock), .Q(U4_DATA3_1), .QN(n133) );
  DFF_X2 value_reg_6_ ( .D(n87), .CK(clock), .Q(U4_DATA3_5), .QN(n122) );
  DFF_X2 value_reg_1_ ( .D(n92), .CK(clock), .Q(n140), .QN(n135) );
  DFF_X2 value_reg_7_ ( .D(n93), .CK(clock), .Q(U4_DATA3_6), .QN(n117) );
  DFF_X2 value_reg_0_ ( .D(n94), .CK(clock), .Q(n114), .QN(n113) );
  DFF_X2 value_reg_3_ ( .D(n90), .CK(clock), .Q(U4_DATA3_2), .QN(net346) );
  INV_X4 U36 ( .A(net971), .ZN(net972) );
  NAND3_X4 U37 ( .A1(divide_by_two), .A2(n95), .A3(net386), .ZN(net368) );
  INV_X1 U38 ( .A(net368), .ZN(net324) );
  INV_X4 U39 ( .A(dec), .ZN(n95) );
  INV_X4 U40 ( .A(latch), .ZN(net386) );
  OAI221_X2 U41 ( .B1(net967), .B2(net386), .C1(net346), .C2(net368), .A(
        net968), .ZN(net958) );
  OAI211_X1 U42 ( .C1(net358), .C2(net368), .A(net463), .B(net464), .ZN(net461) );
  NAND3_X4 U43 ( .A1(net972), .A2(net386), .A3(net368), .ZN(net327) );
  INV_X2 U44 ( .A(n96), .ZN(n90) );
  AOI221_X2 U45 ( .B1(U4_DATA3_3), .B2(net324), .C1(in[3]), .C2(net388), .A(
        n97), .ZN(n96) );
  INV_X1 U46 ( .A(net386), .ZN(net388) );
  OAI22_X1 U47 ( .A1(net346), .A2(net327), .B1(n98), .B2(net972), .ZN(n97) );
  NOR2_X2 U48 ( .A1(net947), .A2(n99), .ZN(n98) );
  NOR2_X1 U49 ( .A1(net376), .A2(U4_DATA3_2), .ZN(net947) );
  NOR2_X1 U50 ( .A1(net338), .A2(net346), .ZN(n99) );
  INV_X1 U51 ( .A(net376), .ZN(net338) );
  AND2_X1 U52 ( .A1(U4_DATA3_6), .A2(net324), .ZN(n100) );
  AND2_X1 U53 ( .A1(in[6]), .A2(net388), .ZN(n101) );
  NOR3_X2 U54 ( .A1(n100), .A2(n101), .A3(n126), .ZN(n127) );
  OAI22_X1 U55 ( .A1(n122), .A2(net327), .B1(n125), .B2(n115), .ZN(n126) );
  NAND2_X2 U56 ( .A1(n143), .A2(n141), .ZN(n102) );
  NAND2_X2 U57 ( .A1(n103), .A2(n142), .ZN(n94) );
  INV_X4 U58 ( .A(n102), .ZN(n103) );
  MUX2_X1 U59 ( .A(net972), .B(net327), .S(n114), .Z(n142) );
  NAND2_X4 U60 ( .A1(n124), .A2(n117), .ZN(n144) );
  AND2_X4 U61 ( .A1(n113), .A2(n135), .ZN(n105) );
  NAND2_X1 U62 ( .A1(net324), .A2(n140), .ZN(n141) );
  INV_X2 U63 ( .A(n119), .ZN(n124) );
  NOR2_X1 U64 ( .A1(n105), .A2(n136), .ZN(n137) );
  NOR2_X1 U65 ( .A1(n105), .A2(n133), .ZN(n134) );
  INV_X4 U66 ( .A(net326), .ZN(net971) );
  NOR2_X1 U67 ( .A1(net947), .A2(net352), .ZN(n131) );
  AND2_X1 U68 ( .A1(n106), .A2(net358), .ZN(n109) );
  INV_X4 U69 ( .A(in[2]), .ZN(net967) );
  INV_X4 U70 ( .A(net336), .ZN(net968) );
  OAI211_X1 U71 ( .C1(net338), .C2(n134), .A(n144), .B(n108), .ZN(n112) );
  AOI221_X2 U72 ( .B1(in[5]), .B2(latch), .C1(U4_DATA3_5), .C2(net324), .A(
        n130), .ZN(n104) );
  INV_X2 U73 ( .A(n104), .ZN(n107) );
  OAI22_X2 U74 ( .A1(net352), .A2(net327), .B1(n132), .B2(n115), .ZN(net959)
         );
  INV_X4 U75 ( .A(net959), .ZN(net464) );
  NOR2_X2 U76 ( .A1(n123), .A2(n124), .ZN(n125) );
  INV_X2 U77 ( .A(n144), .ZN(zero) );
  NOR2_X1 U78 ( .A1(n106), .A2(net358), .ZN(n128) );
  NOR2_X2 U79 ( .A1(n109), .A2(n128), .ZN(n129) );
  NAND2_X2 U80 ( .A1(n144), .A2(n108), .ZN(n115) );
  NAND3_X2 U81 ( .A1(n144), .A2(dec), .A3(net386), .ZN(net326) );
  AND2_X4 U82 ( .A1(net947), .A2(net352), .ZN(n106) );
  AND2_X4 U83 ( .A1(dec), .A2(net386), .ZN(n108) );
  AND4_X2 U84 ( .A1(net352), .A2(net346), .A3(n122), .A4(net358), .ZN(n116) );
  NAND2_X2 U85 ( .A1(in[4]), .A2(net388), .ZN(net463) );
  NOR2_X1 U86 ( .A1(n113), .A2(n135), .ZN(n136) );
  OR2_X1 U87 ( .A1(n133), .A2(net327), .ZN(n111) );
  NAND2_X2 U88 ( .A1(n111), .A2(n112), .ZN(net336) );
  NAND3_X1 U89 ( .A1(U4_DATA3_6), .A2(n119), .A3(n118), .ZN(n120) );
  INV_X2 U90 ( .A(n139), .ZN(n92) );
  INV_X1 U91 ( .A(n115), .ZN(n118) );
  INV_X2 U92 ( .A(n127), .ZN(n87) );
  OAI22_X1 U93 ( .A1(net358), .A2(net327), .B1(n129), .B2(net972), .ZN(n130)
         );
  OAI22_X1 U94 ( .A1(net327), .A2(n135), .B1(n137), .B2(net972), .ZN(n138) );
  NAND2_X2 U95 ( .A1(n105), .A2(n133), .ZN(net376) );
  NAND2_X2 U96 ( .A1(net338), .A2(n116), .ZN(n119) );
  INV_X4 U97 ( .A(in[7]), .ZN(n121) );
  OAI221_X2 U98 ( .B1(n117), .B2(net327), .C1(net386), .C2(n121), .A(n120), 
        .ZN(n93) );
  NOR2_X2 U99 ( .A1(n109), .A2(n122), .ZN(n123) );
  NOR2_X2 U100 ( .A1(n106), .A2(n131), .ZN(n132) );
  AOI221_X2 U101 ( .B1(U4_DATA3_1), .B2(net324), .C1(in[1]), .C2(net388), .A(
        n138), .ZN(n139) );
  NAND2_X2 U102 ( .A1(in[0]), .A2(net388), .ZN(n143) );
endmodule

