LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_flip_flop_jk IS
END tb_flip_flop_jk;

ARCHITECTURE testbench OF tb_flip_flop_jk IS
    -- Declaracao do componente
    COMPONENT flip_flop_jk IS
        PORT(
            CLK, PR, CLR : IN STD_LOGIC;
            J, K : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;
    
    -- Sinais de teste
    SIGNAL CLK_tb : STD_LOGIC := '0';
    SIGNAL PR_tb, CLR_tb : STD_LOGIC := '0';
    SIGNAL J_tb, K_tb : STD_LOGIC := '0';
    SIGNAL Q_tb : STD_LOGIC;
    
    -- Periodo do clock
    CONSTANT clk_period : TIME := 20 ns;
    
    -- Sinal para controlar fim da simulacao
    SIGNAL sim_end : BOOLEAN := FALSE;
    
BEGIN
    -- Instanciacao do DUT (Device Under Test)
    DUT: flip_flop_jk PORT MAP(
        CLK => CLK_tb,
        PR => PR_tb,
        CLR => CLR_tb,
        J => J_tb,
        K => K_tb,
        Q => Q_tb
    );
    
    -- Processo de geracao do clock
    clk_process: PROCESS
    BEGIN
        WHILE NOT sim_end LOOP
            CLK_tb <= '0';
            WAIT FOR clk_period/2;
            CLK_tb <= '1';
            WAIT FOR clk_period/2;
        END LOOP;
        WAIT;
    END PROCESS;
    
    -- Processo de estimulos
    stim_process: PROCESS
    BEGIN
        -- Estado inicial
        PR_tb <= '0'; CLR_tb <= '0';
        J_tb <= '0'; K_tb <= '0';
        WAIT FOR clk_period;
        
        -- Teste 1: Preset assincrono
        PR_tb <= '1'; CLR_tb <= '0';
        J_tb <= '0'; K_tb <= '0';
        WAIT FOR clk_period * 2;
        
        -- Teste 2: Clear assincrono
        PR_tb <= '0'; CLR_tb <= '1';
        WAIT FOR clk_period * 2;
        
        -- Desativa entradas assincronas
        PR_tb <= '0'; CLR_tb <= '0';
        WAIT FOR clk_period;
        
        -- Teste 3: J=0, K=0 (Mantem estado)
        J_tb <= '0'; K_tb <= '0';
        WAIT FOR clk_period * 2;
        
        -- Teste 4: J=1, K=0 (Set - vai para 1)
        J_tb <= '1'; K_tb <= '0';
        WAIT FOR clk_period * 2;
        
        -- Teste 5: J=0, K=0 (Mantem em 1)
        J_tb <= '0'; K_tb <= '0';
        WAIT FOR clk_period * 2;
        
        -- Teste 6: J=0, K=1 (Reset - vai para 0)
        J_tb <= '0'; K_tb <= '1';
        WAIT FOR clk_period * 2;
        
        -- Teste 7: J=1, K=1 (Toggle - inverte)
        J_tb <= '1'; K_tb <= '1';
        WAIT FOR clk_period * 4;
        
        -- Finaliza simulacao
        sim_end <= TRUE;
        WAIT;
    END PROCESS;
    
END testbench;