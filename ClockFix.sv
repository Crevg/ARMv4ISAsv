module ClockFix (input logic clk, output logic clk_mem,clk_memdat,clk_proc,clk_vga);

	initial begin
		clk_mem = 0;
		clk_memdat = 0;
		clk_proc = 0;
		clk_vga = 0;
	end
	
	always @* begin
		clk_mem <= clk;
		clk_memdat <= clk;
		clk_proc <= clk;
		clk_vga <= clk;
	end

endmodule

