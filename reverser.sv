module reverser #(parameter bus = 32) (input logic [bus-1:0]a,b,input logic sel,output logic [bus-1:0] aout,bout);

	assign bout = sel? a : b;
	assign aout = sel? b : a;

endmodule
