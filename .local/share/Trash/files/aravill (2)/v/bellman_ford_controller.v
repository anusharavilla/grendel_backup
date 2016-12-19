module controlpath( prev_node,status_of_input,finish_simulation,negedge_cycle, dest_node,WE2, output_selector1,output_selector2,output_selector3,output_selector4, clock, reset, num_vertice, source_num, daugther_counter, ouput_comparator, WE, current_node_daughter_selector, graph1_selector, graph2_selector, daughter_selector, control, register_pc_ip, cntrl_w_add, cntrl_w_val, wram_add_selector, control_write_mux, finish, daughter_count_hold, controller_mux1, controller_mux2, controller_mux3, controller_mux4,number_of_lines_reg

    );
	 
/*--------------------input declaration---------------*/
input [7:0] dest_node;
input [127:0] prev_node;
input clock;
input reset;
input [7:0] num_vertice;
input [7:0] source_num;
input [7:0] daugther_counter;
input ouput_comparator;
input status_of_input;
input [4:0] number_of_lines_reg;
/*------------------output declaration--------------*/
output WE;
output WE2;
output [1:0] output_selector2,output_selector3;
output [2:0] output_selector4;
output   output_selector1;
output current_node_daughter_selector;
output control;
output [1:0] graph1_selector;
output [1:0] graph2_selector;
output [2:0] daughter_selector;
output [12:0] register_pc_ip;
output [12:0] cntrl_w_add;
output [127:0] cntrl_w_val;
output finish_simulation;
reg finish_simulation;
output [1:0] wram_add_selector;
output control_write_mux;
output finish;
output daughter_count_hold;
output [1:0] controller_mux1;
output controller_mux2;
output controller_mux3;
output controller_mux4;


/*-------------------registers and nets-----------*/	 

parameter [4:0] 
	S0 = 5'b00000,
	S1 = 5'b00001,
	S2 = 5'b00010,
	S3 = 5'b00011,
	S4 = 5'b00100,
	S5 = 5'b00101,
	S6 = 5'b00110,
	S7 = 5'b00111,
	S8 = 5'b01000,
	S9 = 5'b01001,
	S10 = 5'b01010,
	S11 = 5'b01011,
	S12 = 5'b01100,
	S13 = 5'b01101,
	S14 = 5'b01110,
	S15 = 5'b01111,
	S16 = 5'b10000,
        S17 = 5'b10001,
	S18 = 5'b10010,
	S19 = 5'b10011,
	S20 = 5'b10100,
	S21 = 5'b10101,
	S22 = 5'b10110,
	S23 = 5'b10111,
	S24 = 5'b11000,
	S25 = 5'b11001,
	S26 = 5'b11010,
	S27 = 5'b11011,
	S28 = 5'b11100,
	S29 = 5'b11101,
	S31 = 5'b11111;
	

reg WE2;
reg [1:0] output_selector2,output_selector3;
reg [2:0] output_selector4;
reg output_selector1;
reg [4:0] current_state, next_state;
reg [7:0] d_count,d_count_reg,temp1,temp1_reg,temp3,temp3_reg;
reg [7:0] run_loop,run_loop_reg;
reg [7:0] bellman_count,bellman_count_reg;
output negedge_cycle;
reg WE;
reg current_node_daughter_selector;
reg control,control_reg;
reg [1:0] graph1_selector,graph1_reg;
reg [1:0] graph2_selector,graph2_reg;
reg [2:0] daughter_selector,d_mux_reg;
reg [12:0] register_pc_ip,PC_REG_input_reg;
reg [12:0] cntrl_w_add,controller_writing_address_reg;
reg [127:0] cntrl_w_val;
reg [1:0] wram_add_selector,w_mux_reg;
reg control_write_mux,control_write_mux_reg;
reg finish,finish_reg;
reg [7:0] a,a_reg,b,b_reg;
reg daughter_count_hold;
reg [1:0] controller_mux1;
reg controller_mux2;
reg controller_mux3;
reg controller_mux4;
reg negedge_cycle;

reg[12:0] flag,flag_reg,count,count_reg;

reg value,value_reg;	
always@(posedge clock or negedge reset)
begin 
if (!reset) current_state <= S0; //s28
else       
begin
current_state <= next_state;

temp3_reg<=temp3;
b_reg<=b;
bellman_count_reg<=bellman_count;
graph1_reg<=graph1_selector;
a_reg<=a;
d_count_reg<=d_count;
control_reg<=control;
control_write_mux_reg<=control_write_mux;
run_loop_reg<=run_loop;
w_mux_reg<=wram_add_selector;
d_mux_reg<=daughter_selector;
graph2_reg<=graph2_selector;
controller_writing_address_reg<=cntrl_w_add;
finish_reg<=finish;
temp1_reg<=temp1;
value_reg<=value;
count_reg<=count;
flag_reg<=flag;
PC_REG_input_reg<=register_pc_ip;
end
end

