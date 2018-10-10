module Muxr #(parameter bus = 32) (input logic [bus-1:0] a,b,input sel,output logic [bus-1:0] s);


	assign s = sel? b:a;

endmodule

