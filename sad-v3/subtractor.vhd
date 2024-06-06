library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity subtractor is
	generic (N : positive := 8);
	port (
		a : in  std_logic_vector(N-1 downto 0);
		b : in  std_logic_vector(N-1 downto 0);
		s : out std_logic_vector(N-1 downto 0)
	);
end entity ;

architecture beh of subtractor is
	signal diff : std_logic_vector (N-1 downto 0);
	begin
		diff <= a-b;
		s <= diff when a >= b
		else (b-a);
end architecture ;