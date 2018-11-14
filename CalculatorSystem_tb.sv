
module CalculatorSystem_tb ();
	
	
	logic clk,o_clk, rst;
	logic [31:0] keyboard_data;
	logic [7:0] R,G,B;
	
	logic o_hs, o_vs, o_sync, o_blank;
	
	logic[31:0] datain,dir;
	
	logic PS2_DATA, PS2_CLK;
	
	CalculatorSystem #(32, 256) _calc(clk,rst, PS2_DATA, PS2_CLK, R,G,B, o_hs, o_vs, o_sync, o_blank, o_clk);
	
	
	
	initial begin
		clk = 1;
		rst = 1;
//		PS2_CLK = 1;
//		PS2_DATA = 0;
		//rst2 = 1;
		//#800 rst2 = 0;
		#800 rst = 0;
//		#800
//		PS2_DATA = 1;
//		#2400
//		PS2_DATA = 0;
		
		
		
		
		
	end
	always
	//begin 
		#400 clk = ~clk;
//		PS2_CLK = ~PS2_CLK;
	//end
	
endmodule
