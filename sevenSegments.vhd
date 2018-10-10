library IEEE; use IEEE.STD_LOGIC_1164.all;

entity sevenSegments is
	port(A: in STD_LOGIC_VECTOR(3 downto 0);
		  Output: out STD_LOGIC_VECTOR(6 downto 0));
end;

architecture synth of sevenSegments is
	signal temp: STD_LOGIC_VECTOR(6 downto 0);

begin
	temp <= "1111110" when A = "0000" else -- 0
				"0110000" when A = "0001" else -- 1
				"1101101" when A = "0010" else -- 2
				"1111001" when A = "0011" else -- 3
				"0110011" when A = "0100" else -- 4 
				"1011011" when A = "0101" else -- 5
				"1011111" when A = "0110" else -- 6
				"1110000" when A = "0111" else -- 7
				"1111111" when A = "1000" else -- 8
				"1111011" when A = "1001" else -- 9
				"1110111" when A = "1010" else -- A
				"0011111" when A = "1011" else -- B
				"1001110" when A = "1100" else -- C
				"0111101" when A = "1101" else -- D
				"1001111" when A = "1110" else -- E
				"1000111" when A = "1111"; -- F
	
	Output <= not temp;
end;

