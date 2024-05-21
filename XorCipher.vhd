-- XorCipher.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XorCipher is
    generic (
        N : integer := 4  -- Number of characters in the block
    );
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        text_in : in STD_LOGIC_VECTOR(8*N-1 downto 0);
        key : in STD_LOGIC_VECTOR(8*N-1 downto 0);
        text_out : out STD_LOGIC_VECTOR(8*N-1 downto 0)
    );
end XorCipher;

architecture Behavioral of XorCipher is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            text_out <= (others => '0');
        elsif rising_edge(clk) then
            text_out <= text_in XOR key;
        end if;
    end process;
end Behavioral;