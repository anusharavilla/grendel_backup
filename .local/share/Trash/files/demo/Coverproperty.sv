
/*----------------------Interface.reset behavior of all the sync signals--------------*/

// Asserting---- FETCH signals------- //
 Probe_if_fetch_pc_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_if.fetch_pc==16'h3000);
  Probe_if_fetch_npc_out_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_if.fetch_npc_out==16'h3001);

// Asserting---- DECODE signals------- //
 
  Probe_decode_Mem_Control_rst: cover property ( @(posedge clock) Interface.reset |=> !Probe_decode.Mem_Control);
  Probe_decode_E_Control_rst: cover property ( @(posedge clock) Interface.reset |=> !Probe_decode.E_Control);
  Probe_decode_W_Control_rst: cover property ( @(posedge clock) Interface.reset |=> !Probe_decode.W_Control);
  Probe_decode_IR_rst: cover property ( @(posedge clock) Interface.reset |=> !Probe_decode.IR);
  Probe_decode_npc_out_rst: cover property ( @(posedge clock) Interface.reset |=> !Probe_decode.npc_out);

// Asserting---- EXECUTE signals------- //
  
  Probe_ex_aluout_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.aluout==0); // I am changing it here
  Probe_ex_pcout_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.pcout==0);
  Probe_ex_dr_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.dr==0);
  Probe_ex_IR_Exec_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.IR_Exec==0);
  Probe_ex_NZP_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.NZP==0);
  Probe_ex_M_Data_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.M_Data==0);
  Probe_ex_W_Control_out_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.W_Control_out==0);
  Probe_ex_Mem_Control_out_rst: cover property ( @(posedge clock) Interface.reset |=> Probe_ex.Mem_Control_out==0);


// Asserting---- WRITEBACK signals------- //
 
  Probe_writeback_psr_rst: cover property( @(posedge clock) Interface.reset |=> Probe_writeback.psr==0 );

// Asserting---- CONTROLLER signals------- //

  Prob_controller_mem_state_rst: cover property( @(posedge clock) Interface.reset |=> Prob_controller.mem_state==3 );
  Prob_controller_enable_fetch_rst: cover property( @(posedge clock) Interface.reset |=> Prob_controller.enable_fetch==1 );
  Prob_controller_enable_decode_rst: cover property( @(posedge clock) Interface.reset |=> Prob_controller.enable_decode==0);
  Prob_controller_enable_writeback_rst: cover property( @(posedge clock) Interface.reset |=> Prob_controller.enable_writeback==0);


/*-------------Covers condition of branch .. if N/Z/P is 1-----------------*/

// Asserting---- Br_taken jump signals------- //

      CTRL_br_taken_jmp_BRZ: cover property( @(posedge clock) Prob_controller.IR_Exec[15:12] == BR |-> if(Prob_controller.NZP == 3'b010 &      Prob_controller.psr==3'b010) Prob_controller.br_taken==1);

      CTRL_br_taken_jmp_BRNP: cover property( @(posedge clock) Prob_controller.IR_Exec[15:12] == BR |-> if(Prob_controller.NZP == 3'b101 & Prob_controller.psr!=3'b010) Prob_controller.br_taken==1);

               CTRL_br_taken_jmp_BRP: cover property( @(posedge clock) Prob_controller.IR_Exec[15:12] == BR |-> if(Prob_controller.NZP == 3'b001 & Prob_controller.psr==3'b001) Prob_controller.br_taken==1);

            CTRL_br_taken_jmp_BRZP: cover property( @(posedge clock) Prob_controller.IR_Exec[15:12] == BR |-> if(Prob_controller.NZP == 3'b011 & Prob_controller.psr!=3'b100) Prob_controller.br_taken==1);

    CTRL_br_taken_jmp_BRN: cover property( @(posedge clock) Prob_controller.IR_Exec[15:12] == BR |-> if(Prob_controller.NZP == 3'b100 & Prob_controller.psr==3'b100) Prob_controller.br_taken==1);

           CTRL_br_taken_jmp_BRNZ: cover property( @(posedge clock) Prob_controller.IR_Exec[15:12] == BR |-> if(Prob_controller.NZP == 3'b110 & Prob_controller.psr!=3'b001) Prob_controller.br_taken==1);
                                                                                                                                                  
   CTRL_br_taken_jmp_BR: cover property( @(posedge clock) Prob_controller.IR_Exec[15:12] == BR |-> if(Prob_controller.NZP == 3'b111) 
Prob_controller.br_taken==1);  



//*------------------Asserting----- enable fetch signals---------**/////  
    enable_fetch_LD: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LD )|=> Prob_controller.enable_fetch==0);
   enable_fetch_LDR: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDR )|=> Prob_controller.enable_fetch==0);
        enable_fetch_LDI: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDI )|=> Prob_controller.enable_fetch==0);
   enable_fetch_ST: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == ST )|=> Prob_controller.enable_fetch==0);
     enable_fetch_STR: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STR )|=> Prob_controller.enable_fetch==0);
 enable_fetch_STI: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STI )|=> Prob_controller.enable_fetch==0);
   enable_fetch_BR : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == BR )|-> Prob_controller.enable_fetch==0);
 enable_fetch_JMP : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == JMP )|-> Prob_controller.enable_fetch==0);
   enable_fetch :  cover property( @(posedge clock) ( Prob_controller.IR[15:12] ==ADD || Prob_controller.IR[15:12] ==AND || Prob_controller.IR[15:12] ==NOT || Prob_controller.IR[15:12] ==LEA ) |-> Prob_controller.enable_fetch==1);



