library ieee;
use ieee.std_logic_1164.all;

-- Entity for counter with control signals
entity counter is

    port (
        c_in       : in  std_logic_vector(3 downto 0);   -- Input data for the counter down
        reset      : in  std_logic;                        -- Reset input for the simulation
        clk_in     : in  std_logic;                        -- Clock signal for generating next states
        clear      : in  std_logic;                        -- Clear signal, when active disables 7-segment display
        pl         : in  std_logic;                        -- Parallel load, when active loads data from c_in
        ce         : in  std_logic;                        -- Count enable, when active, enables counting in descending order
        count_value : out std_logic_vector(3 downto 0);    -- Output count value
        int7seg    : out std_logic_vector(7 downto 0);    -- Output to 7-segment display (F..0 order)
        tc         : out std_logic                         -- Terminal count output
    );

end counter;

-- Behavioral architecture for the counter
architecture behavioral of counter is

    -- Component declaration for full adder
    component adder
        port (
            a          : in  std_logic_vector(3 downto 0);
            b          : in  std_logic_vector(3 downto 0);
            carry_in   : in  std_logic;
            carry_out  : out std_logic;
            result     : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Component declaration for 2-input MUX
    component mux_2x4
        port (
            a         : in  std_logic_vector(3 downto 0);
            b         : in  std_logic_vector(3 downto 0);
            selector  : in  std_logic;
            result    : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Component declaration for registryister
    component registry
        port (
            clk       : in  std_logic;
            reset     : in  std_logic;
            set       : in  std_logic;
            d         : in  std_logic_vector(3 downto 0);
            en        : in  std_logic;
            q_4bits   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signal declarations for internal connections
    signal out_mux_ce        : std_logic_vector(3 downto 0);
    signal out_registry           : std_logic_vector(3 downto 0);
    signal result_full_adder : std_logic_vector(3 downto 0);
    signal data_in          : std_logic_vector(3 downto 0);

begin

    -- Instantiate the 2-input MUX to control counting enable (CE)
    instance_mux_ce : mux_2x4
        port map (
            a        => "0000",          -- If CE is 0, use "0000"
            b        => "1111",          -- If CE is 1, use "1111"
            selector => ce,
            result   => out_mux_ce
        );

    -- Instantiate the full adder to add the counter value with the output of MUX
    instance_full_adder : adder
        port map (
            a        => out_registry,            -- Current counter value
            b        => out_mux_ce,        -- Control signal value (CE)
            carry_in => '0',               -- No carry-in for subtraction
            result   => result_full_adder  -- Result of the full adder
        );

    -- Instantiate the 2-input MUX for parallel load (PL)
    instance_mux_pl : mux_2x4
        port map (
            a        => result_full_adder, -- Adder result (counting)
            b        => c_in,             -- Parallel load value (input)
            selector => pl,               -- Control signal for parallel load
            result   => data_in           -- Data to load into the registryister
        );

    -- Instantiate the registryister to store the counter value
    instance_registry : registry
        port map (
            clk     => clk_in,      -- Clock input for registryister
            reset   => '0',         -- Reset is inactive
            set     => '0',         -- Set is inactive
            d       => data_in,     -- Data to load (either adder result or parallel load)
            en      => '1',         -- Enable the registryister
            q_4bits => out_registry      -- Output of the registryister (counter value)
        );

end behavioral;
