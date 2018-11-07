	module vgaController #(parameter HACTIVE = 10'd635,
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
											VMAX    = VSYN + VBP + VACTIVE + VFP)
	(input logic i_clk, i_rst,
	output logic o_hs, o_vs, o_sync_n, o_blank_n,
	output logic [9:0] o_x, o_y); 	
	
	logic hRstF, vRstF, hDS, hDE, vDS, vDE = 0;
	
	logic [9:0] hCnt, vCnt;
	
	//	Pixel Counter
	counter#(10) horizontalPixelCounter(i_clk, (i_rst | hRstF), 1, hCnt);
	counter#(10) VerticalPixelCounter(i_clk, (i_rst | hRstF & vRstF), hRstF, vCnt);
	
	//	Max Line Comparator
	comparator#(10) hMaxComparator(.a(hCnt), .b(HMAX - 1), .gte(hRstF));
	comparator#(10) vMaxComparator(.a(vCnt), .b(VMAX - 1), .gte(vRstF));
	
	//	Sync Signals (Low Active)
	comparator#(10) hSSComparator(.a(hCnt), .b(HSYN), .gte(o_hs));
	comparator#(10) vSEComparator(.a(vCnt), .b(VSYN), .gte(o_vs));
	
	//	Blank Comparator
	comparator#(10) hDisplayStartComparator(.a(hCnt), .b(HSS), .gte(hDS));
	comparator#(10) hDisplayEndComparator(.a(hCnt), .b(HSE), .lt(hDE));
	
	comparator#(10) vDisplayStartComparator(.a(vCnt), .b(VSS), .gte(vDS));
	comparator#(10) vDisplayEndComparator(.a(vCnt), .b(VSE), .lt(vDE));
	
	assign o_sync_n = 1;//o_hs & o_vs;
	
	assign o_blank_n = hDS & hDE & vDS & vDE;
	
   assign o_x = hCnt;
   assign o_y = vCnt;
	
endmodule
