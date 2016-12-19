`timescale 1ns/1ps
`include "TopLevelLC3.v"
`include "project.if.sv"
`include "environment.sv"


/*
parameter ADD = 4'b0001;
parameter AND = 4'b0101;
parameter NOT = 4'b1001;
parameter LD = 4'b0010;
parameter LDR = 4'b0110;
parameter LDI = 4'b1010;
parameter LEA = 4'b1110;
parameter ST = 4'b0011;
parameter STR = 4'b0111;
parameter STI = 4'b1011;
parameter BR = 4'b0000;
parameter JMP = 4'b1100;
*/
int no_of_simulations =200000;

module testbench();

bit clock;
 environment env;
LC3_io Interface(clock);
always #10 clock = ~clock;


 ///coverage///


       `include "Coverage.sv"
       ALU_OPR_cg ALU_object;
       MEM_OPR_cg MEM_object;
       CTRL_OPR_cg CTRL_object;
       OPR_SEQ_cg OPR_object;
       




	
	LC3 dut(.clock(clock),
			.reset(Interface.reset),
			.pc(Interface.pc),
			.instrmem_rd(Interface.instrmem_rd),
			.Instr_dout(Interface.Instr_dout),
			.Data_addr(Interface.Data_addr),
			.complete_instr(Interface.complete_instr),
			.complete_data(Interface.complete_data),
			.Data_din(Interface.Data_din),
			.Data_dout(Interface.Data_dout),
			.Data_rd(Interface.Data_rd));
	
	LC3_io top_io(clock);
	
	 dut_Probe_if Probe_if(.clock(clock), .reset(Interface.reset),                                  
			    .fetch_enable_updatePC(dut.Fetch.enable_updatePC),
                            .fetch_enable_fetch(dut.Fetch.enable_fetch),
			    .fetch_pc(dut.Fetch.pc), 
			    .fetch_npc_out(dut.Fetch.npc_out),
			    .fetch_instrmem_rd(dut.Fetch.instrmem_rd),
			    .fetch_taddr(dut.Fetch.taddr),
			    .fetch_br_taken(dut.Fetch.br_taken));

	dut_Probe_decode Probe_decode(.clock(clock),   
                                       .reset(Interface.reset), 
		        		 .enable_decode(dut.Dec.enable_decode),
					 .dout(dut.Dec.dout),
					 .E_Control(dut.Dec.E_Control), 
					 .npc_in(dut.Dec.npc_in), //psr, 
					 .Mem_Control(dut.Dec.Mem_Control),
					 .W_Control(dut.Dec.W_Control), //F_Control, 
					 .IR(dut.Dec.IR),
					 .npc_out(dut.Dec.npc_out) ); 
				
		dut_Probe_ex Probe_ex(	.clock(clock),
					.reset(Interface.reset),                                 
					.E_Control(dut.Ex.E_Control), 
					.bypass_alu_1(dut.Ex.bypass_alu_1), 
					.bypass_alu_2(dut.Ex.bypass_alu_2), 
					.IR(dut.Ex.IR), 
					.npc(dut.Ex.npc), 
					.W_Control_in(dut.Ex.W_Control_in), 
					.Mem_Control_in(dut.Ex.Mem_Control_in), 
					.VSR1(dut.Ex.VSR1), 
					.VSR2(dut.Ex.VSR2), 
					.enable_execute(dut.Ex.enable_execute),
					.Mem_Bypass_Val(dut.Ex.Mem_Bypass_Val),
					.bypass_mem_1(dut.Ex.bypass_mem_1), 
					.bypass_mem_2(dut.Ex.bypass_mem_2),           
					.W_Control_out(dut.Ex.W_Control_out), 
					.Mem_Control_out(dut.Ex.Mem_Control_out),
					.NZP(dut.Ex.NZP),
					.IR_Exec(dut.Ex.IR_Exec),
					.aluout(dut.Ex.aluout), 
					.pcout(dut.Ex.pcout), 
					.sr1(dut.Ex.sr1), 
					.sr2(dut.Ex.sr2), 
					.dr(dut.Ex.dr), 
					.M_Data(dut.Ex.M_Data)
						);		
		
			
				dut_Probe_controller Prob_controller(
					.clock(clock),
					.reset(Interface.reset),                                  
					.IR(dut.Ctrl.IR), 
					.bypass_alu_1(dut.Ctrl.bypass_alu_1), 
					.bypass_alu_2(dut.Ctrl.bypass_alu_2), 
					.bypass_mem_1(dut.Ctrl.bypass_mem_1), 
					.bypass_mem_2(dut.Ctrl.bypass_mem_2), 
					.complete_data(dut.Ctrl.complete_data),
					.complete_instr(dut.Ctrl.complete_instr),
					.Instr_dout(dut.Ctrl.Instr_dout), 
					.NZP(dut.Ctrl.NZP), 
					.psr(dut.Ctrl.psr), 
					.IR_Exec(dut.Ctrl.IR_Exec),
					.enable_fetch(dut.Ctrl.enable_fetch), 
					.enable_decode(dut.Ctrl.enable_decode), 
					.enable_execute(dut.Ctrl.enable_execute), 
					.enable_writeback(dut.Ctrl.enable_writeback), 
					.enable_updatePC(dut.Ctrl.enable_updatePC), 
					.br_taken(dut.Ctrl.br_taken), 
					.mem_state(dut.Ctrl.mem_state)
					);	
				dut_Probe_writeback Probe_writeback(.clock(clock), 
								    .reset(Interface.reset), 
								    .enable_writeback(dut.WB.enable_writeback), 
								    .W_Control(dut.WB.W_Control), 
                                                                    .aluout(dut.WB.aluout), 
                                                                    .memout(dut.WB.memout), 
								    .pcout(dut.WB.pcout), 
								    .npc(dut.WB.npc), 
								    .sr1(dut.WB.sr1), 
								    .sr2(dut.WB.sr2), 
								    .dr(dut.WB.dr), 
								    .d1(dut.WB.d1), 
								    .d2(dut.WB.d2), 
								    .psr(dut.WB.psr)
								    ); 	
			dut_Probe_mem Probe_mem(	
						.mem_state(dut.MemAccess.mem_state), 
						.M_Control(dut.MemAccess.M_Control), 
						.M_Data(dut.MemAccess.M_Data), 
						.M_Addr(dut.MemAccess.M_Addr), 
						.memout(dut.MemAccess.memout), 
						.Data_addr(dut.MemAccess.Data_addr), 
						.Data_din(dut.MemAccess.Data_din), 
						.Data_dout(dut.MemAccess.Data_dout), 
						.Data_rd(dut.MemAccess.Data_rd)
				);



`include "Coverproperty.sv"

