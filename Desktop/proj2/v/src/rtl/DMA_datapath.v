// DMA-Datapath Module
// (c) 2016-04-29 by Reshma Siddalingadevaru

module DMA_datapath (
	 hclk,
	 hreset_n,
	 hready_i,
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
	 src_addr,
	 dest_addr,
	 transfer_length,
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
         hwrite_cpu_o,
	 done,
	 count_pulldown	
);

input wire  hready_pulldown;
input wire dma_start;
wire dram_control;
input wire haddr_pulldown;
input wire count_pulldown;

input wire  hclk;
input wire 	 hreset_n;
input wire 	 hready_i;
input wire 	 hresp_i;
input wire  [31:0] hrdata_i;

output wire [31:0] haddr_o;
output reg	 [2:0]  hburst_o;
output reg	 [3:0]  hprot_o;
output reg	 [2:0]  hsize_o;
output reg	 [1:0]  htrans_o;
output wire	 [31:0] hwdata_o;
output reg	hmastlock_o;
output wire	hwrite_o;
output reg done;	


input wire [31:0] src_addr;
input wire [31:0] dest_addr;
input wire [3:0]  transfer_length;
input wire start;
input wire  sel_control;
input wire buf_control;
input wire write_control;
input wire length_control;
input wire trans_control;

input wire [31:0]                     haddr_cpu_o;
input wire [2:0]                      hburst_cpu_o;
input wire [3:0]                      hprot_cpu_o;
input wire [2:0]                      hsize_cpu_o;
input wire [1:0]                      htrans_cpu_o;
input wire [31:0]                     hwdata_cpu_o;
input wire                            hmastlock_cpu_o;
input wire                            hwrite_cpu_o;


reg [31:0] buffer;
reg [31:0] src_addr_reg;
reg [31:0] dest_addr_reg;
reg [3:0] transfer_length_reg;
reg [31:0] selctrl_wire;
reg [31:0] addrctrl_wire;
reg [31:0] bufctrl_wire;
reg  writectrl_wire;
reg [31:0] src_addr_reg_1;
reg dram_control_reg;


reg start_1,start_2, length_control_1, length_control_2;


reg done_dma;
reg done_reg;

reg [31:0] addrctrl_reg;
reg [31:0] bufctrl_reg;
reg writectrl_reg;
reg [1:0] htrans_reg;
reg [2:0] hsize_reg;
reg htrans_control, htrans_control_reg;
reg [3:0]count;
wire zero;


always @(posedge hclk)
begin
if(!hreset_n || count_pulldown)
   count <= 4'b1011;
