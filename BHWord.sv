module BHWord #(parameter bus = 32) (input logic [bus-1:0] word, input logic MEM_MODIF,output logic [bus-1:0] modified_word);

	assign modified_word = word;

endmodule

