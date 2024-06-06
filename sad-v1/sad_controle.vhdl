LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sad_controle IS
	PORT (
		clk : IN STD_LOGIC; -- ck
		enable : IN STD_LOGIC; -- iniciar
		reset : IN STD_LOGIC; -- reset
		menor: IN STD_LOGIC;
		read_mem : OUT STD_LOGIC; -- read
		done: OUT STD_LOGIC; -- pronto
		zi: OUT STD_LOGIC;
		ci: OUT STD_LOGIC;
		cpA: OUT STD_LOGIC;
		cpB: OUT STD_LOGIC;
		ZSOMA: OUT STD_LOGIC;
		CSOMA: OUT STD_LOGIC;
		CSAD_reg: OUT STD_LOGIC		
		);	
end sad_controle;

architecture arch of sad_controle is
  type estado is (S0, S1, S2, S3, S4, S5);
  signal EA, PE: estado;
begin

process (clk, reset)
begin
  if reset = '1' then
    EA <= S0;
  elsif (rising_edge(clk)) then
	 EA <= PE;
  end if;
end process;

process (EA, menor, enable )
begin
  case EA is
    when S0 =>
      if enable = '1' then
        PE <= S1;
      else
        PE <= S0;
      end if;
	 when S1 =>
      PE <= S2;
	 when S2 =>
      if menor = '1' then
        PE <= S3;
      else
        PE <= S5;
		end if;
	 when S3 =>
      PE <= S4;
	 when S4 =>
      PE <= S2;
	 when S5 =>
  		PE <= S0;
  end case;
end process;

-- lógica de saída

	done <= '1' WHEN EA = S0 ELSE '0'; -- pronto
	read_mem <= '1' WHEN EA = S3 ELSE '0'; -- read	
	cpA <= '1' WHEN EA = S3 ELSE '0'; 
	cpB <= '1' WHEN EA = S3 ELSE '0'; 
	ZSOMA <= '1' WHEN EA = S1 ELSE '0';
	zi <= '1' WHEN EA = S1 ELSE '0';
	ci <= '1' WHEN EA = S1 OR EA = S4 ELSE '0';
	CSOMA <= '1' WHEN EA = S1 OR EA = S4 ELSE '0';
	CSAD_reg <= '1' WHEN EA = S5 ELSE '0';


end arch;