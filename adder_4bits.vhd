library ieee;
use ieee.std_logic_1164.all;

-- This entity is responsible for taking in two 4-bit integers and adding
-- them together, allowing for a carry in, and a carry out
entity adder_4bits is

	port (
		A : in std_logic_vector(3 downto 0);
		B : in std_logic_vector(3 downto 0);
		
		carry_in  : in std_logic;
		carry_out : out std_logic;
		
		result : out std_logic_vector(3 downto 0)
	);
	
end adder_4bits;


architecture behavioral of adder_4bits is

	-- Imports the full adder from the specification in the full_adder entity
	component full_adder
	
		port (
			A : in std_logic;
			B : in std_logic;
			
			carry_in  : in std_logic;
			carry_out : out std_logic;
			
			result : out std_logic
		);
		
	end component;
	
	
	-- Declares the output and carry variables for the 4 full adders
	signal out_full_adder_1 : std_logic;
	signal out_full_adder_2 : std_logic;
	signal out_full_adder_3 : std_logic;
	signal out_full_adder_4 : std_logic;
	
	signal carry_full_adder_1 : std_logic;
	signal carry_full_adder_2 : std_logic;
	signal carry_full_adder_3 : std_logic;
	signal carry_full_adder_4 : std_logic;
	
begin

	-- Instantiates a full adder with all the default values
	instance_full_adder_1 : full_adder
	
		port map (
			A => A(0),
			B => B(0),
			
			carry_in  => carry_in,
			carry_out => carry_full_adder_1,
			
			result => out_full_adder_1
		);
		
	
	-- Instantiates three more full adders with the previous carries as inputs
	-- and with incremental bit placements for the A and B inputs
	instance_full_adder_2 : full_adder
	
		port map (
			A => A(1),
			B => B(1),
			
			carry_in  => carry_full_adder_1,
			carry_out => carry_full_adder_2,
			
			result => out_full_adder_2
		);
		
	
	instance_full_adder_3 : full_adder
	
		port map (
			A => A(2),
			B => B(2),
			
			carry_in  => carry_full_adder_2,
			carry_out => carry_full_adder_3,
			
			result => out_full_adder_3
		);
		
	
	instance_full_adder_4 : full_adder
	
		port map (
			A => A(3),
			B => B(3),
			
			carry_in  => carry_full_adder_3,
			carry_out => carry_full_adder_4,
			
			result => out_full_adder_4
		);
	
	
	-- Defines the adder/subtractor's carry out as the last full adder's carry
	carry_out <= carry_full_adder_4;
	
	-- Sets the result bits in order
	result(0) <= out_full_adder_1;
	result(1) <= out_full_adder_2;
	result(2) <= out_full_adder_3;
	result(3) <= out_full_adder_4;
	
end behavioral;

	