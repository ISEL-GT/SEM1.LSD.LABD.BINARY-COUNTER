library ieee;
use ieee.std_logic_1164.all;


-- This entity is responsible for acting as a binary counter, displaying the output in
-- a 7 segment display
entity binary_counter is

	port (
		dataIn : in std_logic_vector(3 downto 0);
		PL     : in std_logic;
		CE 	 : in std_logic;
		CLK 	 : in std_logic;
		Clear  : in std_logic;
		
		reset : in std_logic;
		
		count_value : out std_logic_vector(3 downto 0);
		int7seg     : out std_logic_vector(7 downto 0);
		TC          : out std_logic
	);

end binary_counter;


architecture behavioral of binary_counter is

	-- Imports the counter's main logic
	component counter
	
		port (
        c_in       : in  std_logic_vector(3 downto 0);   
        reset      : in  std_logic;                       
        clk_in     : in  std_logic;                        
        clear      : in  std_logic;                        
        pl         : in  std_logic;                        
        ce         : in  std_logic;                       
        
		  q : out std_logic_vector(3 downto 0)
		);
		
	end component;
	
	
	-- Imports the 7 segment display decoder
	component decoder7segment
	
		port (
        d    : in  std_logic_vector(3 downto 0);
        dout : out std_logic_vector(7 downto 0)
		);
		
	end component;
	
	
	-- Imports the clock system
	component clock
	
		generic (
        div : natural := 50000000
		);
		
		port (
        clk_in  : in  std_logic;
        clk_out : out std_logic
		);
		
	end component;
	
	-- A signal to store the value of the "count_value" output from the counter
	signal clock_output : std_logic;
	signal counter_output : std_logic_vector(3 downto 0);
	
begin

	-- Instantiates the clock 
	instance_clock : clock
		
		port map (
			clk_in  => CLK,
         clk_out => clock_output
		);

		
	-- Instantiates the actual conter
	instance_counter : counter
	
		port map (
			c_in   => dataIn,
			reset  => reset,
			clk_in => clock_output,
			clear  => Clear,
			pl     => PL,
			ce     => CE,		
		
			q => counter_output
		);
		
		
	instance_decoder7segment : decoder7segment
	
		port map (
			d => counter_output,
			dout => int7seg
		);
		
	count_value <= counter_output;
	TC <= '1' when counter_output = "0000" else '0';
		
	
end behavioral;
	

	
	