//**----------------Assert enable decode signals------------------**//
  enable_decode_LD: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LD )|=> Prob_controller.enable_decode==0);
   enable_decode_LDR: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDR )|=> Prob_controller.enable_decode==0);
   enable_decode_LDI : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDI )|=> Prob_controller.enable_decode==0);
  enable_decode_ST: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == ST )|=> Prob_controller.enable_decode==0);
     enable_decode_STR : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STR )|=> Prob_controller.enable_decode==0);
        enable_decode_STI: cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STI )|=> Prob_controller.enable_decode==0);
     enable_decode_BR: cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == BR )|-> Prob_controller.enable_decode==1 |=>   Prob_controller.enable_decode==0);
    enable_decode_JMP: cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == JMP )|-> Prob_controller.enable_decode==1 |=>   Prob_controller.enable_decode==0);



//**---------------------Assert bypass alu------------------------*//
     bypass_alu_1_AA: cover property (	@(posedge clock) (Prob_controller.IR[15:12] ==ADD || Prob_controller.IR[15:12] ==AND || Prob_controller.IR[15:12] ==NOT) && (Prob_controller.IR_Exec[15:12] ==ADD || Prob_controller.IR_Exec[15:12] ==AND || Prob_controller.IR_Exec[15:12] ==NOT || Prob_controller.IR[15:12] == LEA) |-> if( Prob_controller.IR_Exec[11:9] == Prob_controller.IR[8:6]) Prob_controller.bypass_alu_1==1);

   bypass_alu_2_AA: cover property ( @(posedge clock) (Prob_controller.IR[15:12] ==ADD || Prob_controller.IR[15:12] ==AND || Prob_controller.IR[15:12] ==NOT) && (Prob_controller.IR_Exec[15:12] ==ADD || Prob_controller.IR_Exec[15:12] ==AND || Prob_controller.IR_Exec[15:12] ==NOT || Prob_controller.IR[15:12] == LEA)	|-> if( Prob_controller.IR_Exec[11:9] == Prob_controller.IR[2:0] && Prob_controller.IR[5]!=1) Prob_controller.bypass_alu_2==1);

bypass_alu_1_AS : cover property ( @(posedge clock) (Prob_controller.IR[15:12] == STR ) && (Prob_controller.IR_Exec[15:12] ==ADD || Prob_controller.IR_Exec[15:12] ==AND || Prob_controller.IR_Exec[15:12] ==NOT || Prob_controller.IR[15:12] == LEA) 
				|-> if( Prob_controller.IR_Exec[11:9] == Prob_controller.IR[8:6]) Prob_controller.bypass_alu_1==1);

    bypass_alu_2_AS : cover property (
				@(posedge clock)
					(Prob_controller.IR[15:12] == ST || Prob_controller.IR[15:12] == STI ||Prob_controller.IR[15:12] == STR ) && (Prob_controller.IR_Exec[15:12] ==ADD || Prob_controller.IR_Exec[15:12] ==AND || Prob_controller.IR_Exec[15:12] ==NOT || Prob_controller.IR[15:12] == LEA) 
				|-> if( Prob_controller.IR_Exec[11:9] == Prob_controller.IR[11:9]) Prob_controller.bypass_alu_2==1
);
bypass_alu_1_AL : cover property (
				@(posedge clock)
					(Prob_controller.IR[15:12] == LDR ) && (Prob_controller.IR_Exec[15:12] ==ADD || Prob_controller.IR_Exec[15:12] ==AND || Prob_controller.IR_Exec[15:12] ==NOT || Prob_controller.IR[15:12] == LEA) 
				|-> if( Prob_controller.IR_Exec[11:9] == Prob_controller.IR[8:6]) Prob_controller.bypass_alu_1==1
);


