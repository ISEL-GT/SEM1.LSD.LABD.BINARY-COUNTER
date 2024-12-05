library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity for clock divider
entity clock is

    generic (
        div : natural := 50000000 -- Divider value, default is 50 million
    );

    port (
        clk_in  : in  std_logic;  -- Input clock
        clk_out : out std_logic   -- Output clock
    );

end clock;

-- Architecture for clock divider logic
architecture bhv of clock is

    signal count : integer := 1;       -- Counter for clock division
    signal tmp   : std_logic := '0';   -- Temporary signal to toggle output

begin

    -- Process to divide the input clock
    process(clk_in)
    begin
        if (clk_in'event and clk_in = '1') then  -- Rising edge detection
            count <= count + 1;
            if (count = div / 2) then
                tmp <= NOT tmp;  -- Toggle the output signal
                count <= 1;      -- Reset counter after division
            end if;
        end if;
    end process;

    -- Output clock is the toggled signal
    clk_out <= tmp;

end bhv;
