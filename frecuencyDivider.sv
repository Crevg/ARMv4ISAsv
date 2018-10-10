module frequencyDivider (
	input logic i_clk, i_rst,
	output logic o_clk);
	
	always_ff @(posedge i_clk)
		if (i_rst) o_clk <= 0;
		else o_clk <= ~o_clk;
	
endmodule
