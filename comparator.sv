module comparator #(parameter N = 8) (
	input  logic [N-1:0] a, b,
	output logic eq, neq, lt, lte, gt, gte);

	always_comb begin
		eq  = (a == b);
		neq = (a != b);
		lt  = (a < b);
		lte = (a <= b);
		gt  = (a > b);
		gte = (a >= b);
	end
endmodule
	