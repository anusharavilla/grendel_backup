// DMA-Unit Module
// (c) 2016-04-29 by Reshma Siddalingadevaru

module dma_unit(
input wire hclk,
input wire hreset_n,
input wire hready_2,
input wire hready_1,
input wire [31:0]                     haddr_cpu,
input wire [2:0]                      hburst_cpu,
input wire [3:0]                      hprot_cpu,
input wire [2:0]                      hsize_cpu,
input wire [1:0]                      htrans_cpu,
input wire [31:0]                     hwdata_cpu,
input wire                            hmastlock_cpu,
input wire                            hwrite_cpu,
input wire hsel_s1,
input wire [31:0] hrdata_i,
input wire  hresp_i,
output wire [31:0] haddr_o,
output wire	 [2:0]  hburst_o,
output wire	 [3:0]  hprot_o,
output wire	 [2:0]  hsize_o,
output wire	 [1:0]  htrans_o,
output wire	 [31:0] hwdata_o,
output wire	hmastlock_o,
output wire	hwrite_o,
output wire       hready_resp_s1,
output wire  [1:0]     hresp_s1,
output wire [31:0] hrdata_cpu_o);

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


wire  hready_pulldown;	
wire dma_start;
wire dram_control;
wire haddr_pulldown;
wire count_pulldown;
wire done;


wire  [31:0] src_addr_reg;
wire  [31:0] dest_addr_reg;
wire [3:0] transfer_length_reg;

wire    start;
wire    sel_control;
wire    buf_control;
wire    write_control;
wire    length_control;
wire 	trans_control;



arbiter arb(
hclk,
hreset_n,hready_2,
haddr_cpu,
hburst_cpu,
hprot_cpu,
hsize_cpu,
htrans_cpu,
hwdata_cpu,
hmastlock_cpu,
hwrite_cpu,
haddr_cpu_o,
hburst_cpu_o,
hprot_cpu_o,
hsize_cpu_o,
htrans_cpu_o,
hwdata_cpu_o,
hmastlock_cpu_o,
hwrite_cpu_o,
haddr_dma_o,
hburst_dma_o,
hprot_dma_o,
hsize_dma_o,
htrans_dma_o,
hwdata_dma_o,
hmastlock_dma_o,
hwrite_dma_o,
hrdata_i,
hrdata_cpu_o
);

DMA_slave dmaslave (
 	 hclk,
	 hreset_n,
	 hready_resp_s1,	
	 hresp_s1, 					
	 src_addr_reg,
	 dest_addr_reg,
	 transfer_length_reg,
	 

	 hready_2,
	 hsel_s1,	
	 haddr_dma_o,
	 hburst_dma_o,
	 hprot_dma_o,
	 hsize_dma_o,
	 htrans_dma_o,
	 hwdata_dma_o,
	 hmastlock_dma_o,
	 hwrite_dma_o,
	 hready_1,
	 hready_pulldown,
	 dma_start,haddr_pulldown,done,count_pulldown
	
);

DMA_datapath datapath(
	hclk,
	hreset_n,
	hready_2,
	hresp_i,
	hrdata_i,
	haddr_o,
	hburst_o,
	hprot_o,
	hsize_o,
	htrans_o,
	hwdata_o,
	hmastlock_o,
	hwrite_o,
	src_addr_reg,
	dest_addr_reg,
	transfer_length_reg,
	start,
	sel_control,
	buf_control,
	write_control,
	length_control,trans_control,
	 hready_pulldown,dma_start,haddr_pulldown,
	 haddr_cpu_o,
            hburst_cpu_o,
        hprot_cpu_o,
           hsize_cpu_o,
           htrans_cpu_o,
         hwdata_cpu_o,
             hmastlock_cpu_o,
                hwrite_cpu_o,done,count_pulldown

);

DMA_controller controller (
	hclk,
	hreset_n,
	hready_2,
    start,
    sel_control,
    buf_control,
    write_control,
    length_control,trans_control,
	dma_start, done, hready_pulldown
);

endmodule
