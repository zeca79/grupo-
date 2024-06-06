library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity somador is
	GENERIC (N : POSITIVE := 4);
	port (
		A, B: in std_logic_vector(N-1 downto 0);
		S: out std_logic_vector(N-1 downto 0);
		cout: out std_logic
	);
end somador;

architecture circ of somador is
	signal SA,SB, Soma : STD_LOGIC_VECTOR(N downto 0);
begin
	SA <= '0' & A;
	SB <= '0' & B;	
	Soma <= SA + SB;
	S <= Soma (N-1 downto 0);
	cout <= Soma(N);
	
end circ;