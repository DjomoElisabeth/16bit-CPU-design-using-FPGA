library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 use work.cpu_lib.all;
 
entity top_cpu_mem is
--  Port ( );
end top_cpu_mem;

architecture Behavioral of top_cpu_mem is

component memory
port( addr     : in bit16;
      sel , rw : in std_logic;  --sel = vma
      ready    : out std_logic;
      data     : inout bit16);
end component;

component cpu
port( clock , reset , ready : in std_logic;
      addr                  : out bit16;
      rw , vma              : out std_logic;
      data                  : inout bit16);
end component;

signal addr , data     : bit16;
signal rw , vma, ready : std_logic;
signal clock , reset   : std_logic := '0';

begin
clock <= not clock after 50ns;
reset <= '1', '0' after 100ns;

m1: memory port map ( addr, vma, rw , ready , data);
u1 : cpu port map( clock , reset , ready, addr , rw , vma , data);

end Behavioral;
