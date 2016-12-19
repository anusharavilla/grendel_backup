`timescale 1ns/1ps
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
	
	    fork :  flaglabel1
	        begin //123
				 forever@ (posedge Interface.clock);
						begin
						check_fetch();
						end
			forever@(Interface.reset,enable_updatePC,br_taken)
	            begin		  
				//checker();
				// task checker()
   
   //endtask
				 //// checking
				 $display("adi");
				        case(Interface.reset)
						     1'b0:
                                begin
									case(enable_updatePC)
									
											1'b0: begin end//enable_updatePC_out=pc;// no need
											1'b1: 
												 begin
													 case(br_taken)
													  
																1'b0: 
																    begin
																        pc=npc_out;
																		npc_out = pc+1;
																	end
																1'b1: 
																     begin 
																	    pc=taddr;
																		npc_out=pc+1;
																	end
													  endcase
												  end
									endcase
							    end

					   
				             1'b1:
     						   begin
							       pc = 16'h3000;
								   npc_out = pc+1;
								   
								end
								
				       endcase
		
			    end
			end // 123
	
            begin	
					forever@(enable_fetch)
					begin  
					#0.001; //added number			
							if(enable_fetch)
							instrmem_rd=1'b1;
							else
							instrmem_rd=1'bz;

						
					end
			end


            begin
			         

            end			
			
			
			
		 join
	
		 
	endtask

   task check_fetch();
    @(posedge Interface.clock);
    if(instrmem_rd != Probe_if.fetch_instrmem_rd)
	begin
   $display("bug in fetch dut:instrmem_rd");
   $display("%d,%d",instrmem_rd,Probe_if.fetch_instrmem_rd);
    end
	
    if(pc!= Probe_if.fetch_pc)
     begin
	 $display("bug in fetch dut:pc");
	 $display("%d,%d",pc,Probe_if.fetch_pc);
	 end
	 if(npc_out!= Probe_if.fetch_npc_out)
	 begin
     $display ("bug in fetch dut:npc_out");	
	 $display("%d,%d",npc_out,Probe_if.fetch_npc_out);
	 end
	    
	else
	$display("adi");
	
	
	endtask

   

   endclass
	
