`timescale 1ns / 1ps
module sram_1R (ReadAddress, ReadBus);
input  [9:0] ReadAddress; // Change as you change size of SRAM
output [7:0] ReadBus;

reg [7:0] Register [0:1023];   // 1024 words, with each 8 bits wide
reg [7:0] ReadBus;

// Note the 4 ns delay - this is the OUTPUT DELAY FOR THE MEMORY FOR SYNTHESIS
always@(*) 
  begin 
    #4 ReadBus  =  Register[ReadAddress];
  end
endmodule
