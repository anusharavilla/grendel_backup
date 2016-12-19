`timescale 1ns/1ps
`include "project.if.sv"



class writeback_golden;

	///inputs///	

  	logic 	        clock, reset, enable_writeback;
  	logic 	[15:0] 	aluout, memout, pcout, npc;
  	logic 	[1:0] 	W_Control;
  	logic 	[2:0] 	sr1, sr2, dr;     	// source and destination register addresses
  	
	///outputs///

  	logic	[2:0]	psr;
  	logic 	[15:0] 	d1, d2;				// two read port output
	
	///regfile///
	
	logic [15:0]    RegFile[0:7];

/////Temporary/////

logic [15:0] DR_in;
       
	virtual LC3_io.TB Interface;
	virtual dut_Probe_writeback Probe_writeback;

	function new (virtual LC3_io.TB Interface, virtual dut_Probe_writeback Probe_writeback);
	this.Interface = Interface;
	this.Probe_writeback = Probe_writeback;
	endfunction

	task golden_reference();
//$display($time,"%d,%d",W_Control,Probe_writeback.W_Control);	
	fork 
			begin
			  
			     
			    forever@(posedge Interface.clock)
			      begin
				      fork
				      check_sync();
				      begin
				      if(Interface.reset)
				      psr=3'b000;
				      end
				      begin
                                    //#0.0009
				      if(enable_writeback && !Interface.reset)
				      begin
                                      
				      RegFile[dr]=DR_in;
				    //fileObj.file[dr]=valueToWrite;
				      if(DR_in[15])
				      psr=3'b100;
				      else if(DR_in==0)
				      psr= 3'b010;
				      else 
			 	      psr=3'b001;
				      end
				      end
                                      join
				      
			      end
		        end
			begin
			     forever
			     begin
			     //@(sr1,sr2,W_Control,aluout,pcout,memout)
                             #0.002;
			     if(!Interface.reset)
			     begin
				
			     case(W_Control)              //
			     2'b00: DR_in = aluout;
			     2'b01: DR_in = memout;
		             2'b10: DR_in = pcout;
			     default: DR_in = aluout; //0 can  be
			     endcase
			     d1=RegFile[sr1];
			    d2=RegFile[sr2];
                            //d1= fileObj.file[sr1];
                            //d2= fileObj.file[sr2]; 
			     end
			     end
			end
		begin     
		     forever@(posedge Interface.clock)
		     begin
		     check_async();
		     end	
		end    
		join
	      endtask
	   task check_sync();
	   if(psr!=Probe_writeback.psr)
	   $display($time,"error in WB psr %b,%b",psr,Probe_writeback.psr);
	    endtask
	   
	   task check_async();

	   //$display($time,"d2%d",d2);
//$display($time,"reg %d",RegFile[sr2]);
	   if(d1!=Probe_writeback.d1)
	   begin
	   $display($time,"error in WB d1 %b,%b",d1,Probe_writeback.d1);
	  //$display($time,"probe d1 %d",Probe_writeback.d1);
	   end  
	  if(d2!=Probe_writeback.d2)
begin
	   $display($time,"error in WB d2 %b,%b",d2,Probe_writeback.d2);
//$display($time,"reg %d",RegFile[sr2]);
end
//$display("sr2,%d %d",sr2,Probe_writeback.sr2);
	    //if(d2!=Probe_writeback.d2)
	   //$display($time,"WC, %d,%d",W_Control,Probe_writeback.W_Control);
	   //$display($time,"sr1 %d,%d",sr1,Probe_writeback.sr1);	
	   //$display($time,"sr2 %d,%d",sr2,Probe_writeback.sr2);
	   //$display($time,"enable_WB %d,%d",enable_writeback,Probe_writeback.enable_writeback);
	   
            endtask
           
     
   endclass
    
