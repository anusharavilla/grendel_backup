
module RequestQueue ( clock, reset, R0, R1, G0, G1 );
  input clock, reset, R0, R1;
  output G0, G1;
  wire   n16, U4_Z_0, n30, n31, n32, n33;

  DFFR_X1 current_state_reg_1_ ( .D(n30), .CK(clock), .RN(reset), .Q(n16), 
        .QN(n31) );
  NOR2_X2 U5 ( .A1(G0), .A2(n31), .ZN(G1) );
  INV_X4 U6 ( .A(n33), .ZN(n30) );
  INV_X4 U7 ( .A(R0), .ZN(n32) );
  DFFR_X2 current_state_reg_0_ ( .D(U4_Z_0), .CK(clock), .RN(reset), .Q(G0) );
  AOI21_X1 U8 ( .B1(G0), .B2(n16), .A(n32), .ZN(U4_Z_0) );
  AOI21_X1 U9 ( .B1(G0), .B2(n16), .A(R1), .ZN(n33) );
endmodule

