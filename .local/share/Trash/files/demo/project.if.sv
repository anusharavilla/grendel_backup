`timescale 1ns/1ps
interface LC3_io(input bit clock);
  	
	logic reset, instrmem_rd, complete_instr, complete_data, Data_rd; 
	logic [15:0] pc, Instr_dout, Data_addr,  Data_dout, Data_din;
  	

  	clocking cb @(posedge clock);
 	default input #1 output #0;

		// instruction memory side
		input	pc; 
   		input	instrmem_rd;  
   		output  Instr_dout;

		// data memory side
		input Data_din;
		input Data_rd;
		input Data_addr;		
		output Data_dout;
		
		//output reset;
		
  	endclocking

  	modport TB(clocking cb, output complete_data, output complete_instr, input clock, output reset);   //modify to include reset
endinterface


interface dut_Probe_if(	
                                        // fetch block interface signals
										input   logic                           reset,
										input   logic                           clock,
                                        input   logic                           fetch_enable_updatePC,
                                        input   logic                           fetch_enable_fetch,
                                        input   logic                           fetch_br_taken,
                                        input   logic           [15:0]          fetch_taddr,
                                        input   logic                           fetch_instrmem_rd,
                                        input   logic           [15:0]          fetch_pc,
                                        input   logic           [15:0]          fetch_npc_out
                                        );
endinterface

interface dut_Probe_decode(
								
										input 	logic 							clock, 
										input 	logic 							reset, 
										input 	logic							enable_decode,
										input 	logic			[15:0] 			dout,
   //input 	[2:0] 	psr;
										input 	logic			[15:0] 			npc_in,
										input 	logic			[1:0] 			W_Control, 
										input 	logic 							Mem_Control,
										input 	logic			[5:0] 			E_Control,
										input 	logic			[15:0] 			IR,
										input 	logic			[15:0] 			npc_out

                                       );
endinterface
									   

interface dut_Probe_controller(
									   input   logic	           	    clock,
									   input   logic                    reset,	
									   input   logic			        complete_data, complete_instr,
									   input   logic         [15:0] 	IR, IR_Exec,
									   input   logic         [2:0]      psr, NZP,
									   input   logic         [15:0] 	Instr_dout,
									   input   logic		        	bypass_alu_1, bypass_alu_2, bypass_mem_1, bypass_mem_2,
									   input   logic			        enable_fetch, enable_decode, enable_execute, enable_writeback, enable_updatePC,
									   input   logic         [1:0]   	mem_state,
									   input   logic			        br_taken
									   );
endinterface


interface dut_Probe_ex(
									   input	logic						clock, reset, enable_execute,
									   input 	logic			[1:0] 		W_Control_in,													
									   input 	logic						Mem_Control_in,													
									   input 	logic			[5:0] 		E_Control,
									   input 	logic			[15:0]	 	IR,
									   input 	logic			[15:0] 		npc,
									   input 	logic			[15:0] 		VSR1, VSR2, Mem_Bypass_Val,
									   input	logic						bypass_alu_1, bypass_alu_2, bypass_mem_1, bypass_mem_2, //bypass1 and bypass2 allow for the use of bypass values for either VSR1 or VSR2 
									   input    logic 			[15:0]	 	aluout, pcout,
									   input 	logic			[1:0] 		W_Control_out,
									   input								Mem_Control_out,
									   input 	logic			[2:0] 		NZP,
									   input 	logic			[15:0]	 	IR_Exec,
									   input 	logic			[2:0] 		sr1, sr2, dr,
									   input 	logic			[15:0]	 	M_Data			
                                       );
endinterface
			


interface dut_Probe_writeback(

									   input 	logic			clock, reset, enable_writeback,
  									   input 	logic 	 [15:0] 	aluout, memout, pcout, npc,
  									   input 	logic    [1:0] 		W_Control,
  	
  									   input 	logic	 [2:0] 		sr1, sr2, dr,   
  	
  									   input	logic	 [2:0]		psr,
  									   input 	logic    [15:0] 	d1, d2
                             );
endinterface        
	

interface dut_Probe_mem(
 			

									   input 	logic	[1:0] 		mem_state,
									   input 	logic			M_Control,
									   input 	logic	[15:0] 	 	M_Data,
									   input 	logic	[15:0] 		M_Addr,
									   input 	logic	[15:0] 		Data_dout,

									   input 	logic	[15:0] 		Data_addr,
									   input        logic	[15:0] 		Data_din,
									   input 	logic			Data_rd,
									   input 	logic   [15:0]	        memout

			    );
endinterface	







								
                                                                            						   
