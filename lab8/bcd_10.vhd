library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_bcd_10 is
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
end contador_bcd_10;

architecture contador_bcd_10_arch of contador_bcd_10 is
    type estado is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9);
    signal currentState, nextState, loadState : estado;
begin
    with D select
        loadState <= ST0 when "0000",
                     ST1 when "0001",
                     ST2 when "0010",
                     ST3 when "0011",
                     ST4 when "0100",
                     ST5 when "0101",
                     ST6 when "0110",
                     ST7 when "0111",
                     ST8 when "1000",
                     ST9 when "1001",
                     ST0 when others;
    
    -- Processo síncrono
    sync_proc: process(clock)
    begin
        if rising_edge(clock) then
            currentState <= nextState;
        end if;
    end process sync_proc;
    
    -- Processo combinacional
    comb_proc: process(currentState, reset, enable, rci, load, loadState)
    begin
        case currentState is
            when ST0 =>
                Q <= "0000";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST1;
                else 
                    nextState <= ST0;
                end if;
                
            when ST1 =>
                Q <= "0001";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST2;
                else 
                    nextState <= ST1;
                end if;
                
            when ST2 =>
                Q <= "0010";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST3;
                else 
                    nextState <= ST2;
                end if;
                
            when ST3 =>
                Q <= "0011";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST4;
                else 
                    nextState <= ST3;
                end if;
                
            when ST4 =>
                Q <= "0100";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST5;
                else 
                    nextState <= ST4;
                end if;
                
            when ST5 =>
                Q <= "0101";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST6;
                else 
                    nextState <= ST5;
                end if;
                
            when ST6 =>
                Q <= "0110";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST7;
                else 
                    nextState <= ST6;
                end if;
                
            when ST7 =>
                Q <= "0111";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST8;
                else 
                    nextState <= ST7;
                end if;
                
            when ST8 =>
                Q <= "1000";
                rco <= '1';
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST9;
                else 
                    nextState <= ST8;
                end if;
                
            when ST9 =>
                Q <= "1001";
                rco <= '0';  -- RCO é 0 apenas no estado 9
                if (reset = '1') then 
                    nextState <= ST0;
                elsif (load = '1') then 
                    nextState <= loadState;
                elsif (enable = '0' and rci = '0') then 
                    nextState <= ST0;
                else 
                    nextState <= ST9;
                end if;
                
            when others =>
                Q <= "0000";
                rco <= '1';
                nextState <= ST0;
        end case;
    end process comb_proc;
end contador_bcd_10_arch;
