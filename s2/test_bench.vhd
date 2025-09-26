LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; -- Necess�rio para a convers�o de inteiro para std_logic_vector

ENTITY tb_mux8x1 IS
END tb_mux8x1;

ARCHITECTURE behavior OF tb_mux8x1 IS
    -- Declara��o do componente que ser� testado (sua entidade mux8x1)
    COMPONENT mux8x1
        PORT(
            S : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
            D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Sinais para conectar �s portas do componente
    SIGNAL s_S : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_D : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_Y : STD_LOGIC;

BEGIN
    -- Instancia��o do Componente em Teste (Unit Under Test - UUT)
    uut: mux8x1 PORT MAP (
        S => s_S,
        D => s_D,
        Y => s_Y
    );

    -- Processo de est�mulo para gerar os sinais de entrada
    stim_proc: PROCESS
    BEGIN
        -- Caso de teste 1: Valor de D fixo para verificar a sele��o.
        -- D = "11100101" -> D7=1, D6=1, D5=1, D4=0, D3=0, D2=1, D1=0, D0=1
        s_D <= "11100101";
        WAIT FOR 20 ns;

        -- Loop para varrer todas as 8 combina��es do seletor S
        FOR i IN 0 TO 7 LOOP
            -- Converte o inteiro 'i' para um vetor de 3 bits e aplica em S
            s_S <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 3));
            -- Espera um tempo para que a mudan�a seja vis�vel no waveform
            WAIT FOR 20 ns;
        END LOOP;
        
        WAIT; -- Fim da simula��o
    END PROCESS;

END behavior;