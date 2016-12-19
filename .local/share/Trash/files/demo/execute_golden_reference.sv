///////////////////////////////////E_control... should we add?

`timescale 1ns/1ps
class execute_golden;


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

/*--inputs---*/
   logic			clock, reset, enable_execute;
   logic [1:0] 			W_Control_in;													
   logic 			Mem_Control_in;													
   logic [5:0] 			E_Control;
   logic [15:0] 		IR;
   logic [15:0] 		npc; //npc_in?
   logic [15:0] 		VSR1, VSR2, Mem_Bypass_Val;
   logic			bypass_alu_1, bypass_alu_2, bypass_mem_1, bypass_mem_2; //bypass1 and bypass2 allow for the use of bypass values for 
   //either  VSR1 or VSR2 
	
 /*---outputs--*/
   logic [15:0] 		aluout, pcout; // pcout??
   logic [1:0] 		        W_Control_out;
   logic			Mem_Control_out;
   logic [2:0] 		        NZP;
   logic [15:0] 		IR_Exec;
   logic [2:0] 		        sr1, sr2, dr;
   logic [15:0] 		M_Data;
 //Intermediate variables
  logic[15:0] aluin1,aluin2;
  logic[3:0] opcode;
  logic mode;
  logic[15:0] pcin1,pcin2;













/*------------*/

//logic DR = IR[11:9];
        virtual LC3_io.TB Interface;
	virtual dut_Probe_ex Probe_ex;
        
        function new (	virtual LC3_io.TB Interface,virtual dut_Probe_ex Probe_ex);
        	this.Interface = Interface;
		this.Probe_ex = Probe_ex;
        endfunction



                           
task golden_reference();
/*
 logic IR[15:12] = IR[15:12];
 logic IR[5] = IR[5];
 logic IR[4:0] = IR[4:0];
logic IR[8:6] = IR[8:6];
  */      
//Econtrol == 6 bits -- choose right values and operation {alu_control, psel1,psel2,op2sel}
//W_control -- 2 bits-- (what to write to a reg file 1.op from ALU 2. op from PC rel op 3. op mem(loads) )  
fork  
	
    
	begin // 2nd thing in fork 
	forever // forever 2
	  begin  //forever 2 begin
            @(posedge Interface.clock);
		  check_execute_sync();
		  
              if(Interface.reset)
				  begin
					  W_Control_out = 0;
					  Mem_Control_out = 0;
					  aluout = 0;
					  pcout = 0;
					  dr = 0;
					  NZP = 0;
					  M_Data  = 0; 
					  IR_Exec =0;	
					sr1=0;
					sr2=0;
				  end


               else 
begin
			
			if(enable_execute==0)
			 NZP = 0;
			else if(enable_execute==1)    
			  begin
		  // all outputs except SR1 and SR2 
			  W_Control_out = W_Control_in;
			  Mem_Control_out = Mem_Control_in;
		          IR_Exec=IR;

				  /*-----------aluout----------*/
				//Calculate aluin1

 case({bypass_mem_1,bypass_alu_1})
      2'b01: aluin1 = aluout;
      2'b10: aluin1 = Mem_Bypass_Val;
      default: aluin1 = VSR1;
   endcase


/*
				    if(bypass_mem_1)
					aluin1 = Mem_Bypass_Val;
				    else if(bypass_alu_1)
					aluin1 = aluout;
				    else
					aluin1 = VSR1;
*/

				    //Calculate aluin2
case({bypass_mem_2,bypass_alu_2})
      2'b01: aluin2 = aluout;
      2'b10: aluin2 = Mem_Bypass_Val;
      default: begin
                  if(IR[5]==0)
                     aluin2 = VSR2;
                  else
                     aluin2 = {IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4:0]};
               end
   endcase				   



/*
 				if(bypass_mem_2)
					aluin2 = Mem_Bypass_Val;
				    else if(bypass_alu_2)
					aluin2 = aluout;
				    else if(IR[5])
					aluin2 =IR[4:0];
				    else
					aluin2 = VSR2;

*/
				   
				/*----------pcout------------*/    
				   case(E_Control[3:2])
				    3: pcin1 = 0;
				    2: pcin1 = {IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5:0]};
				    1: pcin1 = {IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[8:0]};
				    0: pcin1 = {IR[10],IR[10],IR[10],IR[10],IR[10],IR[10:0]};
				     endcase
				   
				    case(E_Control[1])
				    1: pcin2 = npc-1'b1;
				    0: pcin2 = aluin1;
				     endcase
					   

 				   
				    
				  if((IR[15:12] == AND) || (IR[15:12] == ADD) || (IR[15:12] == NOT ))
				begin
					 case(IR[15:12])

				    ADD: aluout = aluin1 + aluin2;
				    AND: aluout = aluin1 & aluin2;
				    NOT: aluout = ~aluin1;
				     
					endcase				
					pcout = aluout;
				end
				else
				begin
				pcout=pcin1+pcin2;
				aluout=pcout;
				end
		                 /*------dr-------*/
		if( IR[15:12]== LD || IR[15:12] == LDR || IR[15:12] == LDI || IR[15:12] == LEA || IR[15:12] == ADD || IR[15:12] == AND || IR[15:12] == NOT)
				    dr = IR[11:9];
				    else 
		                    dr = 0;        
				 /*-----IR_Exec-----*/
		                     IR_Exec = IR;
		                 /*-----NZP----*/
		                  if( IR[15:12] == BR) 
		                  NZP = IR[11:9];
				else if(IR[15:12] == JMP)
				NZP=3'b111;
		                  else 
		                  NZP = 0;
		                /*--------M_Data---------*/
		                  if(bypass_alu_2 == 1)
		                   M_Data = aluin2;  // bypass aluout
		                  else 
		                   M_Data  = VSR2; 
                        
	   end // if(enable execute)   
end         
	   end // forever
	  end // 2nd thing in fork

     begin // 1st thing in fork 
	forever // forever 1
	  begin 
            #0.001;
/*
                     if(Interface.reset)
				  begin
					  sr1 = 0;
					  sr2 = 0;
					  
				  end
  */                    
		      if(Interface.reset!=1)    
			  begin
		          //$display($time, " you are here %d,%d",sr2,IR[2:0]);
			  //SR1 and SR2 are creasted async as a fun of IR[15:12]
			 
			sr1=IR[8:6];
			    
		            if((IR[15:12] == 4'b0001) || (IR[15:12] == 4'b0101 ) || (IR[15:12]== 4'b1001 ))
				begin				
				//$display($time, " you are here %d,%d",sr2,IR[2:0]);				 
				sr2 = IR[2:0];
				end
			    else if (( IR[15:12] == ST ) || (IR[15:12] == STR) || ( IR[15:12] == STI ))
				sr2 = IR[11:9];
			    else sr2 = 0;
		   end // for if
	       end // forever 1
	     end // 1st thing in fork 
	begin
        forever@(posedge Interface.clock)
		begin
		  check_execute_async();
		 end
       end
join 
endtask

		task check_execute_sync();

		//$display("inside check_execute_sync");
		if(aluout!= Probe_ex.aluout)
		$display($time, "bug in execute aluout %b,%b,%b",IR,aluout,Probe_ex.aluout);
		//else
		//$display("aluout %b,%b",aluout,Probe_ex.aluout);
		if(pcout!=Probe_ex.pcout)
		$display($time, "bug in execute pcout %b,%b,%b",IR,pcout,Probe_ex.pcout);
		//else
		//$display("pcout %d,%d",pcout,Probe_ex.pcout);
		if(W_Control_out!=Probe_ex.W_Control_out)
		$display("bug in execute W_Control_out %b,%b,%b",IR,W_Control_out,Probe_ex.W_Control_out);
		//else
		//$display("w_control_out %d,%d",W_Control_out,Probe_ex.W_Control_out);
      		if(Mem_Control_out!=Probe_ex.Mem_Control_out)
		$display("bug in execute Mem_Control_out %b,%b,%b",IR,Mem_Control_out,Probe_ex.Mem_Control_out);
		//else
		//$display("Mem_control_out %d,%d",Mem_Control_out,Probe_ex.Mem_Control_out);
 		if(NZP!=Probe_ex.NZP)
		$display($time,"bug in execute Prob_ex.NZP %b,%b,%b",IR,NZP,Probe_ex.NZP);
		//else
		//$display("NZP %d,%d",NZP,Probe_ex.NZP);
		if(IR_Exec!=Probe_ex.IR_Exec)
		$display("bug in execute Probe_ex.IR_Exec %b,%b,%b",IR,IR_Exec,Probe_ex.IR_Exec);
		//else
		//$display("IRexec %d,%d",IR_Exec,Probe_ex.IR_Exec);
                if(dr!=Probe_ex.dr)
		$display($time, "bug in execute Probe_ex.dr %b,%b,%b",IR,dr,Probe_ex.dr);
		//else
		//$display("dr %d,%d",dr,Probe_ex.dr);
		if(M_Data!=Probe_ex.M_Data)
		$display("bug in execute Probe_ex.M_Data %b,%b,%b",IR,M_Data,Probe_ex.M_Data);
		//else
		//$display("Mdata%d,%d",M_Data,Probe_ex.M_Data);
		endtask
       
                task check_execute_async();

		//$display("inside check_execute_async");
		if(sr1!= Probe_ex.sr1)
		$display($time,"bug in execute Probe_ex.sr1 %b,%b,%b",IR,sr1,Probe_ex.sr1);
		//else
		//$display("sr1%d,%d",sr1,Probe_ex.sr1);
		if(sr2!= Probe_ex.sr2)
		$display($time,"bug in execute Probe_ex.sr2 %b,%b,%b",IR,sr2,Probe_ex.sr2);
		//else
		//$display("sr2 %d,%d",sr2,Probe_ex.sr2);
                endtask                

endclass

 
 