else if (transfer_length_reg == 4'h0 && !zero) 
   count <= count - 4'b0001;   
end


assign zero = ~|count;

always @(posedge hclk)
begin
if(!hreset_n)
	done_dma <= 1'b0;
else if (count == 4'h1) begin
	done_dma <= 1'b1 ;
end
else
	done_dma <= 1'b0;
end


always @(posedge hclk)
begin
	if(!hreset_n)
	done_reg <= 1'b0;
	else
	done_reg <= done_dma;
end

always @(*)
begin
	if(!hreset_n)
	done <= 1'b0;
	else
	done <= (done_dma == 1'b1) && (done_reg == 1'b0);
end

always @(posedge hclk)
begin
	if(!hreset_n)
	begin
	start_1 <= 1'b0;
	start_2 <= 1'b0;
	length_control_1 <= 1'b0;
	length_control_2 <= 1'b0;
	end
	else begin
	start_1 <= start;
	start_2 <= start_1;
	length_control_1 <= length_control;
	length_control_2 <= length_control_1; end
end


always @(posedge hclk)
begin
	if(!hreset_n )
	begin
		hburst_o <= 3'b0;
		hprot_o <= 4'b0;
		hmastlock_o <= 1'b0;
	end
	else
	begin
		hburst_o <= 3'b0;
		hprot_o <= 4'b0;
		hmastlock_o <= 1'b0;
	end
end


always @(posedge hclk)
begin
	if(!hreset_n)
	begin
		hsize_reg <= 3'b0;
		htrans_reg <= 2'b0;
	end

	else if (trans_control)		
	begin
		hsize_reg <=  3'b010 ;
		htrans_reg <=  2'b10 ;
	end
	else 	
	begin
		hsize_reg <=  3'b000 ;
		htrans_reg <=  2'b00 ;
	end
end

always @(*)
begin
	hsize_o <=  haddr_pulldown ? hsize_reg : hsize_cpu_o;
	htrans_o <= (haddr_pulldown ? htrans_reg : htrans_cpu_o);
end



always @(posedge hclk)
begin
	if(!hreset_n)
	begin
		src_addr_reg <= src_addr;
		dest_addr_reg <= dest_addr;
		transfer_length_reg <= 4'hf;
	end
	else
	begin
		case({start,length_control})
			2'b00 : src_addr_reg <= src_addr_reg;
			2'b01 : begin 
				if(transfer_length_reg != 4'h1)
					src_addr_reg <= src_addr_reg + 32'h4;
				end			
			2'b10 : src_addr_reg <= src_addr;
			2'b11 : src_addr_reg <= 32'h0;
		endcase
		case({start_1,length_control_1})
			2'b00 : dest_addr_reg <= dest_addr_reg;
			2'b01 : begin 
				if(transfer_length_reg != 4'h1)
					dest_addr_reg <= dest_addr_reg + 32'h4;
				end
			2'b10 : dest_addr_reg <= dest_addr;
			2'b11 : dest_addr_reg <= 32'h0;
		endcase
		case({start_2,length_control_2})
			2'b00 : transfer_length_reg <= transfer_length_reg;
			2'b01 : begin
				if(transfer_length_reg != 4'h0) transfer_length_reg <= transfer_length_reg - 4'h1;
				//else transfer_length_reg <= 4'h0;
				end
			2'b10 : if(transfer_length != 4'h0) transfer_length_reg <= transfer_length; 
			2'b11 : transfer_length_reg <= 4'hf;
		endcase
	end
	//end
end


//********************** Haddr combinational *************************
always @(*)
begin
	addrctrl_wire <= (hready_i ? (sel_control ? dest_addr_reg : src_addr_reg) : haddr_o);
end

//********************** Haddr sequential *************************
always @(posedge hclk)
begin
	if(!hreset_n ) begin
		//haddr_o <= 32'h0;		
		addrctrl_reg <= 32'h0; 
	end
	
	else begin		
		addrctrl_reg <= addrctrl_wire;
		//haddr_o <= haddr_pulldown ? addrctrl_wire : haddr_cpu_o;
	end
end

assign haddr_o = (haddr_pulldown ? addrctrl_reg : haddr_cpu_o);

//*********************** HWrite combinational ********************
always @(*)
begin	
		writectrl_wire <= write_control ? 1'b1 : 1'b0;
		
end


//*********************** HWrite sequential ***********************
always @(posedge hclk)
begin
	if(!hreset_n )//|| transfer_length_reg == 4'h0)
		writectrl_reg <= 1'h0;
	else
		writectrl_reg <= writectrl_wire ;
end


assign hwrite_o = (haddr_pulldown ? writectrl_reg : hwrite_cpu_o);

//*********************** HWdata combinational********************
always @(*)
begin	

	bufctrl_wire  <= buf_control ? hrdata_i : hwdata_o ;
end


//*********************** HWdata sequential********************
always @(posedge hclk)
begin
	if(!hreset_n )
		bufctrl_reg <= 32'h0;
	else
		bufctrl_reg <= bufctrl_wire;
end

assign hwdata_o = (hready_pulldown ? bufctrl_reg : hwdata_cpu_o);

endmodule


		

