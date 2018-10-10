module ALUController #(parameter bus = 32) (input logic [3:0] ALUFUN,output logic selrev,selc1,selc,output logic [1:0]selop,output logic selmov,selnot,selc3);

	logic A,B,C,D;
	
	assign A = ALUFUN[3];
	assign B = ALUFUN[2];
	assign C = ALUFUN[1];
	assign D = ALUFUN[0];
	
	//assign selrev = (~A | B) & C & D ;
	//selrev changed: te correct way is:
	assign selrev = ~A & C & D ;
	
	assign selc1 = C & ( ~A | ~D | B);
	
	assign selmov = A & B & ~C & D;
	
	assign selnot = A & B & C & D;
	
	assign selc3 = ~A & B & C;
	
	assign selc = A & B & (C | D );
	assign selop[0] = (~B & C) | (B & (~A | ~D));
	assign selop[1] = (~B & (D | C)) | (~A & B);

endmodule

