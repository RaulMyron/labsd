
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux8x1 IS
    PORT (
        S : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Y : OUT STD_LOGIC
    );
END mux8x1;

ARCHITECTURE arch_mux8x1 OF mux8x1 IS
BEGIN
    Y <= D(0) WHEN S = "000" ELSE
         D(1) WHEN S = "001" ELSE
         D(2) WHEN S = "010" ELSE
         D(3) WHEN S = "011" ELSE
         D(4) WHEN S = "100" ELSE
         D(5) WHEN S = "101" ELSE
         D(6) WHEN S = "110" ELSE
         D(7);
END arch_mux8x1;