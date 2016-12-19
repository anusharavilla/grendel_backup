`timescale 1ns / 1ps



module final_test_fixture;

	// Inputs
	
	reg clock;
	reg reset;
	
	// Outputs
	reg [13:0] output_address;
	wire [15:0] final_output;
	wire finish;
	wire n_exist;
	wire finish_simulation;

	integer i, output_file;
	integer j=0;
	
	// Instantiate the Unit Under Test (UUT)
	

	initial begin
		// Initialize Inputs
		$readmemh("input_small.mem", uut7.uut8.Register);
		$readmemh("data.mem", uut7.uut2.Register);
		
		clock = 0;
		reset = 0;
		
		#20;
		reset =1;
      output_address=13'b0000000000001;
		output_file = $fopen("output.dat","w");
		end
      	
		
		initial
		begin  
		wait(uut7.uut20.n_exist);
		
      
   	 $fdisplay(output_file,"Negative cycle exists");
		$fclose(output_file);
        #1 $finish;		
		end
		
		always@(posedge clock) 
		begin
	
		
		wait(uut7.finish_simulation);    
		
		

		
		begin
			
			
			if(uut7.uut20.n_exist)
			begin
		   
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
			$fdisplay(output_file,"0");
			disable aloop;
			end
			else 
			$fdisplay(output_file,"%2d", final_test_fixture.uut7.uut9.Register[i]);
			end
			end
			
		end
		end
		$fclose(output_file);

		#1 $finish;
		end
		
	
	always #10 clock = ~clock;    
	top_with_mem uut7 (
		.clock(clock), 
		.reset(reset), 
		.output_address(output_address),
		.final_output(final_output),
		.finish(finish),
		.n_exist(n_exist),
		.finish_simulation(finish_simulation)
	
		
	);   
endmodule

