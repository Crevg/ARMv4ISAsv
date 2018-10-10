
//4*1024 = 16K of memory
module InstructionMemory #(parameter bus = 32, parameter memsize = 1024*4, parameter memoryfile ="instructions.txt") 
(input logic [bus-1:0]readdir,output logic [bus-1:0]dataout,input clk,reset);


	logic [bus-1:0] my_memory [0:memsize-1];
	
	initial begin
		$readmemh(memoryfile,my_memory);
	end
	
	always @(negedge clk) begin
		//if (!reset)
			dataout <= my_memory[{2'b00,readdir[bus-1:2]}];
		//else
		//	dataout <= my_memory[0];
	end

endmodule

