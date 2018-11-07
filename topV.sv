module topV (
    input logic clk, rst, input logic[31:0] datain,
    output logic[7:0] r, g, b,
	 output logic o_hs, o_vs, o_sync, o_blank, o_clk,output logic [31:0] dir);
	 
	logic [9:0] x, y; 
	logic counter = 0;
	logic o_rst = 1;
	
	always @(posedge o_clk)
		begin 
			if (counter == 0) begin
				o_rst <= 1;
				counter <= 1;
			end
			else o_rst <= rst;
		end
	
	 frequencyDivider ffd(clk, rst, o_clk);
	 vgaController v0(o_clk, o_rst, o_hs, o_vs, o_sync, o_blank, x, y);
	 
	 assign r = datain[23:16];
	 assign g = datain[15:8];
	 assign b = datain[7:0];
	 assign dir = 32'd0;
	 
endmodule

