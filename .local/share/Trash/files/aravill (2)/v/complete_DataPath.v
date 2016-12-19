module datapath (clock,negedge_cycle,n_exist,G1,G2,W1,W2,InputBus,controller_mux1,controller_mux2,controller_mux3,controller_mux4,output_selector1,output_selector2,output_selector3,output_selector4,output_memory_value, output_memory_address, prev_node,current_node_daughter_selector,control,graph1_selector,graph2_selector,daughter_count_hold, daughter_selector,register_pc_ip,wram_add_selector,control_write_mux,cntrl_w_add, cntrl_w_val, register1_pc,register2_pc,source_node_dest,wram_address2,dist_reg,out_reg_64,wa,write_value,daugther_counter,floating_out1,floating_out2,totalnodes,AL1,AL2,AL3,AL4,AL5,AL6,AL7,AL8,num_vertice,ouput_comparator,source,dest_node,InputAddress,status_of_input,number_of_lines_reg);
/*---------------------------------------------------------------input declaration----------------------------------------------------------------------------------------*/
input clock;
input negedge_cycle;
input [127:0] G1;
input [127:0] G2;
input [127:0] W1;
input [127:0] W2;
input daughter_count_hold;
input current_node_daughter_selector;
input [1:0] graph1_selector;
input [1:0] graph2_selector;
input [2:0] daughter_selector;
input [12:0] register_pc_ip;
input [1:0] wram_add_selector;
input control;
input [7:0] InputBus;
//input wmdr1_mux;
//input wmdr2_mux;
input control_write_mux;
input [12:0]  cntrl_w_add;
input [127:0] cntrl_w_val;
input controller_mux2,controller_mux3,controller_mux4;
input [1:0] controller_mux1;
input [1:0] output_selector2,output_selector3;
input [2:0] output_selector4;
input output_selector1;
/*---------------------------------------------------------------output declaration---------------------------------------------------------------------------------------*/
output [63:0] totalnodes;
output [127:0] prev_node;
output [15:0] output_memory_value;
reg [15:0] output_memory_value;
output [13:0] output_memory_address;
output [7:0]  num_vertice;
output [12:0] register1_pc;
output [12:0] register2_pc;
output [12:0] source_node_dest;
output reg [4:0] number_of_lines_reg; 
output [12:0]  wram_address2;
output signed [63:0] out_reg_64;
output ouput_comparator;
//output [127:0]WMDR1;
//output [127:0]WMDR2;
output [12:0] wa;
output [127:0]write_value;
output [7:0]  daugther_counter;
output floating_out1,floating_out2;
output [7:0]   dist_reg;
output [15:0] AL1;
output [15:0] AL2;
output [15:0] AL3;
output [15:0] AL4;
output [15:0] AL5;
output [15:0] AL6;
output [15:0] AL7;
output [15:0] AL8;
output [7:0] source;
output [7:0] dest_node;
output status_of_input;
output [9:0] InputAddress;
output n_exist;
reg n_exist;
/*----------------------------------------------------------------nets and registers declaration---------------------------------------------------------------------------*/
wire [63:0] totalnodes;
reg [13:0] output_memory_address;
reg [127:0] GDR1;
reg [127:0] GDR2;
reg [12:0]  register1_pc;
reg [12:0]  register2_pc;
reg [12:0]  source_node_dest;
reg [7:0]   current_node_dest;
reg [7:0]   dist_reg;
reg [63:0]  padding_dist_reg;
reg [7:0] DCR_sub_7;
reg [2:0] remainder_out;
reg [4:0] quotient;
reg [4:0] num_of_lines;
reg[2:0] remainder;
//reg [15:0]  d_mux_value;//values outside daughter decoding mux
//reg [127:0] WMDR1;
//reg [127:0] WMDR2;
reg [7:0]   num_vertice;
reg [63:0]  out_reg_64;
reg         ouput_comparator;//ouput_comparator is actually registered
reg [12:0]  wa;
reg [127:0] write_value;
reg [63:0]  a;//for part c
reg [127:0] b;//for part c   
reg signed [63:0]  tmp;// for part d   
reg comp;// for part d  
reg signed [63:0]  outreg;
reg [7:0]   daugther_counter;
reg floating_out1,floating_out2;
reg [63:0] temp1;
reg [12:0] extended_destination;
reg signed [63:0] temp2;
reg [63:0] temp3;
reg [15:0] AL1;
reg [15:0] AL2;
reg [15:0] AL3;
reg [15:0] AL4;
reg [15:0] AL5;
reg [15:0] AL6;
reg [15:0] AL7;
reg [15:0] AL8;
reg [7:0] source;
reg [7:0] dest_node;
reg [9:0]InputAddress;
reg status_of_input;
reg [12:0] extended_current_node_dest;
reg [12:0] wram_address2;
reg [127:0] prev_node;
//source and dest_node initialization
always@(posedge clock)
begin
if(negedge_cycle)
begin
n_exist<=1;

