
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_contador_bcd_10 is
end tb_contador_bcd_10;

architecture tb of tb_contador_bcd_10 is
    component contador_bcd_10
        port(
            clock  : in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            enable : in  STD_LOGIC;
            rci    : in  STD_LOGIC;
            load   : in  STD_LOGIC;
            D      : in  STD_LOGIC_VECTOR(3 downto 0);
            Q      : out STD_LOGIC_VECTOR(3 downto 0);
            rco    : out STD_LOGIC
        );
    end component;
    
    signal clock  : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal rci    : STD_LOGIC := '0';
    signal load   : STD_LOGIC := '0';
    signal D      : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Q      : STD_LOGIC_VECTOR(3 downto 0);
    signal rco    : STD_LOGIC;
    
    constant clk_period : time := 10 ns;
begin
    -- Instância do contador
    uut: contador_bcd_10
        port map(
            clock  => clock,
            reset  => reset,
            enable => enable,
            rci    => rci,
            load   => load,
            D      => D,
            Q      => Q,
            rco    => rco
        );
    
    -- Geração do clock
    clk_process: process
    begin
        clock <= '0';
        wait for clk_period/2;
        clock <= '1';
        wait for clk_period/2;
    end process;
    
    -- Processo de estímulos
    stim_process: process
    begin
        -- Teste 1: Reset do contador
        reset <= '1';
        enable <= '1';
        rci <= '1';
        wait for clk_period;
        reset <= '0';
        
        -- Teste 2: Contagem normal (enable=0, rci=0)
        enable <= '0';
        rci <= '0';
        wait for clk_period * 15;  -- Conta de 0 a 9 e volta a 0
        
        -- Teste 3: Pausa na contagem (enable=1)
        enable <= '1';
        wait for clk_period * 3;
        
        -- Teste 4: Retoma contagem
        enable <= '0';
        wait for clk_period * 5;
        
        -- Teste 5: Função LOAD (carregar valor 5)
        load <= '1';
        D <= "0101";
        wait for clk_period;
        load <= '0';
        wait for clk_period * 5;
        
        -- Teste 6: LOAD com valor 8
        load <= '1';
        D <= "1000";
        wait for clk_period;
        load <= '0';
        wait for clk_period * 5;
        
        -- Teste 7: Reset durante contagem
        wait for clk_period * 3;
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period * 10;
        
        -- Teste 8: Verificar RCO (deve ser 0 apenas em Q=9)
        wait for clk_period * 5;
        
        wait;
    end process;
end tb;