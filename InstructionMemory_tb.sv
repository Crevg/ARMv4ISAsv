

module InstructionMemory_tb ();
	logic clk;
	logic [31:0] keyboard_data;
	logic [7:0] R,G,B;
	
	logic [31:0] pcdir,instruction;
	
	InstructionMemory #(32, 255, "instructions.txt") 
		instruction_memory(pcdir,instruction,clk);

	
	initial begin
		clk = 1;
		pcdir = 32'd0;
		#100;
		#100 pcdir = 32'd1;
		#100 pcdir = 32'd2;
		#100 pcdir = 32'd4;
		#100 pcdir = 32'd5;
		
	end
	
	always
		#50 clk = ~clk;
		
	
	

endmodule
