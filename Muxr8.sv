module Muxr8 #(parameter bus = 32) (input logic [bus-1:0] a,b,c,d,e,f,g,h,input[2:0] sel,output logic [bus-1:0] s);
	always @*
	case (sel) 
	3'b000:
		s = a;
	3'b001:
		s = b;
	3'b010:
		s = c;
	3'b011:
		s = d;
	3'b100:
		s = e;
	3'b101:
		s = f;
	3'b110:
		s = g;
	3'b111:
		s = h;
		
	endcase

endmodule