bypass_alu_1_AJ :  cover property (
				@(posedge clock)
					(Prob_controller.IR[15:12] == JMP ) && (Prob_controller.IR_Exec[15:12] ==ADD || Prob_controller.IR_Exec[15:12] ==AND || Prob_controller.IR_Exec[15:12] ==NOT || Prob_controller.IR[15:12] == LEA) 
				|-> if( Prob_controller.IR_Exec[11:9] == Prob_controller.IR[8:6]) Prob_controller.bypass_alu_1==1
);

//**------------Assert bypass_mem_1--------------------*//
bypass_mem_1_LA : cover property ( @(posedge clock) (Prob_controller.IR[15:12] ==ADD || Prob_controller.IR[15:12] ==AND || Prob_controller.IR[15:12] ==NOT) && (Prob_controller.IR_Exec[15:12] ==LD || Prob_controller.IR_Exec[15:12] == LDR || Prob_controller.IR_Exec[15:12] ==LDI)
				|-> if( Prob_controller.IR_Exec[11:9] == Prob_controller.IR[8:6]) Prob_controller.bypass_mem_1==1);

bypass_mem_2_LA : cover property ( @(posedge clock) (Prob_controller.IR[15:12] ==ADD || Prob_controller.IR[15:12] ==AND || Prob_controller.IR[15:12] ==NOT) && (Prob_controller.IR_Exec[15:12] ==LD || Prob_controller.IR_Exec[15:12] == LDR || Prob_controller.IR_Exec[15:12] ==LDI)
				|-> if( Prob_controller.IR_Exec[11:9]  == Prob_controller.IR[2:0] && Prob_controller.IR[5]!=1) Prob_controller.bypass_mem_2==1);

//*---------------Assert mem_state-----------------*//
mem_state_3_0 : cover property ( @(posedge clock) (Prob_controller.mem_state == 3 && Prob_controller.complete_data==1) |=> if (Prob_controller.IR_Exec[15:12] ==LD || Prob_controller.IR_Exec[15:12] == LDR) Prob_controller.mem_state == 0 );
mem_state_3_1 : cover property ( @(posedge clock) (Prob_controller.mem_state == 3 && Prob_controller.complete_data==1) |=> if (Prob_controller.IR_Exec[15:12] ==STI || Prob_controller.IR_Exec[15:12] == LDI)  Prob_controller.mem_state == 1 );
mem_state_3_2 : cover property ( @(posedge clock) (Prob_controller.mem_state == 3 && Prob_controller.complete_data==1 )|=> if (Prob_controller.IR_Exec[15:12] ==ST || Prob_controller.IR_Exec[15:12] == STR)  Prob_controller.mem_state == 2 );
mem_state_2_3 : cover property ( @(posedge clock) (Prob_controller.mem_state == 2 && Prob_controller.complete_data==1) |=> Prob_controller.mem_state == 3 );
mem_state_1_2 : cover property ( @(posedge clock) (Prob_controller.mem_state == 1 && Prob_controller.complete_data==1) |=> if(Prob_controller.IR_Exec[15:12] == ST ||Prob_controller.IR_Exec[15:12] == STR ||Prob_controller.IR_Exec[15:12] == STI) Prob_controller.mem_state == 2 );
mem_state_1_0 : cover property ( @(posedge clock) (Prob_controller.mem_state == 1 && Prob_controller.complete_data==1)|=> if(Prob_controller.IR_Exec[15:12] == LD || Prob_controller.IR_Exec[15:12] == LDR|| Prob_controller.IR_Exec[15:12] == LDI)  Prob_controller.mem_state == 0 );
mem_state_0_3 : cover property ( @(posedge clock) (Prob_controller.mem_state == 0 && Prob_controller.complete_data==1) |=> Prob_controller.mem_state == 3 );


