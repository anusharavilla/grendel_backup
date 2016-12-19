//------------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2010 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : 2010-08-03 21:05:56 +0100 (Tue, 03 Aug 2010)
//
//      Revision            : 144987
//
//      Release Information : AT510-MN-80001-r0p0-00rel0
//------------------------------------------------------------------------------
//
// Modified 2/20/2012 by David S. Huffman and W. Rhett Davis for ECE 720
//
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Cortex-M0 DesignStart testbench example
//------------------------------------------------------------------------------
`timescale 1ns / 1ps

`define XACT_DUMP
//`define VCD
//`define USE_STUB

module tb ();

//------------------------------------------------------------------------------
// Define parameters for clock period and power-on reset delay
//------------------------------------------------------------------------------

localparam clk_period = 10;            // Simulation cycles per clock period
localparam clk2_period = clk_period / 2;
localparam por_delay  = 1001;           // Simulation cycles of power-on-reset
localparam ram_log2   = 18;             // Power of two of RAM words
localparam addr_tty   = 32'h40000000;   // Address of output console

//------------------------------------------------------------------------------
// Define registers for clock, reset and memory
//------------------------------------------------------------------------------

reg sim_clock;                          // System clock
reg power_on_reset_n;                   // Power-on reset signal
reg [31:0] ram [0:(2**ram_log2)-1];     // Storage for AHB memory model
reg [31:0] ram_2 [0:(2**ram_log2)-1];     // AHB 2
//------------------------------------------------------------------------------
// Cortex-M0 DesignStart signal list
//------------------------------------------------------------------------------

// See the AMBA(r)3 AHB-Lite Protocol Specification v1.0 (ARM IHI 0033),
// and the Cortex(tm)-M0 Technical Reference Manual (ARM DDI 0432), for
// further details on the following signals:

/*reg [31:0] src_addr;					// DMA source address input
reg [31:0] dest_addr;					// DMA destination address input
reg [3:0] transfer_length;*/			// DMA transfer length


wire        HCLK;               // AHB-Lite interface and CPU master clock
wire        HRESETn;            // AHB-Lite active-low reset signal

wire [31:0] HADDR;              // AHB-Lite byte address
wire [ 2:0] HBURST;             // AHB-Lite burst type (not used by testbench)
wire        HMASTLOCK;          // AHB-Lite locked transaction (always zero)
wire [ 3:0] HPROT;              // AHB-Lite protection (not used by testbench)
wire [ 2:0] HSIZE;              // AHB-Lite size (# of bits: 0=8, 1=16, 2=32)
wire [ 1:0] HTRANS;             // AHB-Lite perform transaction
wire [31:0] HWDATA;             // AHB-Lite write-data
wire        HWRITE;             // AHB-Lite transaction is write not read
wire [31:0] HRDATA;             // AHB-Lite read-data
wire        HREADY;             // AHB-Lite bus ready signal
wire        HRESP;      // AHB-Lite bus error (not used by testbench)



/*************************** AHB 2 Signals *****************************************************/
wire [31:0] HADDR_2;              // AHB-Lite byte address
wire [ 2:0] HBURST_2;             // AHB-Lite burst type (not used by testbench)
wire        HMASTLOCK_2;          // AHB-Lite locked transaction (always zero)
wire [ 3:0] HPROT_2;              // AHB-Lite protection (not used by testbench)
wire [ 2:0] HSIZE_2;              // AHB-Lite size (# of bits: 0=8, 1=16, 2=32)
wire [ 1:0] HTRANS_2;             // AHB-Lite perform transaction
wire [31:0] HWDATA_2;             // AHB-Lite write-data
wire        HWRITE_2;           // AHB-Lite transaction is write not read
wire [31:0] HRDATA_2;             // AHB-Lite read-data
wire        HREADY_2;             // AHB-Lite bus ready signal
wire        HRESP_2;      // AHB-Lite bus error (not used by testbench)