always@(*)
begin
finish_simulation=0;
cntrl_w_val = 128'h00000000000000000000000000000000;
daughter_count_hold = 1'b1;
controller_mux4=1'b0;
controller_mux2=1'b0;
controller_mux3=1'b0;                   
controller_mux1=2'b10;
output_selector2=2'b00;  
output_selector1=1'b0;
output_selector4=3'b011;
output_selector3=2'b11;
WE2=1'b0;
WE=1'b0;
current_node_daughter_selector=1'b0;
negedge_cycle =1'b0;
temp3=temp3_reg;
b=b_reg;
bellman_count=bellman_count_reg;
graph1_selector=graph1_reg;
a=a_reg;
d_count=d_count_reg;
control=control_reg;
control_write_mux=control_write_mux_reg;
run_loop=run_loop_reg;
wram_add_selector=w_mux_reg;
daughter_selector=d_mux_reg;
graph2_selector=graph2_reg;
cntrl_w_add=controller_writing_address_reg;
finish=finish_reg;
temp1=temp1_reg;
value=value_reg;
count=count_reg;
flag=flag_reg;
register_pc_ip=PC_REG_input_reg;
next_state=current_state;
case(current_state)
S0:   //s28
begin
flag = 0;
controller_mux1 = 2'b00;
register_pc_ip= 13'b0000000000000;

next_state = S1;
end

S1:          //s20
begin   
controller_mux1= 2'b01;   //10 adhi
controller_mux2=1'b1;
next_state = S2;
end

S2:          //s22
begin
controller_mux1=2'b01;
controller_mux3=1'b1;
next_state = S3;
end
S3:                  //s23
begin
controller_mux4=1'b1;
/*next_state = S4;
end
S4:                 //s0
begin*/
value=0;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b10;    
graph2_selector = 2'b01;
daughter_selector = 3'b000;
//bellman_count = 1;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = 13'b0000000000000;
//cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b10;
control = 1'b1;
control_write_mux = 1'b0;
a = 1; 

next_state = S5;
end
S5:     //s1
begin
graph2_selector = 2'b01;//
WE = 1'b0;
current_node_daughter_selector = 1'b1;

//graph1_selector = 2'b01;
daughter_selector = 3'b000;//
graph2_selector = 2'b01;
//daughter_selector = 3'b000;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = 13'b0000000000000;
cntrl_w_val = 128'h00000000000000000000000000000000;
a = 1;
wram_add_selector = 2'b10;
control_write_mux = 1'b0;
control = 1'b1;
next_state=S6;
end

S6:       //s2
begin
WE = 1'b0;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b01;
daughter_selector = 3'b000;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = 13'b0000000000000;
cntrl_w_val = 128'h00000000000000000000000000000000;

wram_add_selector = 2'b10;
control_write_mux = 1'b0;
control = 1'b0;
b = num_vertice;
bellman_count=num_vertice;
next_state = S7;
end 

//booting infinity in temporary memory
S7:                    //s3
begin
WE = 1'b1;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
daughter_selector = 3'b000;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, a};
cntrl_w_val = 128'h00000000000100000000000000000000;
wram_add_selector = 2'b10;
control_write_mux = 1'b0;
next_state = S8;



end

