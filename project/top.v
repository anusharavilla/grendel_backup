`timescale 1ns / 1ps
module top(clock,reset,output_address,final_output,finish,n_exist,simulation_finish
    );
/*--------inputs-----------*/
input clock;
input reset;
input [13:0] output_address;
output n_exist;
output simulation_finish;
/*--------ouputs-----------*/
output finish; 
output [15:0] final_output;
/*---------nets and registers----*/
wire finish;
wire [7:0] vertice_num;
wire control;
wire [127:0] GraphReadBus1;
wire [127:0] GraphReadBus2;
wire [12:0]  PC_REG1;
wire [12:0]  PC_REG2;
wire [12:0]  source_node_dest;
wire [7:0]   dist_reg;
wire [127:0] WMReadBus1;
wire [127:0] WMReadBus2;
//wire [127:0] WMDR1;
//wire [127:0] WMDR2;
wire [63:0]  out_reg_64;
wire out_comp;
wire [12:0]  wa;
wire [127:0] write_value;
wire [4:0] num_of_lines_out;
wire [2:0] remainder_out;
wire n_exist;
wire simulation_finish;

wire [7:0]   DCR;
wire floating_out1,floating_out2;  
wire [63:0] totalnodes;
wire [15:0] al1;
wire [15:0] al2;
wire [15:0] al3;
wire [15:0] al4;
wire [15:0] al5;
wire [15:0] al6;
wire [15:0] al7;
wire [15:0] al8;
wire WE;
wire dcr_mux;
wire snd_mux;
wire [1:0] graph1;
wire [1:0] graph2;
wire [2:0] d_mux;
wire [12:0] PC_REG_input;
wire [12:0] controller_writing_address;
wire [127:0] controller_writing_value;
//wire wmdr1_mux;
//wire wmdr2_mux;
wire [1:0] w_mux;
wire control_write_mux;
wire [1:0] c1;
wire c2,c3,c4;
wire [9:0] InputAddress;
wire [7:0] InputRead;
wire [7:0] source;
wire [7:0] destination;
wire i_status;
wire [1:0] o2,o3;
wire o1;
wire [2:0] o4;
wire [13:0] output_memory_address;
wire [15:0] output_memory_value; 
wire WE2;
wire [15:0] final_output;
wire [127:0] previous;
wire [12:0] wram_address2;


complete_DataPath uut1(.clock(clock),.negedge_cycle(negedge_cycle),.n_exist(n_exist),.G1(GraphReadBus1),.G2(GraphReadBus2),.W1(WMReadBus1),.W2(WMReadBus2),.InputBus(InputRead),.c1(c1),.c2(c2),.c3(c3),.c4(c4),.o1(o1),.o2(o2),.o3(o3),.o4(o4),.output_memory_value(output_memory_value), .output_memory_address(output_memory_address), .previous(previous),.snd_mux(snd_mux),.control(control),.graph1(graph1),.graph2(graph2),.dcr_mux(dcr_mux),.d_mux(d_mux),.PC_REG_input(PC_REG_input),.w_mux(w_mux),.control_write_mux(control_write_mux),.controller_writing_address(controller_writing_address), .controller_writing_value(controller_writing_value), .PC_REG1(PC_REG1),.PC_REG2(PC_REG2),.source_node_dest(source_node_dest),.wram_address2(wram_address2),.dist_reg(dist_reg),.out_reg_64(out_reg_64),.wa(wa),.write_value(write_value),.DCR(DCR),.floating_out1(floating_out1),.floating_out2(floating_out2),.totalnodes(totalnodes),.al1(al1),.al2(al2),.al3(al3),.al4(al4),.al5(al5),.al6(al6),.al7(al7),.al8(al8),.vertice_num(vertice_num),.out_comp(out_comp),.source(source),.destination(destination),.InputAddress(InputAddress),.i_status(i_status),.num_of_lines_out(num_of_lines_out));
sram_2R  uut2(.ReadAddress1(PC_REG1), .ReadAddress2(PC_REG2), .ReadBus1(GraphReadBus1), .ReadBus2(GraphReadBus2));
wram uut3(.clock(clock), .WE(WE), .WriteAddress(wa), .ReadAddress1(source_node_dest), .ReadAddress2(wram_address2), .WriteBus(write_value), .ReadBus1(WMReadBus1), .ReadBus2(WMReadBus2));
sram_1R uut8(.ReadAddress(InputAddress), .ReadBus(InputRead));
bellman_ford_controller uut4(.simulation_finish(simulation_finish),.negedge_cycle(negedge_cycle),.previous(previous), .i_status(i_status),.destination(destination),.WE2(WE2), .o1(o1),.o2(o2),.o3(o3),.o4(o4), .clock(clock), .reset(reset), .vertice_num(vertice_num), .source_num(source), .DCR(DCR), .out_comp(out_comp), .WE(WE), .snd_mux(snd_mux), .graph1(graph1), .graph2(graph2), .d_mux(d_mux), .control(control), .PC_REG_input(PC_REG_input), .controller_writing_address(controller_writing_address), .controller_writing_value(controller_writing_value),.w_mux(w_mux), .control_write_mux(control_write_mux), .finish(finish),.dcr_mux(dcr_mux),.c1(c1),.c2(c2),.c3(c3),.c4(c4),.num_of_lines_out(num_of_lines_out),.remainder_out(remainder_out));
sram_1R1W uut9(.clock(clock), .WE(WE2), .WriteAddress(output_memory_address), .ReadAddress(output_address), .WriteBus(output_memory_value), .ReadBus(final_output));

endmodule
