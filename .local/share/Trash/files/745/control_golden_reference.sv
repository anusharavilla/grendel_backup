`timescale 1ns/1ps
`include "project.if.sv"
class control_golden;

   logic			clock, reset;	
   logic			complete_data, complete_instr;
   logic [15:0] 		IR, IR_Exec;
   logic [2:0] 			psr, NZP;
   logic [15:0] 		Instr_dout;
   logic			bypass_alu_1, bypass_alu_2, bypass_mem_1, bypass_mem_2;
   logic			enable_fetch, enable_decode, enable_execute, enable_writeback, enable_updatePC;
   logic [1:0] 			mem_state;
   logic			br_taken;
   bit   [3:0]                  track_en; //state variable
  bit   [3:0]                  br_track_en; //state variable
  int branch=0;
parameter ADD = 4'b0001;
parameter AND = 4'b0101;
parameter NOT = 4'b1001;
parameter LD =  4'b0010;
parameter LDR = 4'b0110;
parameter LDI = 4'b1010;
parameter LEA = 4'b1110;
parameter ST =  4'b0011;
parameter STR = 4'b0111;
parameter STI = 4'b1011;
parameter BR =  4'b0000;
parameter JMP = 4'b1100;

bit [1:0] count1=2'b00;
bit [1:0] count2=2'b00;
virtual LC3_io.TB Interface;
virtual dut_Probe_controller Probe_controller;
function new (virtual LC3_io.TB Interface, virtual dut_Probe_controller Probe_controller);
this.Interface = Interface;
this.Probe_controller = Probe_controller;
endfunction

/*	task golden_reference();
	    
              fork
		    begin
                      forever@(IR,IR_Exec)
                       begin   
		      //@(posedge Interface.clock);
                      check_bypass_alu();
		      mem_state1();
		      br_taken_value();
		      enables();       
                     end
                    end
                    begin
                    forever@(posedge Interface.clock)
                    begin   
                    
                    check_controller();		
                    end
                    end
             join_none
           
	endtask    */
task golden_reference();
	    
             
		    begin
                      forever
                       begin   
		      @(posedge Interface.clock);
                    fork
                     begin
                     check_bypass_alu();
		     mem_state1();
		     br_taken_value();
		     enables();       
                    end
                    
                    begin   
                    
                    check_controller();		
                     end
                    join_none
                  end
                 end
	endtask 


