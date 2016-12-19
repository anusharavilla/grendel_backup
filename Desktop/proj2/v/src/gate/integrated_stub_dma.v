// Integrated_cpu_dma Module
// (c) 2016-04-29 by Reshma Siddalingadevaru


module integrated_stub_dma (
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
 /* NMI_2,
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
  //AHB 2 signal
  hsel_s1_2,
  hsel_reg,
  hsel_reg_2,	  //AHB 2 signal
  s_rd_data,
  s_rd_ready,
  hclk_2x
);

  input          HCLK;              // Clock
  input          HRESETn;           // Asynchronous reset
  output  [31:0] HADDR;             // AHB transaction address
  output  [ 2:0] HBURST;            // AHB burst: tied to single
  output         HMASTLOCK;         // AHB locked transfer (always zero)
  output  [ 3:0] HPROT;             // AHB protection: priv; data or inst
  output  [ 2:0] HSIZE;             // AHB size: byte, half-word or word
  output  [ 1:0] HTRANS;            // AHB transfer: non-sequential only
  output  [31:0] HWDATA;            // AHB write-data
  output         HWRITE;            // AHB write control
  input   [31:0] HRDATA;            // AHB read-data
  input          HREADY;            // AHB stall signal
  output         HRESP;             // AHB error response
  input          NMI;               // Non-maskable interrupt input
  input   [15:0] IRQ;               // Interrupt request inputs
  output         TXEV;              // Event output (SEV executed)
  input          RXEV;              // Event input
  output         LOCKUP;            // Core is locked-up
  output         SYSRESETREQ;       // System reset request
  output         SLEEPING;          // Core and NVIC sleeping


/*************AHB2*****************************************************************************/
  //input          HCLK;              // Clock
 // input          HRESETn;           // Asynchronous reset
  output  [31:0] HADDR_2;             // AHB transaction address
  output  [ 2:0] HBURST_2;            // AHB burst: tied to single
  output         HMASTLOCK_2;         // AHB locked transfer (always zero)
  output  [ 3:0] HPROT_2;             // AHB protection: priv; data or inst
  output  [ 2:0] HSIZE_2;             // AHB size: byte, half-word or word
  output  [ 1:0] HTRANS_2;            // AHB transfer: non-sequential only
  output  [31:0] HWDATA_2;            // AHB write-data
  output         HWRITE_2;            // AHB write control
  input   [31:0] HRDATA_2;            // AHB read-data
  input          HREADY_2;            // AHB stall signal
  output         HRESP_2;             // AHB error response
 /* input          NMI_2;               // Non-maskable interrupt input
  input   [15:0] IRQ_2;               // Interrupt request inputs
  output         TXEV_2;              // Event output (SEV executed)
  input          RXEV_2;              // Event input
  output         LOCKUP_2;            // Core is locked-up
  output         SYSRESETREQ_2;       // System reset request
  output         SLEEPING_2;          // Core and NVIC sleeping*/
/***************************************************************************************************/


  output  [ 1:0] htrans_s;
  output         hwrite_s;
  output  [31:0] haddr_s;
  output  [ 2:0] hsize_s;
  output  [31:0] hwdata_s;
  output         hsel_s2;
  input   [ 1:0] hresp_s2;
  input          hready_resp_s2;
  output         hready_resp_s1;

/*********************************AHB 2 *******************************************************/

 output  [ 1:0] htrans_s_2;
  output         hwrite_s_2;
  output  [31:0] haddr_s_2;
  output  [ 2:0] hsize_s_2;
  output  [31:0] hwdata_s_2;
  output         hsel_s2_2;
  input   [ 1:0] hresp_s2_2;
  input          hready_resp_s2_2;
  output         hready_resp_s1_2;
/***************************************************************************************************/

  input          scan_mode;
  input          remap;
  input          power_down;
  input          clear_sr_dp;
  input          big_endian;
  output  [15:0] debug_ad_row_addr;
  output  [ 1:0] debug_ad_bank_addr;
  output  [15:0] debug_ad_col_addr;
  output         hsel_s1;
//AHB 2 signal
  output         hsel_s1_2;
  input          hsel_reg;
  input		 hsel_reg_2;	//AHB 2 signal
  input   [31:0] s_rd_data;
  input          s_rd_ready;
  input          hclk_2x;

output  [31:0] src_addr_reg;
output  [31:0] dest_addr_reg;
output [3:0] transfer_length_reg;

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
wire        HRESP;              // AHB-Lite bus error (not used by testbench)
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
wire hmastlock_s;	

/***********************************************AHB 2 *******************/
wire [31:0] HADDR_2;              // AHB-Lite byte address
wire [ 2:0] HBURST_2;             // AHB-Lite burst type (not used by testbench)
wire        HMASTLOCK_2;          // AHB-Lite locked transaction (always zero)
wire [ 3:0] HPROT_2;              // AHB-Lite protection (not used by testbench)
wire [ 2:0] HSIZE_2;              // AHB-Lite size (# of bits: 0=8, 1=16, 2=32)
wire [ 1:0] HTRANS_2;             // AHB-Lite perform transaction
wire [31:0] HWDATA_2;             // AHB-Lite write-data
wire        HWRITE_2;             // AHB-Lite transaction is write not read
wire [31:0] HRDATA_2;             // AHB-Lite read-data
wire        HREADY_2;             // AHB-Lite bus ready signal
wire        HRESP_2;              // AHB-Lite bus error (not used by testbench)
/*wire        NMI_2;                // Non-maskable interrupt input (not used by tb)
wire [15:0] IRQ_2;                // Interrupt inputs (not used by testbench)
wire        TXEV_2;               // Event output (CPU executed SEV instruction)
wire        RXEV_2;               // Event input (not used by testbench)
wire        LOCKUP_2;             // CPU stopped due to multiple software errors
wire        SYSRESETREQ_2;        // CPU request for system to be reset
wire        SLEEPING_2;           // CPU is sleeping (not used by testbench)*/


///////////////////////////////////////////////////
//////////////////AHB BUS wires////////////////////
///////////////////////////////////////////////////
//wire hbusreq;  // Not needed for AHB-Lite
//wire hgrant;   // Not needed for AHB-Lite
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
wire hmastlock_s_2;	
 /****************************************************************************/

	
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
wire s_rd_ready; 				//input; to SDRAM; read data ready
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
wire hclk_2x; 					//input; 2x freq of hclk (DDR)
wire hsel_reg; 					//input; from ahb ?; used to program mem ctl
wire [31:0] s_rd_data; 			//input; from SDRAM; read data
wire s_sda_in;					//output; to SDRAM serial-presence-detect data out
wire [7:0] gpi; 				//input; from ?; general purpose inputs
wire remap; 					//input; from ?; if high address comparison down with remap registers
wire power_down; 				//input; from power management unit; if high SDRAM is put in power-down mode
wire clear_sr_dp; 				//input from ? ; clear self_freresh bit of SDRAM (SCTLR)
wire big_endian;				//input; from ?; high if AHB bus is big endian



wire    start;
wire    sel_control;
wire    addr_control;
wire    buf_control;
wire    write_control;
wire    length1_control;
wire 	trans_control;


wire [31:0] other_read_reg;
wire [31:0]	 other_write_reg;
wire [31:0]	 APhase_haddr;
wire  APhase_hwrite;
wire [1:0] APhase_htrans;
wire [2:0] APhase_hsize;
wire [3:0] APhase_hprot;
wire APhase_hmastlock;
wire [2:0] APhase_hburst;
wire  hready_pulldown;	
wire dma_start;
wire dram_control;
wire haddr_pulldown;
wire done;


//arbiter signals
wire [31:0]                     haddr_cpu_o;
wire [2:0]                      hburst_cpu_o;
wire [3:0]                      hprot_cpu_o;
wire [2:0]                      hsize_cpu_o;
wire [1:0]                      htrans_cpu_o;
wire [31:0]                     hwdata_cpu_o;
wire                            hmastlock_cpu_o;
wire                            hwrite_cpu_o;
wire [31:0]                     haddr_dma_o;
wire [2:0]                      hburst_dma_o;
wire [3:0]                      hprot_dma_o;
wire [2:0]                      hsize_dma_o;
wire [1:0]                      htrans_dma_o;
wire [31:0]                     hwdata_dma_o;
wire                            hmastlock_dma_o;
wire                            hwrite_dma_o;

//------------------------------------------------------------------------------
// Instantiate Cortex-M0 DesignStart processor macro cell
//------------------------------------------------------------------------------



//DW_ahb ahb( HCLK, 
AHB_Lite_2s ahb_1( HCLK, 
    HRESETn, 
    HADDR,              //input, from master1
    HBURST,             //not used
    //HBUSREQ,          //master1 doesn't have signal
    HMASTLOCK,          //not used
    HPROT,              //not used
    HSIZE,              //input, from master1
    HTRANS,             //input, from master1
    HWDATA,             //input, from master1
    HWRITE,             //input, high if write, from master1
    //hgrant,           //output, would go to master1 if it wasn't ahb-lite
    hsel_s1,           //output, high if s1 selected
    hready_resp_s1,     //input, from s1, transfer status
    hresp_s1,           //input, from s1, transfer error message
    hrdata_s1,          //input, from s1, data
    hsel_s2,           //output, high if s2 selected
    hready_resp_s2,     //input, from s2, transfer status
    hresp_s2,           //input, from s2, transfer error message
    hrdata_s2,          //input, from s2, data
    haddr_s,              //output
    hburst_s,             //output
    hprot_s,              //output
    hsize_s,              //output
    htrans_s,             //output
    hwdata_s,             //output
    hwrite_s,             //output
    HREADY,             //output
    hresp_ahb,          //output
    HRDATA,             //output, to master1, read data
    hmaster,            //output, indicates which master has ownership of address and control bus
    hmaster_data,       //output, indicats whic master has ownership of data bus
    hmastlock_s);         //output, arbiter drives it to indicate locked transfer 


AHB_Lite_2s ahb_2( HCLK, 
    HRESETn, 
    HADDR_2,              //input, from master1
    HBURST_2,             //not used
    //HBUSREQ,          //master1 doesn't have signal
    HMASTLOCK_2,          //not used
    HPROT_2,              //not used
    HSIZE_2,              //input, from master1
    HTRANS_2,             //input, from master1
    HWDATA_2,             //input, from master1
    HWRITE_2,             //input, high if write, from master1
    //hgrant,           //output, would go to master1 if it wasn't ahb-lite
    hsel_s1_2,           //output, high if s1 selected
    hready_resp_s1_2,     //input, from s1, transfer status
    hresp_s1_2,           //input, from s1, transfer error message
    hrdata_s1_2,          //input, from s1, data
    hsel_s2_2,           //output, high if s2 selected
    hready_resp_s2_2,     //input, from s2, transfer status
    hresp_s2_2,           //input, from s2, transfer error message
    hrdata_s2_2,          //input, from s2, data
    haddr_s_2,              //output
    hburst_s_2,             //output
    hprot_s_2,              //output
    hsize_s_2,              //output
    htrans_s_2,             //output
    hwdata_s_2,             //output
    hwrite_s_2,             //output
    HREADY_2,             //output
    hresp_ahb_2,          //output
    HRDATA_2,             //output, to master1, read data
    hmaster_2,            //output, indicates which master has ownership of address and control bus
    hmaster_data_2,       //output, indicats whic master has ownership of data bus
    hmastlock_s_2);         //output, arbiter drives it to indicate locked transfer 



dma_unit dma_module(
HCLK,
HRESETn,HREADY_2,
HREADY,
haddr_s,	//inputs
hburst_s,
hprot_s,
hsize_s,
htrans_s,
hwdata_s,
hmastlock_s,
hwrite_s,
hsel_s1,
HRDATA_2,
HRESP_2,
HADDR_2,
	HBURST_2,
	HPROT_2,
	HSIZE_2,
	HTRANS_2,
	HWDATA_2,
	HMASTLOCK_2,
	HWRITE_2,
hready_resp_s1,
hresp_s1,hrdata_s1
);


AHBLiteStub stub(
	// inputs
	HCLK,
	HRESETn,
	HREADY,
	HRESP,
	HRDATA,
	// outputs
	HADDR,
	HBURST,
	HPROT,
	HSIZE,
	HTRANS,
	HWDATA,
	HMASTLOCK,
	HWRITE
);
assign TXEV=1'b0;
assign LOCKUP=1'b0;
assign SYSRESETREQ=1'b0;
assign SLEEPING=1'b0;

			
   
   
///////////////////////////////////////////////
///////////////////MEMCTL//////////////////////
///////////////////////////////////////////////		
DW_memctl memctl_v4(
			hready_resp_s1_2, 			//output, to ahb, data is ready
			hresp_s1_2, 					//output, to ahb, ahb transfer error message
			hrdata_s1_2,					//output, to ahb, ahb read data
			s_ras_n, 					//output, to SDRAM, row address select
			s_cas_n, 					//output, to SDRAM, column address select
			s_cke, 						//output, to SDRAM, clock enable
			s_wr_data,					//output, to SDRAM, write data
			s_addr, 					//output, to SDRAM, address bus
			s_bank_addr, 				//output, to SDRAM, bank address
			s_dout_valid,				//output, to SDRAM, valid signal for write data
			s_sel_n,					//output, to SDRAM, chip select
			s_dqm, 						//output, to SDRAM, input mask for write access/output enable for read access
			s_we_n, 					//output, to SDRAM, write enable
			s_dqs, 						//output, to SDRAM, data strobe 
			s_sa, 						//output, to SDRAM, serial-presence-detect address
			s_scl, 						//output, to SDRAM, serial-presence-detect clock
			s_rd_ready, 				//input, to SDRAM, read data ready
			s_rd_start, 				//output, to SDRAM, read command issued
			s_rd_pop, 					//output, to SDRAM, read data pop
			s_rd_end, 					//output, to SDRAM, last read data in a burst
			s_rd_dqs_mask,				//output, to SDRAM, read DQS mask
			s_cas_latency, 				//output, to SDRAM, CAS latency...
			s_read_pipe, 				//output, to SDRAM, holds the value of SCTLR[8:6]
			s_sda_out, 					//output, to SDRAM, serial-presence-detect data out
			s_sda_oe_n, 				//output, to SDRAM, serial-presence-detect data in
			gpo, 						//output, to SDRAM, gernal purpose output
			debug_ad_bank_addr,			//output
			debug_ad_row_addr, 			//output 					
			debug_ad_col_addr, 			//output
			debug_ad_sf_bank_addr,		//output
			debug_ad_sf_row_addr, 		//output
			debug_ad_sf_col_addr, 		//output
			debug_hiu_addr,				//output
			debug_sm_burst_done,		//output
			debug_sm_pop_n,				//output
			debug_sm_push_n, 			//output
			debug_smc_cs, 				//output
			debug_ref_req, 				//?	
			HCLK, 						//input
			hclk_2x, 					//input, 2x freq of hclk (DDR)
			HRESETn,					//input, reset active low
			scan_mode, 					//input, used to bypass internally generated reset during scan testing, must be low
			haddr_s_2, 						//input, from ahb 
			hsel_s1_2, 					//input, from ahb, ahb has selected this slave, active high
			hsel_reg_2, 					//input, from ahb ?, used to program mem ctl
			hwrite_s_2, 					//input, from ahb, high when writting, low when reading
			htrans_s_2, 					//input, from ahb, transfer type
			hsize_s_2, 						//input, from ahb, bus transfer size
			hburst_s_2,						//input, from ahb, burst type
			HREADY_2, 					//input, from ahb, bus data ready response
			hwdata_s_2, 					//input, from ahb, write data
			s_rd_data, 					//input, from SDRAM, read data
			s_sda_in,					//output, to SDRAM serial-presence-detect data out
			gpi, 						//input, from ?, general purpose inputs
			remap, 						//input, from ?, if high address comparison down with remap registers
			power_down, 				//input, from power management unit, if high SDRAM is put in power-down mode
			clear_sr_dp, 				//input from ? , clear self_freresh bit of SDRAM (SCTLR)
			big_endian);				//input, from ?, high if AHB bus is big endian


OR2X1_LVT resp_or ( .A1(hresp_ahb[0]), .A2(hresp_ahb[1]), .Y(HRESP) );
OR2X1_LVT resp_or_2 ( .A1(hresp_ahb_2[0]), .A2(hresp_ahb_2[1]), .Y(HRESP_2) );

endmodule 
