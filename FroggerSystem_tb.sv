
module FroggerSystem_tb ();
	
	
	logic clk,o_clk, rst;
	logic [31:0] keyboard_data;
	logic [7:0] R,G,B;
	
	logic o_hs, o_vs, o_sync, o_blank;
	
	logic[31:0] datain,dir;
	FroggerSystem #(32, 256) _frogger(clk,rst,keyboard_data, R,G,B, o_hs, o_vs, o_sync, o_blank, o_clk);
	
	
	initial begin
		clk = 1;
		rst = 1;
		//rst2 = 1;
		//#800 rst2 = 0;
		#800 rst = 0;
	end
	always
		#400 clk = ~clk;

endmodule
