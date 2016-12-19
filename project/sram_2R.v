`timescale 1ns / 1ps
module sram_2R (ReadAddress1, ReadAddress2, ReadBus1, ReadBus2);
input  [12:0]  ReadAddress1, ReadAddress2; // Change as you change size of SRAM
output [127:0] ReadBus1;
output [127:0] ReadBus2;

reg [127:0] Register [0:8191];   // 8192 words, with each 128 bits wide
reg [127:0] ReadBus1;
reg [127:0] ReadBus2;

// Note the 4 ns delay - this is the OUTPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*) 
  begin 
    #4 ReadBus1  =  Register[ReadAddress1];
    ReadBus2  =  Register[ReadAddress2];
  end
endmodule
