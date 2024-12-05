library ieee;
use ieee.std_logic_1164.all;

-- This entity is responsible for acting as a half adder, simply XOR'ing two
-- to sum them returning their value and carry.
entity half_adder is 

	port (
		A : in std_logic;
		B : in std_logic;
		
		result     : out std_logic;
		carry_out  : out std_logic
	);
	
end half_adder;


architecture structural of half_adder is
begin

	result 	  <= A xor B;
	carry_out  <= A and B;

end structural;	