library ieee;
use ieee.std_logic_1164.all;

-- Entity for a 4-bit register implemented using flip-flops
entity registry is

    port (
        clk       : in  std_logic;              -- Clock signal
        reset     : in  std_logic;              -- Asynchronous reset (active high)
        set       : in  std_logic;              -- Set signal (active high)
        d         : in  std_logic_vector(3 downto 0); -- Data input (4-bit)
        en        : in  std_logic;              -- Enable signal
        q_4bits   : out std_logic_vector(3 downto 0)  -- Data output (4-bit)
    );
    
end registry;

-- Architecture implementing the 4-bit register using flip-flops
architecture behavioral of registry is

    -- Component declaration for a single flip-flop
    component flip_flop_d is
        port (
            clk   : in  std_logic;              -- Clock signal
            reset : in  std_logic;              -- Reset signal (active high)
            set   : in  std_logic;              -- Set signal (active high)
            d     : in  std_logic;              -- Data input
            en    : in  std_logic;              -- Enable signal
            q     : out std_logic               -- Data output
        );
    end component;

begin

    -- Instantiate flip-flops for each bit
    ffd1 : flip_flop_d 
        port map (
            clk   => clk,
            reset => reset,
            set   => set,
            en    => en,
            d     => d(0),
            q     => q_4bits(0)
        );

		  
    ffd2 : flip_flop_d 
        port map (
            clk   => clk,
            reset => reset,
            set   => set,
            en    => en,
            d     => d(1),
            q     => q_4bits(1)
        );

		  
    ffd3 : flip_flop_d 
        port map (
            clk   => clk,
            reset => reset,
            set   => set,
            en    => en,
            d     => d(2),
            q     => q_4bits(2)
        );

		  
    ffd4 : flip_flop_d 
        port map (
            clk   => clk,
            reset => reset,
            set   => set,
            en    => en,
            d     => d(3),
            q     => q_4bits(3)
        );

end behavioral;
