module Nandr #(parameter bus = 32) (input logic [bus-1:0]a,b,output logic [bus-1:0] s);

	assign s = ~(a & b);

endmodule
