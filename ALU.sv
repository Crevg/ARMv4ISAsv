module ALU #(parameter bus = 4) (input logic [bus-1:0]a,b,input logic [3:0] ALUFUN,CNVZI,output logic [bus-1:0] s,output logic [3:0] CNVZO);


	logic Ci,Ni,Vi,Zi;
	logic Co,No,Vo,Zo;
	
	assign Ci = CNVZI[3];
	//assign Ni = CNVZI[2];
	//assign Vi = CNVZI[1];
	//assign Zi = CNVZI[0];
	
	
	assign CNVZO[3] = Co;
	assign CNVZO[2] = No;
	assign CNVZO[1] = Vo;
	assign CNVZO[0] = Zo;

	//selectors
	logic selrev,selc1,selc,selmov,selnot,selc3;
	logic [1:0] selop;
	
	ALUController #(bus) _alucontroller(ALUFUN,selrev,selc1,selc,selop,selmov,selnot,selc3);
	
	
	logic [bus-1:0] first_and_operand;
	logic [bus-1:0] andout,orout,xorout, notout, addout,c1out;
	
	logic [bus-1:0] reva,revb;
	
	Muxr #(bus) _muxand(a,b,selmov,first_and_operand);
	
	Andr #(bus) _and(first_and_operand,b,andout);
	
	Orr #(bus) _or(a,c1out,orout);
	Eor #(bus) _eor(a,b,xorout);
	
	reverser #(bus) _reverser(a,b,selrev,reva,revb);
	
	logic [bus-1:0] c1flagout;
	multiout #(bus) _c1flag(selc1,c1flagout);
	
	//Nandr #(bus) _c1comp(revb,c1flagout,c1out);
	Eor #(bus) _c1comp(revb,c1flagout,c1out);
	
	logic [bus-1:0] opout;
	Muxr4 #(bus) _muxrop(andout,orout,xorout,addout,selop,opout);
	
	Muxr  #(bus) _muxrout(opout,c1out,selnot,s);
	
	
	logic cout1,cout;
	logic [bus-1:0] sumouttmp,cparamext;
	Adder #(bus) _adder1(reva,c1out,selc1,sumouttmp,cout1);
	Adder #(bus) _adder2(sumouttmp,cparamext,selc,addout,cout);
	
	logic [bus-1:0] zeroext;
	logic third_add_operand;
	
	Muxr  #(1) _muxradd_third_operand(0,Ci,selc3,third_add_operand);
	
	
	ZeroExtension #(bus,1) _ext(third_add_operand,zeroext);
	
	logic [bus-1:0] c1flagout2;
	multiout #(bus) _c1flag2(selc3,c1flagout2);
	
	//Nandr #(bus) _c1comp2(zeroext,c1flagout2,cparamext);
	Eor #(bus) _c1comp2(zeroext,c1flagout2,cparamext);
	
	logic arithmetic_operation;
	assign arithmetic_operation = selop[0]& selop[1];
	
	assign Co = cout & arithmetic_operation;
	assign Zo = ~| s;
	assign No = s[bus-1] & arithmetic_operation;
	
	//verificar implementacion del overflow!
	assign Vo = arithmetic_operation & ~(reva[bus-1] ^ revb[bus-1]) & (reva[bus-1] ^ s[bus-1]) & ~ selc1;

endmodule
