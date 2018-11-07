 
module FroggerSystemTop (input logic clk, reset, input logic [31:0] keyboard_data, output logic [7:0] R,G,B, output logic o_hs, o_vs, o_sync, o_blank, o_clk);


FroggerSystem #(32, 256) (clk, reset,keyboard_data, R,G,B, o_hs, o_vs, o_sync, o_blank, o_clk);
	 
	 

endmodule
