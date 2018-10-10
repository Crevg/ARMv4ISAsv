module RotationRight #(parameter bus = 32)
	(input logic [bus-1:0] a, b,output logic [bus-1:0] s);

	
	
	logic [bus-1:0] shift_value;
	assign shift_value = bus - b;
	
	assign s = (a >> b) | (a << shift_value);
	
	
endmodule
