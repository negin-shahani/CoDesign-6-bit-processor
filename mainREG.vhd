-------------------------------------------------------------------------------
--
-- Description : This is our main registers file. if LD=1 then we store input
-- on our register and if the content of register is zero the ZR output will be 1 else ZR will be 0.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mainREG is 
	PORT(	RIN : in STD_LOGIC_VECTOR(5 downto 0); 
			LD : in std_logic;
			CLK : in std_logic;
			ROUT : out STD_LOGIC_VECTOR(5 downto 0);
			ZR : out std_logic);
end mainREG;

architecture mainREG of mainREG is
signal tmpReg : std_logic_vector(5 downto 0) := "000000";
begin
	Process(CLK)
	 begin
		if Rising_edge(CLK) then
			if(LD = '1')then
				tmpReg <= RIN;
			end if;
		end if;
	end process;

	process(tmpReg)
		begin
		   if(tmpReg = "000000")then
			   ZR <= '1';
		   else
			   ZR <= '0' ;
		   end if;		   
	end process;
	
	ROUT <= tmpReg;

end mainREG;
