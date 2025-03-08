library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cpu_lib.all;


entity comp is
    Port ( a       : in bit16;
           b       : in bit16;
           sel     : in t_comp;
           compout : out STD_LOGIC);
end comp;

architecture Behavioral of comp is

begin
    process(a ,b,sel)
        begin
             case sel is 
                 when eq =>
                     if a = b then
                         compout <= '1' after 1ns;
                     else
                         compout <= '0' after 1ns;
                     end if;
                 when neq =>
                     if a /= b then
                         compout <= '1' after 1ns;
                     else
                         compout <= '0' after 1ns;
                     end if;
                 when gt =>
                     if a > b then
                         compout <= '1' after 1ns;
                     else
                         compout <= '0' after 1ns;
                     end if;
                 when gte =>
                     if a >= b then
                         compout <= '1' after 1ns;
                     else
                         compout <= '0' after 1ns;
                     end if;
                when lt =>
                     if a < b then
                         compout <= '1' after 1ns;
                     else
                         compout <= '0' after 1ns;
                     end if;
                when lte =>
                     if a <= b then
                         compout <= '1' after 1ns;
                     else
                         compout <= '0' after 1ns;
                     end if;
                when others =>            
                         compout <= '0' after 1ns;
             end case;
        end process;

end Behavioral;
