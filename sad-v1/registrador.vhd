library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity registrador is 
	GENERIC (N : POSITIVE := 8);
	port (
    D     : in  std_logic_vector(N-1 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(N-1 downto 0));
end registrador;
        
architecture arch of registrador is
    begin
    process(CLK,reset)
    begin
        if(reset = '1') then
            q <= (others => '0');
        elsif(enable = '1') then
            if (rising_edge(CLK)) then
    				q <= d;		
            end if;
        end if;
    end process;
end arch;