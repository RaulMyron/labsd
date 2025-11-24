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

    -- Declaração do componente Módulo 10
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
    
    -- Sinal interno para conectar o Carry Out da unidade ao Carry In da dezena
    signal rco_unidade : STD_LOGIC;

begin

    -- Instância do Contador das UNIDADES
    contador_unidade: contador_bcd_10
        port map(
            clock  => clock,
            reset  => reset,
            enable => enable,      -- Recebe o Enable Global
            rci    => '0',         -- Sempre pronto para contar (LSB)
            load   => load,
            D      => D_unidade,
            Q      => Q_unidade,
            rco    => rco_unidade  -- Envia sinal de estouro para a dezena
        );

    -- Instância do Contador das DEZENAS
    contador_dezena: contador_bcd_10
        port map(
            clock  => clock,
            reset  => reset,
            enable => enable,      -- Recebe o Enable Global (Pausa geral)
            rci    => rco_unidade, -- Só conta se a unidade estiver estourando (RCO=0)
            load   => load,
            D      => D_dezena,
            Q      => Q_dezena,
            rco    => open         -- Não utilizado (ou conectaria à centena)
        );

end contador_bcd_100_arch;
