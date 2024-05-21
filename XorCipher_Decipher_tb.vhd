-- XorCipher_Decipher_tb.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XorCipher_Decipher_tb is
end XorCipher_Decipher_tb;

architecture Behavioral of XorCipher_Decipher_tb is
    constant N : integer := 4;  -- Number of characters in the block
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';
    signal text_in : STD_LOGIC_VECTOR(8*N-1 downto 0);
    signal key : STD_LOGIC_VECTOR(8*N-1 downto 0);
    signal cipher_text : STD_LOGIC_VECTOR(8*N-1 downto 0);
    signal deciphered_text : STD_LOGIC_VECTOR(8*N-1 downto 0);

    constant clk_period : time := 10 ns;

begin
    -- Instantiate the XOR Cipher module
    uut_cipher: entity work.XorCipher
        generic map (N => N)
        port map (
            clk => clk,
            reset => reset,
            text_in => text_in,
            key => key,
            text_out => cipher_text
        );

    -- Instantiate the XOR Decipher module
    uut_decipher: entity work.XorDecipher
        generic map (N => N)
        port map (
            clk => clk,
            reset => reset,
            cipher_text => cipher_text,
            key => key,
            text_out => deciphered_text
        );

    -- Clock process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initial reset
        reset <= '1';
        wait for clk_period*2;
        reset <= '0';

        -- Test case: Encrypt "ABCD" with key "1234"
        text_in <= x"41424344";  -- ASCII for "ABCD"
        key <= x"31323334";      -- ASCII for "1234"
        wait for clk_period*2;

        -- Wait and observe cipher text
        wait for clk_period*2;

        -- Observe decrypted text
        wait for clk_period*2;

        -- Display results
        report "Ciphered text: " & to_hstring(cipher_text) severity note;
        report "Deciphered text: " & to_hstring(deciphered_text) severity note;

        -- Add more test cases as needed...

        wait;
    end process;
end Behavioral;