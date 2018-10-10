module frecuencyDivider_tb;


	logic clkIn, rst, clkOut;
	frequencyDivider uut (clkIn, rst, clkOut);
	initial begin
		clkIn = 0;
		rst = 1;
		#10000 rst = 0;
		
	end
	
	always #5000 clkIn = ~clkIn;
	
endmodule
