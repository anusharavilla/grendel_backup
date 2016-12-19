
module statistic ( clock, reset, clear, DataIn1, DataIn2, EvenParity, GreyCode, 
        overflow );
  input [7:0] DataIn1;
  input [7:0] DataIn2;
  output [7:0] EvenParity;
  output [7:0] GreyCode;
  input clock, reset, clear;
  output overflow;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n84, n122, \U8/Z_0 ,
         \U8/CONTROL2 , \U8/CONTROL1 , \U8/DATA2_0 , \U5/Z_0 , \U5/Z_1 ,
         \U5/Z_2 , \U5/Z_3 , \U5/Z_4 , \U5/Z_5 , \U5/Z_6 , \U5/Z_7 ,
         \U5/DATA2_0 , \U5/DATA2_1 , \U5/DATA2_2 , \U5/DATA2_3 , \U5/DATA2_4 ,
         \U5/DATA2_5 , \U5/DATA2_6 , \U5/DATA2_7 , \U4/Z_0 , \U4/Z_1 ,
         \U4/Z_2 , \U4/Z_3 , \U4/Z_4 , \U4/Z_5 , \U4/Z_6 , \U4/Z_7 ,
         \U4/DATA2_0 , \U4/DATA2_1 , \U4/DATA2_2 , \U4/DATA2_3 , \U4/DATA2_4 ,
         \U4/DATA2_5 , \U4/DATA2_6 , \U4/DATA2_7 ,
         \add_1_root_add_47_2/carry[8] , \add_1_root_add_47_2/carry[7] ,
         \add_1_root_add_47_2/carry[6] , \add_1_root_add_47_2/carry[5] ,
         \add_1_root_add_47_2/carry[4] , \add_1_root_add_47_2/carry[3] ,
         \add_1_root_add_47_2/carry[2] , \add_1_root_add_47_2/carry[1] ,
         \add_1_root_add_47_2/SUM[8] , \add_1_root_add_47_2/CI ,
         \add_1_root_add_47_2/B[0] , \add_1_root_add_47_2/A[0] ,
         \add_1_root_add_47_2/A[1] , \add_1_root_add_47_2/A[2] ,
         \add_1_root_add_47_2/A[3] , \add_1_root_add_47_2/A[4] ,
         \add_1_root_add_47_2/A[5] , \add_1_root_add_47_2/A[6] ,
         \add_1_root_add_47_2/A[7] , \add_1_root_add_46_2/carry[8] ,
         \add_1_root_add_46_2/carry[7] , \add_1_root_add_46_2/carry[6] ,
         \add_1_root_add_46_2/carry[5] , \add_1_root_add_46_2/carry[4] ,
         \add_1_root_add_46_2/carry[3] , \add_1_root_add_46_2/carry[2] ,
         \add_1_root_add_46_2/carry[1] , \add_1_root_add_46_2/SUM[8] ,
         \add_1_root_add_46_2/CI , \add_1_root_add_46_2/B[0] ,
         \add_1_root_add_46_2/A[0] , \add_1_root_add_46_2/A[1] ,
         \add_1_root_add_46_2/A[2] , \add_1_root_add_46_2/A[3] ,
         \add_1_root_add_46_2/A[4] , \add_1_root_add_46_2/A[5] ,
         \add_1_root_add_46_2/A[6] , \add_1_root_add_46_2/A[7] ;
  assign GreyCode[0] = \add_1_root_add_47_2/A[0] ;
  assign GreyCode[1] = \add_1_root_add_47_2/A[1] ;
  assign GreyCode[2] = \add_1_root_add_47_2/A[2] ;
  assign GreyCode[3] = \add_1_root_add_47_2/A[3] ;
  assign GreyCode[4] = \add_1_root_add_47_2/A[4] ;
  assign GreyCode[5] = \add_1_root_add_47_2/A[5] ;
  assign GreyCode[6] = \add_1_root_add_47_2/A[6] ;
  assign GreyCode[7] = \add_1_root_add_47_2/A[7] ;
  assign EvenParity[0] = \add_1_root_add_46_2/A[0] ;
  assign EvenParity[1] = \add_1_root_add_46_2/A[1] ;
  assign EvenParity[2] = \add_1_root_add_46_2/A[2] ;
  assign EvenParity[3] = \add_1_root_add_46_2/A[3] ;
  assign EvenParity[4] = \add_1_root_add_46_2/A[4] ;
  assign EvenParity[5] = \add_1_root_add_46_2/A[5] ;
  assign EvenParity[6] = \add_1_root_add_46_2/A[6] ;
  assign EvenParity[7] = \add_1_root_add_46_2/A[7] ;

  \**SEQGEN**  overflow_reg ( .clear(1'b0), .preset(1'b0), .next_state(
        \U8/Z_0 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        overflow), .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_7 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[7] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_6 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[6] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_5 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[5] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_4 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[4] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_3 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[3] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_2 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[2] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_1 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[1] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \GreyCode_reg[0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U5/Z_0 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_47_2/A[0] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[7]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_7 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[7] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[6]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_6 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[6] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[5]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_5 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[5] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[4]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_4 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[4] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[3]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_3 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[3] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[2]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_2 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[2] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[1]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_1 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[1] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \EvenParity_reg[0]  ( .clear(1'b0), .preset(1'b0), .next_state(
        \U4/Z_0 ), .clocked_on(clock), .data_in(1'b0), .enable(1'b0), .Q(
        \add_1_root_add_46_2/A[0] ), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  GTECH_NOT I_0 ( .A(DataIn1[7]), .Z(n73) );
  GTECH_NOT I_1 ( .A(DataIn1[5]), .Z(n72) );
  GTECH_NOT I_2 ( .A(DataIn1[3]), .Z(n71) );
  GTECH_NOT I_3 ( .A(DataIn1[1]), .Z(n70) );
  GTECH_OR2 C56 ( .A(DataIn1[6]), .B(n73), .Z(n69) );
  GTECH_OR2 C57 ( .A(n72), .B(n69), .Z(n68) );
  GTECH_OR2 C58 ( .A(DataIn1[4]), .B(n68), .Z(n67) );
  GTECH_OR2 C59 ( .A(n71), .B(n67), .Z(n66) );
  GTECH_OR2 C60 ( .A(DataIn1[2]), .B(n66), .Z(n65) );
  GTECH_OR2 C61 ( .A(n70), .B(n65), .Z(n64) );
  GTECH_OR2 C62 ( .A(DataIn1[0]), .B(n64), .Z(n63) );
  GTECH_NOT I_4 ( .A(n63), .Z(n62) );
  GTECH_NOT I_5 ( .A(DataIn1[6]), .Z(n61) );
  GTECH_NOT I_6 ( .A(DataIn1[4]), .Z(n60) );
  GTECH_NOT I_7 ( .A(DataIn1[2]), .Z(n59) );
  GTECH_NOT I_8 ( .A(DataIn1[0]), .Z(n58) );
  GTECH_OR2 C68 ( .A(n61), .B(DataIn1[7]), .Z(n57) );
  GTECH_OR2 C69 ( .A(DataIn1[5]), .B(n57), .Z(n56) );
  GTECH_OR2 C70 ( .A(n60), .B(n56), .Z(n55) );
  GTECH_OR2 C71 ( .A(DataIn1[3]), .B(n55), .Z(n54) );
  GTECH_OR2 C72 ( .A(n59), .B(n54), .Z(n53) );
  GTECH_OR2 C73 ( .A(DataIn1[1]), .B(n53), .Z(n52) );
  GTECH_OR2 C74 ( .A(n58), .B(n52), .Z(n51) );
  GTECH_NOT I_9 ( .A(n51), .Z(n50) );
  GTECH_NOT I_10 ( .A(DataIn2[6]), .Z(n49) );
  GTECH_NOT I_11 ( .A(DataIn2[4]), .Z(n48) );
  GTECH_NOT I_12 ( .A(DataIn2[2]), .Z(n47) );
  GTECH_NOT I_13 ( .A(DataIn2[0]), .Z(n46) );
  GTECH_OR2 C80 ( .A(n49), .B(DataIn2[7]), .Z(n45) );
  GTECH_OR2 C81 ( .A(DataIn2[5]), .B(n45), .Z(n44) );
  GTECH_OR2 C82 ( .A(n48), .B(n44), .Z(n43) );
  GTECH_OR2 C83 ( .A(DataIn2[3]), .B(n43), .Z(n42) );
  GTECH_OR2 C84 ( .A(n47), .B(n42), .Z(n41) );
  GTECH_OR2 C85 ( .A(DataIn2[1]), .B(n41), .Z(n40) );
  GTECH_OR2 C86 ( .A(n46), .B(n40), .Z(n39) );
  GTECH_NOT I_14 ( .A(n39), .Z(n38) );
  GTECH_NOT I_15 ( .A(DataIn2[7]), .Z(n37) );
  GTECH_NOT I_16 ( .A(DataIn2[5]), .Z(n36) );
  GTECH_NOT I_17 ( .A(DataIn2[3]), .Z(n35) );
  GTECH_NOT I_18 ( .A(DataIn2[1]), .Z(n34) );
  GTECH_OR2 C92 ( .A(DataIn2[6]), .B(n37), .Z(n33) );
  GTECH_OR2 C93 ( .A(n36), .B(n33), .Z(n32) );
  GTECH_OR2 C94 ( .A(DataIn2[4]), .B(n32), .Z(n31) );
  GTECH_OR2 C95 ( .A(n35), .B(n31), .Z(n30) );
  GTECH_OR2 C96 ( .A(DataIn2[2]), .B(n30), .Z(n29) );
  GTECH_OR2 C97 ( .A(n34), .B(n29), .Z(n28) );
  GTECH_OR2 C98 ( .A(DataIn2[0]), .B(n28), .Z(n27) );
  GTECH_NOT I_19 ( .A(n27), .Z(n26) );
  GTECH_OR2 C100 ( .A(n122), .B(n84), .Z(n25) );
  GTECH_NOT I_20 ( .A(reset), .Z(n122) );
  GTECH_OR2 C144 ( .A(overflow), .B(n24), .Z(\U8/DATA2_0 ) );
  GTECH_OR2 C145 ( .A(\add_1_root_add_46_2/SUM[8] ), .B(
        \add_1_root_add_47_2/SUM[8] ), .Z(n24) );
  GTECH_NOT I_22 ( .A(n17), .Z(\add_1_root_add_46_2/CI ) );
  GTECH_XOR2 C149 ( .A(n18), .B(DataIn1[0]), .Z(n17) );
  GTECH_XOR2 C150 ( .A(n19), .B(DataIn1[1]), .Z(n18) );
  GTECH_XOR2 C151 ( .A(n20), .B(DataIn1[2]), .Z(n19) );
  GTECH_XOR2 C152 ( .A(n21), .B(DataIn1[3]), .Z(n20) );
  GTECH_XOR2 C153 ( .A(n22), .B(DataIn1[4]), .Z(n21) );
  GTECH_XOR2 C154 ( .A(n23), .B(DataIn1[5]), .Z(n22) );
  GTECH_XOR2 C155 ( .A(DataIn1[7]), .B(DataIn1[6]), .Z(n23) );
  GTECH_NOT I_23 ( .A(n10), .Z(\add_1_root_add_46_2/B[0] ) );
  GTECH_XOR2 C157 ( .A(n11), .B(DataIn2[0]), .Z(n10) );
  GTECH_XOR2 C158 ( .A(n12), .B(DataIn2[1]), .Z(n11) );
  GTECH_XOR2 C159 ( .A(n13), .B(DataIn2[2]), .Z(n12) );
  GTECH_XOR2 C160 ( .A(n14), .B(DataIn2[3]), .Z(n13) );
  GTECH_XOR2 C161 ( .A(n15), .B(DataIn2[4]), .Z(n14) );
  GTECH_XOR2 C162 ( .A(n16), .B(DataIn2[5]), .Z(n15) );
  GTECH_XOR2 C163 ( .A(DataIn2[7]), .B(DataIn2[6]), .Z(n16) );
  GTECH_OR2 C164 ( .A(n62), .B(n50), .Z(n75) );
  GTECH_BUF B_1 ( .A(n75), .Z(\add_1_root_add_47_2/CI ) );
  GTECH_OR2 C166 ( .A(n38), .B(n26), .Z(n74) );
  GTECH_BUF B_2 ( .A(n74), .Z(\add_1_root_add_47_2/B[0] ) );  assign \U8/CONTROL2  = (~clear & ~n122);
  assign n84 = (clear & reset);
  assign \U8/CONTROL1  = n25;
  assign \U8/Z_0  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U8/DATA2_0 ));
  assign \U5/Z_7  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_7 ));
  assign \U5/Z_6  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_6 ));
  assign \U5/Z_5  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_5 ));
  assign \U5/Z_4  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_4 ));
  assign \U5/Z_3  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_3 ));
  assign \U5/Z_2  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_2 ));
  assign \U5/Z_1  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_1 ));
  assign \U5/Z_0  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U5/DATA2_0 ));
  assign \U4/Z_7  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_7 ));
  assign \U4/Z_6  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_6 ));
  assign \U4/Z_5  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_5 ));
  assign \U4/Z_4  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_4 ));
  assign \U4/Z_3  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_3 ));
  assign \U4/Z_2  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_2 ));
  assign \U4/Z_1  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_1 ));
  assign \U4/Z_0  = (1'b0 | (\U8/CONTROL1  & 1'b0) | (\U8/CONTROL2  & 
        \U4/DATA2_0 ));

  GTECH_ADD_ABC \add_1_root_add_47_2/U1_8  ( .A(1'b0), .B(1'b0), .C(
        \add_1_root_add_47_2/carry[8] ), .S(\add_1_root_add_47_2/SUM[8] ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_7  ( .A(\add_1_root_add_47_2/A[7] ), 
        .B(1'b0), .C(\add_1_root_add_47_2/carry[7] ), .COUT(
        \add_1_root_add_47_2/carry[8] ), .S(\U5/DATA2_7 ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_6  ( .A(\add_1_root_add_47_2/A[6] ), 
        .B(1'b0), .C(\add_1_root_add_47_2/carry[6] ), .COUT(
        \add_1_root_add_47_2/carry[7] ), .S(\U5/DATA2_6 ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_5  ( .A(\add_1_root_add_47_2/A[5] ), 
        .B(1'b0), .C(\add_1_root_add_47_2/carry[5] ), .COUT(
        \add_1_root_add_47_2/carry[6] ), .S(\U5/DATA2_5 ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_4  ( .A(\add_1_root_add_47_2/A[4] ), 
        .B(1'b0), .C(\add_1_root_add_47_2/carry[4] ), .COUT(
        \add_1_root_add_47_2/carry[5] ), .S(\U5/DATA2_4 ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_3  ( .A(\add_1_root_add_47_2/A[3] ), 
        .B(1'b0), .C(\add_1_root_add_47_2/carry[3] ), .COUT(
        \add_1_root_add_47_2/carry[4] ), .S(\U5/DATA2_3 ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_2  ( .A(\add_1_root_add_47_2/A[2] ), 
        .B(1'b0), .C(\add_1_root_add_47_2/carry[2] ), .COUT(
        \add_1_root_add_47_2/carry[3] ), .S(\U5/DATA2_2 ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_1  ( .A(\add_1_root_add_47_2/A[1] ), 
        .B(1'b0), .C(\add_1_root_add_47_2/carry[1] ), .COUT(
        \add_1_root_add_47_2/carry[2] ), .S(\U5/DATA2_1 ) );
  GTECH_ADD_ABC \add_1_root_add_47_2/U1_0  ( .A(\add_1_root_add_47_2/A[0] ), 
        .B(\add_1_root_add_47_2/B[0] ), .C(\add_1_root_add_47_2/CI ), .COUT(
        \add_1_root_add_47_2/carry[1] ), .S(\U5/DATA2_0 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_8  ( .A(1'b0), .B(1'b0), .C(
        \add_1_root_add_46_2/carry[8] ), .S(\add_1_root_add_46_2/SUM[8] ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_7  ( .A(\add_1_root_add_46_2/A[7] ), 
        .B(1'b0), .C(\add_1_root_add_46_2/carry[7] ), .COUT(
        \add_1_root_add_46_2/carry[8] ), .S(\U4/DATA2_7 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_6  ( .A(\add_1_root_add_46_2/A[6] ), 
        .B(1'b0), .C(\add_1_root_add_46_2/carry[6] ), .COUT(
        \add_1_root_add_46_2/carry[7] ), .S(\U4/DATA2_6 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_5  ( .A(\add_1_root_add_46_2/A[5] ), 
        .B(1'b0), .C(\add_1_root_add_46_2/carry[5] ), .COUT(
        \add_1_root_add_46_2/carry[6] ), .S(\U4/DATA2_5 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_4  ( .A(\add_1_root_add_46_2/A[4] ), 
        .B(1'b0), .C(\add_1_root_add_46_2/carry[4] ), .COUT(
        \add_1_root_add_46_2/carry[5] ), .S(\U4/DATA2_4 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_3  ( .A(\add_1_root_add_46_2/A[3] ), 
        .B(1'b0), .C(\add_1_root_add_46_2/carry[3] ), .COUT(
        \add_1_root_add_46_2/carry[4] ), .S(\U4/DATA2_3 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_2  ( .A(\add_1_root_add_46_2/A[2] ), 
        .B(1'b0), .C(\add_1_root_add_46_2/carry[2] ), .COUT(
        \add_1_root_add_46_2/carry[3] ), .S(\U4/DATA2_2 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_1  ( .A(\add_1_root_add_46_2/A[1] ), 
        .B(1'b0), .C(\add_1_root_add_46_2/carry[1] ), .COUT(
        \add_1_root_add_46_2/carry[2] ), .S(\U4/DATA2_1 ) );
  GTECH_ADD_ABC \add_1_root_add_46_2/U1_0  ( .A(\add_1_root_add_46_2/A[0] ), 
        .B(\add_1_root_add_46_2/B[0] ), .C(\add_1_root_add_46_2/CI ), .COUT(
        \add_1_root_add_46_2/carry[1] ), .S(\U4/DATA2_0 ) );
endmodule

