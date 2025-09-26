
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_mux8x1 is
end entity tb_mux8x1;

architecture testbench of tb_mux8x1 is
    component mux8x1 is
        port (
            S : in std_logic_vector(2 downto 0);
            D : in std_logic_vector(7 downto 0);
            Y : out std_logic
        );
    end component;
    
    signal S : std_logic_vector(2 downto 0) := "000";
    signal D : std_logic_vector(7 downto 0) := "00000000";
    signal Y : std_logic;
    
begin
    uut: mux8x1 port map (S => S, D => D, Y => Y);
    
    stimulus: process
    begin
        -- Teste com D = "10101010"
        D <= "10101010";
        
        -- Testa todos os valores de S
        S <= "000"; wait for 10 ns;  -- Deve selecionar D(0) = 0
        S <= "001"; wait for 10 ns;  -- Deve selecionar D(1) = 1
        S <= "010"; wait for 10 ns;  -- Deve selecionar D(2) = 0
        S <= "011"; wait for 10 ns;  -- Deve selecionar D(3) = 1
        S <= "100"; wait for 10 ns;  -- Deve selecionar D(4) = 0
        S <= "101"; wait for 10 ns;  -- Deve selecionar D(5) = 1
        S <= "110"; wait for 10 ns;  -- Deve selecionar D(6) = 0
        S <= "111"; wait for 10 ns;  -- Deve selecionar D(7) = 1
        
        wait;
    end process stimulus;
end architecture testbench;

-----------------------------------------------------------------

-- TESTBENCH para Decodificador 4x16
library ieee;
use ieee.std_logic_1164.all;

entity tb_decoder4x16 is
end entity tb_decoder4x16;

architecture testbench of tb_decoder4x16 is
    component decoder4x16 is
        port (
            A : in std_logic_vector(3 downto 0);
            Y : out std_logic_vector(15 downto 0)
        );
    end component;
    
    signal A : std_logic_vector(3 downto 0) := "0000";
    signal Y : std_logic_vector(15 downto 0);
    
begin
    uut: decoder4x16 port map (A => A, Y => Y);
    
    stimulus: process
    begin
        -- Testa todos os valores de A
        for i in 0 to 15 loop
            case i is
                when 0  => A <= "0000";
                when 1  => A <= "0001";
                when 2  => A <= "0010";
                when 3  => A <= "0011";
                when 4  => A <= "0100";
                when 5  => A <= "0101";
                when 6  => A <= "0110";
                when 7  => A <= "0111";
                when 8  => A <= "1000";
                when 9  => A <= "1001";
                when 10 => A <= "1010";
                when 11 => A <= "1011";
                when 12 => A <= "1100";
                when 13 => A <= "1101";
                when 14 => A <= "1110";
                when 15 => A <= "1111";
                when others => A <= "0000";
            end case;
            wait for 10 ns;
        end loop;
        
        wait;
    end process stimulus;
end architecture testbench;
