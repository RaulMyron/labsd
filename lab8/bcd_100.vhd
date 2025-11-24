library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_bcd_100 is
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
end contador_bcd_100;

architecture contador_bcd_100_arch of contador_bcd_100 is
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
    
    signal rco_unidade : STD_LOGIC;
begin
    -- Contador das unidades // RCI zera p/ habilitar contagem
    contador_unidade: contador_bcd_10
        port map(
            clock  => clock,
            reset  => reset,
            enable => enable,
            rci    => '0',
            load   => load,
            D      => D_unidade,
            Q      => Q_unidade,
            rco    => rco_unidade
        );
    
    -- Contador das dezenas (RCI conectado ao RCO das unidades)
    contador_dezena: contador_bcd_10
        port map(
            clock  => clock,
            reset  => reset,
            enable => rco_unidade,  -- Soh conta quando unidade completa ciclo
            rci    => '0',
            load   => load,
            D      => D_dezena,
            Q      => Q_dezena,
            rco    => open
        );
end contador_bcd_100_arch;
