module multiout #(parameter bus = 32) (input logic a,output logic [bus-1:0] s);

	genvar i;
	generate 
		for (i = 0; i < bus; i = i+1) begin:forloop
			assign s[i] = a;
		end
	endgenerate

endmodule
