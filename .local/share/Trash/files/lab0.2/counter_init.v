
module counter ( clock, in, latch, dec, zero, divide_by_two );
  input [7:0] in;
  input clock, latch, dec, divide_by_two;
  output zero;
  wire   net461, net958, n114, n117, n140, n145, n186, net1559, net1562,
         net1563, net1565, net1567, net1570, net1571, net1572, net1573,
         net1574, net1575, net1577, net1579, net1580, net1587, net1589,
         net1593, net1594, net1596, net1608, net1617, net1626, net1633,
         net1636, net1635, net1647, net1658, net1665, net1692, net1691,
         net1690, net1721, net1720, net1627, net1619, net1618, net1641,
         net1631, net1609, net1595, net1590, net2275, net2296, net2401,
         net2359, net2358, net2348, net1601, net1599, net1597, net1610,
         net1605, net1600, net1613, net1588, n190, n191, n192, n193, n194,
         n195, n196, n197, n198, n199, n200, n201, n202, n203, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223;

  DFF_X2 value_reg_7_ ( .D(n145), .CK(clock), .QN(n117) );
  DFF_X2 value_reg_6_ ( .D(n186), .CK(clock), .Q(net1577), .QN(net1665) );
  DFF_X2 value_reg_2_ ( .D(net958), .CK(clock), .Q(net2275), .QN(net1631) );
  DFF_X2 value_reg_0_ ( .D(n219), .CK(clock), .Q(n114), .QN(net2348) );
  DFF_X2 value_reg_5_ ( .D(n214), .CK(clock), .Q(net1633), .QN(n202) );
  DFF_X2 value_reg_4_ ( .D(net461), .CK(clock), .Q(net1635), .QN(net1636) );
  DFF_X2 value_reg_1_ ( .D(net1690), .CK(clock), .Q(n140), .QN(net2296) );
  DFF_X2 value_reg_3_ ( .D(n217), .CK(clock), .Q(net1626), .QN(net1627) );
  AND2_X1 U85 ( .A1(net1567), .A2(net1626), .ZN(n190) );
  AND2_X1 U86 ( .A1(in[2]), .A2(net1619), .ZN(n191) );
  NOR3_X2 U87 ( .A1(n190), .A2(n191), .A3(net1599), .ZN(net1597) );
  INV_X1 U88 ( .A(net1618), .ZN(net1619) );
  OR2_X1 U89 ( .A1(net1647), .A2(net1631), .ZN(n192) );
  OR2_X1 U90 ( .A1(net1691), .A2(net1618), .ZN(n193) );
  NAND3_X2 U91 ( .A1(n192), .A2(n193), .A3(net1692), .ZN(net1690) );
  AOI21_X2 U92 ( .B1(net2275), .B2(n140), .A(net1590), .ZN(net1601) );
  OAI21_X2 U93 ( .B1(net1665), .B2(n202), .A(n194), .ZN(n195) );
  INV_X4 U94 ( .A(n201), .ZN(n194) );
  AOI22_X2 U95 ( .A1(net1562), .A2(n114), .B1(net1589), .B2(net2348), .ZN(n200) );
  AOI22_X2 U96 ( .A1(net1579), .A2(net1577), .B1(n195), .B2(net1589), .ZN(n197) );
  OAI22_X2 U97 ( .A1(net1570), .A2(net1636), .B1(net1641), .B2(net1571), .ZN(
        n222) );
  OAI221_X2 U98 ( .B1(n196), .B2(net1618), .C1(n117), .C2(net1613), .A(n197), 
        .ZN(n186) );
  INV_X4 U99 ( .A(in[6]), .ZN(n196) );
  NAND3_X2 U100 ( .A1(net1565), .A2(net1618), .A3(net1613), .ZN(net1588) );
  NAND2_X2 U101 ( .A1(net2358), .A2(net2359), .ZN(net1565) );
  INV_X4 U102 ( .A(latch), .ZN(net1618) );
  NAND3_X2 U103 ( .A1(divide_by_two), .A2(net1618), .A3(net1617), .ZN(net1613)
         );
  INV_X1 U104 ( .A(net1588), .ZN(net1562) );
  NAND2_X2 U105 ( .A1(net1587), .A2(net1588), .ZN(net1579) );
  NAND2_X2 U106 ( .A1(net1610), .A2(net1588), .ZN(net1605) );
  NAND2_X1 U107 ( .A1(net1596), .A2(net1588), .ZN(net1575) );
  INV_X4 U108 ( .A(dec), .ZN(net1617) );
  INV_X1 U109 ( .A(net1613), .ZN(net1567) );
  INV_X2 U110 ( .A(net1605), .ZN(net1600) );
  OAI22_X2 U111 ( .A1(net1631), .A2(net1600), .B1(net1601), .B2(net1641), .ZN(
        net1599) );
  NAND2_X2 U112 ( .A1(net1589), .A2(n114), .ZN(net1610) );
  INV_X4 U113 ( .A(net2401), .ZN(net1589) );
  MUX2_X2 U114 ( .A(net1605), .B(net1609), .S(net2296), .Z(net1608) );
  INV_X4 U115 ( .A(net1597), .ZN(net958) );
  INV_X4 U116 ( .A(net1595), .ZN(net1590) );
  INV_X1 U117 ( .A(net1589), .ZN(net1641) );
  OR2_X1 U118 ( .A1(net1647), .A2(net1636), .ZN(n198) );
  OR2_X1 U119 ( .A1(n218), .A2(net1618), .ZN(n199) );
  NAND3_X2 U120 ( .A1(n198), .A2(n199), .A3(net1658), .ZN(n217) );
  NAND2_X1 U121 ( .A1(in[7]), .A2(latch), .ZN(n203) );
  NOR2_X1 U122 ( .A1(net1617), .A2(latch), .ZN(n211) );
  AND4_X4 U123 ( .A1(n204), .A2(net2348), .A3(n205), .A4(n206), .ZN(n201) );
  OAI21_X2 U124 ( .B1(n117), .B2(net1559), .A(n203), .ZN(n145) );
  INV_X4 U125 ( .A(net2359), .ZN(zero) );
  NAND3_X2 U126 ( .A1(net2348), .A2(net2296), .A3(net1631), .ZN(net1595) );
  NOR2_X2 U127 ( .A1(net1595), .A2(net1565), .ZN(net1594) );
  NOR2_X2 U128 ( .A1(n114), .A2(net1565), .ZN(net1609) );
  AND2_X1 U129 ( .A1(n117), .A2(net1665), .ZN(n207) );
  NOR2_X2 U130 ( .A1(n140), .A2(n114), .ZN(n208) );
  NOR2_X2 U131 ( .A1(net1635), .A2(net1633), .ZN(n209) );
  NOR2_X2 U132 ( .A1(net1626), .A2(net2275), .ZN(n210) );
  NOR2_X2 U133 ( .A1(net1633), .A2(net1626), .ZN(n206) );
  NOR2_X2 U134 ( .A1(net1635), .A2(net2275), .ZN(n205) );
  NOR2_X2 U135 ( .A1(n140), .A2(net1577), .ZN(n204) );
  NOR2_X2 U136 ( .A1(net1617), .A2(latch), .ZN(net2358) );
  NAND4_X2 U137 ( .A1(n210), .A2(n209), .A3(n208), .A4(n207), .ZN(net2359) );
  NAND2_X2 U138 ( .A1(n211), .A2(net2359), .ZN(net2401) );
  NOR2_X1 U139 ( .A1(net1565), .A2(net1574), .ZN(net1580) );
  NOR2_X1 U140 ( .A1(n201), .A2(net1641), .ZN(net1563) );
  NAND3_X2 U141 ( .A1(net1627), .A2(net1636), .A3(net1590), .ZN(net1574) );
  NAND2_X2 U142 ( .A1(net1589), .A2(net1595), .ZN(net1596) );
  AND2_X1 U143 ( .A1(in[4]), .A2(net1619), .ZN(net1721) );
  NOR2_X1 U144 ( .A1(net1627), .A2(net1636), .ZN(net1573) );
  MUX2_X2 U145 ( .A(net1575), .B(net1594), .S(net1627), .Z(net1593) );
  AND2_X1 U146 ( .A1(net1567), .A2(net1633), .ZN(net1720) );
  NOR3_X2 U147 ( .A1(net1720), .A2(net1721), .A3(n222), .ZN(n223) );
  INV_X1 U148 ( .A(net1575), .ZN(net1570) );
  OR2_X1 U149 ( .A1(net1647), .A2(net1665), .ZN(n212) );
  OR2_X1 U150 ( .A1(n215), .A2(net1618), .ZN(n213) );
  NAND3_X2 U151 ( .A1(n212), .A2(n213), .A3(n216), .ZN(n214) );
  NAND2_X1 U152 ( .A1(net1589), .A2(net1574), .ZN(net1587) );
  INV_X4 U153 ( .A(in[0]), .ZN(n220) );
  INV_X4 U154 ( .A(in[3]), .ZN(n218) );
  INV_X4 U155 ( .A(in[5]), .ZN(n215) );
  INV_X4 U156 ( .A(in[1]), .ZN(net1691) );
  OAI221_X2 U157 ( .B1(net2296), .B2(net1647), .C1(n220), .C2(net1618), .A(
        n200), .ZN(n219) );
  INV_X4 U158 ( .A(net1608), .ZN(net1692) );
  INV_X4 U159 ( .A(n221), .ZN(n216) );
  INV_X4 U160 ( .A(net1593), .ZN(net1658) );
  INV_X4 U161 ( .A(net1567), .ZN(net1647) );
  NOR2_X1 U162 ( .A1(net1562), .A2(net1563), .ZN(net1559) );
  MUX2_X2 U163 ( .A(net1579), .B(net1580), .S(n202), .Z(n221) );
  INV_X4 U164 ( .A(net1574), .ZN(net1572) );
  NOR2_X2 U165 ( .A1(net1572), .A2(net1573), .ZN(net1571) );
  INV_X4 U166 ( .A(n223), .ZN(net461) );
endmodule