//*-------------------Asserting mem_state for STI and LDI----------*//
mem_state_STI_3_1 : cover property  ( @(posedge clock) (Prob_controller.mem_state == 3 && Prob_controller.complete_data==1) |=> if(Prob_controller.IR_Exec[15:12] ==STI) Prob_controller.mem_state == 1);
mem_state_STI_1_2 : cover property  ( @(posedge clock) (Prob_controller.mem_state == 1 && Prob_controller.complete_data==1) |=> if(Prob_controller.IR_Exec[15:12] ==STI ) Prob_controller.mem_state == 2);

mem_state_LDI_3_1 : cover property  ( @(posedge clock) (Prob_controller.mem_state == 3 && Prob_controller.complete_data==1) |=> if(Prob_controller.IR_Exec[15:12] == LDI) Prob_controller.mem_state == 1);
mem_state_LDI_1_0 : cover property  ( @(posedge clock) (Prob_controller.mem_state == 1 && Prob_controller.complete_data==1) |=> if(Prob_controller.IR_Exec[15:12] ==LDI) Prob_controller.mem_state == 0);


//**------------------Assert enable writeback------------------------*//
enable_writeback_LD : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LD )|=> Prob_controller.enable_writeback==0);
enable_writeback_LDR : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDR )|=> Prob_controller.enable_writeback==0);
enable_writeback_LDI : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDI )|=> Prob_controller.enable_writeback==0);
enable_writeback_ST : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == ST )|=> Prob_controller.enable_writeback==0);
enable_writeback_STR : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STR )|=> Prob_controller.enable_writeback==0);
enable_writeback_STI : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STI )|=> Prob_controller.enable_writeback==0);
enable_writeback_BR : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == BR )|-> Prob_controller.enable_writeback==1);
enable_writeback_JMP : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == JMP )|-> Prob_controller.enable_writeback==1);


//**------------------Assert enable execute---------------------------*//
enable_execute_LD : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LD )|=> Prob_controller.enable_execute==0);
enable_execute_LDR : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDR )|=> Prob_controller.enable_execute==0);
enable_execute_LDI : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDI )|=> Prob_controller.enable_execute==0);
enable_execute_ST : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == ST )|=> Prob_controller.enable_execute==0);
enable_execute_STR : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STR )|=> Prob_controller.enable_execute==0);
enable_execute_STI : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STI )|=> Prob_controller.enable_execute==0);
enable_execute_BR : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == BR )|-> Prob_controller.enable_execute==1);
enable_execute_JMP : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == JMP )|-> Prob_controller.enable_execute==1);

//*-------------------------Assert enable updatePC---------------------*//
enable_updatePC_LD : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LD )|=> Prob_controller.enable_updatePC==0);
enable_updatePC_LDR : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDR )|=> Prob_controller.enable_updatePC==0);
enable_updatePC_LDI : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == LDI )|=> Prob_controller.enable_updatePC==0);
enable_updatePC_ST : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == ST )|=> Prob_controller.enable_updatePC==0);
enable_updatePC_STR : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STR )|=> Prob_controller.enable_updatePC==0);
enable_updatePC_STI : cover property( @(posedge clock) ( Prob_controller.IR[15:12] == STI )|=> Prob_controller.enable_updatePC==0);
enable_updatePC_BR : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == BR )|-> Prob_controller.enable_updatePC==1);
enable_updatePC_JMP : cover property( @(posedge clock) ( Prob_controller.Instr_dout[15:12] == JMP )|-> Prob_controller.enable_updatePC==1);


//**-----------------------Assert NZP-----------------------------------*//
EXE_NZP_enable_execute_low : cover property (@(posedge clock) (!Probe_ex.enable_execute) |=> Probe_ex.NZP==0);

//Assert stall pipeline
FETCH_stall_pipe_instrmem_rd : cover property (@(posedge clock) (Probe_if.fetch_instrmem_rd!=1) |=> Interface.Instr_dout==Probe_decode.dout);

//-------------------------Assert State Machine Stall--------------------------------//

//2 cycle stall on branch   
assert_CTRL_stall_2cycle_mem: assert property( @(posedge clock) disable iff (Interface.reset) ((Probe_ex.IR[15:12]==LDI) || (Probe_ex.IR[15:12]==STI) |=> ##2 $rose(Probe_if.fetch_enable_fetch)));

assert_CTRL_stall_1cycle : assert property (@(posedge clock) disable iff (Interface.reset) ( (Probe_ex.IR[15:12]==LD) || (Probe_ex.IR[15:12]==LDR) || (Probe_ex.IR[15:12]==ST) || (Probe_ex.IR[15:12]==STR)) |=> ##1 $rose(Probe_if.fetch_enable_fetch));





