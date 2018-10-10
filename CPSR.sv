module CPSR #(parameter bus = 4) 
	(input logic[bus-1:0] datain,input logic clk,CPSR_WE,
	output logic [bus-1:0] dataout);

	logic [bus-1:0] my_memory;
	
	initial begin
		my_memory = 32'b00000000000000000000000000000000;
	end
	
	//always_ff is not used because the book recomends not to use flip-flops
	//SRAMs are more compact than flipflops
	always @(posedge clk) begin
		dataout <= my_memory;
	end
	
	always @(negedge clk) begin
	if (CPSR_WE == 1'b1) begin
		my_memory <= datain;
	end
	end

endmodule

