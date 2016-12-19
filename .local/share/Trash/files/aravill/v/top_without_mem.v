`timescale 1ns / 1ps
module top_without_mem(clock,reset,output_address,WMReadBus1,WMReadBus2,GraphReadBus1,GraphReadBus2,InputRead,final_output,register1_pc,register2_pc,source_node_dest,wram_address2,write_value,InputAddress,WE2,output_memory_address,output_memory_value,finish,n_exist,finish_simulation, wa, WE
    );
input clock;
input reset;
input [13:0] output_address;
input [127:0] WMReadBus1;
input [127:0] WMReadBus2;
input [127:0] GraphReadBus1;
input [127:0] GraphReadBus2;
input [7:0] InputRead;

/*--------ouputs-----------*/
output finish; 
output n_exist;
output finish_simulation;
output WE;
//output no_negedge;
output [15:0] final_output;
output [12:0]  register1_pc;
output [12:0]  register2_pc;
output [12:0]  source_node_dest;
output [12:0] wram_address2;
output [127:0] write_value;
output [9:0] InputAddress;
output WE2;
output [13:0] output_memory_address;
output [15:0] output_memory_value; 
output [12:0]  wa;
/*---------nets and registers----*/
wire finish;
wire [7:0] num_vertice;
wire control;
wire [127:0] GraphReadBus1;
wire [127:0] GraphReadBus2;
wire [12:0]  register1_pc;
wire [12:0]  register2_pc;
wire [12:0]  source_node_dest;       
wire [7:0]   dist_reg;
wire [127:0] WMReadBus1;      //
wire [127:0] WMReadBus2;   //
//wire [127:0] WMDR1;
//wire [127:0] WMDR2;
wire [63:0]  out_reg_64;
wire ouput_comparator;
wire [12:0]  wa;
wire [127:0] write_value;   
wire [4:0] number_of_lines_reg;  //
wire [2:0] remainder_out;   //
wire n_exist;       //
wire finish_simulation;   //

wire [7:0]   daugther_counter;
wire floating_out1,floating_out2;  
wire [63:0] totalnodes;
wire [15:0] AL1;
wire [15:0] AL2;
wire [15:0] AL3;
wire [15:0] AL4;
wire [15:0] AL5;
wire [15:0] AL6;
wire [15:0] AL7;
wire [15:0] AL8;
wire WE;
wire daughter_count_hold;
wire current_node_daughter_selector;
wire [1:0] graph1_selector;
wire [1:0] graph2_selector;
wire [2:0] daughter_selector;
wire [12:0] register_pc_ip;
wire [12:0] cntrl_w_add;
wire [127:0] cntrl_w_val;
//wire wmdr1_mux;
//wire wmdr2_mux;
wire [1:0] wram_add_selector;
wire control_write_mux;
wire [1:0] controller_mux1;
wire controller_mux2,controller_mux3,controller_mux4;
wire [9:0] InputAddress;
wire [7:0] InputRead;
wire [7:0] source;
wire [7:0] dest_node;
wire status_of_input;
wire [1:0] output_selector2,output_selector3;
wire output_selector1;
wire [2:0] output_selector4;
wire [13:0] output_memory_address;
wire [15:0] output_memory_value; 
wire WE2;
wire [15:0] final_output;
wire [127:0] prev_node;
wire [12:0] wram_address2;


datapath uut1(.clock(clock),.negedge_cycle(negedge_cycle),.n_exist(n_exist),.G1(GraphReadBus1),.G2(GraphReadBus2),.W1(WMReadBus1),.W2(WMReadBus2),.InputBus(InputRead),.controller_mux1(controller_mux1),.controller_mux2(controller_mux2),.controller_mux3(controller_mux3),.controller_mux4(controller_mux4),.output_selector1(output_selector1),.output_selector2(output_selector2),.output_selector3(output_selector3),.output_selector4(output_selector4),.output_memory_value(output_memory_value), .output_memory_address(output_memory_address), .prev_node(prev_node),.current_node_daughter_selector(current_node_daughter_selector),.control(control),.graph1_selector(graph1_selector),.graph2_selector(graph2_selector),.daughter_count_hold(daughter_count_hold),.daughter_selector(daughter_selector),.register_pc_ip(register_pc_ip),.wram_add_selector(wram_add_selector),.control_write_mux(control_write_mux),.cntrl_w_add(cntrl_w_add), .cntrl_w_val(cntrl_w_val), .register1_pc(register1_pc),.register2_pc(register2_pc),.source_node_dest(source_node_dest),.wram_address2(wram_address2),.dist_reg(dist_reg),.out_reg_64(out_reg_64),.wa(wa),.write_value(write_value),.daugther_counter(daugther_counter),.floating_out1(floating_out1),.floating_out2(floating_out2),.totalnodes(totalnodes),.AL1(AL1),.AL2(AL2),.AL3(AL3),.AL4(AL4),.AL5(AL5),.AL6(AL6),.AL7(AL7),.AL8(AL8),.num_vertice(num_vertice),.ouput_comparator(ouput_comparator),.source(source),.dest_node(dest_node),.InputAddress(InputAddress),.status_of_input(status_of_input),.number_of_lines_reg(number_of_lines_reg));
//sram_2R  uut2(.ReadAddress1(register1_pc), .ReadAddress2(register2_pc), .ReadBus1(GraphReadBus1), .ReadBus2(GraphReadBus2));
//wram uut3(.clock(clock), .WE(WE), .WriteAddress(wa), .ReadAddress1(source_node_dest), .ReadAddress2(wram_address2), .WriteBus(write_value), .ReadBus1(WMReadBus1), .ReadBus2(WMReadBus2));
//sram_1R uut8(.ReadAddress(InputAddress), .ReadBus(InputRead));
controlpath uut4(.finish_simulation(finish_simulation),.negedge_cycle(negedge_cycle),.prev_node(prev_node), .status_of_input(status_of_input),.dest_node(dest_node),.WE2(WE2), .output_selector1(output_selector1),.output_selector2(output_selector2),.output_selector3(output_selector3),.output_selector4(output_selector4), .clock(clock), .reset(reset), .num_vertice(num_vertice), .source_num(source), .daugther_counter(daugther_counter), .ouput_comparator(ouput_comparator), .WE(WE), .current_node_daughter_selector(current_node_daughter_selector), .graph1_selector(graph1_selector), .graph2_selector(graph2_selector), .daughter_selector(daughter_selector), .control(control), .register_pc_ip(register_pc_ip), .cntrl_w_add(cntrl_w_add), .cntrl_w_val(cntrl_w_val),.wram_add_selector(wram_add_selector), .control_write_mux(control_write_mux), .finish(finish),.daughter_count_hold(daughter_count_hold),.controller_mux1(controller_mux1),.controller_mux2(controller_mux2),.controller_mux3(controller_mux3),.controller_mux4(controller_mux4),.number_of_lines_reg(number_of_lines_reg));
//sram_1R1W uut9(.clock(clock), .WE(WE2), .WriteAddress(output_memory_address), .ReadAddress(output_address), .WriteBus(output_memory_value), .ReadBus(final_output));

endmodule
