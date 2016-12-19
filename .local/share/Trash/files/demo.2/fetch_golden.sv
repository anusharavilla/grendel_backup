`timescale 1ns/1ps
`include "project.if.sv"
class fetch_golden;
	
	/*--inputs---*/
	logic 			br_taken, enable_fetch, enable_updatePC;
  	logic 	[15:0] 	taddr;
  	/*---outputs--*/
  	logic 	[15:0] 	pc, npc_out;   // current and next PC
  	logic 			instrmem_rd;
	
	virtual LC3_io.TB Interface;
	virtual dut_Probe_if Probe_if;
function new (	virtual LC3_io.TB Interface,virtual dut_Probe_if Probe_if);
this.Interface = Interface;
		this.Probe_if = Probe_if;
endfunction


task golden_reference();

    fork //123
       begin
          forever
             begin 
                @(posedge Interface.clock);
		check_fetch_pc();
         // `pc_chk
          //`npc_chk
                if(Interface.reset)
                   begin
                      pc = 16'h3000;
                      npc_out = pc + 1;
                instrmem_rd = 1'b1;
                   end
                else
                   begin
                      if(enable_updatePC)
                         begin
                            if(br_taken)
          begin
                               pc = taddr;
          end
                            else
              begin
                               pc = npc_out;
          end
          npc_out = pc + 1;
                         end
                   end
             end
       end  // 123
       begin
          forever
             begin
      #0.001;
            case(enable_fetch)
                   1'b0 : instrmem_rd = 1'bz;
                   1'b1 : instrmem_rd = 1'b1;
                  // default : instrmem_rd = 1'bz;
            endcase
             end
       end
       begin
    forever@(posedge Interface.clock) // can remove this check 
    begin
      check_fetch_instrmem_rd();    //For asynchronous signal instrmem_rd
    end
       end
       
    join
  endtask

   task check_fetch_instrmem_rd();
    @(posedge Interface.clock);
    if(instrmem_rd != Probe_if.fetch_instrmem_rd)
	begin
   $display($time,"bug in fetch dut:instrmem_rd %b,%b",instrmem_rd,Probe_if.fetch_instrmem_rd);
   //$display("%d,%d",instrmem_rd,Probe_if.fetch_instrmem_rd);
    end
    //else
//$display("%d,%d",instrmem_rd,Probe_if.fetch_instrmem_rd);
	endtask


task check_fetch_pc();
    if(pc!= Probe_if.fetch_pc)
     begin
	 $display("bug in fetch dut:pc %b,%b",pc,Probe_if.fetch_pc);
	 //$display("%d,%d",pc,Probe_if.fetch_pc);
	 end
//	    else
//$display("%d,%d",pc,Probe_if.fetch_pc);
	 if(npc_out!= Probe_if.fetch_npc_out)
	 begin
     $display ("bug in fetch dut:npc_out %b,%b",npc_out,Probe_if.fetch_npc_out);	
	 //$display("%d,%d",npc_out,Probe_if.fetch_npc_out);
	 end
	    

	
//	   else
//$display("%d,%d",npc_out,Probe_if.fetch_npc_out);
	
	
	endtask

   

   endclass
	
