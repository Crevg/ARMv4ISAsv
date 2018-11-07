module processor_tb ();

	logic clk;
	logic[31:0] instruction,memdatain;
	logic[31:0] pcdir,memdataout,memdir;
	logic MRE,MWE;
	processor #(32) _up(clk, instruction,memdatain, pcdir,memdataout,memdir,MRE,MWE);
	
	initial begin
		
		//Mov instructions
		
		//MOV 
		instruction = 32'HE3E00017;
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
		
		
		
		clk = 1;
		instruction = 32'HE281101B;
		#500;
		clk = 0;
		#500;
		
		
		instruction = 32'HE0812000;
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		clk = 1;
		instruction = 32'HE0823081;
		#500;
		clk = 0;
		#500;		
		
		clk = 1;
		instruction = 32'HE3A0F000;
		#500;
		clk = 0;
		#500;
		
		
		clk = 1;
		instruction = 32'HEA000004;
		#500;
		clk = 0;
		#500;
		clk = 1;
		instruction = 32'HEB000004;
		#500;
		clk = 0;
		#500;
		
		
		clk = 1;
		instruction = 32'HE3E00017;
		#500;
		clk = 0;
		#500;
		
		
		clk = 1;
		instruction = 32'HE5827002;
		memdatain = 32'H00000010;
		#500;
		clk = 0;
		#500;
		
		
		clk = 1;
		instruction = 32'HE5927002;
		memdatain = 32'H00000010;
		#500;
		clk = 0;
		#500;
		
		
		
		
		clk = 1;
		instruction = 32'HE3A02FFF;
		#500;
		clk = 0;
		#500;
		
		clk = 1;
		instruction = 32'HE3A021FF;
		#500;
		clk = 0;
		#500;
		
		
		clk = 1;
		instruction = 32'HE3A022FF;
		#500;
		clk = 0;
		#500;
		
		
		clk = 1;
		instruction = 32'HE3A022FF;
		#500;
		clk = 0;
		#500;
		
		

		clk = 1;
		instruction = 32'HE3A02C01;
		#500;
		clk = 0;
		#500;
		
		
		
		clk = 1;
		instruction = 32'HE3A07058;
		#500;
		clk = 0;
		#500;
		
		clk = 1;
		instruction = 32'HE5827004;
		#500;
		clk = 0;
		#500;
		
		
	
	end
	

endmodule

