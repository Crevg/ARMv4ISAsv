module RegisterBank_tb();

	logic [3:0] dira,dirb,dc,dirwrite;
	
	logic [31:0] a,b,c,pc,pc_in;
	
	logic[31:0] datawrite;
	
	logic clk,memwrite,memread;
	
	RegisterBank #(4) rbank(dira,dirb,dc,dirwrite,datawrite,pc_in,clk,memwrite,memread,a,b,c,pc);

	
	initial begin
		dirb <= 0;
		memwrite <= 1;
		memread <= 1;
		dirwrite <= 5;
		datawrite <= 54;
		dira <= 5;
		dc <= 1;
		pc_in <= 0;
		#20
		
		
		memwrite <= 1;
		memread <= 1;
		dirwrite <= 8;
		datawrite <= 4;
		dira <= 5;
		pc_in <= pc + 4;
		#20
		
		memwrite <= 0;
		memread <= 1;
		dira <= 8;
		pc_in <= pc + 4;
		#20
		
		memwrite <= 0;
		memread <= 1;
		dirb <= 8;
		pc_in <= pc + 4;
		#20
		
		
		memwrite <= 0;
		memread <= 1;
		dirb <= 5;
		pc_in <= pc + 4;
		#20;
	
	end
	
	
		always
		begin
			clk <= 1; #10; clk <= 0; #10;
		end

endmodule

