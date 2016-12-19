/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Aug 22 16:11:43 2016
/////////////////////////////////////////////////////////////


module AHB_Lite_2s ( HCLK, HRESETn, HADDR, HBURST, HMASTLOCK, HPROT, HSIZE, 
        HTRANS, HWDATA, HWRITE, hsel_s1, hready_resp_s1, hresp_s1, hrdata_s1, 
        hsel_s2, hready_resp_s2, hresp_s2, hrdata_s2, haddr_s, hburst_s, 
        hprot_s, hsize_s, htrans_s, hwdata_s, hwrite_s, HREADY, hresp_ahb, 
        HRDATA, hmaster, hmaster_data, hmastlock_s );
  input [31:0] HADDR;
  input [2:0] HBURST;
  input [3:0] HPROT;
  input [2:0] HSIZE;
  input [1:0] HTRANS;
  input [31:0] HWDATA;
  input [1:0] hresp_s1;
  input [31:0] hrdata_s1;
  input [1:0] hresp_s2;
  input [31:0] hrdata_s2;
  output [31:0] haddr_s;
  output [2:0] hburst_s;
  output [3:0] hprot_s;
  output [2:0] hsize_s;
  output [1:0] htrans_s;
  output [31:0] hwdata_s;
  output [1:0] hresp_ahb;
  output [31:0] HRDATA;
  output [3:0] hmaster;
  output [3:0] hmaster_data;
  input HCLK, HRESETn, HMASTLOCK, HWRITE, hready_resp_s1, hready_resp_s2;
  output hsel_s1, hsel_s2, hwrite_s, hmastlock_s;
  inout HREADY;
  wire   n310, n309, n207;
  assign HREADY = hready_resp_s1;

  AO22X1_LVT U4 ( .A1(hrdata_s2[9]), .A2(hsel_s2), .A3(hrdata_s1[9]), .A4(
        hsel_s1), .Y(HRDATA[9]) );
  AO22X1_LVT U5 ( .A1(hrdata_s2[8]), .A2(hsel_s2), .A3(hrdata_s1[8]), .A4(
        hsel_s1), .Y(HRDATA[8]) );
  AO22X1_LVT U6 ( .A1(hrdata_s2[7]), .A2(hsel_s2), .A3(hrdata_s1[7]), .A4(
        hsel_s1), .Y(HRDATA[7]) );
  AO22X1_LVT U7 ( .A1(hrdata_s2[6]), .A2(hsel_s2), .A3(hrdata_s1[6]), .A4(
        hsel_s1), .Y(HRDATA[6]) );
  AO22X1_LVT U8 ( .A1(hrdata_s2[5]), .A2(hsel_s2), .A3(hrdata_s1[5]), .A4(
        hsel_s1), .Y(HRDATA[5]) );
  AO22X1_LVT U9 ( .A1(hrdata_s2[4]), .A2(hsel_s2), .A3(hrdata_s1[4]), .A4(
        hsel_s1), .Y(HRDATA[4]) );
  AO22X1_LVT U10 ( .A1(hrdata_s2[31]), .A2(hsel_s2), .A3(hrdata_s1[31]), .A4(
        hsel_s1), .Y(HRDATA[31]) );
  AO22X1_LVT U11 ( .A1(hrdata_s2[30]), .A2(hsel_s2), .A3(hrdata_s1[30]), .A4(
        hsel_s1), .Y(HRDATA[30]) );
  AO22X1_LVT U12 ( .A1(hrdata_s2[3]), .A2(hsel_s2), .A3(hrdata_s1[3]), .A4(
        hsel_s1), .Y(HRDATA[3]) );
  AO22X1_LVT U13 ( .A1(hrdata_s2[29]), .A2(hsel_s2), .A3(hrdata_s1[29]), .A4(
        hsel_s1), .Y(HRDATA[29]) );
  AO22X1_LVT U14 ( .A1(hrdata_s2[28]), .A2(hsel_s2), .A3(hrdata_s1[28]), .A4(
        hsel_s1), .Y(HRDATA[28]) );
  AO22X1_LVT U15 ( .A1(hrdata_s2[27]), .A2(hsel_s2), .A3(hrdata_s1[27]), .A4(
        hsel_s1), .Y(HRDATA[27]) );
  AO22X1_LVT U16 ( .A1(hrdata_s2[26]), .A2(hsel_s2), .A3(hrdata_s1[26]), .A4(
        hsel_s1), .Y(HRDATA[26]) );
  AO22X1_LVT U17 ( .A1(hrdata_s2[25]), .A2(n310), .A3(hrdata_s1[25]), .A4(
        hsel_s1), .Y(HRDATA[25]) );
  AO22X1_LVT U18 ( .A1(hrdata_s2[24]), .A2(n310), .A3(hrdata_s1[24]), .A4(n309), .Y(HRDATA[24]) );
  AO22X1_LVT U19 ( .A1(hrdata_s2[23]), .A2(n310), .A3(hrdata_s1[23]), .A4(n309), .Y(HRDATA[23]) );
  AO22X1_LVT U20 ( .A1(hrdata_s2[22]), .A2(n310), .A3(hrdata_s1[22]), .A4(n309), .Y(HRDATA[22]) );
  AO22X1_LVT U21 ( .A1(hrdata_s2[21]), .A2(n310), .A3(hrdata_s1[21]), .A4(n309), .Y(HRDATA[21]) );
  AO22X1_LVT U22 ( .A1(hrdata_s2[20]), .A2(n310), .A3(hrdata_s1[20]), .A4(n309), .Y(HRDATA[20]) );
  AO22X1_LVT U23 ( .A1(hrdata_s2[2]), .A2(n310), .A3(hrdata_s1[2]), .A4(n309), 
        .Y(HRDATA[2]) );
  AO22X1_LVT U24 ( .A1(hrdata_s2[19]), .A2(n310), .A3(hrdata_s1[19]), .A4(n309), .Y(HRDATA[19]) );
  AO22X1_LVT U25 ( .A1(hrdata_s2[18]), .A2(n310), .A3(hrdata_s1[18]), .A4(n309), .Y(HRDATA[18]) );
  AO22X1_LVT U26 ( .A1(hrdata_s2[17]), .A2(n310), .A3(hrdata_s1[17]), .A4(n309), .Y(HRDATA[17]) );
  AO22X1_LVT U27 ( .A1(hrdata_s2[16]), .A2(n310), .A3(hrdata_s1[16]), .A4(n309), .Y(HRDATA[16]) );
  AO22X1_LVT U28 ( .A1(hrdata_s2[15]), .A2(n310), .A3(hrdata_s1[15]), .A4(n309), .Y(HRDATA[15]) );
  AO22X1_LVT U29 ( .A1(hrdata_s2[14]), .A2(n310), .A3(hrdata_s1[14]), .A4(n309), .Y(HRDATA[14]) );
  AO22X1_LVT U30 ( .A1(hrdata_s2[13]), .A2(n310), .A3(hrdata_s1[13]), .A4(n309), .Y(HRDATA[13]) );
  AO22X1_LVT U31 ( .A1(hrdata_s2[12]), .A2(n310), .A3(hrdata_s1[12]), .A4(n309), .Y(HRDATA[12]) );
  AO22X1_LVT U32 ( .A1(hrdata_s2[11]), .A2(n310), .A3(hrdata_s1[11]), .A4(n309), .Y(HRDATA[11]) );
  AO22X1_LVT U33 ( .A1(hrdata_s2[10]), .A2(hsel_s2), .A3(hrdata_s1[10]), .A4(
        hsel_s1), .Y(HRDATA[10]) );
  AO22X1_LVT U34 ( .A1(hrdata_s2[1]), .A2(hsel_s2), .A3(hrdata_s1[1]), .A4(
        hsel_s1), .Y(HRDATA[1]) );
  AO22X1_LVT U35 ( .A1(hrdata_s2[0]), .A2(hsel_s2), .A3(hrdata_s1[0]), .A4(
        hsel_s1), .Y(HRDATA[0]) );
  INVX1_LVT U38 ( .A(1'b1), .Y(hmastlock_s) );
  INVX1_LVT U40 ( .A(1'b0), .Y(hmaster_data[0]) );
  INVX1_LVT U42 ( .A(1'b1), .Y(hmaster_data[1]) );
  INVX1_LVT U44 ( .A(1'b1), .Y(hmaster_data[2]) );
  INVX1_LVT U46 ( .A(1'b1), .Y(hmaster_data[3]) );
  INVX1_LVT U48 ( .A(1'b0), .Y(hmaster[0]) );
  INVX1_LVT U50 ( .A(1'b1), .Y(hmaster[1]) );
  INVX1_LVT U52 ( .A(1'b1), .Y(hmaster[2]) );
  INVX1_LVT U54 ( .A(1'b1), .Y(hmaster[3]) );
  INVX1_LVT U56 ( .A(1'b1), .Y(hresp_ahb[0]) );
  INVX1_LVT U58 ( .A(1'b1), .Y(hresp_ahb[1]) );
  NBUFFX2_LVT U60 ( .A(n309), .Y(hsel_s1) );
  NBUFFX2_LVT U61 ( .A(n310), .Y(hsel_s2) );
  NBUFFX2_LVT U63 ( .A(HADDR[30]), .Y(haddr_s[30]) );
  NBUFFX2_LVT U64 ( .A(HADDR[29]), .Y(haddr_s[29]) );
  NBUFFX2_LVT U65 ( .A(HADDR[31]), .Y(haddr_s[31]) );
  NBUFFX2_LVT U66 ( .A(HWDATA[22]), .Y(hwdata_s[22]) );
  NBUFFX2_LVT U67 ( .A(HWDATA[23]), .Y(hwdata_s[23]) );
  NBUFFX2_LVT U68 ( .A(HWDATA[24]), .Y(hwdata_s[24]) );
  NBUFFX2_LVT U69 ( .A(HWDATA[25]), .Y(hwdata_s[25]) );
  NBUFFX2_LVT U70 ( .A(HWDATA[26]), .Y(hwdata_s[26]) );
  NBUFFX2_LVT U71 ( .A(HWDATA[27]), .Y(hwdata_s[27]) );
  NBUFFX2_LVT U72 ( .A(HWDATA[28]), .Y(hwdata_s[28]) );
  NBUFFX2_LVT U73 ( .A(HWDATA[29]), .Y(hwdata_s[29]) );
  NBUFFX2_LVT U74 ( .A(HWDATA[30]), .Y(hwdata_s[30]) );
  NBUFFX2_LVT U75 ( .A(HWDATA[31]), .Y(hwdata_s[31]) );
  NBUFFX2_LVT U76 ( .A(HTRANS[0]), .Y(htrans_s[0]) );
  NBUFFX2_LVT U77 ( .A(HTRANS[1]), .Y(htrans_s[1]) );
  NBUFFX2_LVT U78 ( .A(HSIZE[0]), .Y(hsize_s[0]) );
  NBUFFX2_LVT U79 ( .A(HSIZE[1]), .Y(hsize_s[1]) );
  NBUFFX2_LVT U80 ( .A(HSIZE[2]), .Y(hsize_s[2]) );
  NBUFFX2_LVT U81 ( .A(HPROT[0]), .Y(hprot_s[0]) );
  NBUFFX2_LVT U82 ( .A(HPROT[1]), .Y(hprot_s[1]) );
  NBUFFX2_LVT U83 ( .A(HPROT[2]), .Y(hprot_s[2]) );
  NBUFFX2_LVT U84 ( .A(HPROT[3]), .Y(hprot_s[3]) );
  NBUFFX2_LVT U85 ( .A(HBURST[0]), .Y(hburst_s[0]) );
  NBUFFX2_LVT U86 ( .A(HBURST[1]), .Y(hburst_s[1]) );
  NBUFFX2_LVT U87 ( .A(HBURST[2]), .Y(hburst_s[2]) );
  NBUFFX2_LVT U88 ( .A(HADDR[0]), .Y(haddr_s[0]) );
  NBUFFX2_LVT U89 ( .A(HADDR[1]), .Y(haddr_s[1]) );
  NBUFFX2_LVT U90 ( .A(HADDR[2]), .Y(haddr_s[2]) );
  NBUFFX2_LVT U91 ( .A(HADDR[3]), .Y(haddr_s[3]) );
  NBUFFX2_LVT U92 ( .A(HADDR[4]), .Y(haddr_s[4]) );
  NBUFFX2_LVT U93 ( .A(HADDR[5]), .Y(haddr_s[5]) );
  NBUFFX2_LVT U94 ( .A(HADDR[6]), .Y(haddr_s[6]) );
  NBUFFX2_LVT U95 ( .A(HADDR[7]), .Y(haddr_s[7]) );
  NBUFFX2_LVT U96 ( .A(HADDR[8]), .Y(haddr_s[8]) );
  NBUFFX2_LVT U97 ( .A(HADDR[9]), .Y(haddr_s[9]) );
  NBUFFX2_LVT U98 ( .A(HADDR[10]), .Y(haddr_s[10]) );
  NBUFFX2_LVT U99 ( .A(HADDR[11]), .Y(haddr_s[11]) );
  NBUFFX2_LVT U100 ( .A(HADDR[12]), .Y(haddr_s[12]) );
  NBUFFX2_LVT U101 ( .A(HADDR[13]), .Y(haddr_s[13]) );
  NBUFFX2_LVT U102 ( .A(HADDR[14]), .Y(haddr_s[14]) );
  NBUFFX2_LVT U103 ( .A(HADDR[15]), .Y(haddr_s[15]) );
  NBUFFX2_LVT U104 ( .A(HADDR[16]), .Y(haddr_s[16]) );
  NBUFFX2_LVT U105 ( .A(HADDR[17]), .Y(haddr_s[17]) );
  NBUFFX2_LVT U106 ( .A(HADDR[18]), .Y(haddr_s[18]) );
  NBUFFX2_LVT U107 ( .A(HADDR[19]), .Y(haddr_s[19]) );
  NBUFFX2_LVT U108 ( .A(HADDR[20]), .Y(haddr_s[20]) );
  NBUFFX2_LVT U109 ( .A(HADDR[21]), .Y(haddr_s[21]) );
  NBUFFX2_LVT U110 ( .A(HADDR[22]), .Y(haddr_s[22]) );
  NBUFFX2_LVT U111 ( .A(HADDR[23]), .Y(haddr_s[23]) );
  NBUFFX2_LVT U112 ( .A(HADDR[24]), .Y(haddr_s[24]) );
  NBUFFX2_LVT U113 ( .A(HADDR[25]), .Y(haddr_s[25]) );
  NBUFFX2_LVT U114 ( .A(HADDR[26]), .Y(haddr_s[26]) );
  NBUFFX2_LVT U115 ( .A(HADDR[27]), .Y(haddr_s[27]) );
  NBUFFX2_LVT U116 ( .A(HADDR[28]), .Y(haddr_s[28]) );
  NBUFFX2_LVT U117 ( .A(HWRITE), .Y(hwrite_s) );
  NBUFFX2_LVT U118 ( .A(HWDATA[0]), .Y(hwdata_s[0]) );
  NBUFFX2_LVT U119 ( .A(HWDATA[1]), .Y(hwdata_s[1]) );
  NBUFFX2_LVT U120 ( .A(HWDATA[2]), .Y(hwdata_s[2]) );
  NBUFFX2_LVT U121 ( .A(HWDATA[3]), .Y(hwdata_s[3]) );
  NBUFFX2_LVT U122 ( .A(HWDATA[4]), .Y(hwdata_s[4]) );
  NBUFFX2_LVT U123 ( .A(HWDATA[5]), .Y(hwdata_s[5]) );
  NBUFFX2_LVT U124 ( .A(HWDATA[6]), .Y(hwdata_s[6]) );
  NBUFFX2_LVT U125 ( .A(HWDATA[7]), .Y(hwdata_s[7]) );
  NBUFFX2_LVT U126 ( .A(HWDATA[8]), .Y(hwdata_s[8]) );
  NBUFFX2_LVT U127 ( .A(HWDATA[9]), .Y(hwdata_s[9]) );
  NBUFFX2_LVT U128 ( .A(HWDATA[10]), .Y(hwdata_s[10]) );
  NBUFFX2_LVT U129 ( .A(HWDATA[11]), .Y(hwdata_s[11]) );
  NBUFFX2_LVT U130 ( .A(HWDATA[12]), .Y(hwdata_s[12]) );
  NBUFFX2_LVT U131 ( .A(HWDATA[13]), .Y(hwdata_s[13]) );
  NBUFFX2_LVT U132 ( .A(HWDATA[14]), .Y(hwdata_s[14]) );
  NBUFFX2_LVT U133 ( .A(HWDATA[15]), .Y(hwdata_s[15]) );
  NBUFFX2_LVT U134 ( .A(HWDATA[16]), .Y(hwdata_s[16]) );
  NBUFFX2_LVT U135 ( .A(HWDATA[17]), .Y(hwdata_s[17]) );
  NBUFFX2_LVT U136 ( .A(HWDATA[18]), .Y(hwdata_s[18]) );
  NBUFFX2_LVT U137 ( .A(HWDATA[19]), .Y(hwdata_s[19]) );
  NBUFFX2_LVT U138 ( .A(HWDATA[20]), .Y(hwdata_s[20]) );
  NBUFFX2_LVT U139 ( .A(HWDATA[21]), .Y(hwdata_s[21]) );
  NOR3X4_LVT U62 ( .A1(HADDR[29]), .A2(HADDR[31]), .A3(n207), .Y(n310) );
  INVX0_LVT U140 ( .A(HADDR[30]), .Y(n207) );
  NOR3X4_LVT U141 ( .A1(HADDR[30]), .A2(HADDR[31]), .A3(HADDR[29]), .Y(n309)
         );
endmodule

