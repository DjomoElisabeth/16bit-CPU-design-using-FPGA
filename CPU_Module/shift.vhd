library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cpu_lib.all;

entity shift is
    Port ( a : in bit16;
           sel : in t_shift;
           y : out bit16);
end shift;

architecture Behavioral of shift is

begin
    process(a , sel)
      begin
         case sel is
            when shftpass =>
                y <= a after 1ns;
            when shl =>
                y <= a(14 downto 0) & '0'    after 1ns;
            when shr =>
                y <='0' & a (15 downto 1)    after 1ns;    
            when rotl =>
                y <= a(14 downto 0) & a(15)  after 1ns;
            when rotr =>
                y <= a(0) & a(15 downto 1)   after 1ns;
        end case;
     end process;

end Behavioral;
