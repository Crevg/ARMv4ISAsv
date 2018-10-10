module SignExtension #(parameter bus = 32, parameter inputsize = 1) (input logic [inputsize-1:0]a,output logic [bus-1:0] s);

	logic[bus-1-inputsize:0] concat;
	logic zero;
	assign zero = a[inputsize-1];
	
	multiout #(bus-inputsize) _ext(zero,concat);
	
	assign s = {concat,a};

endmodule