end
else
begin
n_exist<=n_exist;

end
end
always@(posedge clock)
begin
case(controller_mux1)
2'b00:
begin
InputAddress<=register_pc_ip[9:0];
end
2'b01:
begin
InputAddress<=InputAddress + 1;
end
2'b10:
begin
InputAddress<=InputAddress;
end
2'b11:
begin
InputAddress<=InputAddress;
end
endcase
end
always@(posedge clock)
begin
if(controller_mux2)
source<=InputBus;
else
source<=source;
end
always@(posedge clock)
begin
if(controller_mux3)
dest_node<=InputBus;
else
dest_node<=dest_node;
end
always@(posedge clock)
begin
if(controller_mux4)
status_of_input <= &InputBus;
else
status_of_input <= status_of_input;
end
//GDR registers initialization
always@(posedge clock)
begin
//first fragment
GDR1<=G1;
GDR2<=G2;
AL8<=G2[15:0];
AL7<=G2[31:16];
AL6<=G2[47:32];
AL5<=G2[63:48];  
AL4<=G2[79:64];
AL3<=G2[95:80];
AL2<=G2[111:96];
AL1<=G2[127:112];
if(control)
num_vertice<=G1[7:0];
else
num_vertice<=num_vertice;
//end of first fragment ..registers outside graph memory
if(current_node_daughter_selector) 
	source_node_dest<= GDR1[76:64];//getting source node address
else 
	source_node_dest<=source_node_dest;//getting source node address for different cycles(it might have to be constant for different cycles)



end                     
assign totalnodes = GDR1[63:0] - GDR1[127:0]; 
//multiplexor for daughter and distance separation->extracting from GDR2

//registers for daughter address in working memory and its distance from current source node
always@(posedge clock)
begin
case(daughter_selector) 
3'b000: 
begin
current_node_dest<=AL1[15:8];
dist_reg<=AL1[7:0];
end
3'b001: 
begin
current_node_dest<=AL2[15:8];
dist_reg<=AL2[7:0];
end
3'b010: 
begin
current_node_dest<=AL3[15:8];
dist_reg<=AL3[7:0];
end
3'b011: 
begin
current_node_dest<=AL4[15:8];
dist_reg<=AL4[7:0];
end
3'b100: 
begin
current_node_dest<=AL5[15:8];
dist_reg<=AL5[7:0];
end
3'b101: 
begin
current_node_dest<=AL6[15:8];
dist_reg<=AL6[7:0];
end
3'b110: 
begin
current_node_dest<=AL7[15:8];
dist_reg<=AL7[7:0];
end
3'b111: 
begin
current_node_dest<=AL8[15:8];
dist_reg<=AL8[7:0];
end


endcase

end

//Program counters for graph memory
always@(posedge clock)
begin
case (graph1_selector)
2'b00: register1_pc<=register1_pc + 13'b0000000000001;
2'b01: register1_pc<=register1_pc;
2'b10: register1_pc<=register_pc_ip;
2'b11: register1_pc<=register_pc_ip;
endcase
case (graph2_selector)
2'b01: register2_pc<=GDR1[12:0];
2'b00: register2_pc<=register2_pc;
2'b10: register2_pc<=register2_pc+1;
2'b11: register2_pc<=num_vertice;
endcase
end
//status signal regarding daughter count which is to be sent to controller

