
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_contador_bcd_100 is
end tb_contador_bcd_100;

architecture tb of tb_contador_bcd_100 is
    component contador_bcd_100
        port(
            clock      : in  STD_LOGIC;
            reset      : in  STD_LOGIC;
            enable     : in  STD_LOGIC;
            load       : in  STD_LOGIC;
            D_unidade  : in  STD_LOGIC_VECTOR(3 downto 0);
            D_dezena   : in  STD_LOGIC_VECTOR(3 downto 0);
            Q_unidade  : out STD_LOGIC_VECTOR(3 downto 0);
            Q_dezena   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    signal clock      : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '0';
    signal enable     : STD_LOGIC := '0';
    signal load       : STD_LOGIC := '0';
    signal D_unidade  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal D_dezena   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Q_unidade  : STD_LOGIC_VECTOR(3 downto 0);
    signal Q_dezena   : STD_LOGIC_VECTOR(3 downto 0);
    
    constant clk_period : time := 10 ns;
begin
    -- Instância do contador
    uut: contador_bcd_100
        port map(
            clock      => clock,
            reset      => reset,
            enable     => enable,
            load       => load,
            D_unidade  => D_unidade,
            D_dezena   => D_dezena,
            Q_unidade  => Q_unidade,
            Q_dezena   => Q_dezena
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
        -- Teste 1: Reset
        reset <= '1';
        enable <= '1';
        wait for clk_period;
        reset <= '0';
        
        -- Teste 2: Contagem normal de 0 a 30
        enable <= '0';
        wait for clk_period * 32;
        
        -- Teste 3: Pausa na contagem
        enable <= '1';
        wait for clk_period * 3;
        
        -- Teste 4: Retoma contagem até 50
        enable <= '0';
        wait for clk_period * 20;
        
        -- Teste 5: LOAD - carregar valor 75
        load <= '1';
        D_unidade <= "0101";  -- 5
        D_dezena <= "0111";   -- 7
        wait for clk_period;
        load <= '0';
        wait for clk_period * 10;
        
        -- Teste 6: LOAD - carregar valor 95
        load <= '1';
        D_unidade <= "0101";  -- 5
        D_dezena <= "1001";   -- 9
        wait for clk_period;
        load <= '0';
        wait for clk_period * 10;  -- Observar transição 95->96->97->98->99->00
        
        -- Teste 7: Reset durante contagem
        wait for clk_period * 5;
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period * 20;
        
        -- Teste 8: Contagem completa de 0 a 99
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        enable <= '0';
        wait for clk_period * 105;
        
        wait;
    end process;
end tb;