/*******************************************************************************/

// See the ARMv6-M Architecture Reference Manual (ARM DDI 0419), and the
// Cortex(tm)-M0 Technical Reference Manual (ARM DDI 0432), for further
// details on the following signals:

wire        NMI;                // Non-maskable interrupt input (not used by tb)
wire [15:0] IRQ;                // Interrupt inputs (not used by testbench)

wire        TXEV;               // Event output (CPU executed SEV instruction)
wire        RXEV;               // Event input (not used by testbench)

wire        LOCKUP;             // CPU stopped due to multiple software errors
wire        SYSRESETREQ;        // CPU request for system to be reset

wire        SLEEPING;           // CPU is sleeping (not used by testbench)


///////////////////////////////////////////////////
//////////////////AHB BUS wires////////////////////
///////////////////////////////////////////////////
//wire hbusreq;  // Not needed for AHB-Lite
//wire hgrant;   // Not needed for AHB-Lite
wire hsel_s1;
wire hready_resp_s1;
wire [1:0] hresp_s1;
wire [31:0] hrdata_s1;
wire hsel_s2;
wire hready_resp_s2;
wire [1:0] hresp_s2;
wire [31:0] hrdata_s2;
wire [31:0] haddr_s;
wire [2:0] hburst_s;
wire [3:0] hprot_s;
wire [2:0] hsize_s;
wire [1:0] htrans_s;
wire [31:0] hwdata_s;
wire hwrite_s;
wire hready;
wire [1:0] hresp_ahb;
wire [31:0] hrdata;
wire [3:0] hmaster;
wire [3:0] hmaster_data;
wire hmastlock;	

/*******************************************************************************/
wire hsel_s1_2;
wire hready_resp_s1_2;
wire [1:0] hresp_s1_2;
wire [31:0] hrdata_s1_2;
wire hsel_s2_2;
wire hready_resp_s2_2;
wire [1:0] hresp_s2_2;
wire [31:0] hrdata_s2_2;
wire [31:0] haddr_s_2;
wire [2:0] hburst_s_2;
wire [3:0] hprot_s_2;
wire [2:0] hsize_s_2;
wire [1:0] htrans_s_2;
wire [31:0] hwdata_s_2;
wire hwrite_s_2;
wire hready_2;
wire [1:0] hresp_ahb_2;
wire [31:0] hrdata_2;
wire [3:0] hmaster_2;
wire [3:0] hmaster_data_2;
wire hmastlock_2;	
/*******************************************************************************/

	
///Memctl///
wire s_ras_n; 					//output; to SDRAM; row address select
wire s_cas_n; 					//output; to SDRAM; column address select
wire s_cke; 					//output; to SDRAM; clock enable
wire [15:0] s_wr_data;			//output; to SDRAM; write data
wire [15:0] s_addr; 			//output; to SDRAM; address bus
wire [1:0] s_bank_addr; 		//output; to SDRAM; bank address
wire [1:0] s_dout_valid;		//output; to SDRAM; valid signal for write data
wire [0:0] s_sel_n;				//output; to SDRAM; chip select
wire [1:0] s_dqm; 				//output; to SDRAM; input mask for write access/output enable for read access
wire s_we_n; 					//output; to SDRAM; write enable
wire [1:0] s_dqs; 				//output; to SDRAM; data strobe 
wire [2:0] s_sa; 				//output; to SDRAM; serial-presence-detect address
wire s_scl; 					//output; to SDRAM; serial-presence-detect clock
reg s_rd_ready; 				//input; to SDRAM; read data ready
wire s_rd_start; 				//output; to SDRAM; read command issued
wire s_rd_pop; 					//output; to SDRAM; read data pop
wire s_rd_end; 					//output; to SDRAM; last read data in a burst
wire s_rd_dqs_mask;				//output; to SDRAM; read DQS mask
wire [2:0] s_cas_latency; 		//output; to SDRAM; CAS latency...
wire [2:0] s_read_pipe; 		//output; to SDRAM; holds the value of SCTLR[8:6]
wire s_sda_out; 				//output; to SDRAM; serial-presence-detect data out
wire s_sda_oe_n; 				//output; to SDRAM; serial-presence-detect data in
wire [7:0] gpo; 				//output; to SDRAM; gernal purpose output
wire [1:0] debug_ad_bank_addr;		//output
wire [15:0] debug_ad_row_addr; 		//output 					
wire [15:0] debug_ad_col_addr; 		//output
wire [1:0] debug_ad_sf_bank_addr;	//output
wire [15:0] debug_ad_sf_row_addr; 	//output
wire [15:0] debug_ad_sf_col_addr; 	//output
wire [31:0] debug_hiu_addr;			//output
wire debug_sm_burst_done;			//output
wire debug_sm_pop_n;			//output
wire debug_sm_push_n; 			//output
wire [3:0] debug_smc_cs; 		//output
wire debug_ref_req; 			//?	
reg hclk_2x; 					//input; 2x freq of hclk (DDR)
reg hsel_reg; 					//input; from ahb ?; used to program mem ctl
reg hsel_reg_2;
wire [31:0] s_rd_data; 			//input; from SDRAM; read data
wire s_sda_in;					//output; to SDRAM serial-presence-detect data out
wire [7:0] gpi; 				//input; from ?; general purpose inputs
wire remap; 					//input; from ?; if high address comparison down with remap registers
wire power_down; 				//input; from power management unit; if high SDRAM is put in power-down mode
wire clear_sr_dp; 				//input from ? ; clear self_freresh bit of SDRAM (SCTLR)
wire big_endian;				//input; from ?; high if AHB bus is big endian
//wire [31:0] hrdata_s1_2;
//wire hready_resp_s1_2;

