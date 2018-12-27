library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
  port (
    clk, rst: in std_logic;
    o_y : out std_logic
  );
end entity;

architecture behavior of fsm is
  type statetype is (S0, S1, S2);
  signal s_state, s_nextstate: statetype;

begin
  process(clk, rst) begin
    if rising_edge(clk) then
      if rst = '1' then 
        s_state <= S0;
      else
        s_state <= s_nextstate;
      end if;
    end if;
  end process;

  -- next state logic;
  s_nextstate <= S1 when s_state=S0 else
               S2 when s_state=S1 else
               S0;

  -- output logic
  o_y <= '1' when s_state=S2 else '0';
end architecture;

