library ieee;
use ieee.std_logic_1164.all;

entity counter is
	port(
		C_in			: in std_logic_vector(3 downto 0);	-- Input of Data for the counter down 
		RESET			: in std_logic;							--	Input of Reset -> Reset input for the simulation
		CLK_In		: in std_logic;							-- Input of Clock	-> A sinal of clock to generate next states
		Clear			: in std_logic;							-- Input of Clear -> When active makes the display of 7 segments inactive
		PL				: in std_logic;							-- Parallel load 	-> the sincronate input that when active, makes the counter fill with the dataIn input
		CE				: in std_logic;							-- Count Enable 	-> When active, counts in the decrescent mode
		
		CountValue	: out std_logic_vector(3 downto 0); -- Count the values
		int7seg		: out std_logic_vector(7 downto 0); -- display with 7 segment -> 15..0 with 1 bit per segment with the order of {F E D C B A 9 8 7 6 5 4 3 2 1 0}
		TC				: out std_logic
		);
end ;	


architecture behavioral of counter is
	
	-- Imports the full adder from the specification in the full_adder entity
	component adder	
	
		port (
				A : in std_logic_vector(3 downto 0);
				B : in std_logic_vector(3 downto 0);
		
				carry_in  : in std_logic;
				carry_out : out std_logic;
		
				result : out std_logic_vector(3 downto 0)
		);
		
	end component;
	
	-- Import the two inputs MUX
	component mux_2inputs
	
		port (
			A : in std_logic_vector(3 downto 0);
			B : in std_logic_vector(3 downto 0); 

			selector : in std_logic;

			result : out std_logic_vector (3 downto 0) 
		);
		
	end component;
	
		-- Imports the register 
	component reg
	
		port (	
			CLK 				: in std_logic;
			RESET				: in std_logic;
			SET 				: in std_logic;
			D 					: in std_logic_vector(3 downto 0);
			EN					: in std_logic;
			
			Q_4bits			: out std_logic_vector(3 downto 0)
		);
	end component;
	
	
	
	signal out_mux_ce : std_logic_vector(3 downto 0);
	signal out_reg : std_logic_vector(3 downto 0);
	signal result_full_adder : std_logic_vector(3 downto 0);
	signal dataIn : std_logic_vector(3 downto 0);
	
	
begin




	-- Instantiates the 2 inputs MUX 
	instance_mux_ce : mux_2inputs 
	
		port map (
			A => "0000",
			B => "1111",
			selector => CE,
			
			result => out_mux_ce
		);
		
	-- Instantiates the full_adder to perform math operations
	instance_full_adder : full_adder
	
		port map (
			A => out_reg,
			B => out_mux_ce,
		
			carry_in => "0",
			
			result   => result_full_adder
		);

	
	-- Instantiates the 2 inputs MUX 
	instance_mux_PL : mux_2inputs 
	
		port map (
			A => result_full_adder,
			B => C_in,
			selector => PL,
			
			result => dataIn
		);
		
	-- Instantiates the register
	instance_reg : reg 
	
		port map(	
		CLK 		=>		CLK,	
		RESET		=>		'0',	
		SET 		=>		'0',	
		D 			=>		dataIn,
		EN			=>		'1',	
		Q_4bits	=>		out_reg	
		);

	
			
end behavioral;
	


