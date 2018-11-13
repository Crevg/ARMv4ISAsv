module topV 

	#(parameter HACTIVE = 10'd635,
											HFP 	  = 10'd15,
											HSYN    = 10'd95,
											HBP     = 10'd48,
											HSS     = HSYN + HBP,
											HSE     = HSYN + HBP + HACTIVE,
											HMAX    = HSYN + HBP + HACTIVE + HFP,
											
											VACTIVE = 10'd480,
											VFP     = 10'd10,
											VSYN    = 10'd2,
											VBP     = 10'd33,
											VSS     = VSYN + VBP,
											VSE     = VSYN + VBP + VACTIVE,
											VMAX    = VSYN + VBP + VACTIVE + VFP
	)
	(
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
	 
	 
	logic hRstF, vRstF, hDS, hDE, vDS, vDE = 0;
	//	Blank Comparator
	comparator#(10) hDisplayStartComparator(.a(x), .b(HSS), .gte(hDS));
	comparator#(10) hDisplayEndComparator(.a(x), .b(HSE), .lt(hDE));
	
	comparator#(10) vDisplayStartComparator(.a(y), .b(VSS), .gte(vDS));
	comparator#(10) vDisplayEndComparator(.a(y), .b(VSE), .lt(vDE));
	
	
	
	
	 
	 
	 
	 assign r = datain[23:16];
	 assign g = datain[15:8];
	 assign b = datain[7:0];
	 assign dir = 32'd0;
	 
endmodule

