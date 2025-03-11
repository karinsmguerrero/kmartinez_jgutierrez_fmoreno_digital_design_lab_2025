library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use std.textio.ALL;

entity problema2_top_tb is
end problema2_top_tb;

architecture testbench of problema2_top_tb is
    component sumador_fpga
        Port ( A    : in  STD_LOGIC_VECTOR(3 downto 0);
               B    : in  STD_LOGIC_VECTOR(3 downto 0);
               Cin  : in  STD_LOGIC;
               S    : out STD_LOGIC_VECTOR(3 downto 0);
               Cout : out STD_LOGIC);
    end component;

    signal A, B, S: STD_LOGIC_VECTOR(3 downto 0);
    signal Cin, Cout: STD_LOGIC;

begin
    UUT: sumador_fpga port map(A, B, Cin, S, Cout);

    process
    begin
        -- Prueba 1: 3 + 2
        A   <= "0011";  -- 3
        B   <= "0010";  -- 2
        Cin <= '0';
        wait for 10 ns;
		  
        -- Prueba 2: 7 + 8
        A   <= "0111";  -- 7
        B   <= "1000";  -- 8
        Cin <= '0';
        wait for 10 ns;

        -- Prueba 3: 15 + 1
        A   <= "1111";  -- 15
        B   <= "0001";  -- 1
        Cin <= '0';
        wait for 10 ns;

        -- Prueba 4: 9 + 6 con carry-in
        A   <= "1001";  -- 9
        B   <= "0110";  -- 6
        Cin <= '1';
        wait for 10 ns;

        -- Prueba 5: 6 + 6
        A   <= "0111";  -- 6
        B   <= "0110";  -- 6
        Cin <= '0';
        wait for 10 ns;	

        -- Prueba 6: 12 + 3 con carry-in
        A   <= "1100";  -- 12
        B   <= "0011";  -- 3
        Cin <= '1';
        wait for 10 ns;

        wait;
    end process;
end testbench;