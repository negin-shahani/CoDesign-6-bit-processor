-------------------------------------------------------------------------------
--
-- Description : This is our PC register .
-- if CLR = 1 the program counter should be reset(0) and 
-- if the LD=1 we should store the new address in our PC register.
-- if INC=1 the program counter should  increase one more unit.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_REG is  
	PORT( RIN : in std_logic_vector(5 downto 0);
		  LD : in std_logic;
		  CLK : in std_logic;
		  INC : in std_logic;
		  CLR : in std_logic;
		  ROUT : out std_Logic_vector( 5 downto 0));
end PC_REG;

architecture PC_REG of PC_REG is
signal tmpREG : std_logic_vector( 5 downto 0);
begin
	 Process( CLK, CLR)
	 variable tmpVar : std_logic_vector( 5 downto 0) := "000000";
	 begin
		if( CLR = '1') then
			tmpVar := "000000";
		elsif Rising_edge(CLK) then
			if( LD = '1') then
				tmpVar := RIN;
			end if;
			if ( INC = '1') then
				tmpVar := tmpVar + 1;
			end if;
		end if;
		tmpREG <= tmpVar;
	end process; 
	
	ROUT <= tmpREG; 
	
end PC_REG;
