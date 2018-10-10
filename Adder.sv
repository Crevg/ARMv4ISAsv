module Adder #(bus_size = 4)
	(input logic[bus_size-1:0] a,b,input logic cin,
	output logic[bus_size-1:0] s,output logic carryout);
	
	
	logic[bus_size:0] cout;
	assign cout[0]  = cin;
	assign carryout = cout[bus_size];
	genvar i;
	generate 
		for (i = 0; i < bus_size; i = i+1) begin:forloop
			BitAdder addr(a[i],b[i],cout[i], s[i],cout[i+1]);
		end
	
	endgenerate
	
	
endmodule
