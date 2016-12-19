module complete_DataPath (clock,negedge_cycle,n_exist,G1,G2,W1,W2,InputBus,c1,c2,c3,c4,o1,o2,o3,o4,output_memory_value, output_memory_address, previous,snd_mux,control,graph1,graph2,dcr_mux, d_mux,PC_REG_input,w_mux,control_write_mux,controller_writing_address, controller_writing_value, PC_REG1,PC_REG2,source_node_dest,wram_address2,dist_reg,out_reg_64,wa,write_value,DCR,floating_out1,floating_out2,totalnodes,al1,al2,al3,al4,al5,al6,al7,al8,vertice_num,out_comp,source,destination,InputAddress,i_status,num_of_lines_out);
/*---------------------------------------------------------------input declaration----------------------------------------------------------------------------------------*/
input clock;
input negedge_cycle;
input [127:0] G1;
input [127:0] G2;
input [127:0] W1;
input [127:0] W2;
input dcr_mux;
input snd_mux;
input [1:0] graph1;
input [1:0] graph2;
input [2:0] d_mux;
input [12:0] PC_REG_input;
input [1:0] w_mux;
input control;
input [7:0] InputBus;
//input wmdr1_mux;
//input wmdr2_mux;
input control_write_mux;
input [12:0]  controller_writing_address;
input [127:0] controller_writing_value;
input c2,c3,c4;
input [1:0] c1;
input [1:0] o2,o3;
input [2:0] o4;
input o1;
/*---------------------------------------------------------------output declaration---------------------------------------------------------------------------------------*/
output [63:0] totalnodes;
output [127:0] previous;
output [15:0] output_memory_value;
reg [15:0] output_memory_value;
output [13:0] output_memory_address;
output [7:0]  vertice_num;
output [12:0] PC_REG1;
output [12:0] PC_REG2;
output [12:0] source_node_dest;
output reg [4:0] num_of_lines_out; 
output [12:0]  wram_address2;
output signed [63:0] out_reg_64;
output out_comp;
//output [127:0]WMDR1;
//output [127:0]WMDR2;
output [12:0] wa;
output [127:0]write_value;
output [7:0]  DCR;
output floating_out1,floating_out2;
output [7:0]   dist_reg;
output [15:0] al1;
output [15:0] al2;
output [15:0] al3;
output [15:0] al4;
output [15:0] al5;
output [15:0] al6;
output [15:0] al7;
output [15:0] al8;
output [7:0] source;
output [7:0] destination;
output i_status;
output [9:0] InputAddress;
output n_exist;
reg n_exist;
/*----------------------------------------------------------------nets and registers declaration---------------------------------------------------------------------------*/
wire [63:0] totalnodes;
reg [13:0] output_memory_address;
reg [127:0] GDR1;
reg [127:0] GDR2;
reg [12:0]  PC_REG1;
reg [12:0]  PC_REG2;
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
reg [7:0]   vertice_num;
reg [63:0]  out_reg_64;
reg         out_comp;//out_comp is actually registered
reg [12:0]  wa;
reg [127:0] write_value;
reg [63:0]  a;//for part c
reg [127:0] b;//for part c   
reg signed [63:0]  tmp;// for part d   
reg comp;// for part d  
reg signed [63:0]  outreg;
reg [7:0]   DCR;
reg floating_out1,floating_out2;
reg [63:0] temp1;
reg [12:0] extended_destination;
reg signed [63:0] temp2;
reg [63:0] temp3;
reg [15:0] al1;
reg [15:0] al2;
reg [15:0] al3;
reg [15:0] al4;
reg [15:0] al5;
reg [15:0] al6;
reg [15:0] al7;
reg [15:0] al8;
reg [7:0] source;
reg [7:0] destination;
reg [9:0]InputAddress;
reg i_status;
reg [12:0] extended_current_node_dest;
reg [12:0] wram_address2;
reg [127:0] previous;
//source and destination initialization
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
case(c1)
2'b00:
begin
InputAddress<=PC_REG_input[9:0];
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
if(!c2)
source<=source;
else
source<=InputBus;
end
always@(posedge clock)
begin
if(!c3)
destination<=destination;
else
destination<=InputBus;

end
always@(posedge clock)
begin
if(c4)
i_status <= &InputBus;
else
i_status <= i_status;
end
//GDR registers initialization
always@(posedge clock)
begin
//first fragment
GDR1<=G1;
GDR2<=G2;
al8<=G2[15:0];
al7<=G2[31:16];
al6<=G2[47:32];
al5<=G2[63:48];  
al4<=G2[79:64];
al3<=G2[95:80];
al2<=G2[111:96];
al1<=G2[127:112];
if(control)
vertice_num<=G1[7:0];
else
vertice_num<=vertice_num;
//end of first fragment ..registers outside graph memory
if(!snd_mux) 
	source_node_dest<=source_node_dest;//getting source node address for different cycles(it might have to be constant for different cycles)