wire [31:0] src_addr_reg;
wire [31:0] dest_addr_reg;
wire [3:0] transfer_length_reg;
	

//------------------------------------------------------------------------------
// Generate system clock, power-on reset and synchronized AHB reset signals
//------------------------------------------------------------------------------

// Generate a clock of the appropriate period
initial
  #0 sim_clock = 1'b0;

always @(sim_clock)
  #(clk_period/2) sim_clock <= ~sim_clock;

// Release the active-low power-on reset signal after the given delay
initial begin
  #0 power_on_reset_n = 1'b0;
  #(por_delay) power_on_reset_n = 1'b1;
end

// Synchronize AHB reset, and factor in reset request from the CPU
reg [1:0] rst_sync;
always @(posedge sim_clock or negedge power_on_reset_n)
begin
  if(!power_on_reset_n)
    rst_sync <= 2'b00;
  else
    //rst_sync <= {rst_sync[0],~SYSRESETREQ};
	rst_sync <= {power_on_reset_n,1'b0};
end
//------------------------------------------------------------------------------
// Connect clock and reset to AHB signals and assign static signals
//------------------------------------------------------------------------------

assign HCLK    = sim_clock;    // Assign AHB clock from simulation clock
assign HRESETn = rst_sync[1];  // Assign AHB clock from synchronizer
//assign HREADY  = 1'b1;         // All devices are zero-wait-state
//assign HRESP   = 1'b0;         // No device in this system generates errors
assign NMI     = 1'b0;         // Do not generate any non-maskable interrupts
assign IRQ     = {16{1'b0}};   // Do not generate any interrupts
assign RXEV    = 1'b0;         // Do not generate any external events

//assign hresp_s1 = 2'b00;
assign hresp_s2 = 2'b00;
//assign HRESP = hresp_ahb[0] | hresp_ahb[1];
//assign hready_resp_s1 = 1'b1;
assign hready_resp_s2 = 1'b1;
assign HBUSREQ = 1'b1;

/***********************************AHB 2*********************************************************/
//assign hresp_s1 = 2'b00;
assign hresp_s2_2 = 2'b00;
//assign HRESP = hresp_ahb[0] | hresp_ahb[1];
//assign hready_resp_s1 = 1'b1;
assign hready_resp_s2_2 = 1'b1;
assign HBUSREQ_2 = 1'b1;
/********************************************************************************************/


///memctl///
assign scan_mode = 1'b0; 			//input, used to bypass internally generated reset during scan testing, must be low
assign remap = 1'b0; 				//input, from ?, if high address comparison down with remap registers
assign power_down = 1'b0;			//input, from power management unit, if high SDRAM is put in power-down mode
assign clear_sr_dp = 1'b0; 			//input from ? , clear self_freresh bit of SDRAM (SCTLR)
assign big_endian = 1'b0;			//input, from ?, high if AHB bus is big endian

//------------------------------------------------------------------------------
// Instantiate Cortex-M0 DesignStart processor macro cell
//------------------------------------------------------------------------------
`ifdef USE_STUB
integrated_stub_dma soc(
`else
integrated_cpu_dma soc(
`endif
  HCLK,
  HRESETn,
  HADDR,
  HBURST,
  HMASTLOCK,
  HPROT,
  HSIZE,
  HTRANS,
  HWDATA,
  HWRITE,
  HRDATA,
  HREADY,
  HRESP,
  NMI,
  IRQ,
  TXEV,
  RXEV,
  LOCKUP,
  SYSRESETREQ,
  SLEEPING,


/**************AHB 2************/

  //HCLK,
 // HRESETn,
  HADDR_2,
  HBURST_2,
  HMASTLOCK_2,
  HPROT_2,
  HSIZE_2,
  HTRANS_2,
  HWDATA_2,
  HWRITE_2,
  HRDATA_2,
  HREADY_2,
  HRESP_2,
  /*NMI_2,
  IRQ_2,
  TXEV_2,
  RXEV_2,
  LOCKUP_2,
  SYSRESETREQ_2,
  SLEEPING_2,*/


  htrans_s,
  hwrite_s,
  haddr_s,
  hsize_s,
  hwdata_s,
  hsel_s2,
  hresp_s2,
  hready_resp_s2,
  hready_resp_s1,


/**************** AHB 2****************/

htrans_s_2,
  hwrite_s_2,
  haddr_s_2,
  hsize_s_2,
  hwdata_s_2,
  hsel_s2_2,
  hresp_s2_2,
  hready_resp_s2_2,
  hready_resp_s1_2,

/************************************************/
  src_addr_reg,
	 dest_addr_reg,
	 transfer_length_reg,

  scan_mode,
  remap,
  power_down,
  clear_sr_dp,
  big_endian,
  debug_ad_row_addr,
  debug_ad_bank_addr,
  debug_ad_col_addr,
  hsel_s1,
  hsel_s1_2,  //AHB 2
  hsel_reg,
  hsel_reg_2,  //AHB 2
  s_rd_data,
  s_rd_ready,
  hclk_2x
);
 

//------------------------------------------------------------------------------
// Simulation model of an AHB memory
//------------------------------------------------------------------------------

// Initialize memory content from "ram.bin"
integer fd, i;
reg [31:0] data;

initial begin
  s_rd_ready <= 0;
  hclk_2x <= 1;
  hsel_reg <= 0;
  hsel_reg_2 <= 0;  // AHB 2 
  $display("%t: ----------------------------------------------", $time);
  $display("%t: ARM(r) Cortex(tm)-M0 DesignStart(tm) Testbench", $time);
  $display("%t: (c) Copyright 2010 ARM Limited", $time);
  $display("%t: All Rights Reserved", $time);
  $display("%t: ----------------------------------------------\n", $time);
  $display("%t: Loading initial memory content...", $time);
  fd = $fopen("ram.bin","rb");
  if(fd != 0) begin
	for (i = 0; (i < (2**ram_log2)) && ($fread(data,fd) != -1); i = i + 1)
		ram[i] = {data[7:0],data[15:8],data[23:16],data[31:24]};
  end
  $display("%t: ...complete\n", $time);
  
  #(clk_period * 100 + clk_period/2);
  $display("%t: Memory Controller leaving startup...", $time);
  
  //#(clk_period * 2000);
  //$finish();
/*   transfer_length <= 4'hF;  				//early end for debug
src_addr <= 32'h00000014;
dest_addr <= 32'h00001000;*/

end

always #(clk2_period/2) begin
 hclk_2x <= ~hclk_2x;
end

///Memctrl Programming
always @(*) begin
	if(haddr_s_2==4 && $time>100000 && hwrite_s_2==1)begin				// haddr, hsel, hwdata and hwrite changed for AHB 2
//crude detection, seems reliable... but don't rely on it if major changes to fibonacci.c
		$display("%t: Memory Controller PRGM STMG0R [start]...", $time);
		hsel_reg_2 <= 1;
		#(clk_period);
		hsel_reg_2 <= 0; 
		#(clk_period);
		$display("%t: Memory Controller PRGM STMG0R [end] hwdata=%x",$time,hwdata_s_2);
	end
end

// Record transaction information from last accepted address phase
reg [ 1:0] htrans_last;
reg        hwrite_last;
reg [31:0] haddr_last;
reg [31:0] haddr_mm;
reg [ 2:0] hsize_last;

// Record transaction information from last accepted address phase // AHB 2
reg [ 1:0] htrans_last_2;
reg        hwrite_last_2;
reg [31:0] haddr_last_2;
reg [31:0] haddr_mm_2;
reg [ 2:0] hsize_last_2;


always @(posedge HCLK)					//used for pseduo memory module writes only
  if (hready_resp_s1) begin
    htrans_last <= htrans_s;
    hwrite_last <= hwrite_s;
    haddr_last  <= haddr_s;
    hsize_last  <= hsize_s;
  end

always @(posedge HCLK)					//changed for AHB 2 //used for pseduo memory module writes only
  if (hready_resp_s1_2) begin
    htrans_last_2 <= htrans_s_2;
    hwrite_last_2 <= hwrite_s_2;
    haddr_last_2  <= haddr_s_2;
    hsize_last_2  <= hsize_s_2;
  end

always @(*) begin
	haddr_mm <= {debug_ad_row_addr[12:0],debug_ad_bank_addr[1:0],debug_ad_col_addr * 2};		//widths: row address 13, bank 2, column 12
end  
  
  
// Select RAM only if between address zero and top of RAM
assign hsel_ram = hsel_s1;
wire hsel_ram_2;
assign hsel_ram_2 = hsel_s1_2;

assign s_rd_data[31:0] = hsel_ram ? ram[haddr_mm[ram_log2+1:2]] : 32'd0;

reg [31:0] ram_tmp;
reg [31:0] ram_tmp_2;

always @(posedge HCLK)								
  if(hready_resp_s1 & hwrite_last & hsel_ram & htrans_last[1]) begin

    // Extract RAM entry into temporary buffer
    ram_tmp = ram[haddr_last[ram_log2+1:2]];

    // Insert appropriate bytes from AHB-Lite transaction
    case({hsize_last[1:0], haddr_last[1:0]})
      // Byte writes are valid to any address
      4'b00_00 : ram_tmp[ 7: 0] = hwdata_s[ 7: 0];
      4'b00_01 : ram_tmp[15: 8] = hwdata_s[15: 8];
      4'b00_10 : ram_tmp[23:16] = hwdata_s[23:16];
      4'b00_11 : ram_tmp[31:24] = hwdata_s[31:24];
      // Halfword writes are only valid to even addresses
      4'b01_00 : ram_tmp[15: 0] = hwdata_s[15: 0];
      4'b01_10 : ram_tmp[31:16] = hwdata_s[31:16];
      // Word writes are only valid to word aligned addresses
      4'b10_00 : ram_tmp[31: 0] = hwdata_s[31: 0];
      default  : begin
        $display("%t: Illegal AHB transaction, stopping simulation\n", $time);
        $finish(2);
      end
    endcase

    // Commit write to RAM model
    ram[haddr_last[ram_log2+1:2]] <= ram_tmp;
  end

/**********************************************************************************************/
always @(posedge HCLK)								//AHB 2
  if(hready_resp_s1_2 & hwrite_last_2 & hsel_ram_2 & htrans_last_2[1]) begin

    // Extract RAM entry into temporary buffer
    ram_tmp_2 = ram_2[haddr_last_2[ram_log2+1:2]];

    // Insert appropriate bytes from AHB-Lite transaction
    case({hsize_last_2[1:0], haddr_last_2[1:0]})
      // Byte writes are valid to any address
      4'b00_00 : ram_tmp_2[ 7: 0] = hwdata_s_2[ 7: 0];
      4'b00_01 : ram_tmp_2[15: 8] = hwdata_s_2[15: 8];
      4'b00_10 : ram_tmp_2[23:16] = hwdata_s_2[23:16];
      4'b00_11 : ram_tmp_2[31:24] = hwdata_s_2[31:24];
      // Halfword writes are only valid to even addresses
      4'b01_00 : ram_tmp_2[15: 0] = hwdata_s_2[15: 0];
      4'b01_10 : ram_tmp_2[31:16] = hwdata_s_2[31:16];
      // Word writes are only valid to word aligned addresses
      4'b10_00 : ram_tmp_2[31: 0] = hwdata_s_2[31: 0];
      default  : begin
        $display("%t: Illegal AHB transaction, stopping simulation\n", $time);
        $finish(2);
      end
    endcase

    // Commit write to RAM model
    ram_2[haddr_last_2[ram_log2+1:2]] <= ram_tmp_2;
  end

//------------------------------------------------------------------------------
// Simulation model of a simple AHB output console
//------------------------------------------------------------------------------

wire hsel_tty2 = (haddr_last == addr_tty);

   
reg hsel_tty;
always @(posedge HCLK) begin
    hsel_tty <= hsel_s2;
end

reg hsel_tty_2;
always @(posedge HCLK) begin
    hsel_tty_2 <= hsel_s2_2;
end

// AHB 2
always @(posedge HCLK)
  if(HRESETn & HREADY_2 & hwrite_last_2 & hsel_tty_2 & htrans_last_2[1]) begin
    if(hwdata_s_2[7:0] != 8'hD)
          // The following line should be used to print single console characters to stdout.
          // It shouldn't be used with the Transaction-Dump process (below)
          $write("%c", hwdata_s_2[7:0]);
          // The following line should be used to print console character on separate lines.
          // It works better in conjunction with the Transaction-Dump process
	  //$display("To Console: %c",HWDATA[7:0]);
    else begin
      $display("%t: Simulation stop requested by CPU 2 \n", $time);
      $finish(2);
    end
  end

/*
always @(posedge HCLK)
  if(HRESETn & HREADY & hwrite_last & hsel_tty & htrans_last[1]) begin
    if(hwdata_s[7:0] != 8'hD)
          // The following line should be used to print single console characters to stdout.
          // It shouldn't be used with the Transaction-Dump process (below)
          $write("%c", hwdata_s[7:0]);
          // The following line should be used to print console character on separate lines.
          // It works better in conjunction with the Transaction-Dump process
	  //$display("To Console: %c",HWDATA[7:0]);
    else begin
      $display("%t: Simulation stop requested by CPU \n", $time);
      $finish(2);
    end
  end
*/

//------------------------------------------------------------------------------
// Simulation commentary
//------------------------------------------------------------------------------

always @(posedge HRESETn)
  $display("%t: Simulation leaving reset", $time);

always @(posedge HCLK)
  if (HRESETn & LOCKUP) begin
    $display("%t: CPU LOCKUP asserted, stopping simulation\n", $time);
    #(clk_period * 32)
    $finish(2);
  end
 
always @(posedge HCLK)
  if (HRESETn & TXEV) begin
    $display("%t: CPU executed SEV instruction and asserted TXEV\n", $time);
  end

always @(posedge HCLK)
  if (HRESETn & HREADY & htrans_last[1] & ~(hsel_ram | hsel_s2))
    $display("%t: Warning, address %x selects neither RAM or console", $time, haddr_last);


//AHB 2
always @(posedge HCLK)
  if (HRESETn & HREADY_2 & htrans_last_2[1] & ~(hsel_ram_2 | hsel_s2_2))
    $display("%t: Warning, address %x selects neither RAM or console 2", $time, haddr_last_2);
	
/*	
always @ (s_rd_data) $display ("%t: - [SDRAM] SENDING: s_rd_data %x, addr:%x",$time, s_rd_data,haddr_last);
always @ (hrdata_s1) $display ("%t: - [MEM] RECEIVED: hrdata_s1 %x",$time, hrdata_s1);
always @ (s_rd_ready) $display ("%t: - [SDRAM] D-READY: s_rd_ready %x",$time, s_rd_ready);
always @ (hready_resp_s1) $display ("%t: - [MEM] D-READY: hready_resp_s1 %x",$time, hready_resp_s1);
*/
//always @ (hsel_ram) $display ("%t: - [AHB] hsel_ram=hsel_s1 %x",$time, hsel_ram);	
//always @ (hsel_s2) $display ("%t: - [AHB] hsel_s2 %x",$time, hsel_s2);	
//always @ (hsel_tty) $display ("%t: - HREADY:%x hwrite:%x hsel_tty:%x htrans[1]:%x",$time,HREADY,hwrite,hsel_tty,htrans);

//always @ (s_addr) $display ("%t: - [MEM] haddr=%x s_addr=%x s_bank_addr=%x",$time,haddr,s_addr,s_bank_addr);	
//always @ (debug_ad_col_addr) $display ("%t: - [MEM] haddr=%x debug_ad_row_addr=%x debug_ad_col_addr=%x debug_ad_bank_addr=%x",$time,haddr,debug_ad_row_addr,debug_ad_col_addr,debug_ad_bank_addr);	
//always @ (hwrite) $display ("%t: - [MEM] Writing hwrite=%x htrans=%x hsel_ram=%x hready_resp_s1=%x",$time,hwrite,htrans,hsel_ram,hready_resp_s1);		
	
	
// Transaction-Dump Process
// Uncomment the XACT_DUMP macro at the top of this file 
// to allow printing of each transaction in the simulation
`ifdef XACT_DUMP
always @(posedge HCLK)
  if (HRESETn & HREADY & htrans_last[1] & (hsel_ram | hsel_s2))
    //if (htrans_last[0])
    //  $display("%d unhandled SEQUENTIAL transaction",$time);
    //else 
      begin
      $write("%d ",$time);
      if (htrans_last[0])
        $write("SEQ ");
      if (hwrite_last)
        begin
        $write("WRITE addr_1=%h ",haddr_last);
        if (hsize_last==3'h0)
          begin
          $write("size=byte ");
          case (haddr_last[1:0])
            2'b00: $write("data=%h ",hwdata_s[7:0]);
            2'b01: $write("data=%h ",hwdata_s[15:8]);
            2'b10: $write("data=%h ",hwdata_s[23:16]);
            2'b11: $write("data=%h ",hwdata_s[31:24]);
          endcase
          end
        else if (hsize_last==3'h1)
          begin
          $write("size=halfword ");
          case (haddr_last[1])
            1'b0: $write("data=%h ",hwdata_s[15:0]);
            1'b1: $write("data=%h ",hwdata_s[31:16]);
          endcase
          end
        else if (hsize_last==3'h2)
          $write("size=word data=%h ", hwdata_s);
        else
          $write("size=%h (unhandled) data=%h ",hsize_last,hwdata_s);
        end
      else
        begin
        $write("READ addr_1=%h ",haddr_last);
        if (hsize_last==3'h0)
          begin
          $write("size=byte ");
          case (haddr_last[1:0])
            2'b00: $write("data=%h ",HRDATA[7:0]);
            2'b01: $write("data=%h ",HRDATA[15:8]);
            2'b10: $write("data=%h ",HRDATA[23:16]);
            2'b11: $write("data=%h ",HRDATA[31:24]);
          endcase
          end
        else if (hsize_last==3'h1)
          begin
          $write("size=halfword ");
          case (haddr_last[1])
            1'b0: $write("data=%h ",HRDATA[15:0]);
            1'b1: $write("data=%h ",HRDATA[31:16]);
          endcase
          end
        else if (hsize_last==3'h2)
          $write("size=word data=%h ", HRDATA);
        end
      $display("");
      end


//AHB 2
always @(posedge HCLK)
  if (HRESETn & HREADY_2 & htrans_last_2[1] & (hsel_ram_2 | hsel_s2_2))
    //if (htrans_last[0])
    //  $display("%d unhandled SEQUENTIAL transaction",$time);
    //else 
      begin
      $write("%d ",$time);
      if (htrans_last_2[0])
        $write("SEQ ");
      if (hwrite_last_2)
        begin
        $write("WRITE addr_2=%h ",haddr_last_2);
        if (hsize_last_2==3'h0)
          begin
          $write("size=byte ");
          case (haddr_last_2[1:0])
            2'b00: $write("data=%h ",hwdata_s_2[7:0]);
            2'b01: $write("data=%h ",hwdata_s_2[15:8]);
            2'b10: $write("data=%h ",hwdata_s_2[23:16]);
            2'b11: $write("data=%h ",hwdata_s_2[31:24]);
          endcase
          end
        else if (hsize_last_2==3'h1)
          begin
          $write("size=halfword ");
          case (haddr_last_2[1])
            1'b0: $write("data=%h ",hwdata_s_2[15:0]);
            1'b1: $write("data=%h ",hwdata_s_2[31:16]);
          endcase
          end
        else if (hsize_last_2==3'h2)
          $write("size=word data=%h ", hwdata_s_2);
        else
          $write("size=%h (unhandled) data=%h ",hsize_last_2,hwdata_s_2);
        end
      else
        begin
        $write("READ addr_2=%h ",haddr_last_2);
        if (hsize_last_2==3'h0)
          begin
          $write("size=byte ");
          case (haddr_last_2[1:0])
            2'b00: $write("data=%h ",HRDATA_2[7:0]);
            2'b01: $write("data=%h ",HRDATA_2[15:8]);
            2'b10: $write("data=%h ",HRDATA_2[23:16]);
            2'b11: $write("data=%h ",HRDATA_2[31:24]);
          endcase
          end
        else if (hsize_last_2==3'h1)
          begin
          $write("size=halfword ");
          case (haddr_last_2[1])
            1'b0: $write("data=%h ",HRDATA_2[15:0]);
            1'b1: $write("data=%h ",HRDATA_2[31:16]);
          endcase
          end
        else if (hsize_last_2==3'h2)
          $write("size=word data=%h ", HRDATA_2);
        end
      $display("");
      end
`endif

// Value Change Dump
// Uncomment the definition of the VCD macro at the top of this file
// to allow dumping all value changes to waves.vcd
`ifdef VCD
initial begin
  $dumpfile("waves.vcd");
  $dumpvars;
end
`endif



endmodule // tb
