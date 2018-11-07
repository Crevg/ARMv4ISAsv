module comparator_tb;
	logic [9:0] a, b;
	
	logic eq;
	
	initial begin
		 a = 10'b0;
		 b = 10'd6;
	end
	comparator#(10) co0(a, b, eq);

	endmodule
