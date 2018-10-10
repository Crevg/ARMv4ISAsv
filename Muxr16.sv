module Muxr16 #(parameter bus = 32) (input logic [bus-1:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,input[3:0] sel,output logic [bus-1:0] s);
	always @*
	case (sel) 
	4'b0000:
		s = a;
	4'b0001:
		s = b;
	4'b0010:
		s = c;
	4'b0011:
		s = d;
	4'b0100:
		s = e;
	4'b0101:
		s = f;
	4'b0110:
		s = g;
	4'b0111:
		s = h;
		
	4'b1000:
		s = i;
	4'b1001:
		s = j;
	4'b1010:
		s = k;
	4'b1011:
		s = l;
	4'b1100:
		s = m;
	4'b1101:
		s = n;
	4'b1110:
		s = o;
	4'b1111:
		s = p;
		
		
	endcase

endmodule
