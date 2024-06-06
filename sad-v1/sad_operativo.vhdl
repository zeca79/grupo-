LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sad_operativo IS
	generic(B : integer := 8);
	PORT (
		
		clk : IN STD_LOGIC; -- ck
		sample_ori : IN STD_LOGIC_VECTOR (B-1 DOWNTO 0); -- Mem_A[end]
		sample_can : IN STD_LOGIC_VECTOR (B-1 DOWNTO 0); -- Mem_B[end]
		address : OUT STD_LOGIC_VECTOR (5 DOWNTO 0); -- end
		sad_value : OUT STD_LOGIC_VECTOR (13 DOWNTO 0); --sad
		zi: IN STD_LOGIC;
		ci: IN STD_LOGIC;
		cpA: IN STD_LOGIC;
		cpB: IN STD_LOGIC;
		ZSOMA: IN STD_LOGIC;
		CSOMA: IN STD_LOGIC;
		CSAD_reg: IN STD_LOGIC;
		menor: OUT STD_LOGIC
		);
end sad_operativo;

architecture arch of sad_operativo is

signal Ssoma6: STD_LOGIC_VECTOR (5 DOWNTO 0);
signal Sout_reg_i, Sout_mux7: STD_LOGIC_VECTOR (6 DOWNTO 0);
signal SsubA, SsubB, Ssubout : STD_LOGIC_VECTOR (7 DOWNTO 0);
signal somaB14, Sout_regsoma_14, Sout_somador_14, Sout_mux_14 : STD_LOGIC_VECTOR (13 DOWNTO 0);
signal Scout6 : STD_LOGIC;

begin

mux2para1_7 : entity work.mux2para1
	GENERIC MAP (N => 7)
	PORT MAP(
		a => Scout6 & Ssoma6,
		b => "0000000",
		sel => zi,
		y => Sout_mux7
	);
	
somador_6 : entity work.somador
	GENERIC MAP (N => 6)
	port MAP(
		A => Sout_reg_i (5 downto 0),
		B => "000001",
		S => Ssoma6,
		cout => Scout6
	);

reg_i : entity work.registrador 
	GENERIC MAP(N => 7)
	port MAP(
    D => Sout_mux7,
	 Reset => '0',
    Enable => ci,
    CLK => clk,
    Q => Sout_reg_i
	 );
	 
reg_pA : entity work.registrador 
	GENERIC MAP(N => 8)
	port MAP(
    D => sample_ori,
	 Reset => '0',
    Enable => cpA,
    CLK => clk,
    Q => SsubA
	 );
	 
reg_pB : entity work.registrador
	GENERIC MAP(N => 8)
	port MAP (
    D => sample_can,
	 Reset => '0',
    Enable => cpB,
    CLK => clk,
    Q => SsubB
	 );
	 
subtrator : entity work.subtractor
	generic MAP(N => 8)
	port MAP(
		a => SsubA,
		b => SsubB,
		s =>Ssubout
	);

somador_14 : entity work.somador
	GENERIC MAP (N => 14)
	port MAP(
		A => Sout_regsoma_14,
		B => somaB14,
		S => Sout_somador_14
	);
	
mux2para1_14 : entity work.mux2para1
	GENERIC MAP (N => 14)
	PORT MAP(
		a => Sout_somador_14,
		b => "00000000000000",
		sel => ZSOMA,
		y => Sout_mux_14
	);
	
reg_soma : entity work.registrador 
	GENERIC MAP(N => 14)
	port MAP (
    D => Sout_mux_14,
	 Reset => '0',
    Enable => CSOMA,
    CLK => clk,
    Q => Sout_regsoma_14
	 );	

SAD_reg : entity work.registrador
	GENERIC MAP(N => 14)
	port MAP (
    D => Sout_regsoma_14,
	 Reset => '0',
    Enable => CSAD_reg,
    CLK => clk,
    Q => sad_value
	 );	

	 
somaB14 <= "000000" & Ssubout;
menor <= not Sout_reg_i(6);
address <= Sout_reg_i (5 downto 0);

END architecture;		
		
