module ALU_tb ();

	logic [3:0]a,b;
	logic [3:0] ALUFUN,CNVZI;
	logic [3:0] s;
	logic [3:0] CNVZO;
	
	
	ALU #(4) dut(a,b,ALUFUN,CNVZI,s,CNVZO);
	
	
	initial begin
	
		//and testing
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b0000;
		CNVZI = 4'b0000;
		#10;
		
		assert(s === 4'b1010)  else $error("1111 AND 1010 != 1010");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 AND 1010: Z != 0");
		
		
		CNVZI = 4'b1111;
		#10;
		
		assert(s === 4'b1010)  else $error("1111 AND 1010 != 1010");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 AND 1010: Z != 0");
				
		a = 4'b0000;
		b = 4'b1010;
		CNVZI = 4'b0000;
		#10;
		
		
		assert(s === 4'b0000) else $error("0000 AND 1010 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 AND 1010: Z == 0");
		
		
		CNVZI = 4'b1111;
		#10;
		
		assert(s === 4'b0000) else $error("0000 AND 1010 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 AND 1010: Z == 0");
		
		
		a = 4'b0101;
		b = 4'b1010;
		CNVZI = 4'b0000;
		#10;
		assert(s === 4'b0000) else $error("0101 AND 1010 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 AND 1010: Z == 0");
		
		
		
		CNVZI = 4'b1111;
		#10;
		
		assert(s === 4'b0000) else $error("0101 AND 1010 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 AND 1010: Z == 0");
		
		
		a = 4'b1111;
		b = 4'b1111;
		CNVZI = 4'b0000;
		#10;
		assert(s === 4'b1111) else $error("1111 AND 1111 != 1111");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 AND 1010: Z != 0");
		
		CNVZI = 4'b1111;
		#10;
		
		
		assert(s === 4'b1111) else $error("1111 AND 1111 != 1111");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 AND 1010: Z != 0");
		
		a = 4'b0000;
		b = 4'b0000;
		CNVZI = 4'b0000;
		#10;
		assert(s === 4'b0000) else $error("0000 AND 0000 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 AND 1010: Z == 0");
		
		CNVZI = 4'b1111;
		#10;
		
		
		assert(s === 4'b0000) else $error("0000 AND 0000 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 AND 1010: Z == 0");
		
		a = 4'b1100;
		b = 4'b1100;
		CNVZI = 4'b0000;
		#10;
		
		assert(s === 4'b1100) else $error("1100 AND 1100 != 1100");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 AND 1010: Z != 0");
		
		
		CNVZI = 4'b1111;
		#10;
		
		assert(s === 4'b1100) else $error("1100 AND 1100 != 1100");
		assert(CNVZO[3] === 0) else $error("In 1111 AND 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 AND 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 AND 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 AND 1010: Z != 0");
		
		
		//eor
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b0001;
		CNVZI = 4'b0000;
		#10;
		
		assert(s === 4'b0101)  else $error("1111 EOR 1010 != 0101");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 EOR 1010: Z != 0");
		
		
		CNVZI = 4'b1111;
		#10;
		
		assert(s === 4'b0101)  else $error("1111 EOR 1010 != 0101");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 EOR 1010: Z != 0");
				
		a = 4'b0000;
		b = 4'b1010;
		CNVZI = 4'b0000;
		#10;
		
		
		assert(s === 4'b1010) else $error("0000 EOR 1010 != 1010");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 EOR 1010: Z != 0");
		
		
		CNVZI = 4'b1111;
		#10;
		
		
		assert(s === 4'b1010) else $error("0000 EOR 1010 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 EOR 1010: Z != 0");
		
		
		a = 4'b0101;
		b = 4'b1010;
		CNVZI = 4'b0000;
		#10;
		assert(s === 4'b1111) else $error("0101 EOR 1010 != 1111");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 EOR 1010: Z != 0");
		
		
		
		CNVZI = 4'b1111;
		#10;
		
		assert(s === 4'b1111) else $error("0101 EOR 1010 != 1111");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 0) else $error("In 1111 EOR 1010: Z != 0");
		
		
		a = 4'b1111;
		b = 4'b1111;
		CNVZI = 4'b0000;
		#10;
		assert(s === 4'b0000) else $error("1111 EOR 1111 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 EOR 1010: Z == 0");
		
		CNVZI = 4'b1111;
		#10;
		
		
		assert(s === 4'b0000) else $error("1111 EOR 1111 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 EOR 1010: Z == 1");
		
		a = 4'b0000;
		b = 4'b0000;
		CNVZI = 4'b0000;
		#10;
		assert(s === 4'b0000) else $error("0000 EOR 0000 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 EOR 1010: Z == 0");
		
		CNVZI = 4'b1111;
		#10;
		
		
		assert(s === 4'b0000) else $error("0000 EOR 0000 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 EOR 1010: Z == 0");
		
		a = 4'b1100;
		b = 4'b1100;
		CNVZI = 4'b0000;
		#10;
		
		assert(s === 4'b0000) else $error("1100 EOR 1100 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 EOR 1010: Z == 0");
		
		
		CNVZI = 4'b1111;
		#10;
		
		assert(s === 4'b0000) else $error("1100 EOR 1100 != 0000");
		assert(CNVZO[3] === 0) else $error("In 1111 EOR 1010: C != 0");
		assert(CNVZO[2] === 0) else $error("In 1111 EOR 1010: N != 0");
		assert(CNVZO[1] === 0) else $error("In 1111 EOR 1010: V != 0");
		assert(CNVZO[0] === 1) else $error("In 1111 EOR 1010: Z == 0");
		
		
		
		//sub
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b0010;
		CNVZI = 4'b0000;
		#10;
		
		
		
		
		//rsb
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b0011;
		CNVZI = 4'b0000;
		#10;
	
		
		//add testing
		a = 4'b0011;
		b = 4'b0001;
		ALUFUN = 4'b0100;
		CNVZI = 4'b0000;
		#10
		
		
		
		//adc
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b0101;
		CNVZI = 4'b0000;
		#10;
		
		//sbc
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b0110;
		CNVZI = 4'b0000;
		#10;
		
		//rsc
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b0111;
		CNVZI = 4'b0000;
		#10;
		
		//tst
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1000;
		CNVZI = 4'b0000;
		#10;
		
		//teq
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1001;
		CNVZI = 4'b0000;
		#10;
		
		
		//cmp
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1010;
		CNVZI = 4'b0000;
		#10;
		
		//cmn
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1011;
		CNVZI = 4'b0000;
		#10;
		
		//orr
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1100;
		CNVZI = 4'b0000;
		#10;
		
		//mov
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1101;
		CNVZI = 4'b0000;
		#10;
		
		//bic
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1110;
		CNVZI = 4'b0000;
		#10;
		
		//mvn
		a = 4'b1111;
		b = 4'b1010;
		ALUFUN = 4'b1111;
		CNVZI = 4'b0000;
		#10;
		
	end
	
	
endmodule

