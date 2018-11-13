module topKeyboard(input logic CLK, PS2_DATA, PS2_CLK, output logic [6:0] Seven, Seven2);

   logic  [4:0] valorActual;
	logic write = 0; //indica si se toco una tecla o no
	logic [3:0] valorAnteriorValido;
	Keyboard k (CLK, PS2_CLK, PS2_DATA, valorActual, Seven, write);
	SevenSegments (ultimaTecla, Seven2);
	
	always @ (posedge CLK) begin
	
	if (write == 1) begin //acaba de tocar una tecla
		valorAnteriorValido <= valorActual; //esto lee la tecla desde un teclado
	end
	end

endmodule
