module frequencyDivider (
	input logic i_clk, i_rst,
	output logic o_clk);
	
	logic intern_clk;
	
	assign o_clk = intern_clk;
	
	always_ff @(posedge i_clk)
		if (i_rst) intern_clk <= 0;
		else intern_clk <= ~intern_clk;
	
endmodule
