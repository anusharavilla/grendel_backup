`timescale 1ns / 1ps
module wram( clock, WE, WriteAddress, ReadAddress1, ReadAddress2, WriteBus, ReadBus1, ReadBus2
    );
/*---------------------inputs-----------------------*/
input  clock, WE; 
input  [12:0] WriteAddress, ReadAddress1, ReadAddress2; // Change as you change size of SRAM
input  [127:0] WriteBus;
output [127:0] ReadBus1, ReadBus2;
reg [127:0] ReadBus1,ReadBus2;
reg [127:0] Register [0:8191];
integer i;
reg [8191:0] WElines;
always@(*)
#4 WElines = (WE << WriteAddress);

always@(posedge clock)
    for (i=0; i<=8191; i=i+1)
      if (WElines[i]) Register[i] <= WriteBus;
always@(*) 
  begin 
    #4 ReadBus1  =  Register[ReadAddress1];
    ReadBus2  =  Register[ReadAddress2];
  end
endmodule
