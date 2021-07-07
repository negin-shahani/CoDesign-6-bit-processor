-------------------------------------------------------------------------------
--
-- Description : This is our ALU .In this ALU we gonna operate ADD and SUB. 
-- if the CMD is 1 the ADD operation gonna be done and if the CMD is 0 the SUB operation gonna be done.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mini_ALU is 
	PORT( CMD : in std_logic;
		  IN1 : in std_logic_vector(5 downto 0);
		  IN2 : in std_logic_vector(5 downto 0);
		  Result : out std_logic_vector(5 downto 0));
end Mini_ALU;

architecture Mini_ALU of Mini_ALU is  
signal tmpRes : std_logic_vector(5 downto 0):="000000";
begin
	 process( CMD, IN1, IN2) 
	 begin
		if( CMD = '0')then
			tmpRes <= IN1 + IN2;
		else
			tmpRes <= IN1 - IN2;
		end if;
	end process; 
	
Result <= tmpRes;

end Mini_ALU;
