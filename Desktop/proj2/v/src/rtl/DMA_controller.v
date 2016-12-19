// DMA-Controller Module
// (c) 2016-04-29 by Reshma Siddalingadevaru

module DMA_controller (
 hclk,
 hreset_n,
 hready_i,
 start,
 sel_control,
 buf_control,
 write_control,
length_control,
trans_control,dma_start,done,hready_pulldown
);

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
reg [1:0] state;
reg [1:0] next_state;
reg [4:0] output_controls;

input wire hclk;
input wire hreset_n;
input wire hready_i;
input wire dma_start;
input wire done;
input wire hready_pulldown;

output reg start;
output reg sel_control;
output reg buf_control;
output reg write_control;
output reg length_control;
output reg trans_control;

always @(posedge hclk)
begin
	if(!hreset_n) begin
		state <= S0;
		end
	else
		state <= next_state;
end

always @(*)
begin
		case(state)
				
			S0 : begin
					if(hready_i && dma_start && hready_pulldown) 
						begin
						next_state <= S1;
						start <= 1'b1;
						sel_control <= 1'b0;
						buf_control <= 1'b0;
						write_control <= 1'b0;
						length_control <= 1'b0;
						trans_control <= 1'b0;
						end
					 else begin
						next_state <= S0;
						start <= 1'b0;
						sel_control <= 1'b0;
						buf_control <= 1'b0;
						write_control <= 1'b0;
						length_control <= 1'b0;
						trans_control <= 1'b0;
						end
			      end
				 
			S1 : begin
					next_state <= S2;
					start <= 1'b0;
					sel_control <= 1'b1;
					buf_control <= 1'b0;
					write_control <= 1'b1;
					length_control <= 1'b0;
					trans_control <= 1'b0;
				 end
				 
			S2 : begin
					if(hready_i ) begin	
						next_state <= S3;
						start <= 1'b0;
						sel_control <= 1'b0;
						buf_control <= 1'b1;
						write_control <= 1'b0;
						length_control <= 1'b1;
						trans_control <= 1'b1;
						end
					
					else if (done) begin
					next_state <= S0;
						start <= 1'b0;
						sel_control <= 1'b0;
						buf_control <= 1'b0;
						write_control <= 1'b0;
						length_control <= 1'b0;
						trans_control <= 1'b0;
						 end
					 
					
					else begin
						next_state <= S2;
						start <= 1'b0;
						sel_control <= 1'b1;
						buf_control <= 1'b0;
						write_control <= 1'b1;
						length_control <= 1'b0;
						trans_control <= 1'b1;
						end
				end
	
			S3 : begin
						next_state <= S2;
						start <= 1'b0;
						sel_control <= 1'b1;
						buf_control <= 1'b0;
						write_control <= 1'b1;
						length_control <= 1'b0;	
						trans_control <= 1'b1; 
				end
										
		endcase
end

endmodule
