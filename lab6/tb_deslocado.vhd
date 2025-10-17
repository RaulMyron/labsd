LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_shift_register IS
END tb_shift_register;

ARCHITECTURE testbench OF tb_shift_register IS
    COMPONENT shift_register IS
        PORT(
            CLK, RST, LOAD : IN STD_LOGIC;
            DIR, L, R : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL CLK_tb : STD_LOGIC := '0';
    SIGNAL RST_tb, LOAD_tb : STD_LOGIC := '0';
    SIGNAL DIR_tb, L_tb, R_tb : STD_LOGIC := '0';
    SIGNAL D_tb : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL Q_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    CONSTANT clk_period : TIME := 10 ns;
    
BEGIN
    DUT: shift_register PORT MAP(
        CLK => CLK_tb,
        RST => RST_tb,
        LOAD => LOAD_tb,
        DIR => DIR_tb,
        L => L_tb,
        R => R_tb,
        D => D_tb,
        Q => Q_tb
    );
    
    clk_process: PROCESS
    BEGIN
        CLK_tb <= '0';
        WAIT FOR clk_period/2;
        CLK_tb <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;
    
    stim_process: PROCESS
    BEGIN
        -- Reset
        RST_tb <= '1';
        WAIT FOR clk_period;
        RST_tb <= '0';
        
        -- Carga paralela
        LOAD_tb <= '1';
        D_tb <= "1010";
        WAIT FOR clk_period;
        LOAD_tb <= '0';
        
        -- Deslocamento esquerda, L=0
        DIR_tb <= '0';
        L_tb <= '0';
        WAIT FOR clk_period;
        
        -- Deslocamento esquerda, L=1
        L_tb <= '1';
        WAIT FOR clk_period;
        
        -- Deslocamento direita, R=0
        DIR_tb <= '1';
        R_tb <= '0';
        WAIT FOR clk_period;
        
        -- Deslocamento direita, R=1
        R_tb <= '1';
        WAIT FOR clk_period * 2;
        
        -- Nova carga
        LOAD_tb <= '1';
        D_tb <= "1111";
        WAIT FOR clk_period;
        LOAD_tb <= '0';
        
        -- Deslocamentos multiplos esquerda
        DIR_tb <= '0';
        L_tb <= '0';
        WAIT FOR clk_period * 4;
        
        WAIT;
    END PROCESS;
    
END testbench;
