module Unitcontrol #(parameter bus = 4) 
	(
	input logic reset,
	input logic [1:0] sh,
	input logic [1:0] CNVZI,
	//instruction[4]
	input logic shift_type,
	input logic [3:0] cond,
	input logic [5:0] funct,
	input logic [1:0] op,
	input logic [3:0] rd, 
	input logic [4:0] shamt5,
	output logic [1:0]
		//decode flag
		SELSHIFTER,
	output logic
		//decode flags
		SELSHIFT,CPSR_WE,
		SELOPERANDB,
		//register and decode flags
		WE, RE, CSEL,
		//execution flags
		MEM_OP_TYPE,MEM_MODIF,
	output logic [3:0]
		//execution flag
		ALUFUN,
	output logic [1:0]
		//execution flag
		SHIFTFUN,
	output logic
		//execution flag
		ROTTYPE,
		//memory flags
		MRE, MWE,
		//writeback flags
		SELBL,
		SELDESTPC,
		SELPC,
		SELBRANCHDIR,
	output logic [1:0]	
		SELWB 
		);
		
		
		logic L_branch_instruction;
		
		logic I_data_processing;
		assign I_data_processing = funct[5];		
		
		
		//shift flags
		assign SELSHIFTER[0] = ~op[0] & (I_data_processing | shift_type);
		assign SELSHIFTER[1] = ~op[0] & I_data_processing;
		
		
		assign SELSHIFT = SELSHIFTER[1];
		assign ROTTYPE = | shamt5;
		
		
		//assign SHIFTFUN = sh;
		//FIX: imm8 function aren't detected
		assign SHIFTFUN[1] = (sh[1] & ~I_data_processing)  | (~op[1] & ~op[0] & I_data_processing);
 		assign SHIFTFUN[0] = (sh[0] & ~I_data_processing)  | (~op[1] & ~op[0] & I_data_processing);
 		
		
		//operand b flag
		
		logic I_mem_instruction;
		assign I_mem_instruction = funct[5];
		
		assign SELOPERANDB = ~(op[0] & ~I_mem_instruction);
		
		
		//ALU FLAGS
		logic [1:0] ALUOP;
		logic U_mem_instruction;
		assign U_mem_instruction = funct[3];
		assign ALUOP[1] = op[0];
		assign ALUOP[0] = U_mem_instruction;
		
		Muxr4 #(4) _alufunction(funct[4:1],funct[4:1],4'b0010,4'b0100, ALUOP,ALUFUN);
		
		//source/dest memory operation
		
		//destiny
		assign CSEL = op[0];
		
		//source/destiny
		logic L_mem_instruction;
		assign L_mem_instruction = funct[0];
		assign MEM_OP_TYPE = L_mem_instruction;
		
		logic B_mem_instruction;
		assign B_mem_instruction = funct[2];
		assign MEM_MODIF = B_mem_instruction;
		
		//writeback
		
		//assign SELWB[1] = op[0];
		//assign SELWB[0] = ~op[0] & funct[4] & funct[3] & ~funct[2] & funct[1] & ~I_data_processing;
		
		//Fix: LR wasn't saving correctly
		assign SELWB[1] = op[1] & L_branch_instruction;
		assign SELWB[0] = (~op[0] & funct[4] & funct[3] & ~funct[2] & funct[1] & ~I_data_processing & ~op[0]) | SELWB[1];
		
		
		//¿RD == PC ?
		logic is_RD_equal_to_PC;
		assign is_RD_equal_to_PC = & rd;
	
		
		//SELBL
		assign L_branch_instruction = funct[4];
		assign SELBL = op[1] & L_branch_instruction;
		
		//Register bank flags
		logic condflag;
		CondController _cond_controller(CNVZI,cond,condflag);
		
		assign RE = ~op[1];
		//assign WE = ((~op[0] & ~is_RD_equal_to_PC & condflag) & (~op[1] | L_mem_instruction)) | SELBL;
		//FIX: WE for STR function
		assign WE = (((~op[1] & ~op[0] & ~is_RD_equal_to_PC & condflag) | (~op[1] & op[0] & L_mem_instruction & ~is_RD_equal_to_PC & condflag)) | (SELBL & condflag));
		
		//SEL NEW PC DIRECTION
		assign SELBRANCHDIR = op[1] & condflag;
		
		//memory flags
		
		logic  memop;
		assign memop=  ~op[1] & op[0];
		assign MRE = memop & L_mem_instruction;
		assign MWE = memop & ~L_mem_instruction;
		
		
		//assign SELPC = is_RD_equal_to_PC & condflag;
		//FIX: 
		assign SELPC = ((~op[1] & ~op[0]) | MRE) & is_RD_equal_to_PC & condflag;
		
		assign SELDESTPC = op[0];
		
		
		//write enable of CPSR
		logic S_data_processing;
		assign S_data_processing = funct[0];
		assign CPSR_WE = S_data_processing & ~op[0]& ~op[1];
	
	
endmodule
