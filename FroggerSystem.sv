 
module FroggerSystem #(bus = 32, memsize = 256) (input logic clk, reset, input logic [bus-1:0] keyboard_data, output logic [7:0] R,G,B, output logic o_hs, o_vs, o_sync, o_blank, o_clk);

	logic [bus-1:0]pcdir,instruction,memdatain,memdataout,memdataoutVGA,memdir,memdirVGA;
	logic MRE,MWE;
	logic clk_mem,clk_memdat,clk_proc,clk_vga;
	
	ClockFix _clok_fix(clk, clk_mem,clk_memdat,clk_proc,clk_vga);
	
	processor #(bus) u_processor(clk_proc,reset,instruction,memdatain,pcdir,memdataout,memdir,MRE,MWE);
	
	InstructionMemory #(bus, 5000, "program4.txt") 
		instruction_memory(pcdir,instruction,clk_mem,reset);

	//										  (datain,	writedir,readdir,readdir2, dataout,  dataout2,		clk, 		  MRE,MWE);
	
	DataMemory #(bus, 16000) data_memory(memdataout,memdir,memdir, memdirVGA,memdatain,memdataoutVGA,clk_memdat, o_clk,MRE,MWE);

	//			 clk,     rst,   datain,		 r,g,b, o_hs, o_vs, o_sync, o_blank, o_clk,dir
	topV _vga(clk_vga, reset, memdataoutVGA,R,G,B, o_hs, o_vs, o_sync, o_blank, o_clk,memdirVGA);	 

endmodule

