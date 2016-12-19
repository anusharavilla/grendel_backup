`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:31:42 11/03/2015
// Design Name:   top
// Module Name:   C:/Users/prasanth/Xilinx/new_test/final_test_fixture.v
// Project Name:  new_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module final_test_fixture;

	// Inputs
	
	reg clock;
	reg reset;
	//reg [7:0] source_num;
	//reg [7:0] destination;
       // integer file;
	//reg a;
       // reg [12:0] DestinationAddress;
	//reg [16:0] prev;
	//reg [127:0] out, out1;
	// Outputs
	reg [13:0] output_address;
	wire [15:0] final_output;
	wire finish;
	wire n_exist;
	wire simulation_finish;

	integer i, output_file;
	integer j=0;
	
	// Instantiate the Unit Under Test (UUT)
	

	initial begin
		// Initialize Inputs
		$readmemh("input_small.mem", uut7.uut8.Register);
		$readmemh("data.mem", uut7.uut2.Register);
		
		clock = 0;
		reset = 0;
		
		//DestinationAddress = {5'b00000,destination};
		
                
		// Wait 100 ns for global reset to finish
		#20;
		reset =1;
      output_address=13'b0000000000001;
		output_file = $fopen("output.dat","w");
		end
      	//integer i, output_file;
		//initial output_file = $fopen("output.dat","w");
		
		initial
		begin  
		wait(uut7.n_exist);
		
      
   	 $fdisplay(output_file,"Negative cycle exists");
		$fclose(output_file);		
		end
		
		always@(posedge clock) 
		begin
		//output_file = $fopen("output.dat","w");
		
		wait(uut7.simulation_finish);    
		//@(posedge final_test_fixture.uut7.no_negedge); 
		

		//$display("writing to output file");
		begin
			//for (i = 0; i < $size(final_test_fixture.uut7.uut9.Register); i = i + 1)
			
			if(uut7.n_exist)
			begin
		   //$fdisplay(output_file,"Negative cycle exists");
			//disable aloop;
			end
			else
			begin  
			for (i = 0; i < 16383; i = i + 1)
			begin:aloop
			
			if(final_test_fixture.uut7.uut9.Register[i]==16'hFFFF)
			begin
			$fdisplay(output_file,"%4h", final_test_fixture.uut7.uut9.Register[i]);
		
			end
			else if(final_test_fixture.uut7.uut9.Register[i]!=16'hFFFF)
			begin
			if(final_test_fixture.uut7.uut9.Register[i]==16'h0000)
			begin
			$fdisplay(output_file,"%4h", final_test_fixture.uut7.uut9.Register[i]);
			disable aloop;
			end
			else
			$fdisplay(output_file,"%2d", final_test_fixture.uut7.uut9.Register[i]);
			end
			end
			$fdisplay(output_file,"0");
		end
		end
		$fclose(output_file);
		$display("writing to output file");
		end
		
	
	always #10 clock = ~clock;    
	top uut7 (
		.clock(clock), 
		.reset(reset), 
		.output_address(output_address),
		.final_output(final_output),
		.finish(finish),
		.n_exist(n_exist),
		.simulation_finish(simulation_finish)
	
		
	);   
endmodule

