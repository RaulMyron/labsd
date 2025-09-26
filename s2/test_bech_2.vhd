LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; -- <-- THIS LINE WAS MISSING

ENTITY tb_decoder4x16 IS
END tb_decoder4x16;

ARCHITECTURE behavior OF tb_decoder4x16 IS
    COMPONENT decoder4x16
        PORT(
            A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    SIGNAL Y : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
    uut: decoder4x16 PORT MAP (
        A => A,
        Y => Y
    );

    stim_proc: process
    begin
        -- Teste todos os valores de A de 0000 a 1111
        for i in 0 to 15 loop
            A <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        
        wait;
    end process;
END;