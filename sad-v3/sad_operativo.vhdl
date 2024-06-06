LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sad_operativo IS
	generic(B : integer := 8);
	PORT (
		
		clk : IN STD_LOGIC; -- ck
		sample_ori : IN STD_LOGIC_VECTOR (B-1 DOWNTO 0); -- Mem_A[end]
		sample_can : IN STD_LOGIC_VECTOR (B-1 DOWNTO 0); -- Mem_B[end]
		address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- end
		sad_value : OUT STD_LOGIC_VECTOR (13 DOWNTO 0); --sad
		zi: IN STD_LOGIC;
		ci: IN STD_LOGIC;
		pApB: IN STD_LOGIC;
		ZSOMA: IN STD_LOGIC;
		CSOMA: IN STD_LOGIC;
		CSAD_reg: IN STD_LOGIC;
		menor: OUT STD_LOGIC
		);
end sad_operativo;

architecture arch of sad_operativo is

signal Ssoma4: STD_LOGIC_VECTOR (3 DOWNTO 0);
signal Sout_reg_i, Sout_mux5 : STD_LOGIC_VECTOR (4 DOWNTO 0);
signal SsubA0, SsubB0, SsubA1, SsubB1, SsubA2, SsubB2, SsubA3, SsubB3, Ssubout0, Ssubout1, Ssubout2, Ssubout3, Sout_somador01, Sout_somador02 : STD_LOGIC_VECTOR (7 DOWNTO 0);
signal Sout_somador9 : STD_LOGIC_VECTOR (8 DOWNTO 0);
signal somaB14, Sout_regsoma_14, Sout_somador_14, Sout_mux_14 : STD_LOGIC_VECTOR (13 DOWNTO 0);
signal Scout4, Scout9, Scout01, Scout02  : STD_LOGIC;

begin

mux2para1_5 : entity work.mux2para1
	GENERIC MAP (N => 5)
	PORT MAP(
		a => Scout4 & Ssoma4,
		b => "00000",
		sel => zi,
		y => Sout_mux5
	);
	
somador_4 : entity work.somador
	GENERIC MAP (N => 4)
	port MAP(
		A => Sout_reg_i (3 downto 0),
		B => "0001",
		S => Ssoma4,
		cout => Scout4
	);

reg_i : entity work.registrador 
	GENERIC MAP(N => 5)
	port MAP(
    D => Sout_mux5,
	 Reset => '0',
    Enable => ci,
    CLK => clk,
    Q => Sout_reg_i
	 );
	 
reg_pA0 : entity work.registrador 
	GENERIC MAP(N => 8)
	port MAP(
    D => sample_ori (7 downto 0),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubA0
	 );
	 
reg_pA1 : entity work.registrador 
	GENERIC MAP(N => 8)
	port MAP(
    D => sample_ori (15 downto 8),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubA1
	 );
	 
reg_pA2 : entity work.registrador 
	GENERIC MAP(N => 8)
	port MAP(
    D => sample_ori (23 downto 16),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubA2
	 );
	 
reg_pA3 : entity work.registrador 
	GENERIC MAP(N => 8)
	port MAP(
    D => sample_ori (31 downto 24),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubA3
	 );
	
reg_pB0 : entity work.registrador
	GENERIC MAP(N => 8)
	port MAP (
    D => sample_can (7 downto 0),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubB0
	 );
	 
reg_pB1 : entity work.registrador
	GENERIC MAP(N => 8)
	port MAP (
    D => sample_can (15 downto 8),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubB1
	 );
	 
reg_pB2 : entity work.registrador
	GENERIC MAP(N => 8)
	port MAP (
    D => sample_can (23 downto 16),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubB2
	 );
	 
reg_pB3 : entity work.registrador
	GENERIC MAP(N => 8)
	port MAP (
    D => sample_can (31 downto 24),
	 Reset => '0',
    Enable => pApB,
    CLK => clk,
    Q => SsubB3
	 );
	 	 
subtrator0 : entity work.subtractor
	generic MAP(N => 8)
	port MAP(
		a => SsubA0,
		b => SsubB0,
		s =>Ssubout0
	);

subtrator1 : entity work.subtractor
	generic MAP(N => 8)
	port MAP(
		a => SsubA1,
		b => SsubB1,
		s =>Ssubout1
	);
	
subtrator2 : entity work.subtractor
	generic MAP(N => 8)
	port MAP(
		a => SsubA2,
		b => SsubB2,
		s =>Ssubout2
	);
	
subtrator3 : entity work.subtractor
	generic MAP(N => 8)
	port MAP(
		a => SsubA3,
		b => SsubB3,
		s =>Ssubout3
	);

somador01_8 : entity work.somador
	GENERIC MAP (N => 8)
	port MAP(
		A => Ssubout0,
		B => Ssubout1,
		S => Sout_somador01,
		cout => Scout01
	);

somador02_8 : entity work.somador
	GENERIC MAP (N => 8)
	port MAP(
		A => Ssubout2,
		B => Ssubout3,
		S => Sout_somador02,
		cout => Scout02
	);
	
somador_9 : entity work.somador
	GENERIC MAP (N => 9)
	port MAP(
		A => Scout01 & Sout_somador01,
		B => Scout02 & Sout_somador02,
		S => Sout_somador9,
		cout => Scout9
	);
	
somador_14 : entity work.somador
	GENERIC MAP (N => 14)
	port MAP(
		A => Sout_regsoma_14,
		B => "0000" & Scout9 & Sout_somador9,
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

menor <= not Sout_reg_i(4);
address <= Sout_reg_i (3 downto 0);

END architecture;		
		
