library ieee;
use ieee.std_logic_1164.all;

-- This entity is responsible for acting as a full adder, using two half-adders
-- in succession to account for first bit carries
entity full_adder is 

	port (
		A : in std_logic;
		B : in std_logic;
		
		carry_in  : in std_logic;
		carry_out : out std_logic;
		
		result : out std_logic
	);
	
end full_adder;


architecture behavioral of full_adder is

	
	-- Imports the half adder from the specification in the half_adder entity
	component half_adder
	
		port (
			A : in std_logic;
			B : in std_logic;
		
			result 	  : out std_logic;
			carry_out  : out std_logic
		);
		
	end component;
	
	-- Initialises the result carriers for the half-adders
	signal out_half_adder_1 : std_logic;
	signal out_half_adder_2 : std_logic; 
	
	signal carry_half_adder_1 : std_logic;
	signal carry_half_adder_2 : std_logic;
			

begin

	-- Instantiate the first half adder with the full adder's A and B
	instance_half_adder_1 : half_adder
	
		port map (
			A => A,
			B => B,
			
			result => out_half_adder_1,
			carry_out => carry_half_adder_1
		);
		
		
	-- Instantiate the second half adder with the first half adder's result and
	-- carry, to account for the bit carry
	instance_half_adder_2: half_adder
	
		port map (
			A => out_half_adder_1,
			B => carry_in,
			
			result => out_half_adder_2,
			carry_out => carry_half_adder_2
		);
		
	
	result <= out_half_adder_2;
	carry_out <= (carry_half_adder_1 or carry_half_adder_2);
	

end behavioral;


