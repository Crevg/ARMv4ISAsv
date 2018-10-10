// N is the max of bits.
module counter #(parameter N = 8) 
	(input  logic i_clk,
	 input  logic i_rst,
	 input  logic i_ena,
	 output logic [N-1:0] o_cnt);
	 
	// Synchronous reset.
	always_ff @(posedge i_clk)
		if (i_rst)			o_cnt <= 0;
		else if (i_ena)	o_cnt <= o_cnt + 1;
	
endmodule
