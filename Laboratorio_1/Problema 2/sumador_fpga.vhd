library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumador_fpga is
    Port ( A    : in  STD_LOGIC_VECTOR(3 downto 0);
           B    : in  STD_LOGIC_VECTOR(3 downto 0);
           Cin  : in  STD_LOGIC;
           S    : out STD_LOGIC_VECTOR(3 downto 0);
           Cout : out STD_LOGIC);
end sumador_fpga;

architecture Structural of sumador_fpga is
    component sumador_1bit
        Port ( A    : in  STD_LOGIC;
               B    : in  STD_LOGIC;
               Cin  : in  STD_LOGIC;
               S    : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;

    signal carry: STD_LOGIC_VECTOR(3 downto 0);

begin
    U0: sumador_1bit port map(A(0), B(0), Cin, S(0), carry(0));
    U1: sumador_1bit port map(A(1), B(1), carry(0), S(1), carry(1));
    U2: sumador_1bit port map(A(2), B(2), carry(1), S(2), carry(2));
    U3: sumador_1bit port map(A(3), B(3), carry(2), S(3), Cout);
end Structural;