initial
begin
//Interface.Instr_dout = env.cfg_object.Instr_dout;
//Interface.Data_dout = env.cfg_object.Data_dout;
//Interface.complete_instr= 1'b1;
//Interface.complete_data= 1'b1;
	
	clock = 1'b0;		
	Interface.reset=1'b1;	
	env = new (Interface.TB,Probe_if,Probe_ex,Prob_controller,Probe_decode,Probe_writeback,Probe_mem);	
        		
	env.create();

        ALU_object= new();
        MEM_object= new();
        CTRL_object= new();
        OPR_object= new(); 
       
	// must be added 
  fork
  begin
  forever@  (Probe_if.fetch_enable_fetch,Probe_if.fetch_enable_updatePC,Probe_decode.enable_decode,Probe_decode.dout,Probe_decode.npc_in,Probe_ex.VSR1,Probe_ex.VSR2,Probe_ex.Mem_Bypass_Val,Probe_writeback.sr1,Probe_writeback.sr2,Probe_mem.M_Data,Probe_mem.M_Addr,Probe_mem.M_Control,Probe_mem.mem_state)
  env.dut_gr_async();
  end
begin
forever@(env.cfg_object.Data_dout)
env.async1();
end
  env.run();
  join_none

#20 Interface.reset=1'b0;

   for (int i=0;i<no_of_simulations;i++)
	begin
	@(posedge clock);
	if(env.fetch_object.instrmem_rd)
	begin
		env.cfg_randomizing();
		Interface.complete_instr = env.cfg_object.complete_instr;
		Interface.complete_data = env.cfg_object.complete_data;
		Interface.Instr_dout = env.cfg_object.Instr_dout;
		//$display("Instr_dout %b", env.cfg_object.Instr_dout);
		Interface.Data_dout = env.cfg_object.Data_dout;
		//$display("%d",i);
		end
		#0.1;
		env.outputs();
		
	        ALU_object.sample();
		MEM_object.sample();
                CTRL_object.sample();
                OPR_object.sample();
	end

$display("golden_reference is done"); 

$finish;
end
  
endmodule  
  
////////event triggered  
  
  

