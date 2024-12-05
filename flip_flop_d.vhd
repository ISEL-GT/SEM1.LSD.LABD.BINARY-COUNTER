library ieee;
use ieee.std_logic_1164.all;

-- Entity for the flip-flop with enable, set, and reset functionality
entity flip_flop_d is

    port (
        clk   : in  std_logic;   -- Clock input signal
        reset : in  std_logic;   -- Asynchronous reset input (active high)
        set   : in  std_logic;   -- Set input (active high)
        d     : in  std_logic;   -- Data input
        en    : in  std_logic;   -- Enable input
        q     : out std_logic    -- Data output
    );
    
end flip_flop_d;

-- Architecture for the flip-flop logic
architecture logicfunction of flip_flop_d is
begin

    -- Assign output signal based on priority: reset > set > data with enable
    q <= '0' when reset = '1' else 
         '1' when set = '1' else 
          d when rising_edge(clk) and en = '1';

end logicfunction;
