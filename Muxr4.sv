module Muxr4 #(parameter bus = 32) (input logic [bus-1:0] a,b,c,d,input[1:0] sel,output logic [bus-1:0] s);

	logic [bus-1:0] tmp1,tmp2;
	assign tmp1 = sel[0]?d:c;
	assign tmp2 = sel[0]?b:a;
	assign s = sel[1]? tmp1:tmp2;
	
endmodule

