// Arbiter Module
// (c) 2016-04-29 by Reshma Siddalingadevaru

module arbiter(
input wire hclk,
input wire hreset_n,
input wire hready,
input wire [31:0]                     haddr_cpu,
input wire [2:0]                      hburst_cpu,
input wire [3:0]                      hprot_cpu,
input wire [2:0]                      hsize_cpu,
input wire [1:0]                      htrans_cpu,
input wire [31:0]                     hwdata_cpu,
input wire                            hmastlock_cpu,
input wire                            hwrite_cpu,
output reg [31:0]                     haddr_cpu_o,
output reg [2:0]                      hburst_cpu_o,
output reg [3:0]                      hprot_cpu_o,
output reg [2:0]                      hsize_cpu_o,
output reg [1:0]                      htrans_cpu_o,
output reg [31:0]                     hwdata_cpu_o,
output reg                            hmastlock_cpu_o,
output reg                            hwrite_cpu_o,
output reg [31:0]                     haddr_dma_o,
output reg [2:0]                      hburst_dma_o,
output reg [3:0]                      hprot_dma_o,
output reg [2:0]                      hsize_dma_o,
output reg [1:0]                      htrans_dma_o,
output reg [31:0]                     hwdata_dma_o,
output reg                            hmastlock_dma_o,
output reg                            hwrite_dma_o,
input wire [31:0] hrdata_i,
output reg [31:0] hrdata_cpu_o
);


reg [31:0] haddr_reg;

//sending read data back to CPU
always @(*)
begin
	hrdata_cpu_o <= hrdata_i;
end

always @(posedge hclk)
begin
haddr_reg <= haddr_cpu;
end

//distinguishing between DMA and DRAM transactions
always @(*)
begin
	if(!hreset_n)
	begin
	haddr_dma_o <= 32'h0;
		hwrite_dma_o <= 1'h0;
		htrans_dma_o <= 2'h0;
		hsize_dma_o <= 3'h0;
		//hwdata_dma_o <= 32'h0;
		hprot_dma_o <= 4'h0;
		hburst_dma_o <= 3'h0;
		hmastlock_dma_o <= 1'h0;
		haddr_cpu_o <= 32'h0;
		hwrite_cpu_o <= 1'h0;
		htrans_cpu_o <= 2'h0;
		hsize_cpu_o <= 3'h0;
		//hwdata_cpu_o <= 32'h0;
		hprot_cpu_o <= 4'h0;
		hburst_cpu_o <= 3'h0;
		hmastlock_cpu_o <= 1'h0;
	end
	else if (((haddr_cpu == 32'h40000010) || (haddr_cpu == 32'h40000060) || (haddr_cpu == 32'h40000090)) && hready) 
	begin
		haddr_dma_o <= haddr_cpu;
		hwrite_dma_o <= hwrite_cpu;
		htrans_dma_o <= htrans_cpu;
		hsize_dma_o <= hsize_cpu;
		//hwdata_dma_o <= hwdata_reg_dma;
		hprot_dma_o <= hprot_cpu;
		hburst_dma_o <= hburst_cpu;
		hmastlock_dma_o <= hmastlock_cpu;
		haddr_cpu_o <= 32'h0;
		hwrite_cpu_o <= 1'h0;
		htrans_cpu_o <= 2'h0;
		hsize_cpu_o <= 3'h0;
		//hwdata_cpu_o <= 32'h0;
		hprot_cpu_o <= 4'h0;
		hburst_cpu_o <= 3'h0;
		hmastlock_cpu_o <= 1'h0;
	end
	else if (hready)
	begin
		haddr_cpu_o <= haddr_cpu;
		hwrite_cpu_o <= hwrite_cpu;
		htrans_cpu_o <= htrans_cpu;
		hsize_cpu_o <= hsize_cpu;
		//hwdata_cpu_o <= hwdata_reg_cpu;
		hprot_cpu_o <= hprot_cpu;
		hburst_cpu_o <= hburst_cpu;
		hmastlock_cpu_o <= hmastlock_cpu;
		haddr_dma_o <= 32'h0;
		hwrite_dma_o <= 1'h0;
		htrans_dma_o <= 2'h0;
		hsize_dma_o <= 3'h0;
		//hwdata_dma_o <= 32'h0;
		hprot_dma_o <= 4'h0;
		hburst_dma_o <= 3'h0;
		hmastlock_dma_o <= 1'h0;
	end
	else 
	begin
		haddr_dma_o <= 32'h0;
		hwrite_dma_o <= 1'h0;
		htrans_dma_o <= 2'h0;
		hsize_dma_o <= 3'h0;
		//hwdata_dma_o <= 32'h0;
		hprot_dma_o <= 4'h0;
		hburst_dma_o <= 3'h0;
		hmastlock_dma_o <= 1'h0;
		haddr_cpu_o <= 32'h0;
		hwrite_cpu_o <= 1'h0;
		htrans_cpu_o <= 2'h0;
		hsize_cpu_o <= 3'h0;
		//hwdata_cpu_o <= 32'h0;
		hprot_cpu_o <= 4'h0;
		hburst_cpu_o <= 3'h0;
		hmastlock_cpu_o <= 1'h0; 
	end
end

always @(*)
begin
	if(!hreset_n)
	begin
		hwdata_cpu_o <= 32'h0;
		hwdata_dma_o <= 32'h0;
	end
	else if (((haddr_reg == 32'h40000010) || (haddr_reg == 32'h40000060) || (haddr_reg == 32'h40000090)) && hready) 
	begin
		
		hwdata_dma_o <= hwdata_cpu;
		hwdata_cpu_o <= 32'h0;
	end
	else if (hready) 
	begin
		
		hwdata_cpu_o <= hwdata_cpu;
		hwdata_dma_o <= 32'h0;
	end
	else
	begin
		
		hwdata_cpu_o <= 32'h0;
		hwdata_dma_o <= 32'h0;
	end
end
	
endmodule
