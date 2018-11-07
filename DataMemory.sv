//4*1024 = 16K of memory
module DataMemory #(parameter bus = 32, parameter memsize = 1024*4) 
(input logic [bus-1:0]datain,writedir,readdir,readdir2,output logic [bus-1:0]dataout,dataout2,input clk, clk_vga, MRE,MWE);

	
	logic [bus-1:0] my_memory [0:memsize-1];
	
	
	initial begin
		$readmemh("memorydata.txt",my_memory);
	end
	
	
		
	always @(posedge clk) begin
	if (MRE == 1'b1) begin
		dataout <= my_memory[{readdir[bus-1:2], 2'd0}];
	end
	end
	
	always @(posedge clk_vga) begin
	dataout2 <= my_memory[{readdir2, 2'd0}];
	end
	
	always @(negedge clk) begin
	if (MWE == 1'b1) begin
		my_memory[{writedir, 2'd0}] <= datain;
	end
	end


endmodule