S8:            //s17
begin
if (a < num_vertice)
begin
a = a + 1;
next_state = S7;           //s3
end
else
begin
wram_add_selector = 2'b10;
cntrl_w_add = {5'b00000, source_num};
next_state = S9;          //s4
end
end

//booting zero in the source
S9:              //s4
begin
WE = 1'b1;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
daughter_selector = 3'b000;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;

run_loop = b-1;                          //changed
control_write_mux = 1'b0;
if(number_of_lines_reg==1)
begin
temp1=1;
temp3=daugther_counter;
end
else if(number_of_lines_reg>1)
begin
temp1=1;
temp3=7;
end
d_count=1;
next_state = S10;
end
//checkpoint one reached here
//
S10:                   //s5
begin
WE = 1'b0;
daughter_count_hold = 1'b0;
current_node_daughter_selector = 1'b0;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
daughter_selector = temp1[2:0];
next_state = S11;
end
S11:          //s6
begin
WE = 1'b0;
daughter_count_hold = 1'b0;
current_node_daughter_selector = 1'b0;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
next_state = S12;
end
S12:                  //s7
begin
WE = 1'b1;
daughter_count_hold = 1'b0;
current_node_daughter_selector = 1'b0;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
if(ouput_comparator==0)
value=1;
if((bellman_count== 2) && (ouput_comparator==0))
begin
negedge_cycle = 1'b1;

end
else
negedge_cycle=1'b0;

    if(temp1<temp3)
begin
  temp1=temp1+1;
  d_count = d_count+1;
  next_state = S10;              //s5
end
else if(temp1==temp3)
begin
 if(d_count == daugther_counter)
  begin
   next_state = S15;               //s11
  end
 else if((daugther_counter-d_count)<8)
  begin
   temp1=0;      
   temp3=daugther_counter-d_count-1;
   next_state=S13;               //s13
  end   
 else if((daugther_counter-d_count)>=8)
  begin
   temp1=0;
   temp3=7;
   next_state=S13;
  end
end
end
S13:             //s8
begin
WE = 1'b0;
daughter_count_hold = 1'b0;
current_node_daughter_selector = 1'b0;
graph1_selector = 2'b01;
graph2_selector = 2'b10;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
next_state = S14;
end   
S14:                  //s10
begin
WE = 1'b0;
daughter_count_hold = 1'b0;
current_node_daughter_selector = 1'b0;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
d_count = d_count + 1;
next_state = S10;      //s5
end
S15:                    //s11
begin
WE = 1'b0;
current_node_daughter_selector = 1'b1;
if(run_loop == 1)            //changed
begin
graph1_selector = 2'b01;
graph2_selector = 2'b11;
end
else
begin
graph1_selector = 2'b00;
graph2_selector = 2'b10;
end
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
next_state = S16;
end
S16:               //s12
begin
WE = 1'b0;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
daughter_count_hold = 1'b1;
next_state = S17;
end
S17:            //s13
begin
WE = 1'b0;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
run_loop = run_loop - 1;          //changed
if(run_loop== 0)
begin
next_state = S18;
run_loop =b-1;
end
else
begin
	if(daugther_counter<=7)
	begin
	temp1=1;
	temp3=daugther_counter;
	end
	else if(daugther_counter>7)
	begin
	temp1=1;
	temp3=7;
	end
	d_count=1;
	next_state = S10;
end
end
////////////////////////////////////////


S18:
begin
WE = 1'b0;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b10;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
next_state = S19;
end
S19:          //s15
begin
WE = 1'b0;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
next_state = S20;  
end

S20:          //s16
begin
WE = 1'b0;
current_node_daughter_selector = 1'b1;
graph1_selector = 2'b01;
graph2_selector = 2'b00;
register_pc_ip = 13'b0000000000000;
cntrl_w_add = {5'b00000, source_num};
cntrl_w_val = 128'h00000000000000000000000000000000;
wram_add_selector = 2'b01;
control_write_mux = 1'b1;
bellman_count = bellman_count - 1;
if(bellman_count==1 || !value)
begin
//negedge_cycle=1;
finish =1;
count =1;
next_state=S21;
value=0;
end
else

 begin
	if(daugther_counter<=7)
	begin
	temp1=1;
	temp3=daugther_counter;
	end
	else if(daugther_counter>7)
	begin
	temp1=1;
	temp3=7;
	end
	d_count=1;
        value=0;//count iterations here
	next_state = S10;
 end
 
end

S21:            //s24    
begin
if(flag==0)          //output memory address =0 for first source and dest_node . For everything else it is retained(Current value).
begin
register_pc_ip = 13'b0000000000000;
output_selector3 = 2'b00;
end
else
output_selector3 = 2'b11;

/////

output_selector1 = 1'b1;
output_selector4 = 3'b010;                       /////check this
if (count==1)
output_selector2 = 2'b01;
else 
output_selector2 = 2'b10;


if(count==2)
begin
output_selector2 = 2'b01;
next_state=S22;     //27
end
else 
next_state = S23;        //25 


end
S22:         //27
begin
WE2 = 1'b1;             //writing into output memory
output_selector3 = 2'b01;                //increment address
output_selector4 = 3'b000;               //dest_node 
next_state = S23;
end
S23:             //25
begin
if (count == 1)
output_selector4=3'b010;                        //weight
else
output_selector4 = 3'b001;                //prev_node node
    
output_selector1 = 1'b0;                       //prev_node maintained 
next_state = S24;
end
S24:                  //26
begin
WE2=1;
output_selector1=1'b0;
if(count==1)
begin
output_selector4 = 3'b010;
output_selector2=2'b10;
end
else
begin
output_selector4=3'b001;
output_selector2=2'b10;
end
output_selector3 = 2'b11;
next_state = S25;
end
S25:                   //s25
begin
output_selector3 = 2'b01;
output_selector2 = 2'b10;
count = count + 1;
flag = flag + 1;
if (prev_node [7:0] == source_num && count>2)
next_state = S31;                 //18
else 
next_state = S21;                //24
end

S31:begin
if(status_of_input)
begin
controller_mux1 = 2'b01;
WE2=1'b1;
output_selector4=3'b011;
next_state=S26;
end
else
begin
WE2=1'b1;
output_selector4=3'b100;
next_state=S26;
end
end

//Stall:
//begin

S26:               //18
begin
if(status_of_input)
begin
finish = 0;
next_state =S1;               //20
output_selector3=2'b01;
end
else
begin

finish=1;
next_state=S26;  
     finish_simulation=1;
	 //18
end
end

S27:
begin
register_pc_ip = 13'b0000000000000;
output_selector3=2'b00;
WE2=1'b1;
next_state= S28; 
end
S28 :
begin
output_selector4=2'b101;
output_selector3=2'b10;
WE2=1'b1;
next_state = 28;
end

endcase
end

endmodule