//assign daugther_counter = G2[119:112];

always@(posedge clock)
begin
if (daughter_count_hold)
daugther_counter <= G2[119:112];
else 
daugther_counter <= daugther_counter;
end
// second half of the datapath
// part a
//always@(posedge clock)
//begin
//if (wmdr1_mux) 
//    WMDR1 <=  W1;
//else 
//    WMDR1 <= WMDR1;
//end
//always@(posedge clock)
//begin
//if (wmdr2_mux)
//    WMDR2 <= W2;
//else
//    WMDR2 <= WMDR2;
//end
//end of part a
//part b

always@(posedge clock)
begin
case (wram_add_selector)
2'b00: wa <= wa;
2'b01: wa <= current_node_dest;
2'b10: wa <= cntrl_w_add;
2'b11: wa<=wa;
endcase
end

//end of part b
//final
always@(*)
begin
extended_current_node_dest = {5'b00000,current_node_dest};
extended_destination = {5'b00000, dest_node};
end
always@(*)
begin
case(output_selector2)
2'b00: wram_address2 = extended_current_node_dest;
2'b01: wram_address2 = extended_destination;
2'b10: wram_address2 = prev_node[12:0];
2'b11: wram_address2 = prev_node[12:0];
endcase
end

always@(posedge clock)
begin
if(output_selector1)
prev_node<=W2;
else
prev_node<=prev_node;
end
always@(*)
begin
case(output_selector4)
3'b000: output_memory_value = {3'b000,extended_destination};
3'b001: output_memory_value = {3'b000,prev_node[12:0]};
3'b010: output_memory_value =  prev_node[79:64];
3'b011: output_memory_value = 16'hFFFF;
3'b100: output_memory_value = 4'h0;
3'b101 : output_memory_value = 16'h7FFFF;
default : output_memory_value = 0;
endcase
end
always@(posedge clock)
begin
case(output_selector3)
2'b00: output_memory_address <= {1'b0,register_pc_ip};
2'b01: output_memory_address <= output_memory_address+1;
2'b10: output_memory_address <= output_memory_address;
2'b11: output_memory_address <= output_memory_address;
endcase
end
//final output
//part c
always@(*)
begin
if (ouput_comparator)
   a = W2[63:0];
   else
   a = { W1[63:13], source_node_dest};
   
	
   
            
 b = {out_reg_64,a};//preparing 128 bit value for writing into memory
if(control_write_mux)
 write_value = b;
else
 write_value = cntrl_w_val;
end

//end of part c;
//part d
always@(*)
begin
padding_dist_reg = 64'h0000000000000000;
//tmp = $signed(W1[127:64]) + $signed({padding_dist_reg[63:8],dist_reg}); 
tmp = $signed(W1[127:64]) + $signed(dist_reg); 
temp2 = $signed(W2[127:64]);
if ( tmp < $signed(W2[127:64]) )
   begin
     outreg = tmp;
     comp = 1'b0;
   end
else
   begin               
	  outreg = $signed(W2[127:64]);
     comp = 1'b1;
   end
floating_out1 = |GDR1[127:77];
floating_out2 = |GDR1[63:13];
end
always@(posedge clock)
begin
out_reg_64 <= outreg;
ouput_comparator <=comp;
end
//end of part d

always@(*)
begin
if(daugther_counter<=7)
num_of_lines=1;
else
begin
DCR_sub_7=daugther_counter - 8'b00000111;
remainder=DCR_sub_7[2:0];
quotient=DCR_sub_7[7:3];
if(remainder==3'b000)
num_of_lines=quotient+1;
else
num_of_lines=quotient+8'b00000010;
end
end

always@(posedge clock)
begin
number_of_lines_reg<=num_of_lines;
remainder_out<=remainder;
end
endmodule    

                                                          
