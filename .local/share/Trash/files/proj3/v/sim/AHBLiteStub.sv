`timescale 1ns / 1ps


/* AHB-Lite encodings */

/* Transfer types (htrans) */
`define IDLE          2'h0
`define BUSY          2'h1
`define NONSEQ        2'h2
`define SEQ           2'h3

/* Transfer sizes (hsize) */
`define BYTE          3'h0
`define HALF_WORD     3'h1
`define WORD          3'h2
`define DOUBLE_WORD   3'h3
`define FOUR_WORD     3'h4
`define EIGHT_WORD    3'h5
`define BYTE_512      3'h6
`define BYTE_1024     3'h7

/* Burst types (hburst) */
`define SINGLE        3'h0
`define INCR          3'h1
`define WRAP4         3'h2
`define INCR4         3'h3
`define WRAP8         3'h4
`define INCR8         3'h5
`define WRAP16        3'h6
`define INCR16        3'h7

`define READ          1'h0
`define WRITE         1'h1

`define ITERATIONS 1000

module AHBLiteStub (

	/* AHB interface */
	input                             hclk,
	input                             hreset_n,
	input                             hready_i,
	input                             hresp_i,
	input  [31:0]                     hrdata_i,

	output reg [31:0]                     haddr_o,
	output reg [2:0]                      hburst_o,
	output reg [3:0]                      hprot_o,
	output reg [2:0]                      hsize_o,
	output reg [1:0]                      htrans_o,
	output reg [31:0]                     hwdata_o,
	output reg                            hmastlock_o,
	output reg                            hwrite_o
);


   integer 				  fd;
   integer 				  retval;
   reg [63:0]				  xtime;
   reg [80*8:1] 			  xcmd;
   reg [7:0] 				  xsize;
   reg [31:0] 				  xaddr;
   reg [511:0] 				  xdata;
   reg 					  hwriteQ [$];
   reg [7:0] 				  hsizeQ [$];
   reg [31:0] 				  haddrQ [$];
   reg [511:0] 				  hwdataQ [$];
   reg [2:0] 				  hburstQ [$];
   reg [1:0] 				  htransQ [$];

   task ahb_xfer;
      input [7:0]   hsize_val;
      input [31:0]  haddr_val;
      input [7:0]   hwrite_val;
      input [511:0] hwdata_val;
      input [1:0]   htrans_val;
      input [2:0]   hburst_val;
      hsizeQ.push_back(hsize_val);
      haddrQ.push_back(haddr_val);
      hwriteQ.push_back(hwrite_val);
      hwdataQ.push_back(hwdata_val);
      htransQ.push_back(htrans_val);
      hburstQ.push_back(hburst_val);
   endtask
    

   initial
     begin
	fd=$fopen("xact.txt","r");
	if (!fd)
	  begin
	     $display("ERROR: Could not open xact.txt for reading");
	     $finish;
	  end
	
	// Ignore first line
	retval=$fgets(xcmd,fd);
	//$display("%s",xcmd);
	
	
	while (!$feof(fd))
	  begin
	     retval=$fscanf(fd,"%d %s 0x%h 0x%h 0x%h\n", 
                            xtime, xcmd, xsize, xaddr, xdata);
	     //$display("%d %7s %h %h %h",
             //               xtime, xcmd, xsize, xaddr, xdata);
	     if ($time < xtime)
	       #(xtime-$time);

 	     if (xsize==8'h04)
	       begin
                  if (xcmd[4*8:1]=="READ") 
		    ahb_xfer(`WORD,xaddr,`READ,32'h0,`NONSEQ,`SINGLE);
	          else if (xcmd[5*8:1]=="WRITE")
		    ahb_xfer(`WORD,xaddr,`WRITE,xdata[31:0],`NONSEQ,`SINGLE);
                  else
	            $display("ERROR: unrecognized command %7s in xact.txt, time=%d",xcmd,xtime);
	       end
	     else if (xsize==8'h08)
	       begin
                  if (xcmd[4*8:1]=="READ") 
		    begin
		    ahb_xfer(`WORD,xaddr,`READ,32'h0,`NONSEQ,`INCR);
		    ahb_xfer(`WORD,xaddr+32'h04,`READ,32'h0,`SEQ,`INCR);
		    end
	          else if (xcmd[5*8:1]=="WRITE")
		    begin
		    ahb_xfer(`WORD,xaddr,`WRITE,xdata[31:0],`NONSEQ,`INCR);
		    ahb_xfer(`WORD,xaddr+32'h04,`WRITE,xdata[63:32],`SEQ,`INCR);
		    end
                  else
	            $display("ERROR: unrecognized command %7s in xact.txt, time=%d",xcmd,xtime);
	       end
	     else if (xsize==8'h10)
	       begin
                  if (xcmd[4*8:1]=="READ") 
		    begin
		    ahb_xfer(`WORD,xaddr,`READ,32'h0,`NONSEQ,`INCR4);
		    ahb_xfer(`WORD,xaddr+32'h04,`READ,32'h0,`SEQ,`INCR4);
		    ahb_xfer(`WORD,xaddr+32'h08,`READ,32'h0,`SEQ,`INCR4);
		    ahb_xfer(`WORD,xaddr+32'h0c,`READ,32'h0,`SEQ,`INCR4);
		    end
	          else if (xcmd[5*8:1]=="WRITE")
		    begin
		    ahb_xfer(`WORD,xaddr,`WRITE,xdata[31:0],`NONSEQ,`INCR4);
		    ahb_xfer(`WORD,xaddr+32'h04,`WRITE,xdata[63:32],`SEQ,`INCR4);
		    ahb_xfer(`WORD,xaddr+32'h08,`WRITE,xdata[95:64],`SEQ,`INCR4);
		    ahb_xfer(`WORD,xaddr+32'h0c,`WRITE,xdata[127:96],`SEQ,`INCR4);
		    end
                  else
	            $display("ERROR: unrecognized command %7s in xact.txt, time=%d",xcmd,xtime);
	       end
	     else if (xsize==8'h20)
	       begin
                  if (xcmd[4*8:1]=="READ") 
		    begin
		    ahb_xfer(`WORD,xaddr,`READ,32'h0,`NONSEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h04,`READ,32'h0,`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h08,`READ,32'h0,`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h0c,`READ,32'h0,`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h10,`READ,32'h0,`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h14,`READ,32'h0,`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h18,`READ,32'h0,`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h1c,`READ,32'h0,`SEQ,`INCR8);
		    end
	          else if (xcmd[5*8:1]=="WRITE")
		    begin
		    ahb_xfer(`WORD,xaddr,`WRITE,xdata[31:0],`NONSEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h04,`WRITE,xdata[63:32],`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h08,`WRITE,xdata[95:64],`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h0c,`WRITE,xdata[127:96],`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h10,`WRITE,xdata[159:128],`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h14,`WRITE,xdata[191:160],`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h18,`WRITE,xdata[223:192],`SEQ,`INCR8);
		    ahb_xfer(`WORD,xaddr+32'h1c,`WRITE,xdata[255:224],`SEQ,`INCR8);
		    end
                  else
	            $display("ERROR: unrecognized command %7s in xact.txt, time=%d",xcmd,xtime);
	       end
	     else if (xsize==8'h40)
	       begin
                  if (xcmd[4*8:1]=="READ") 
		    begin
		    ahb_xfer(`WORD,xaddr,`READ,32'h0,`NONSEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h04,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h08,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h0c,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h10,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h14,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h18,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h1c,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h20,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h24,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h28,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h2c,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h30,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h34,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h38,`READ,32'h0,`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h3c,`READ,32'h0,`SEQ,`INCR16);
		    end
	          else if (xcmd[5*8:1]=="WRITE")
		    begin
		    ahb_xfer(`WORD,xaddr,`WRITE,xdata[31:0],`NONSEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h04,`WRITE,xdata[63:32],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h08,`WRITE,xdata[95:64],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h0c,`WRITE,xdata[127:96],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h10,`WRITE,xdata[159:128],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h14,`WRITE,xdata[191:160],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h18,`WRITE,xdata[223:192],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h1c,`WRITE,xdata[255:224],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h20,`WRITE,xdata[287:256],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h24,`WRITE,xdata[319:288],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h28,`WRITE,xdata[351:320],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h2c,`WRITE,xdata[383:352],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h30,`WRITE,xdata[415:384],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h34,`WRITE,xdata[447:416],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h38,`WRITE,xdata[479:448],`SEQ,`INCR16);
		    ahb_xfer(`WORD,xaddr+32'h3c,`WRITE,xdata[511:480],`SEQ,`INCR16);
		    end
                  else
	            $display("ERROR: unrecognized command %7s in xact.txt, time=%d",xcmd,xtime);
	       end
	     else
	       $display("ERROR: unrecognized size %h in xact.txt, time=%d",
			xsize,xtime);
	     
	     //$display("%d %7s %h %h %h",
             //               $time, xcmd, xsize, xaddr, xdata);
	  end
        // Signal to test-bench to end the simulation
        ahb_xfer(`WORD,32'h40000000,`WRITE,32'h0d,`NONSEQ,`SINGLE);
     end // initial begin
   
   reg [31:0] hwdata_next;
   
   
  always @(posedge hclk)
    begin
       if (!hreset_n)
	 begin
	    haddr_o=32'h0;
	    hburst_o=3'b000;
	    hprot_o=4'b0000;
	    hsize_o=3'b000;
	    htrans_o=2'b00;
	    hwdata_o=32'h0;
	    hmastlock_o=1'b0;
	    hwrite_o=1'b0;
	    hwdata_next=0;
	 end // if (!hreset_n)
       else
	 if (hready_i)
	   begin
	      if (haddrQ.size()==0)
	        begin
	           haddr_o=32'h0;
	           hburst_o=3'b000;
	           hsize_o=3'b000;
	           htrans_o=2'b00;
	           hwdata_o=hwdata_next;
		   hwdata_next=32'h0;
	           hwrite_o=1'b0;
		end
	      else
	        begin
	           haddr_o=haddrQ.pop_front();
	           hburst_o=hburstQ.pop_front();
	           hsize_o=hsizeQ.pop_front();
	           htrans_o=htransQ.pop_front();
	           hwdata_o=hwdata_next;
		   hwdata_next=hwdataQ.pop_front();
	           hwrite_o=hwriteQ.pop_front();
		end
		
	   end
    end // always @ (posedge hclk)
   

endmodule


