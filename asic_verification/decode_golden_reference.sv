`timescale 1ns/1ps
class decode_golden;
   logic 			clock, reset, enable_decode;
   logic [15:0] 		dout;
   //logic 	[2:0] 	psr;
   logic [15:0] 		npc_in;
  // logic [1:0] 		W_Control; 
   logic 	 		Mem_Control;
   logic [5:0] 		E_Control;
   logic [15:0] 		IR;
   logic [15:0] 		npc_out;
   //logic 			F_Control;
   logic [1:0] 			W_Control; 
   logic 				M_Control; 
   logic [1:0] 			inst_type;
   logic 				pc_store;
   logic [1:0] 			mem_access_mode;
   logic 				load;
   logic [1:0] 			pcselect1, alu_control;
   logic 				pcselect2, op2select;
   //reg 			br_taken;

   

   
   logic [3:0] 			opcode=dout[15:12];
   
   virtual LC3_io.TB Interface;
	virtual dut_Probe_decode Probe_decode;
function new (	virtual LC3_io.TB Interface,virtual dut_Probe_decode Probe_decode);
this.Interface = Interface;
		this.Probe_decode = Probe_decode;
endfunction


task golden_reference();
forever@(Interface.reset,enable_decode,opcode,dout,npc_in)
begin
if(Interface.reset==1)
begin
Mem_Control=0;
W_Control=0;
E_Control=0;
IR=0;
npc_out=0;
end

if(enable_decode==1)
begin


case (opcode)

4'b0010 : W_Control =2'b01;
4'b0110 : W_Control =2'b01;
4'b1010 : W_Control =2'b01;
4'b1110 : W_Control =2'b10;
default :W_Control =2'b0;
endcase



//alu_control
if(opcode == 4'b0001 )
alu_control = 0;
else if (opcode== 4'b0101)
     alu_control = 1;
	 else if (opcode ==4'b1001)
     alu_control= 2'b10;
	 else
	 alu_control =2'bxx;

	 
//pcselect1
if(opcode == 4'b0000)
pcselect1= 2'b1;
else if (opcode == 4'b1100)
pcselect1 = 2'b11;
else if(opcode== 4'b0010)
pcselect1=1;
else if (opcode == 4'b0110)
pcselect1=2'b10;
else if(opcode ==4'b1010)
pcselect1=1;
else if(opcode== 4'b1110)
pcselect1=1;
else if (opcode==4'b0011)
pcselect1=1;
else if(opcode==4'b0111)
pcselect1=2'b10;
else if(opcode==4'b1011)
pcselect1=1;
else
pcselect1=2'bxx;

//pcselect2
if(opcode == 4'b0000)
pcselect2= 1;
else if (opcode == 4'b1100)
pcselect2 = 0;
else if(opcode== 4'b0010)
pcselect2=1;
else if (opcode == 4'b0110)
pcselect2=0;
else if(opcode ==4'b1010)
pcselect2=1;
else if(opcode== 4'b1110)
pcselect2=1;
else if (opcode==4'b0011)
pcselect2=1;
else if(opcode==4'b0111)
pcselect2=0;
else if(opcode==4'b1011)
pcselect2=1;
else
pcselect2=1'bx;

//op2select
if(opcode == 4'b0001 && dout[5]==0 )
op2select = 1;
else if(opcode == 4'b0001 && dout[5]==1 )
op2select = 0;
else if (opcode== 4'b0101 && dout[5]==0)
 op2select = 1;
else if (opcode== 4'b0101 && dout[5]==1)
 op2select = 0;
else
op2select =1'bx;



if(opcode==4'b0010||opcode==4'b0110||opcode==4'b0011||opcode==4'b0111)
Mem_Control=0;
else if(opcode==4'b1010|| opcode==4'b1011)
Mem_Control=1;



IR=dout;
npc_out=npc_in;

E_Control = {alu_control,pcselect1,pcselect2,op2select};
end
end

forever@(posedge Interface.clock);
check_decode();

endtask

task check_decode();
@(posedge Interface.clock);
begin
if(Mem_Control!= Probe_decode.Mem_Control)
$display("bug in decode");
else
$display("%d,%d",Mem_Control,Probe_decode.Mem_Control);
if(W_Control!=Probe_decode.W_Control)
$display("bug in decode");
else
$display("%d,%d",W_Control,Probe_decode.W_Control);
if(E_Control!=Probe_decode.E_Control)
$display("bug in decode");
else
$display("%d,%d",E_Control,Probe_decode.E_Control);
if(IR!=Probe_decode.IR)
$display("bug in decode");
if(npc_out!=Probe_decode.npc_out)
$display("bug in decode");
end
endtask

endclass
