library ieee;
use ieee.std_logic_1164.all;

-- Entity for a hexadecimal decoder
entity hex_decoder is

    port (
        A     : in  std_logic_vector(3 downto 0); -- 4-bit input
        clear : in  std_logic;                    -- Clear signal (active high)
        hex0  : out std_logic_vector(7 downto 0)  -- 7-segment display output
    );
    
end hex_decoder;

-- Architecture for the hexadecimal decoder logic
architecture logicfunction of hex_decoder is

    -- Component declaration for the 7-segment decoder
    component decoder7segment
	 
        port (
            D    : in  std_logic_vector(3 downto 0); -- 4-bit input
            dout : out std_logic_vector(7 downto 0)  -- 7-segment output
        );
		  
    end component;

    -- Internal signal for 7-segment output
    signal hex0t : std_logic_vector(7 downto 0);

begin

    -- Assign output to all high when clear is active, otherwise use the decoded value
    hex0 <= hex0t when clear = '0' else "11111111";

    -- Instantiate the 7-segment decoder
    u0 : decoder7seg 
        port map (
            D    => A,
            dout => hex0t
        );

end logicfunction;
