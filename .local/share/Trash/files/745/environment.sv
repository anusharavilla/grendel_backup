`timescale 1ns/1ps
`include "fetch_golden.sv"
`include "decode_golden_reference.sv"
`include "execute_golden_reference.sv"
`include "cfg.sv"
`include "project.if.sv"
`include "control_golden_reference.sv"
`include "writeback_golden_reference.sv"
`include "mem_golden_reference.sv"

class environment;

	fetch_golden fetch_object;
	decode_golden decode_object;
	execute_golden execute_object;
	control_golden control_object;
	writeback_golden writeback_object;
	mem_golden mem_object;
	cfg cfg_object;
      
        
        
	// interfaces

	virtual LC3_io interfaces;
	virtual dut_Probe_if Probe_if;
	virtual dut_Probe_controller Probe_controller;
	virtual dut_Probe_ex Probe_ex;
	virtual dut_Probe_decode Probe_decode;
        virtual  dut_Probe_writeback Probe_writeback;	
	virtual  dut_Probe_mem Probe_mem;

		function new (virtual LC3_io interfaces, virtual dut_Probe_if Probe_if,virtual dut_Probe_ex Probe_ex, virtual dut_Probe_controller       Probe_controller, virtual dut_Probe_decode Probe_decode,virtual dut_Probe_writeback Probe_writeback, virtual dut_Probe_mem Probe_mem);
			this.interfaces = interfaces;
			this.Probe_if = Probe_if;
			this.Probe_controller = Probe_controller;
			this.Probe_ex = Probe_ex;
			this.Probe_decode=Probe_decode;
			this.Probe_writeback=Probe_writeback;
			this.Probe_mem=Probe_mem;
			

		        
		endfunction

		function void create();
			//$display("adi_create");
			fetch_object = new(interfaces, Probe_if);
			decode_object = new(interfaces, Probe_decode);
			execute_object = new(interfaces, Probe_ex);
		        control_object = new(interfaces, Probe_controller); // added for control
			writeback_object = new(interfaces, Probe_writeback);	
			mem_object=new(interfaces,Probe_mem);	        
			cfg_object = new();
                        //ALU_object = new(execute_object,control_object);
			
		  endfunction

		task run();
			fork
				//$display("adi_run");
				fetch_object.golden_reference();
				decode_object.golden_reference();
		                execute_object.golden_reference();
		                control_object.golden_reference();
				writeback_object.golden_reference();
				mem_object.golden_reference();
			join
		endtask

	// add enables later

		task cfg_randomizing();
			cfg_object.randomize();
			cfg_object.randomized();
		endtask
	// enable asynchronous data for memeory

		task dut_gr_async();
			//$display("inputs driven?");
			fetch_object.enable_fetch = Probe_if.fetch_enable_fetch;
			fetch_object.enable_updatePC = Probe_if.fetch_enable_updatePC;
			decode_object.enable_decode=Probe_decode.enable_decode;
			decode_object.dout=Probe_decode.dout;
			decode_object.npc_in=Probe_decode.npc_in;
			//execute_object.enable_execute = Probe_ex.enable_execute;		        
			execute_object.VSR1 = Probe_ex.VSR1;
		        execute_object.VSR2 = Probe_ex.VSR2;
		        execute_object.Mem_Bypass_Val = Probe_ex.Mem_Bypass_Val;
		        control_object.NZP = Probe_controller.NZP;
			control_object.psr = Probe_controller.psr;
			
			writeback_object.sr1 = Probe_writeback.sr1;
			writeback_object.sr2 = Probe_writeback.sr2;
			writeback_object.memout = Probe_writeback.memout;
			mem_object.mem_state=Probe_mem.mem_state;
			mem_object.M_Control=Probe_mem.M_Control;
			mem_object.M_Addr=Probe_mem.M_Addr;
			mem_object.M_Data=Probe_mem.M_Data;
		        
		   	//$display("%d,%d", fetch_object.enable_updatePC, Probe_if.fetch_enable_updatePC);
		endtask

                task async1();
		mem_object.Data_dout=Probe_mem.Data_dout;
		endtask
	
		task outputs();
			//$display("outputs called");
			fetch_object.br_taken = Probe_if.fetch_br_taken;
		    	fetch_object.taddr = Probe_if.fetch_taddr;
			//decode_object.Mem_Control=Probe_decode.Mem_Control;
			//decode_object.W_Control=Probe_decode.W_Control;
			//decode_object.E_Control=Probe_decode.E_Control;
			//decode_object.IR=Probe_decode.IR;
			//decode_object.npc_out=Probe_decode.npc_out;
		        execute_object.W_Control_in = Probe_ex.W_Control_in;
			execute_object.Mem_Control_in = Probe_ex.Mem_Control_in;
			execute_object.E_Control = Probe_ex.E_Control;
			execute_object.IR = Probe_ex.IR;
			execute_object.npc = Probe_ex.npc;
			execute_object.bypass_alu_1 = Probe_ex.bypass_alu_1;
			execute_object.bypass_alu_2 = Probe_ex.bypass_alu_2;
			execute_object.bypass_mem_1 = Probe_ex.bypass_mem_1;
			execute_object.bypass_mem_2 = Probe_ex.bypass_mem_2;
			

		       /*------sending enable signals---------*/
			
		        execute_object.enable_execute = Probe_ex.enable_execute;
		        control_object.IR = Probe_controller.IR;
			control_object.IR_Exec = Probe_controller.IR_Exec;
			control_object.Instr_dout = Probe_controller.Instr_dout;
			control_object.complete_data = Probe_controller.complete_data;
			control_object.complete_instr = Probe_controller.complete_instr;
			//$display("checking actual results");
			//$display("%d,%d", fetch_object.taddr, Probe_if.fetch_taddr);
			
		        writeback_object.npc = Probe_writeback.npc;		
			writeback_object.pcout = Probe_writeback.pcout;
			writeback_object.aluout = Probe_writeback.aluout;
			writeback_object.dr = Probe_writeback.dr;
			writeback_object.W_Control = Probe_writeback.W_Control;
                        writeback_object.enable_writeback=Probe_writeback.enable_writeback;

         endtask

endclass




 









   



	