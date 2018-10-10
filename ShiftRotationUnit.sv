module ShiftRotationUnit #(parameter bus = 32)
	(input logic [bus-1:0] a, b, input logic ROTTYPE, input logic [1:0] SHIFTFUN, output logic [bus-1:0] s);

	
	
	logic [bus-1:0] lsl,lsr,asr,ror,rrx,rot;
	ShiftLeft #(bus) _LSL(a,b,lsl);
	ShiftRight #(bus) _LSR(a,b,lsr);
	ArithmeticShiftRight #(bus) _ASR(a,b,asr);
	RotationRight #(bus) _ROR(a,b,ror);
	RotationRightExtended #(bus) _RRX(a,b,rrx);
	
	
	Muxr #(bus) _rot_select(rrx,ror,ROTTYPE,rot);
	
	
	Muxr4 #(bus) _shift_select(lsl,lsr,asr,rot,SHIFTFUN,s);
	
	
endmodule
