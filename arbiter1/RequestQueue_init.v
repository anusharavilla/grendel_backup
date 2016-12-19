
module RequestQueue ( clock, reset, R0, R1, G0, G1 );
  input clock, reset, R0, R1;
  output G0, G1;
  wire   n31, n34, n35, n37, n38, n39;

  DFFR_X1 current_state_reg_1_ ( .D(n39), .CK(clock), .RN(reset), .QN(n31) );
  NOR2_X2 U10 ( .A1(n31), .A2(G0), .ZN(G1) );
  INV_X4 U11 ( .A(n37), .ZN(n34) );
  INV_X4 U12 ( .A(R1), .ZN(n35) );
  DFFR_X2 current_state_reg_0_ ( .D(n34), .CK(clock), .RN(reset), .Q(G0), .QN(
        n38) );
  OAI21_X2 U14 ( .B1(n38), .B2(n31), .A(n35), .ZN(n39) );
  OAI21_X2 U15 ( .B1(n31), .B2(n38), .A(R0), .ZN(n37) );
endmodule

