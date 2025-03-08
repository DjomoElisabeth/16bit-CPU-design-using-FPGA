library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cpu_lib.all;

entity reg is
    Port ( a : in bit16;
           clk : in STD_LOGIC;
           q : out bit16);
end reg;

architecture rtl of reg is

begin
regproc:    process
begin
    wait until clk'event and clk= '1';
    q <= a after 1ns;
end process;

end rtl;
