`timescale 1ns/1ps
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


covergroup ALU_OPR_cg;// @(posedge clock);


//1
Cov_alu_opcode: coverpoint dut.Instr_dout[15:12]
{
    bins ADD_BIN = {ADD};
    bins AND_BIN = {AND};
    bins NOT_BIN = {NOT};
}

Cov_IR_EXEC: coverpoint env.execute_object.IR_Exec[15:12]
{
    bins ADD_BIN_ex = {ADD};
    bins AND_BIN_ex = {AND};
    bins NOT_BIN_ex = {NOT};
}

//2
Cov_imm_en: coverpoint dut.Instr_dout[5] iff(dut.Instr_dout[15:12]==ADD||dut.Instr_dout[15:12]==AND)
{
    bins HIGH = {1'b1};
    bins LOW =  {1'b0};
}
//3

Cov_SR1: coverpoint dut.Instr_dout[8:6]
{
 
    bins ALU_SR1[] = { [0:7]};

}
//4

Cov_SR2: coverpoint dut.Instr_dout[2:0]iff((dut.Instr_dout[15:12]==ADD||dut.Instr_dout[15:12]==AND) && dut.Instr_dout[5]==0)
{
    bins ALU_SR2[] = {[0:7]};
}
//5
Cov_DR:  coverpoint dut.Instr_dout[11:9]
{
   bins ALU_DR[] = {[0:7]};
}
//6
Cov_imm5: coverpoint dut.Instr_dout[4:0] iff(dut.Instr_dout[5]==1 &&(dut.Instr_dout[15:12]==ADD||dut.Instr_dout[15:12]==AND))
{

   bins ALU_IMM5[] = {[0:31]};
}
//7
Xc_opcode_imm_en: cross Cov_alu_opcode,Cov_imm_en iff(dut.Instr_dout[15:12]!=NOT)
{
  ignore_bins NOT_INSTRUCTION = binsof(Cov_alu_opcode) intersect {NOT};
}
//8
Xc_opcode_dr_sr1_imm5:cross Cov_alu_opcode, Cov_SR1, Cov_DR,Cov_imm5,Cov_imm_en iff(dut.Instr_dout[5]==1 && (dut.Instr_dout[15:12]==ADD||dut.Instr_dout[15:12]==AND))
{
ignore_bins NOT_INSTR = binsof(Cov_alu_opcode) intersect {NOT};
ignore_bins IMM_INSTR = binsof(Cov_imm_en) intersect {0};
}
//9
Xc_opcode_dr_sr1_sr2: cross Cov_alu_opcode, Cov_SR1, Cov_DR , Cov_SR2,Cov_imm_en iff(dut.Instr_dout[5]==0 && (dut.Instr_dout[15:12]==ADD||dut.Instr_dout[15:12]==AND))
{
ignore_bins NOT_INSTR = binsof(Cov_alu_opcode) intersect {NOT};
ignore_bins IMM_INSTR = binsof(Cov_imm_en) intersect {1};

}

//10
Cov_aluin1: coverpoint env.execute_object.aluin1
{
  option.auto_bin_max = 8 ;
}
//11
Cov_aluin2: coverpoint env.execute_object.aluin2
{
  option.auto_bin_max = 8 ;
}
//12
Cov_aluin1_corner: coverpoint env.execute_object.aluin1
{
  bins aluin1_ALL_1 = {16'hffff};
  bins aluin1_ALL_0 = {0};
  //bins aluin1_ONLY1_1 = {1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536};
  bins aluin1_ALT_01 = {16'b0101010101010101};
  bins aluin1_ALT_10 = {16'b1010101010101010};
  wildcard bins aluin1_pos = {16'b0????????????????};
  wildcard bins aluin1_neg = {16'b1????????????????};
}
//13
Cov_aluin2_corner: coverpoint env.execute_object.aluin2
{
  bins aluin2_ALL_1 = {16'hffff};
  bins aluin2_ALL_0 = {0};
  //bins aluin2_ONLY1_1 = {1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536};
  bins aluin2_ALT_01 = {16'b0101010101010101};
  bins aluin2_ALT_10 = {16'b1010101010101010};
  wildcard bins aluin2_pos = {16'b0????????????????};
  wildcard bins aluin2_neg = {16'b1????????????????};
}
//14
Xc_opcode_aluin1: cross Cov_IR_EXEC, Cov_aluin1_corner;
//15
Xc_opcode_aluin2: cross Cov_IR_EXEC, Cov_aluin2_corner;
//16
Cov_opr_zero_zero: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_zero_zero = binsof(Cov_aluin1_corner)intersect{0} && binsof(Cov_aluin2_corner)intersect{0};
  //bins aluin2_zero_zero = binsof(Cov_aluin2_corner)intersect{0};
  ignore_bins zero_zero = (!binsof(Cov_aluin1_corner)intersect{0} || !binsof(Cov_aluin2_corner)intersect{0});
}
//17
Cov_opr_one_zero: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_one_zero = binsof(Cov_aluin1_corner)intersect{16'hffff} && binsof(Cov_aluin2_corner)intersect{0};
  //bins aluin2_one_zero = binsof(Cov_aluin1_corner)intersect{0};
  ignore_bins one_zero = (!binsof(Cov_aluin1_corner)intersect{16'hffff} || !binsof(Cov_aluin2_corner)intersect{0});
}
//18
Cov_opr_zero_one: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_zero_one = binsof(Cov_aluin1_corner)intersect{0} && binsof(Cov_aluin2_corner)intersect{16'hffff};
  //bins aluin2_zero_one = binsof(Cov_aluin1_corner)intersect{16'hffff};
  ignore_bins zero_one =(!binsof(Cov_aluin1_corner)intersect{0} || !binsof(Cov_aluin2_corner)intersect{16'hffff});
}
//19
Cov_opr_one_one: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_one_one = binsof(Cov_aluin1_corner)intersect{16'hffff} && binsof(Cov_aluin2_corner)intersect{16'hffff};
  //bins aluin2_one_one = binsof(Cov_aluin1_corner)intersect{16'hffff};
  ignore_bins one_one = (!binsof(Cov_aluin1_corner)intersect{16'hffff} || !binsof(Cov_aluin2_corner)intersect{16'hffff});
}

//20
Cov_opr_ALT01_ALT01: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_ALT01_ALT01 = binsof(Cov_aluin1_corner)intersect{16'b0101010101010101} && binsof(Cov_aluin2_corner)intersect{16'b0101010101010101};
  //bins aluin2_ALT01_ALT01 = binsof(Cov_aluin2_corner)intersect{16'b0101010101010101};
  ignore_bins ALT01_ALT01 = (!binsof(Cov_aluin1_corner)intersect{16'b0101010101010101} || !binsof(Cov_aluin2_corner)intersect{16'b0101010101010101});
}
//21
Cov_opr_ALT01_ALT10: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_ALT01_ALT10 = binsof(Cov_aluin1_corner)intersect{16'b0101010101010101} && binsof(Cov_aluin2_corner)intersect{16'b1010101010101010};
  //bins aluin2_ALT01_ALT10 = binsof(Cov_aluin1_corner)intersect{16'b1010101010101010};
  ignore_bins ALT01_ALT10 = (!binsof(Cov_aluin1_corner)intersect{16'b0101010101010101} || !binsof(Cov_aluin2_corner)intersect{16'b1010101010101010});
}
//22
Cov_opr_ALT10_ALT01: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_ALT10_ALT01 = binsof(Cov_aluin1_corner)intersect{16'b1010101010101010} &&  binsof(Cov_aluin2_corner)intersect{16'b0101010101010101};
  //bins aluin2_ALT10_ALT01 = binsof(Cov_aluin1_corner)intersect{16'b0101010101010101};
  ignore_bins ALT10_ALT01 = (!binsof(Cov_aluin1_corner)intersect{16'b1010101010101010} ||  !binsof(Cov_aluin2_corner)intersect{16'b0101010101010101});
}
//23
Cov_opr_ALT10_ALT10: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_ALT10_ALT10 = binsof(Cov_aluin1_corner)intersect{16'b1010101010101010} && binsof(Cov_aluin2_corner)intersect{16'b1010101010101010};
  //bins aluin2_ALT10_ALT10 = binsof(Cov_aluin1_corner)intersect{16'b1010101010101010};
  ignore_bins ALT10_ALT10 = (!binsof(Cov_aluin1_corner)intersect{16'b1010101010101010} || !binsof(Cov_aluin2_corner)intersect{16'b1010101010101010});
}

//24
Cov_opr_pos_pos: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
 bins aluin1_pos_pos = binsof(Cov_aluin1_corner.aluin1_pos) && binsof(Cov_aluin2_corner.aluin2_pos);
 //bins aluin2_pos_pos = binsof(Cov_aluin1_corner)intersect{Cov_aluin2_corner.aluin2_pos};
 ignore_bins pos_pos = (!binsof(Cov_aluin1_corner.aluin1_pos) || !binsof(Cov_aluin2_corner.aluin2_pos));
}
//25
Cov_opr_pos_neg: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_pos_neg = binsof(Cov_aluin1_corner.aluin1_pos) && binsof(Cov_aluin2_corner.aluin2_neg);
  //bins aluin2_pos_neg = binsof(Cov_aluin1_corner)intersect{(Cov_aluin2_corner.aluin2_neg)};
  ignore_bins pos_neg =(!binsof(Cov_aluin1_corner.aluin1_pos) || !binsof(Cov_aluin2_corner.aluin2_neg));
}

//26

Cov_opr_neg_pos: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_neg_pos = binsof(Cov_aluin1_corner.aluin1_neg) && binsof(Cov_aluin2_corner.aluin2_pos);
  //bins aluin2_neg_pos = binsof(Cov_aluin1_corner)intersect{Cov_aluin2_corner.aluin2_pos};
  ignore_bins neg_pos = (!binsof(Cov_aluin1_corner.aluin1_neg) || !binsof(Cov_aluin2_corner.aluin2_pos));

}

//27

Cov_opr_neg_neg: cross Cov_IR_EXEC, Cov_aluin1_corner, Cov_aluin2_corner
{
  bins aluin1_pos_pos = binsof(Cov_aluin1_corner.aluin1_neg) && binsof(Cov_aluin2_corner.aluin2_neg);
  //bins aluin2_pos_pos = binsof(Cov_aluin1_corner)intersect{Cov_aluin2_corner.aluin2_neg};
  ignore_bins neg_neg = (!binsof(Cov_aluin1_corner.aluin1_neg) || !binsof(Cov_aluin2_corner.aluin2_neg));

}

endgroup





/*
Cov_opcode_aluin1c_aluin2c: cross Cov_alu_opcode, Cov_aluin1_corner,Cov_aluin2_corner;

Cov_aluin_alt : coverpoint env.execute_object.aluin1
{
  bins aluin1_ALT01 = {16'b0101010101010101};
  bins aluin1_ALT10 = {16'b1010101010101010};
}

Cov_aluin_alt : coverpoint env.execute_object.aluin2
{
  bins aluin2_ALT01 = {16'b0101010101010101};
  bins aluin2_ALT10 = {16'b1010101010101010};
}

*/

///MEMORY COVERGROUP///
covergroup MEM_OPR_cg;

Cov_mem_opcode: coverpoint dut.Instr_dout[15:12]
{
  bins LD_BIN = {LD}; 
  bins LDR_BIN = {LDR};
  bins LDI_BIN = {LDI};
  //bins LDI_BIN = {LDI}; 
  bins LEA_BIN = {LEA}; 
  bins ST_BIN  = {ST}; 
  bins STR_BIN = {STR}; 
  bins STI_BIN = {STI};
}
Cov_BaseR_LDR: coverpoint dut.Instr_dout[8:6]iff(dut.Instr_dout[15:12]==LDR)//||dut.Instr_dout[15:12]==STR)
{
  bins BaseR_BIN_LDR[] ={[0:7]};
}



Cov_BaseR_STR: coverpoint dut.Instr_dout[8:6]iff(dut.Instr_dout[15:12]==STR)//||dut.Instr_dout[15:12]==STR)
{
  bins BaseR_BIN_STR[] ={[0:7]};
}


Cov_SR_ST: coverpoint dut.Instr_dout[11:9]iff(dut.Instr_dout[15:12]==ST)//||dut.Instr_dout[15:12]==STR||dut.Instr_dout[15:12]==STI)
{
  bins SR_BIN_ST[] = {[0:7]};
}


Cov_SR_STR: coverpoint dut.Instr_dout[11:9]iff(dut.Instr_dout[15:12]==STR)//||dut.Instr_dout[15:12]==STR||dut.Instr_dout[15:12]==STI)
{
  bins SR_BIN_STR[] = {[0:7]};
}



Cov_SR_STI: coverpoint dut.Instr_dout[11:9]iff(dut.Instr_dout[15:12]==STI)//||dut.Instr_dout[15:12]==STR||dut.Instr_dout[15:12]==STI)
{
  bins SR_BIN_STI[] = {[0:7]};
}




Cov_DR_LD: coverpoint dut.Instr_dout[11:9]iff(dut.Instr_dout[15:12]==LD)//||dut.Instr_dout[15:12]==LDR||dut.Instr_dout[15:12]==LDI)
{
  bins DR_BIN_LD[] = {[0:7]};
}


Cov_DR_LDR: coverpoint dut.Instr_dout[11:9]iff(dut.Instr_dout[15:12]==LDR)//||dut.Instr_dout[15:12]==LDR||dut.Instr_dout[15:12]==LDI)
{
  bins DR_BIN_LDR[] = {[0:7]};
}




Cov_DR_LDI: coverpoint dut.Instr_dout[11:9]iff(dut.Instr_dout[15:12]==LDI)//||dut.Instr_dout[15:12]==LDR||dut.Instr_dout[15:12]==LDI)
{
  bins DR_BIN_LDI[] = {[0:7]};
}



Cov_DR_LEA: coverpoint dut.Instr_dout[11:9]iff(dut.Instr_dout[15:12]==LEA)//||dut.Instr_dout[15:12]==LDR||dut.Instr_dout[15:12]==LDI)
{
  bins DR_BIN_LEA[] = {[0:7]};
}



Cov_PCoffset9 : coverpoint dut.Instr_dout[8:0] iff(dut.Instr_dout[15:12] == LD || dut.Instr_dout[15:12] == LDI || dut.Instr_dout[15:12] == LEA || dut.Instr_dout[15:12] == ST || dut.Instr_dout[15:12] == STI || dut.Instr_dout[15:12] == BR )
{
  option.auto_bin_max = 8 ;
}

Cov_PCoffset6 : coverpoint dut.Instr_dout[5:0] iff(dut.Instr_dout[15:12] == LDR || dut.Instr_dout[15:12] == STR)
{
  option.auto_bin_max = 8 ;
}

Cov_PCoffset9_c : coverpoint dut.Instr_dout[8:0] iff(dut.Instr_dout[15:12] == LD || dut.Instr_dout[15:12] == LDI || dut.Instr_dout[15:12] == LEA || dut.Instr_dout[15:12] == ST || dut.Instr_dout[15:12] == STI || dut.Instr_dout[15:12] == BR )
{
  bins PCoffset9_c_high= {9'b111111111};
  bins PCoffset9_c_low= {9'b000000000};
}

Cov_PCoffset6_c : coverpoint dut.Instr_dout[5:0] iff(dut.Instr_dout[15:12] == LDR || dut.Instr_dout[15:12] == STR)
{
  bins PCoffset6_c_high= {6'b111111};
  bins PCoffset6_c_low= {6'b000000};
}

Xc_BaseR_DR_offset6 : cross Cov_PCoffset6,Cov_DR_LDR,Cov_BaseR_LDR iff(dut.Instr_dout[15:12]==LDR);
/*
 ignore_bins others = binsof(Cov_mem_opcode) intersect {LDR, LD, LDI, STI, ST, LEA};
}
*/

Xc_BaseR_SR_offset6 : cross Cov_PCoffset6,Cov_SR_STR,Cov_BaseR_STR iff(dut.Instr_dout[15:12]==STR);
/*
{
  ignore_bins others = binsof(Cov_mem_opcode) intersect {STR, LD, LDI, STI, ST, LEA};
}
*/
endgroup

///control////
covergroup CTRL_OPR_cg;

Cov_ctrl_opcode : coverpoint dut.Instr_dout[15:12]
	{
		bins BR_BIN  = {BR};
		bins JMP_BIN = {JMP};
	}	


Cov_BaseR : coverpoint dut.Instr_dout[8:6] iff(dut.Instr_dout[15:12] == JMP)
	{
		bins BaseR_JMP_BIN[] = {[0:7]};
	}

Cov_NZP : coverpoint env.execute_object.IR_Exec[11:9] iff(env.execute_object.IR_Exec[15:12] == JMP)
	{
		bins NZP_JMP_BIN = {0};
	}


Cov_PSR : coverpoint env.writeback_object.psr //iff(env.writeback_object.DR_in[15:12] == JMP)  ////check!!!!
	{
		bins PSR_JMP_P_BIN = {1};
		bins PSR_JMP_0_BIN = {2};
		bins PSR_JMP_N_BIN = {4};
	}

Cov_PCoffset9 : coverpoint dut.Instr_dout[8:0] iff(dut.Instr_dout[15:12] == BR)
	{
		option.auto_bin_max = 8 ;
	}


Cov_PCoffset9_c : coverpoint dut.Instr_dout[8:0] iff(dut.Instr_dout[15:12] == BR)
	{
		bins pcoffset9_corner_low   = {9'h000} ;
		bins pcoffset9_corner_high  = {9'h1FF} ;
	}
	
Xc_NZP_PSR : cross Cov_NZP,Cov_PSR;
endgroup

/// order of instr///
covergroup OPR_SEQ_cg;

Coverage_order : coverpoint dut.Instr_dout[15:12]
{
 bins order_ALU_Memory = (ADD,AND,NOT=>LD,LDR,LDI,ST,STR,STI); //Treating LEA for corner case
 bins order_ALU_Control = (ADD,AND,NOT=>BR,JMP);
 bins order_ALU_ALU = (ADD,AND,NOT=>ADD,AND,NOT);
 bins order_Memory_ALU = (LD,LDR,LDI,LEA,ST,STR,STI=>ADD,AND,NOT);
 bins order_Control_ALU = (BR,JMP=>ADD,AND,NOT);
 bins order_ALU_LEA = (ADD,AND,NOT=>LEA);
  bins order_LEA_ALU = (LEA=>ADD,AND,NOT);
  bins order_LEA_LEA = (LEA=>LEA);
  bins order_LEA_Memory = (LEA=>LD,LDR,LDI,ST,STR,STI);
  bins order_LEA_Control = (LEA=>BR,JMP);
}

endgroup