else 
	
    source_node_dest<= GDR1[76:64];//getting source node address


end                     
assign totalnodes = GDR1[63:0] - GDR1[127:0]; 
//multiplexor for daughter and distance separation->extracting from GDR2

//registers for daughter address in working memory and its distance from current source node
always@(posedge clock)
begin
case(d_mux) 
3'b000: 
begin
current_node_dest<=al1[15:8];
dist_reg<=al1[7:0];
end
3'b001: 
begin
current_node_dest<=al2[15:8];
dist_reg<=al2[7:0];
end
3'b010: 
begin
current_node_dest<=al3[15:8];
dist_reg<=al3[7:0];
end
3'b011: 
begin
current_node_dest<=al4[15:8];
dist_reg<=al4[7:0];
end
3'b100: 
begin
current_node_dest<=al5[15:8];
dist_reg<=al5[7:0];
end
3'b101: 
begin
current_node_dest<=al6[15:8];
dist_reg<=al6[7:0];
end
3'b110: 
begin
current_node_dest<=al7[15:8];
dist_reg<=al7[7:0];
end
3'b111: 
begin
current_node_dest<=al8[15:8];
dist_reg<=al8[7:0];
end


endcase

end

//Program counters for graph memory
always@(posedge clock)
begin
case (graph1)
2'b00: PC_REG1<=PC_REG1 + 13'b0000000000001;
2'b01: PC_REG1<=PC_REG1;
2'b10: PC_REG1<=PC_REG_input;
2'b11: PC_REG1<=PC_REG_input;
endcase
case (graph2)
2'b01: PC_REG2<=GDR1[12:0];
2'b00: PC_REG2<=PC_REG2;
2'b10: PC_REG2<=PC_REG2+1;
2'b11: PC_REG2<=vertice_num;
endcase
end
always@(posedge clock)
begin
if (dcr_mux)
DCR <= G2[119:112];
else 
DCR <= DCR;
end


always@(posedge clock)
begin
case (w_mux)
2'b00: wa <= wa;
2'b01: wa <= current_node_dest;
2'b10: wa <= controller_writing_address;
2'b11: wa<=wa;
endcase
end

//end of part b
//final
always@(*)
begin
extended_current_node_dest = {5'b00000,current_node_dest};
extended_destination = {5'b00000, destination};
end
always@(*)
begin
case(o2)
2'b00: wram_address2 = extended_current_node_dest;
2'b01: wram_address2 = extended_destination;
2'b10: wram_address2 = previous[12:0];
2'b11: wram_address2 = previous[12:0];
endcase
end

always@(posedge clock)
begin
if(o1)
previous<=W2;
else
previous<=previous;
end
always@(*)
begin
case(o4)
2'b000: output_memory_value = {3'b000,extended_destination};
2'b001: output_memory_value = {3'b000,previous[12:0]};
2'b010: output_memory_value =  previous[79:64];
2'b011: output_memory_value = 16'hFFFF;
2'b100: output_memory_value = 4'h0;
2'b101 : output_memory_value = 16'h7FFFF;
default : output_memory_value = 0;
endcase
end
always@(posedge clock)
begin
case(o3)
2'b00: output_memory_address <= {1'b0,PC_REG_input};
2'b01: output_memory_address <= output_memory_address+1;
2'b10: output_memory_address <= output_memory_address;
2'b11: output_memory_address <= output_memory_address;
endcase
end
//final output
//part c
always@(*)
begin
if (out_comp)
   a = W2[63:0];
   else if(out_comp==0 && current_node_dest!=vertice_num)
   a = { 51'b000000000000000000000000000000000000000000000000000, source_node_dest};
   else
	a = W2[63:0];
   
            
 b = {out_reg_64,a};//preparing 128 bit value for writing into memory
if(control_write_mux)
 write_value = b;
else
 write_value = controller_writing_value;
end

//end of part c;
//part d
always@(*)
begin
if(DCR<=7)
num_of_lines=1;
else
begin
DCR_sub_7=DCR - 8'b00000111;
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
num_of_lines_out<=num_of_lines;
remainder_out<=remainder;
end
  

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
out_comp <=comp;
end
//end of part d
endmodule
  

                                                          
