module processor #(parameter bus = 32) 
(input logic clk, rst, input logic [1:0] inst, memdatain, output logic [bus-1:0] pc_out, memdataout, memdir, output logic MRE, MWE);

	
	//instruction data
	logic [3:0] cond;
	logic [1:0] op;
	logic [5:0] funct;
	logic [3:0] rn, rd;
	logic [23:0] imm24;
	logic [11:0] imm12;
	
	//src2 data processing types
	
	logic [3:0] rot;
	logic [7:0] imm8;
	
	//register shift
	
	logic [4:0] shamt5;
	logic [1:0] sh;
	logic [3:0] rm, rs;
	logic shift_type;
	
	//assign variables
	
	//assign instruction data
	
	assign cond = inst[31:28];
	assign op = inst[27:26];
	assign funct = inst[25:20]
	assign rn = inst[19:16]
	assign rd = inst[15:12]
	assign imm24 = inst[23:0]
	assign imm12 = inst[11:0]
	
	//assign src2 data processing types
	
	assign rot = inst[11:8]
	assign imm8 = inst[7:0]
	
	//assign register shift
	assign shamt5 = inst[11:7]
	assign sh = inst[6:5]
	assign rm = inst[3:0]
	assign rs = inst[11:8]
	assign shift_type = inst[4]
	
	
	logic [bus-1:0] pcdir;
	
	//Control flags
	logic [1:0] SELSHIFTER;
	logic SELSHIFT,CPSR_WE, SELOPERANDB, WE, RE, CSEL, MEM_OP_TYPE,MEM_MODIF;
	logic [3:0] ALUFUN;
	logic [1:0] SHIFTFUN;
	logic ROTTYPE, SELBL, SELDESTPC, SELPC, SELBRANCHDIR;
	logic [1:0] SELWB;
	
	//ALU Data
	logic[bus-1:0] operanda,operandb, aluout;
	logic[3:0] CNVZI,CNVZO;
	
	CPSR #(4) _cpsr (CNVZO, clk, CSPR_WE, CNVZI);
	
	//RegisterBank data
	logic[3:0] da,db, dc,wdir;
	logic[bus-1:0] pc_in,wbdata;
	logic[bus-1:0] rega,regb,regc;
	
	//Assign RegisterBank data
	assign da = rn;
	assign db = rm;
	
	RegisterBank #(bus) _regbank(da,db,dc,wdir,wbdata,pc_in,clk,WE,RE, rega,regb,regc,pcdir);	
	Muxr #(4) MUX_DEST(rs,rd,CSEL,dc);
	
	/*
	Decode 
	*/
	logic [bus-1:0] shamt5ext,rotext,imm12ext,imm24ext,imm8ext;
	ZeroExtension #(bus, 4)  _rotext(rot,rotext);
	ZeroExtension #(bus, 5)  _shamt5ext(shamt5,shamt5ext);
	ZeroExtension #(bus, 8)  _imm8ext(imm8,imm8ext);
	SignExtension #(bus, 12) _imm12ext(imm12,imm12ext);
	SignExtension #(bus, 24) _imm24ext(imm24,imm24ext);
	
	logic [bus-1:0] shift_operand;
	logic [bus-1:0] shifter_operand,rotextshifted;
	logic [bus-1:0] shifted_operand;

	Muxr #(bus) MUX_SHIFT(regb,imm8ext,SELSHIFT,shift_operand);
	SimplestShift #(bus) _simplestshift(rotext, rotextshifted);
	Muxr4 #(bus) MUX_SHIFTER(shamt5ext,regc,rotextshifted,rotextshifted,SELSHIFTER,shifter_operand);
	ShiftRotationUnit #(bus) _shift_unit(shift_operand, shifter_operand, ROTTYPE, SHIFTFUN, shifted_operand);
	Muxr #(bus) MUX_OPERAND_B(imm12ext,shifted_operand,SELOPERANDB,operandb);
	
	/*
	Execution
	*/
	
	
	assign operanda = rega;
	ALU #(bus) _alu(operanda,operandb,ALUFUN,CNVZI,aluout,CNVZO);
	logic [bus-1:0] word, modified_word;
	Muxr #(bus) MUX_STR_LDR(regc,memdatain,MEM_OP_TYPE,word);
	BHWord #(bus) _bhword(word, MEM_MODIF,modified_word);
	

	/*
	Fetch
	*/
	
	logic [bus-1:0] fourext,eightext, pctmp,pc_offset,branch_offset, branch;
	Aligner #(bus) _aligner(imm24ext,branch);
	logic pc_carryout,branch_carryout;
	ZeroExtension #(bus, 3) next_line(3'b100,fourext);
	//A FIX: CHANGE 8 -> 0
	ZeroExtension #(bus, 4) _branch_next_line(4'b1000,eightext);
	
	
	/*
	Branch
	*/
	
	Muxr #(bus) MUX_BRANCH_PC(fourext,branch_offset,SELBRANCHDIR,pc_offset);
	assign pc_out = pc_in;
	Adder #(bus) _branch_next_instruction(branch,eightext,0,branch_offset,branch_carryout);
	Adder #(bus) _next_instruction(pcdir,pc_offset,0,pctmp,pc_carryout);

	/*
	Memory
	*/
	assign memdataout = modified_word;
	assign memdir = aluout;
	
	/*
	WriteBack
	*/
	logic [bus-1:0] calculated_pc_dir;
	logic [bus-1:0] pc_reset;
	
	Muxr #(bus) MUX_OBTAINED_PC(aluout,modified_word,SELDESTPC,calculated_pc_dir);
	Muxr4 #(bus) MUX_WRITEBACK(aluout, operandb, modified_word, pcdir, SELWB, wbdata);
	
	//
	//INSTRUCTION BRANCH
	//
	
	//LR: the 14th register, used by the function branch and link (BL)
	logic [3:0] LR;
	assign LR = 4'b1110;
	
	Muxr #(bus) MUX_PC_OUT(pctmp,calculated_pc_dir,SELPC,pc_reset);
	Muxr #(bus) MUX_PC_RESET(pc_reset,32'd0,reset,pc_in);		
	Muxr #(4) MUX_BRANCH_DEST(rd,LR,SELBL,wdir);
	
	Unitcontrol #(bus) _unitcontrol(reset,sh,CNVZI, shift_type, cond, funct, op, rd, shamt5,
	 SELSHIFTER, SELSHIFT,CPSR_WE, SELOPERANDB, WE, RE, CSEL, MEM_OP_TYPE,MEM_MODIF, ALUFUN, SHIFTFUN,
	 ROTTYPE, MRE, MWE, SELBL, SELDESTPC, SELPC, SELBRANCHDIR, SELWB);
	
endmodule
