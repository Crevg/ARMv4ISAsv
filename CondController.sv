module CondController(input logic [3:0] CNVZI, sel, output logic s);


	logic C,N,V,Z;
	
	assign C = CNVZI[3];
	assign N = CNVZI[2];
	assign V = CNVZI[1];
	assign Z = CNVZI[0];
	
	logic EQ,NE,CS,CC,MI,PL,VS,VC,HI,LS,GE,LT,GT,LE,AL;
	
	assign EQ = Z;
	assign NE = ~Z;
	assign CS = C;
	assign CC = ~C;
	assign MI = N;
	assign PL = ~N;
	assign VS = V;
	assign VC = ~V;
	assign HI = NE & CS;
	assign LS = EQ | CC;
	assign GE = ~LT;
	assign LT = N^V;
	assign GT = GE & NE;
	assign LE = ~GT;
	assign AL = 1;
	

	Muxr16 #(1) _flagselector(EQ,NE,CS,CC,MI,PL,VS,VC,HI,LS,GE,LT,GT,LE,AL,AL,sel,s);


endmodule
