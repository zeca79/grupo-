LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux2para1 IS
	GENERIC (N : POSITIVE := 7);
	PORT (
		a, b: IN std_logic_vector (N-1 DOWNTO 0);
		sel : IN STD_LOGIC;
		y : OUT std_logic_vector (N-1 DOWNTO 0)
	);
END mux2para1;

ARCHITECTURE arch OF mux2para1 IS
BEGIN
		with sel select
			y <= a when '0',
				  b when '1';
END arch;