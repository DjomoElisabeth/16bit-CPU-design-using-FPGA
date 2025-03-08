library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use work.cpu_lib.all;

entity regarray is
    Port ( data : in bit16;
           sel  : in t_reg;
           en   : in STD_LOGIC;
           clk  : in STD_LOGIC;
           q    : out bit16);
end regarray;

architecture Behavioral of regarray is
type t_RAM is array (0 to 7) of bit16;
signal temp_data: bit16;

begin
writeproc :  process(clk , sel)
    variable ramdata : t_RAM;
    begin
      if clk'event and clk = '1' then
        ramdata(conv_integer(sel)) := data;
      end if;
        temp_data <= ramdata(conv_integer(sel)) after 1ns;
    end process;
 
 readproc : process(en , temp_data)
    begin
      if en = '1' then
         q <= temp_data after 1ns;   
      else
         q <= "ZZZZZZZZZZZZZZZZ" after 1ns;
      end if;
 end process;
 
end Behavioral;
