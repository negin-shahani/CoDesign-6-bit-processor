-------------------------------------------------------------------------------
--
-- Description : This is our instruction register. 
-- if LD was 1 we store input in IR register. simple is that 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity IR_REG is 
	PORT(	RIN : in STD_LOGIC_VECTOR(5 downto 0);
			LD : in std_logic;
			CLK : in std_logic;
			ROUT : out STD_LOGIC_VECTOR(5 downto 0));
end IR_REG;


architecture IR_REG of IR_REG is	
signal tmpREG : std_logic_vector(5 downto 0);
begin
	Process(CLK)
	begin
 		if Rising_edge(CLK) then
			if(LD = '1')then
				tmpREG <= RIN;
			end if;
		end if;
	end process;

	ROUT <= tmpREG;
	
end IR_REG;
