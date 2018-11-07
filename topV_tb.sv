module topV_tb;

   logic clkIn, rst, o_hs, o_vs, o_sync, o_blank;
	logic[7:0] r, g, b;
	
	
	initial begin
		clkIn = 1;
		rst = 1;
		#10000 rst = 0;
	end
	
	topV uut(clkIn, rst, r, g, b, o_hs, o_vs, o_sync, o_blank);
	always #5000 clkIn = ~clkIn;
	
	
endmodule
