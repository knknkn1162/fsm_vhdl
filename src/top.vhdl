library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  generic(N : natural);
  port (
    clk, rst : in std_logic;
    o_hex0 : out std_logic_vector(6 downto 0);
    o_hex1 : out std_logic_vector(6 downto 0);
    o_hex2 : out std_logic_vector(6 downto 0);
    o_hex3 : out std_logic_vector(6 downto 0);
    o_hex4 : out std_logic_vector(6 downto 0);
    o_hex5 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of top is
  component enable_generator
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      o_ena : out std_logic
    );
  end component;

  component disp
    port (
      i_num : in std_logic_vector(23 downto 0);
      o_hex0 : out std_logic_vector(6 downto 0);
      o_hex1 : out std_logic_vector(6 downto 0);
      o_hex2 : out std_logic_vector(6 downto 0);
      o_hex3 : out std_logic_vector(6 downto 0);
      o_hex4 : out std_logic_vector(6 downto 0);
      o_hex5 : out std_logic_vector(6 downto 0)
    );
  end component;

  component fsm
    port (
      clk, rst: in std_logic;
      o_y : out std_logic
    );
  end component;

  signal s_ena : std_logic;
  signal s_y : std_logic;
  signal s_num : std_logic_vector(23 downto 0);

begin
  enable_generator0 : enable_generator generic map(N=>N)
  port map (
    clk => clk, rst => rst,
    o_ena => s_ena
  );

  fsm0 : fsm port map (
    clk => clk, rst => rst,
    o_y => s_y
  );

  s_num(0) <= s_y;

  disp0 : disp
  port map (
    i_num => s_num,
    o_hex0 => o_hex0, o_hex1 => o_hex1, o_hex2 => o_hex2,
    o_hex3 => o_hex3, o_hex4 => o_hex4, o_hex5 => o_hex5
  );
end architecture;
