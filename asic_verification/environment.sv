`timescale 1ns/1ps
`include "fetch_golden.sv"
`include "decode_golden_reference.sv"
`include "cfg.sv"

class environment;

fetch_golden fetch_object;
decode_golden decode_object;
cfg cfg_object;

// interfaces

virtual LC3_io.TB interfaces;
virtual dut_Probe_if Probe_if;
virtual  dut_Probe_controller Probe_controller;
virtual dut_Probe_execute Probe_ex;
virtual dut_Probe_decode Probe_decode;
	function new (virtual LC3_io.TB interfaces, virtual dut_Probe_if Probe_if,virtual dut_Probe_execute Probe_ex, virtual dut_Probe_controller  Probe_controller, virtual dut_Probe_decode Probe_decode);
		this.interfaces = interfaces;
		this.Probe_if = Probe_if;
		this.Probe_controller = Probe_controller;
		this.Probe_ex = Probe_ex;
		this.Probe_decode=Probe_decode;
	endfunction

	function void create();
		fetch_object = new(interfaces, Probe_if);
		decode_object = new(interfaces, Probe_decode);
		cfg_object = new();
	endfunction

	task run();
		fork
			fetch_object.golden_reference();
			decode_object.golden_reference();
		join
	endtask

// add enables later

	task cfg_randomizing();
		assert(cfg_object.randomize());
	endtask
// enable asynchronous data for memeory

	function dut_gr_async();
		fetch_object.enable_fetch = Probe_if.fetch_enable_fetch;
		fetch_object.enable_updatePC = Probe_if.fetch_enable_updatePC;
		decode_object.enable_decode=Probe_decode.enable_decode;
		decode_object.dout=Probe_decode.dout;
		decode_object.npc_in=Probe_decode.npc_in;
	endfunction
	
	function outputs();
		decode_object.Mem_Control=Probe_decode.Mem_Control;
		decode_object.W_Control=Probe_decode.W_Control;
		decode_object.E_Control=Probe_decode.E_Control;
		decode_object.IR=Probe_decode.IR;
		decode_object.npc_out=Probe_decode.npc_out;
		fetch_object.br_taken = Probe_if.fetch_br_taken;
	    fetch_object.taddr = Probe_if.fetch_taddr;
	endfunction

endclass




 









   



	