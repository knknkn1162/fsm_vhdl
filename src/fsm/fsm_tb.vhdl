library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_tb is
end entity;

architecture testbench of fsm_tb is
  component fsm
    port (
      clk, rst: in std_logic;
      o_y : out std_logic
    );
  end component;

  -- skip
  signal clk, rst, s_y : std_logic;
  constant clk_period : time := 10 ns;
  signal stop : boolean;

begin
  uut : fsm port map (
    clk => clk, rst => rst, o_y => s_y
  );

  clk_process: process
  begin
    while not stop loop
      clk <= '0'; wait for clk_period/2;
      clk <= '1'; wait for clk_period/2;
    end loop;
    wait;
  end process;

  stim_proc : process
  begin
    wait for clk_period;
    rst <= '1'; wait until rising_edge(clk); wait for 1 ns; rst <= '0';
    assert s_y = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert s_y = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert s_y = '1';
    wait until rising_edge(clk); wait for 1 ns;
    assert s_y = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert s_y = '0';
    rst <= '1'; wait until rising_edge(clk); wait for 1 ns;
    assert s_y = '0';
    -- skip
    stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
