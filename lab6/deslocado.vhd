LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY shift_register IS
    PORT(
        CLK, RST, LOAD : IN STD_LOGIC;
        DIR, L, R : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END shift_register;

ARCHITECTURE behavioral OF shift_register IS
    SIGNAL Q_internal : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
    PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            IF RST = '1' THEN
                Q_internal <= "0000";
            ELSIF LOAD = '1' THEN
                Q_internal <= D;
            ELSE
                IF DIR = '0' THEN
                    Q_internal <= Q_internal(2 DOWNTO 0) & L;
                ELSE
                    Q_internal <= R & Q_internal(3 DOWNTO 1);
                END IF;
            END IF;
        END IF;
    END PROCESS;
    
    Q <= Q_internal;
END behavioral;
