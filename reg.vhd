LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg IS
PORT(	
		CLK 				: in std_logic;
		RESET				: in std_logic;
		SET 				: in std_logic;
		D 					: in std_logic_vector(3 downto 0);
		EN					: in std_logic;
		Q_4bits			: out std_logic_vector(3 downto 0)
	);
END reg;

ARCHITECTURE behavioral of reg is

	component FFD is
      
	PORT(
		CLK 				: in std_logic;
		RESET 			: in STD_LOGIC;
		SET 				: in std_logic;
		D 					: IN STD_LOGIC;			
		EN 				: IN STD_LOGIC;
		Q 					: out std_logic
	);
	end component;
		
begin

	FFD1: FFD port map (CLK => CLK, RESET => RESET, SET => SET, EN => EN, D => D(0), Q => Q_4bits(0));
	FFD2: FFD port map (CLK => CLK, RESET => RESET, SET => SET, EN => EN, D => D(1), Q => Q_4bits(1));
	FFD3: FFD port map (CLK => CLK, RESET => RESET, SET => SET, EN => EN, D => D(2), Q => Q_4bits(2));
	FFD4: FFD port map (CLK => CLK, RESET => RESET, SET => SET, EN => EN, D => D(3), Q => Q_4bits(3));
	
end behavioral;
