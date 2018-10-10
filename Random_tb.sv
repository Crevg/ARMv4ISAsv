`timescale 1ns / 1ps
//module Random_tb();
//
//    logic clk;
//    logic preset;
//    logic [3:0] code;
//    
//    LFSR prg(clk, preset, code);
//    
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk;
//    end
//    
//    initial begin
//        preset = 1; #5;
//        clk = 1; #0.1;
//        clk = 0; #0.1;
//        preset = 0;
//    end
//endmodule

module Random_tb;
	// Inputs
	logic clk;
    logic preset;
    logic [3:0] code;
	// Outputs
	// Instantiate the Unit Under Test (UUT)
	Random uut (
		.clk(clk), 
		.preset(preset),
		.code(code)
	);
 
	initial begin
		// Initialize Inputs
		preset = 1; #1;
        clk = 1; #1;
        clk = 0; #1;
		  clk = 1; #1;
        clk = 0; #1;
		  clk = 1; #1;
        clk = 0; #1;
		  clk = 1; #1;
        clk = 0; #1;
		  clk = 1; #1;
        clk = 0; #1;
		  clk = 1; #1;
        clk = 0; #1;
		  
        
    end  
	 
endmodule 
