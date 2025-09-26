LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_funcaoC IS
END tb_funcaoC;

ARCHITECTURE behavior OF tb_funcaoC IS
    -- Declaração do componente que será testado (sua entidade principal)
    COMPONENT funcaoC
        PORT (
            A, B, C, D, E, F, G : IN  STD_LOGIC;
            Z                  : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Sinais para conectar às portas do componente
    SIGNAL s_A, s_B, s_C, s_D, s_E, s_F, s_G : STD_LOGIC := '0';
    SIGNAL s_Z : STD_LOGIC;

BEGIN
    -- Instanciação do Componente em Teste (Unit Under Test - UUT)
    uut: funcaoC PORT MAP (
        A => s_A,
        B => s_B,
        C => s_C,
        D => s_D,
        E => s_E,
        F => s_F,
        G => s_G,
        Z => s_Z
    );

    -- Processo de estímulo para gerar os sinais de entrada
    stim_proc: PROCESS
        VARIABLE stim_vector : STD_LOGIC_VECTOR(6 DOWNTO 0);
    BEGIN
        -- Loop para percorrer todas as 2^7 = 128 combinações de entrada
        FOR i IN 0 TO 127 LOOP
            -- Converte o inteiro 'i' em um vetor de 7 bits
            stim_vector := STD_LOGIC_VECTOR(TO_UNSIGNED(i, 7));
            
            -- Atribui cada bit do vetor à sua respectiva entrada
            s_A <= stim_vector(6); -- MSB
            s_B <= stim_vector(5);
            s_C <= stim_vector(4);
            s_D <= stim_vector(3);
            s_E <= stim_vector(2);
            s_F <= stim_vector(1);
            s_G <= stim_vector(0); -- LSB
            
            -- Espera um tempo para que a mudança seja visível no waveform
            WAIT FOR 10 ns;
        END LOOP;

        -- Fim da simulação
        WAIT;
    END PROCESS;

END behavior;