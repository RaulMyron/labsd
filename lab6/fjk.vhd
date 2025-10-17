LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY flip_flop_jk IS
    PORT(
        CLK, PR, CLR : IN STD_LOGIC;
        J, K : IN STD_LOGIC;
        Q : OUT STD_LOGIC
    );
END flip_flop_jk;

ARCHITECTURE behavioral OF flip_flop_jk IS
    SIGNAL Q_internal : STD_LOGIC := '0';
    SIGNAL JK_vector : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    JK_vector <= J & K;
    
    PROCESS(CLK, PR, CLR)
    BEGIN
        IF PR = '1' THEN
            Q_internal <= '1';
        ELSIF CLR = '1' THEN
            Q_internal <= '0';
        ELSIF rising_edge(CLK) THEN
            CASE JK_vector IS
                WHEN "00" => Q_internal <= Q_internal;
                WHEN "01" => Q_internal <= '0';
                WHEN "10" => Q_internal <= '1';
                WHEN "11" => Q_internal <= NOT Q_internal;
                WHEN OTHERS => Q_internal <= Q_internal;
            END CASE;
        END IF;
    END PROCESS;
    
    Q <= Q_internal;
END behavioral;