// DMA-Slave Module
// (c) 2016-04-29 by Reshma Siddalingadevaru

module DMA_slave (
	 hclk,	
	 hreset_n,
	 hreadyout_o,	
	 hresp_o,
	 src_addr_reg,
	 dest_addr_reg,
	 transfer_length_reg,
	 hready_dram,
	 hsel_s1,	
	 haddr_i,
	 hburst_i,
	 hprot_i,
	 hsize_i,
	 htrans_i,
	 hwdata_i,
	 hmastlock_i,
	 hwrite_i,
	 hready_i,
	 hready_pulldown,
	 dma_start,
	 haddr_pulldown,
	 done,
	 count_pulldown	
);

output wire	 hreadyout_o;
output wire [1:0]	 hresp_o;
output reg [31:0] src_addr_reg;
output reg [31:0] dest_addr_reg;
output reg [3:0] transfer_length_reg;
output reg hready_pulldown;
output reg dma_start;
output reg haddr_pulldown;
output reg count_pulldown;

reg [31:0] APhase_haddr;
reg APhase_hwrite;
reg [1:0] APhase_htrans;
reg [2:0] APhase_hsize;
reg [3:0] APhase_hprot;
reg APhase_hmastlock;
reg [2:0] APhase_hburst;
reg count_pulldown_1;
reg count_pulldown_2;

input wire hready_dram;
input wire  hclk;
input wire 	 hreset_n;
input wire hsel_s1;
input wire [31:0] haddr_i;
input wire	 [2:0]  hburst_i;
input wire	 [3:0]  hprot_i;
input wire	 [2:0]  hsize_i;
input wire	 [1:0]  htrans_i;
input wire	 [31:0] hwdata_i;
input wire	hmastlock_i;
input wire	hwrite_i;
input wire 	hready_i;
input wire done;	


reg APhase_hsel;

reg done_reg;

always @(posedge hclk)
begin
done_reg <= done;
end

always @(posedge hclk)
begin
	if(hready_i)
	begin
		APhase_hsel <= hsel_s1;
		APhase_hwrite <= hwrite_i;
		APhase_haddr <= haddr_i;
		APhase_htrans <= htrans_i;
		APhase_hprot <= hprot_i;
		APhase_hmastlock <= hmastlock_i;
		APhase_hburst <= hburst_i;
		APhase_hsize <= hsize_i;
	end
end


assign hresp_o = 2'b0;

always @(posedge hclk)
begin
	if(!hreset_n || done )
	begin
		src_addr_reg <= 32'h0;
		dest_addr_reg <= 32'h0;
		transfer_length_reg <= 4'hf;
		hready_pulldown <= 1'h0;
		dma_start <= 1'b0;
		haddr_pulldown <= 1'b0;
		count_pulldown_1 <= 1'b0;
	end
	else if ((!APhase_hsel & APhase_hwrite & APhase_htrans[1]) & (APhase_haddr == 32'h40000010))
		begin src_addr_reg <= hwdata_i; hready_pulldown <= 1'h0; dma_start <= 1'b1;   end
	else if ((!APhase_hsel & APhase_hwrite & APhase_htrans[1]) & (APhase_haddr == 32'h40000060))
		begin dest_addr_reg <= hwdata_i; hready_pulldown <= 1'h0; haddr_pulldown <= 1'b1; end
	else if ((!APhase_hsel & APhase_hwrite & APhase_htrans[1]) & (APhase_haddr == 32'h40000090))
		begin transfer_length_reg <= hwdata_i; hready_pulldown <= 1'h1; count_pulldown_1 <= 1'b1; end
		
end

always @(posedge hclk)
begin
	if(!hreset_n)
	count_pulldown_2 <= 1'b0;
	else
	count_pulldown_2 <= count_pulldown_1;
end

always @(*)
begin
	if(!hreset_n)
	count_pulldown <= 1'b0;
	else
	count_pulldown <= (count_pulldown_1 == 1'b1) && (count_pulldown_2 == 1'b0);
end



assign hreadyout_o = (done_reg == 1'b0) ? (hready_pulldown ? 1'b0 : hready_dram) : hready_dram;

endmodule


