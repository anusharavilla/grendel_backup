//********************************************************************                                        
//  AUTHOR: Engineering Design Institute/ASIC Design and Verification	                                                     		
//  DESCRIPTION: Test bench for XOR (filename=xor_design.v)                                       
//  MODULE NAME: test_xor
//********************************************************************
 `timescale 10 ns / 1 ps
 module test_xor();
 reg clk=0;
 reg reset=0;
 reg [3:0] A=0, B=0;
 reg [3:0] Y, golden_ref_output;
 reg [4:0] i,j;
 reg [71:0] studentid=123456789;
 always #5 clk=~clk;

 initial 
	begin
		reset=1'b1;
		#10 reset=1'b0;
		for (i=0;i<16;i=i+1)
			begin
				A=i;
				B=4'b0001;
				golden_ref_output=A^B;
				#5;
				#15;
			end
	end

 xor_design u0_xordesign(.clk(clk),
						 .reset(reset),
						 .studentid(studentid),
						 .a(A),
						 .b(B),
						 .y(Y));
 endmodule
