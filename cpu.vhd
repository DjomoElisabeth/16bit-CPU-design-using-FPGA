library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cpu_lib.all;

entity cpu is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           ready : in STD_LOGIC;
           addr  : out bit16;
           rw    : out STD_LOGIC;
           vma   : out STD_LOGIC;
           data  : inout bit16);
end cpu;

architecture rtl of cpu is
component regarray
port ( data : in bit16; -- std_logic_vector(15 downto 0)
       sel  : in t_reg; -- std_logic_vector(2 downto 0)
       en   : in std_logic;
       clk  : in std_logic;
       q    : out bit16);
end component;

component reg
port ( a    : in bit16; -- std_logic_vector(15 downto 0)
       clk  : in std_logic;
       q    : out bit16);
end component;

component trireg
port ( a    : in bit16; -- std_logic_vector(15 downto 0)
       en   : in std_logic;
       clk  : in std_logic;
       q    : out bit16);
end component;

component control
port(   clock      : in std_logic;
        reset      : in std_logic;
        instrReg   : in bit16;
        compout    : in std_logic;
        ready      : in std_logic;
        progCntrWr : out std_logic;
        progCntrRd : out std_logic;
        addrRegWr  : out std_logic;
        outRegWr   : out std_logic;
        outRegRd   : out std_logic;
        shiftSel   : out t_shift;
        aluSel     : out t_alu;  --std_logic_vector(3 downto 0)
        compSel    : out t_comp;
        opRegRd    : out std_logic;
        opRegWr    : out std_logic;
        instrWr    : out std_logic;
        regSel     : out t_reg;  --std_logic_vector(2 downto 0)
        regRd      : out std_logic;
        regWr      : out std_logic;
        rw      : out std_logic;
        vma        : out std_logic );
end component;

component ALU
port ( a   , b  : in bit16; -- std_logic_vector(15 downto 0)
       sel      : in t_alu;  --defines ALU operations
       c        : out bit16);
end component;

component shift
port ( a     : in bit16; -- std_logic_vector(15 downto 0)
       sel   : in t_shift;
       y     : out bit16);
end component;

component comp
port ( a   , b  : in bit16; -- std_logic_vector(15 downto 0)
       sel  : in t_comp;
       compout : out std_logic);
end component;

signal opdata, aluout, shiftout, instrregOut : bit16;
signal regsel   : t_reg;
signal regRd, regWr, opregRd, opregWr, outregRd, outregWr,  addrregWr, instrregWr, progcntrRd, progcntrWr,  compout : std_logic;
signal alusel   : t_alu;
signal shiftsel : t_shift;
signal compsel  : t_comp;

begin
ra1 : regarray port map(data, regsel, regRd, regWr, data);
opreg: trireg port map (data, opregRd, opregWr, opdata);
alu1: alu port map (data, opdata, alusel, aluout);
shift1: shift port map (aluout, shiftsel, shiftout);
outreg: trireg port map (shiftout, outregRd, outregWr,
data);
addrreg: reg port map (data, addrregWr, addr);
progcntr: trireg port map (data, progcntrRd, progcntrWr,
data);
comp1: comp port map (opdata, data, compsel, compout);
instr1: reg port map (data, instrregWr, instrregOut);
con1: control port map (clock, reset, instrregOut, compout, ready, 
                        progcntrWr, progcntrRd, addrregWr, outregWr, outregRd, 
                        shiftsel, alusel, compsel, opregRd, opregWr, instrregWr,
                        regsel, regRd, regWr, rw, vma);


end ;
