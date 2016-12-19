`timescale 1ns/1ps

class cfg;

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
	  // rand bit [2:0] PSR;
	 rand bit [15:0] Instr_dout;
	  
	  
	  ////bdna
	  rand bit imm_src_mode;
	  bit [2:0] NZP;
	  
	  
	  rand bit [15:0] Data_dout;
	  /*
	  bit [15:0] IR;
	  bit [2:0] psr;
	  bit [15:0] IR_execution;
	  bit [15:0] Instr_dout;
	  bit [15:0] previous_IR;
	  bit [15:0] previous_instr_dout;
	  */
	  
	  int count = 6;
	  	  
	  constraint instruction
	  {
	     if( count >0)
		 opcode inside { 4'b0001, 4'b0101, 4'b1001};
		 else 
		 opcode inside {4'b0001, 4'b0101, 4'b1001,4'b0010, 4'b0110, 4'b1010,4'b1110,4'b0011, 4'b0111,4'b1011, 4'b0000, 4'b1100};
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
	  
	  4'b0001: begin 
	             case(imm_src_mode)
		           1'b0: Instr_dout = {opcode,destination_register,source_register1,3'b0,source_register2};
				   1'b1: Instr_dout = {opcode,destination_register,source_register1,1'b1,imm5};
              	 endcase
				 end
      4'b0101: begin
	             case(imm_src_mode)
		           1'b0: Instr_dout = {opcode,destination_register,source_register1,3'b0,source_register2};
				   1'b1: Instr_dout = {opcode,destination_register,source_register1,1'b1,imm5};
              	 endcase
               end   	  
	  4'b1001: Instr_dout = {opcode,destination_register,source_register1,6'b1};
	  4'b0010: Instr_dout = {opcode,destination_register,PCoffset9};
	  4'b0110: Instr_dout = {opcode,destination_register,BaseR,PCoffset6};
	  4'b1010: Instr_dout = {opcode,destination_register,PCoffset9};
	  4'b1110: Instr_dout = {opcode,destination_register,PCoffset9};
	  4'b0011: Instr_dout = {opcode,source_register1,PCoffset9};
	  4'b0111: Instr_dout = {opcode,destination_register,BaseR,PCoffset6};
	  4'b1011: Instr_dout = {opcode,source_register1,PCoffset9};
	  4'b0000: Instr_dout = {opcode,nzp,PCoffset9};
	  4'b1100: Instr_dout = {opcode,3'b1,BaseR,6'b0};
	  endcase
	  
	  if((opcode != 4'b0001) && (opcode!=4'b1001) && (opcode!=4'b0101)) // added flag==0
        begin
		count = 6;
		end		
      else 
	      begin
          count --; 
          end		  
	  
	  NZP = nzp;
	  
	  //psr = PSR;
	  //IR = previous_instr_dout;
	  //IR_execution = previous_IR;
	  
	  //
	 //
	 endfunction
	 
endclass
	 