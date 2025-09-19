library IEEE;
use IEEE.std_logic_1164.all;

entity function_logic is
    port (
        A, B, C, D, E, F, G : in std_logic;
        Z : out std_logic
    );
end entity function_logic;

architecture ARCH of function_logic is
    component DECO is
        port (
            A : in std_logic_vector(3 downto 0);
            Y : out std_logic_vector(15 downto 0)
        );
    end component;
    
    component MUX is
        port (
            S : in std_logic_vector(2 downto 0);
            D : in std_logic_vector(7 downto 0);
            Y : out std_logic
        );
    end component;
    
    component OR_GATE is
        port (
            A, B : in std_logic;
            Y : out std_logic
        );
    end component;
    
    signal decoder_in : std_logic_vector(3 downto 0);
    signal decoder_out : std_logic_vector(15 downto 0);
    signal mux_select : std_logic_vector(2 downto 0);
    signal mux_data : std_logic_vector(7 downto 0);
    
    signal func_000, func_001, func_010, func_011 : std_logic;
    signal func_100, func_101, func_110, func_111 : std_logic;
    
    signal or_000_out, or_001_out, or_010_out : std_logic;
    signal or_100_out, or_110_a_out, or_110_b_out : std_logic;

begin
    -- Processo para conexões dos sinais
    Signal_Process: process(A, B, C, D, E, F, G)
    begin
        decoder_in <= A & B & C & D; -- Concatenação ABCD
        mux_select <= E & F & G; -- Seleção do multiplexador
    end process Signal_Process;
    
    -- Instanciação do decodificador
    decoder_inst: DECO
        port map (
            A => decoder_in,
            Y => decoder_out
        );
    
    -- Portas OR para EFG = 000: A'B'C'D' + AB'C'D'
    or_000: OR_GATE
        port map (
            A => decoder_out(0), -- ABCD=0000
            B => decoder_out(8), -- ABCD=1000
            Y => func_000
        );
    
    -- Portas OR para EFG = 001: ABCD + A'B'C'D'
    or_001: OR_GATE
        port map (
            A => decoder_out(15), -- ABCD=1111
            B => decoder_out(0), -- ABCD=0000
            Y => func_001
        );
    
    -- Portas OR para EFG = 010: BCD (A=0 ou A=1)
    or_010: OR_GATE
        port map (
            A => decoder_out(7), -- ABCD=0111
            B => decoder_out(15), -- ABCD=1111
            Y => func_010
        );
    
    -- EFG = 011: sempre 0
    func_011 <= '0';
    
    -- Portas OR para EFG = 100: AB'C
    or_100: OR_GATE
        port map (
            A => decoder_out(10), -- ABCD=1010
            B => decoder_out(11), -- ABCD=1011
            Y => func_100
        );
    
    -- EFG = 101: ABCD
    func_101 <= decoder_out(15); -- ABCD=1111
    
    -- Portas OR para EFG = 110: AB'C + A'BCD (primeira OR)
    or_110_a: OR_GATE
        port map (
            A => decoder_out(10), -- ABCD=1010
            B => decoder_out(11), -- ABCD=1011
            Y => or_110_a_out
        );
    
    -- Portas OR para EFG = 110: resultado anterior + A'BCD
    or_110_b: OR_GATE
        port map (
            A => or_110_a_out,
            B => decoder_out(7), -- ABCD=0111
            Y => func_110
        );
    
    -- EFG = 111: sempre 1 (devido a FG)
    func_111 <= '1';
    
    -- Montagem do vetor de dados do multiplexador
    mux_data <= func_111 & func_110 & func_101 & func_100 & 
                func_011 & func_010 & func_001 & func_000;
    
    -- Instanciação do multiplexador
    mux_inst: MUX
        port map (
            S => mux_select,
            D => mux_data,
            Y => Z
        );

end architecture ARCH;

-----------------------------------------------------------------

-- Decodificador 4x16 (componente DECO)
library IEEE;
use IEEE.std_logic_1164.all;

entity DECO is
    port (
        A : in std_logic_vector(3 downto 0);
        Y : out std_logic_vector(15 downto 0)
    );
end entity DECO;

architecture behavioral of DECO is
begin
    with A select
        Y <= "0000000000000001" when "0000",
             "0000000000000010" when "0001",
             "0000000000000100" when "0010",
             "0000000000001000" when "0011",
             "0000000000010000" when "0100",
             "0000000000100000" when "0101",
             "0000000001000000" when "0110",
             "0000000010000000" when "0111",
             "0000000100000000" when "1000",
             "0000001000000000" when "1001",
             "0000010000000000" when "1010",
             "0000100000000000" when "1011",
             "0001000000000000" when "1100",
             "0010000000000000" when "1101",
             "0100000000000000" when "1110",
             "1000000000000000" when "1111",
             "0000000000000000" when others;
end architecture behavioral;

-----------------------------------------------------------------

-- Multiplexador 8x1 (componente MUX)
library IEEE;
use IEEE.std_logic_1164.all;

entity MUX is
    port (
        S : in std_logic_vector(2 downto 0);
        D : in std_logic_vector(7 downto 0);
        Y : out std_logic
    );
end entity MUX;

architecture behavioral of MUX is
begin
    Y <= D(0) when S = "000" else
         D(1) when S = "001" else
         D(2) when S = "010" else
         D(3) when S = "011" else
         D(4) when S = "100" else
         D(5) when S = "101" else
         D(6) when S = "110" else
         D(7) when S = "111" else
         '0';
end architecture behavioral;

-----------------------------------------------------------------

-- Porta OR (componente OR_GATE)
library IEEE;
use IEEE.std_logic_1164.all;

entity OR_GATE is
    port (
        A, B : in std_logic;
        Y : out std_logic
    );
end entity OR_GATE;

architecture behavioral of OR_GATE is
begin
    Y <= A or B;
end architecture behavioral;
