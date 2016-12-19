`timescale 1ns/1ps
class cfg;

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



      // memory 11
      rand bit [3:0] opcode;
	  rand bit [2:0] destination_register;
	  rand bit [8:0] PCoffset9;
	  rand bit [5:0] PCoffset6;
	  rand bit [2:0] source_register1;
      rand bit [2:0] source_register2;
	  rand bit [2:0] BaseR;
	  
	 // control instructions
	  rand bit [2:0] nzp;
	   bit complete_instr=1'b1;
	   bit complete_data=1'b1;
	  
	  //ALU operations
	  rand bit [4:0] imm5;
	  ////////may or maynot be required
	 rand bit [2:0] PSR;
	 bit [15:0] Instr_dout;
	  
	  
	  ////bdna
	  rand bit imm_src_mode;
	  bit [2:0] NZP;
	  
	  
	  rand bit [15:0] Data_dout;
   constraint fordata { Data_dout dist { 16'b0101010101010101:=5, 16'b1010101010101010:=5, [16'b0000000000000000:16'b1111111111111111]:/90 }; }	  
	  bit [15:0] IR;
	  bit [2:0] psr;
	  bit [15:0] IR_execution;
	  //bit [15:0] Instr_dout;
	  bit [15:0] prev_IR;
	  bit [15:0] prev_Instr_dout;
	  
	  
	  int count = 6;
          int count1 = 29;
          bit [2:0] destn_reg = 3'b111;	  
	  constraint instruction
	  {
	     if( count >0 && count1 <0)
		 opcode inside { 4'b0001, 4'b0101, 4'b1001,4'b1110};
            if(count <=0 && count1 <0)
             opcode inside {4'b0001, 4'b0101, 4'b1001,4'b1110,4'b0010, 4'b0110, 4'b1010,4'b0011, 4'b0111,4'b1011, 4'b0000, 4'b1100};
              if(count1>=21 && count1<=29)
               opcode inside {4'b1111};
		if(count1<21 && count1 >=0)
                   opcode inside {4'b1000};
             
	}	
                      

		/* 
	 constraint complete_data_instr
      {
        complete_data =1;
        complete_instr =1;		
	  }	 */
	  
	  constraint nzp_value
	  {
        nzp inside { 3'b010, 3'b101, 3'b001, 3'b011, 3'b100, 3'b110, 3'b111 };	  
	  }
		 
          		 
	  function void randomized();
	  	  
	  case(opcode)
	  4'b1111: begin
                   Instr_dout = {4'b0101,destn_reg,destn_reg,1'b1,5'b00000};
                   count1--;
                   destn_reg=destn_reg-1'b1;
                   //$display($time,"opcode %b,%d,%d",opcode,count1,destn_reg);
                   end
	  4'b0001: begin 
	             case(imm_src_mode)
		           1'b0: Instr_dout = {opcode,destination_register,source_register1,3'b0,source_register2};
				   1'b1: Instr_dout = {opcode,destination_register,source_register1,1'b1,imm5};
              	                         endcase
		     //$display($time,"opcode %b,%d",opcode,count1);		 
                   end
           4'b0101: begin
	             case(imm_src_mode)
		           1'b0: Instr_dout = {opcode,destination_register,source_register1,3'b0,source_register2};
				   1'b1: Instr_dout = {opcode,destination_register,source_register1,1'b1,imm5};
              	 endcase
               end   	  
	  4'b1001: Instr_dout = {opcode,destination_register,source_register1,6'b111111};
	  4'b0010: Instr_dout = {opcode,destination_register,PCoffset9};
	  4'b0110: Instr_dout = {opcode,destination_register,BaseR,PCoffset6};
	  4'b1010: Instr_dout = {opcode,destination_register,PCoffset9};
	  4'b1110: Instr_dout = {opcode,destination_register,PCoffset9};
	  4'b0011: Instr_dout = {opcode,source_register1,PCoffset9};
	  4'b0111: Instr_dout = {opcode,source_register1,BaseR,PCoffset6};
	  4'b1011: Instr_dout = {opcode,source_register1,PCoffset9};
	  4'b0000: Instr_dout = {opcode,nzp,PCoffset9};
	  4'b1100: Instr_dout = {opcode,3'b000,BaseR,6'b0};

	  4'b1000:     begin
                       case(count1)
                       21: Instr_dout = {LD,12'h600};
                       20: Instr_dout = {AND,3'd0,3'd0,1'b1,5'd0};
                       19: Instr_dout = {AND,3'd1,3'd1,1'b1,5'd0};
                       18: Instr_dout = {NOT,12'h8ff};
                       17: Instr_dout = {NOT,12'h8ff};
                       16: Instr_dout = {ADD,3'd0,3'd0,1'b0,5'd3};
                       15: Instr_dout = {ADD,3'd1,3'd1,1'b0,5'd4};
                       14: Instr_dout = {ADD,3'd5,3'd0,1'b0,5'd1};
                       13: Instr_dout = {ADD,3'd6,3'd1,1'b0,5'd0};
                       12: Instr_dout = {AND,3'd0,3'd0,1'b0,5'd5};
                       11: Instr_dout = {AND,3'd1,3'd1,1'b0,5'd5};
                       10: Instr_dout = {AND,3'd0,3'd5,1'b0,5'd0};
                        9: Instr_dout = {AND,3'd1,3'd5,1'b0,5'd1}; 
                        8: Instr_dout = {NOT,12'h03f};
                        7: Instr_dout = {NOT,12'h03f};
                        6: Instr_dout = {ADD,3'd0,3'd0,1'b1,5'd0};
                        5: Instr_dout = {ADD,3'd1,3'd1,1'b1,5'd0};
                        4: Instr_dout = {ADD,3'd0,3'd0,1'b1,5'd0};
                        3: Instr_dout = {ADD,3'd1,3'd1,1'b1,5'd0};
                        2: Instr_dout = {AND,3'd0,3'd0,1'b1,5'd0};
                        1: Instr_dout = {AND,3'd1,3'd1,1'b1,5'd0};
                       endcase
                        
                       count1--;
                       end  
	  endcase
	  
	  if((opcode != 4'b0001) && (opcode!=4'b1001) && (opcode!=4'b0101)&& (opcode!=4'b1110)) // added flag==0
        begin
		count = 6;
		end		
      else 
	      begin




          count --; 
          end		  
	  
	/*  NZP = nzp;
	  
	  psr = PSR;
	  IR = prev_Instr_dout;
	  IR_execution = prev_IR;
           this.prev_Instr_dout = this.Instr_dout;
           this.prev_IR = this.IR;*/
	  
	  //
	 //
	 endfunction
	 
endclass
	 