task check_bypass_alu(); 
if(!Interface.reset)
begin
        bypass_mem_1=0;
	bypass_mem_2=0;
        bypass_alu_1=0;
        bypass_alu_2=0;
  end

 	if((IR[15:12] == ADD)||(IR[15:12] == AND)||(IR[15:12] == NOT))
	    begin
		    if( (IR_Exec[15:12] == ADD)||(IR_Exec[15:12] == AND)||(IR_Exec[15:12] == NOT)||(IR_Exec[15:12] == LEA))
			begin
                       	if( IR_Exec[11:9] == IR[8:6] ) count1 = 2'b10;  //bypass_alu_1=1;
			if( IR_Exec[11:9] == IR[2:0] && IR[5]!=1'b1) count2 = 2'b10;  //bypass_alu_2=1;
			end
		    if((IR_Exec[15:12] == LD)||(IR_Exec[15:12] == LDR)||(IR_Exec[15:12] == LDI))
			begin
			if( IR_Exec[11:9] == IR[8:6]) bypass_mem_1=1;
			if( IR_Exec[11:9] == IR[2:0] && IR[5]!=1'b1) bypass_mem_2=1;
			end
	     end

	if(IR[15:12] == LDR)
	    begin
		    if( (IR_Exec[15:12] == ADD)||(IR_Exec[15:12] == AND)||(IR_Exec[15:12] == NOT)||(IR_Exec[15:12] == LEA))
			begin
			if( IR_Exec[11:9] == IR[8:6]) count1 = 2'b10; //bypass_alu_1=1;
			end
	    end

	if(IR[15:12] == STR)
	    begin
		    if( (IR_Exec[15:12] == ADD)||(IR_Exec[15:12] == AND)||(IR_Exec[15:12] == NOT)||(IR_Exec[15:12] == LEA))
			begin
			if( IR_Exec[11:9] == IR[11:9]) count2 = 2'b10; //bypass_alu_2=1;
			if( IR_Exec[11:9] == IR[8:6]) count1 = 2'b10; //bypass_alu_1=1;
                       end
	    end
	if((IR[15:12] == ST)||(IR[15:12] == STI))
	    begin
		    if( (IR_Exec[15:12] == ADD)||(IR_Exec[15:12] == AND)||(IR_Exec[15:12] == NOT)||(IR_Exec[15:12] == LEA))
			begin
			if( IR_Exec[11:9] == IR[11:9]) count2 = 2'b10; //bypass_alu_2=1;
			end
	    end
	if(IR[15:12] == JMP)
	    begin
		    if( (IR_Exec[15:12] == ADD)||(IR_Exec[15:12] == AND)||(IR_Exec[15:12] == NOT)||(IR_Exec[15:12] == LEA))
			begin
			if( IR_Exec[11:9] == IR[8:6]) count1 = 2'b10; //bypass_alu_1=1;
                    end
	    end

  case(count1)
  2'b00: 
     begin
        bypass_alu_1=0;	
     end
   2'b10: 
     begin
        bypass_alu_1=1;
	count1=2'b00;
     end
 endcase

case(count2)
  2'b00: 
     begin
        bypass_alu_2=0;
	 end
   2'b10: 
     begin
        bypass_alu_2=1;	
        count2=2'b00;
     end
 endcase
 endtask

function void mem_state1();
   if(Interface.reset)
   mem_state = 2'b11;
	case(mem_state)
		2'b11: begin
			if(complete_data==1)
			begin
			if(IR_Exec[15:12]==LD||IR_Exec[15:12]==LDR)
			mem_state=0;
			if(IR_Exec[15:12]==ST||IR_Exec[15:12]==STR)
			mem_state=2;
			if(IR_Exec[15:12]==LDI||IR_Exec[15:12]==STI)
			mem_state=1;
			end
			end
		2'b10:
			begin
			if(complete_data==0)
			mem_state=2;
			if(complete_data==1)
			mem_state=3;
			end
		2'b01:
			begin
			if(complete_data==0)
			mem_state=1;
			if(complete_data==1 && (IR_Exec[15:12]==LD||IR_Exec[15:12]==LDR||IR_Exec[15:12]==LDI))
			mem_state=0;
			if(complete_data==1 && (IR_Exec[15:12]==ST||IR_Exec[15:12]==STR||IR_Exec[15:12]==STI))
			mem_state=2;
			end
		2'b00:
			begin
			if(complete_data==0)
			mem_state=0;
			if(complete_data==1)
			mem_state=3;
			end
	endcase
endfunction




function void br_taken_value();
        br_taken=| (NZP&psr);
endfunction


function void enables();

  

     if(Interface.reset)
        begin
	enable_updatePC=0;
	enable_fetch=1;
	enable_decode = 1'b0;
	enable_execute = 1'b0;
	enable_writeback = 1'b0;
	track_en=4'b0011;
	end
        else if(IR[15:12]==LD|| IR[15:12]==LDR)
	track_en = 4'b0001;                      //initialize
        else if(IR[15:12]==ST|| IR[15:12]==STR)
	track_en = 4'b0101;
	else if(IR[15:12]==LDI)
	track_en = 4'b0100;
	else if(IR[15:12]==STI)
	track_en = 4'b0111;
	 
       
       else 
       begin
                                
	case(track_en)      
	4'b0011:
	    begin
	    enable_updatePC=0;
	    enable_fetch=1;
	    enable_decode = 1'b0;
	    enable_execute = 1'b0;
	    enable_writeback = 1'b0;    
	    track_en=4'b1101;
	    end 

	4'b1101:
	    begin
	    enable_updatePC=1;
	    enable_fetch=1;
	    enable_decode = 1'b0;
	    enable_execute = 1'b0;
	    enable_writeback = 1'b0;    
	    track_en=4'b1110;
	    end

	4'b1110:
	    begin
	    enable_updatePC=1;
	    enable_fetch=1;
	    enable_decode = 1;
	    enable_execute = 0;
	    enable_writeback = 1'b0;    
	    track_en=4'b1111;
	    end

	4'b1111:
	    begin
	    enable_updatePC=1;
	    enable_fetch=1;
	    enable_decode = 1'b1;
	    enable_execute = 1'b1;
	    enable_writeback = 1'b0;    
	    track_en=4'b0000;
	    end


	4'b0000:
	    begin
	    enable_fetch = 1'b1;
	    enable_decode = 1'b1;
	    enable_execute = 1'b1;
	    enable_writeback = 1'b1;
	    enable_updatePC = 1'b1; // checking 	             			    
	    end

	4'b0001:
		   begin
		    enable_fetch = 1'b0;
		    enable_decode = 1'b0;
		    enable_execute = 1'b0;
		    enable_writeback = 1'b0;
		    enable_updatePC = 1'b0;
		    track_en = 4'b0000;
		    end  

	4'b0101:
		    begin
		    enable_fetch = 1'b0;
		    enable_decode = 1'b0;
		    enable_execute = 1'b0;
		    enable_writeback = 1'b0;
		    enable_updatePC = 1'b0;
		    track_en = 4'b0010;
		    end
	4'b0010:   
		    begin
		    enable_fetch = 1'b1;
		    enable_decode = 1'b1;
		    enable_execute = 1'b1;
		    enable_writeback = 1'b0;
		    enable_updatePC = 1'b1;
		    track_en = 4'b0000;
		    end
	4'b0100: 
		   begin
		    enable_fetch = 1'b0;
		    enable_decode = 1'b0;
		    enable_execute = 1'b0;
		    enable_writeback = 1'b0;
		    enable_updatePC = 1'b0;
		    track_en = 4'b0001;
		    end
       4'b0111:   begin
		    enable_fetch = 1'b0;
		    enable_decode = 1'b0;
		    enable_execute = 1'b0;
		    enable_writeback = 1'b0;
		    enable_updatePC = 1'b0;
		    track_en = 4'b0101;
		    end
	
         endcase
        end
	

	if((Instr_dout[15:12]==BR||Instr_dout[15:12]==JMP) && branch!=1)
	begin	
	branch=1;	
	br_track_en = 4'b0110;
	end

	
   if(branch)
   begin
   case(br_track_en)
   
    /* 	4'b0000:
	    begin
	    enable_fetch = 1'b1;
	    enable_decode = 1'b1;
	    enable_execute = 1'b1;
	    enable_writeback = 1'b1;
	    //enable_updatePC = 1'b1; // checking 	             			    
	    branch=0;
	    end  
   */
     4'b0110: 
		   begin
		    enable_fetch = 1'b0;
		    enable_decode = 1'b1;
		    enable_execute = 1'b1;
		    enable_writeback = 1'b1;
		    enable_updatePC = 1'b0;
		    br_track_en = 4'b0111;
		    branch=1;
		    end
		      
	4'b0111: 
		   begin
		    enable_fetch = 1'b0;
		    enable_decode = 1'b0;
		    enable_execute = 1'b1;
		    enable_writeback = 1'b1;
		    enable_updatePC = 1'b0;
		    br_track_en = 4'b1000;
                    branch=1;
		    end

		      
	4'b1000: 
		   begin
		    enable_fetch = 1'b0;
		    enable_decode = 1'b0;
		    enable_execute = 1'b0;
		    enable_writeback = 1'b0;
		    branch=1;
		    if(br_taken==1)
		    enable_updatePC = 1'b1;
		    else
		    enable_updatePC = 1'b0;
		    br_track_en = 4'b1001;
		    end
	4'b1001:
		   begin
		    enable_fetch = 1'b1;
		    enable_decode = 1'b0;
		    enable_execute = 1'b0;
		    enable_writeback = 1'b0;
		   // enable_updatePC = 1'b1; //
		    br_track_en = 4'b1010;
		    branch=1;
		    end
	4'b1010:
		    begin
		    enable_fetch = 1'b1;
		    enable_decode = 1'b1;
		    enable_execute = 1'b0;
		    enable_writeback = 1'b0;
		    //enable_updatePC = 1'b1;//
		    br_track_en = 4'b1011;
		    branch=1;
		    end
	4'b1011:
		    begin
		    enable_fetch = 1'b1;
		    enable_decode = 1'b1;
		    enable_execute = 1'b1;
		    enable_writeback = 1'b0;
		    //enable_updatePC = 1'b1;//
		    br_track_en = 4'b1100;
		    branch=1;
		    end
	4'b1100:
		    begin
		    enable_fetch = 1'b1;
		    enable_decode = 1'b1;
		    enable_execute = 1'b1;
		    enable_writeback = 1'b1;
		    //enable_updatePC = 1'b1;//
		    br_track_en = 4'b0000;
		    branch=0;
		    end
       endcase
       end
endfunction



task check_controller();

	if(bypass_alu_1!=Probe_controller.bypass_alu_1)
	$display($time,"error in controller bypass_alu_1 %b,%b,%b",IR_Exec,bypass_alu_1,Probe_controller.bypass_alu_1);
	//$display("%d,%d,%d,bypass_alu_1 ",bypass_alu_1,Probe_controller.bypass_alu_1,count1);
        if(bypass_alu_2!=Probe_controller.bypass_alu_2)
	$display($time,"error in controller bypass_alu_2 %b,%b,%b",IR_Exec,bypass_alu_2,Probe_controller.bypass_alu_2);
        //$display("%d,%d,bypass_alu_2",bypass_alu_2,Probe_controller.bypass_alu_2);
	if(bypass_mem_1!=Probe_controller.bypass_mem_1)
	$display($time,"error in controller bypass_mem_1 %b,%b",bypass_mem_1,Probe_controller.bypass_mem_1);
        //$display("%d,%d,bypass_mem_1",bypass_mem_1,Probe_controller.bypass_mem_1);
	if(bypass_mem_2!=Probe_controller.bypass_mem_2)
	$display($time,"error in controller bypass_mem_2 %b,%b,%b",IR_Exec,bypass_mem_2,Probe_controller.bypass_mem_2);
        //$display("%d,%d,bypass_mem_1",bypass_mem_2,Probe_controller.bypass_mem_2);
	if(enable_fetch!=Probe_controller.enable_fetch)
	$display($time,"error in controller enable fetch %b,%b",enable_fetch,Probe_controller.enable_fetch);
        //$display("%d,%d, enable fetch",enable_fetch,Probe_controller.enable_fetch);
	if(enable_decode!=Probe_controller.enable_decode)
	$display($time,"error in controller enable decode %b,%b,%b",IR_Exec,enable_decode,Probe_controller.enable_decode);
	//$display("%d,%d, enable decode",enable_decode,Probe_controller.enable_decode);
        if(enable_execute!=Probe_controller.enable_execute)
	$display($time,"error in controller enable execute %b,%b,%b",IR_Exec,enable_execute,Probe_controller.enable_execute);
	//$display("%d,%d",enable_execute,Probe_controller.enable_execute);
	if(enable_writeback!=Probe_controller.enable_writeback)
	$display($time,"error in controller enable writeback %b,%b,%b",IR_Exec,enable_writeback,Probe_controller.enable_writeback);
        //$display($time,"%d,%d enable witeback",enable_writeback,Probe_controller.enable_writeback);
	if(enable_updatePC!=Probe_controller.enable_updatePC)
	$display($time,"error in controller enable updatePC %b,%b,%b",IR_Exec,enable_updatePC,Probe_controller.enable_updatePC); 
	//$display("%d,%d,updatePC",enable_updatePC,Probe_controller.enable_updatePC);
        if(mem_state!=Probe_controller.mem_state)
	
	$display($time,"error in controller mem_state %b,%b,%b",IR_Exec,mem_state,Probe_controller.mem_state); 
	//$display("%d,%d,mem_state",mem_state,Probe_controller.mem_state);
   
endtask

endclass
