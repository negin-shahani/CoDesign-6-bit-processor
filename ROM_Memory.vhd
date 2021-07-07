-------------------------------------------------------------------------------
--
-- Description : This is our ROM memory. our memory will receive an address and read the content in the memory.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.numeric_std.all;

entity ROM_Memory is  
	PORT( Address : in std_logic_vector( 5 downto 0);
		  MData : out std_logic_vector( 5 downto 0));
end ROM_Memory;

architecture ROM_Memory of ROM_Memory is 
type ROM is array ( 63 downto 0) of std_logic_vector(5 downto 0);
Signal tmpROM : ROM;
begin 
	-- ADD 
	tmpROM(0) <= "000000" ;
	tmpROM(1) <= "000101" ;
	tmpROM(2) <= "000100" ;
	tmpROM(3) <= "000011" ;
	tmpROM(4) <= "010001" ;
	tmpROM(5) <= "111111" ;	 

	-- Multiply 
--	tmpROM(0) <= "000000" ;
--	tmpROM(1) <= "000111" ;
--	tmpROM(2) <= "000100" ;
--	tmpROM(3) <= "001000" ;
--	tmpROM(4) <= "001000" ;
--	tmpROM(5) <= "000000" ;
--	tmpROM(6) <= "001100" ;
--	tmpROM(7) <= "000001" ;
--	tmpROM(8) <= "110100" ;
--	tmpROM(9) <= "001011" ;
--	tmpROM(10) <= "111111" ; 
--	tmpROM(11) <= "011000" ;
--	tmpROM(12) <= "100111" ;
--	tmpROM(13) <= "110100" ;
--	tmpROM(14) <= "001011" ;
--	tmpROM(15) <= "111111" ;
	
	MData <= tmpROM(to_integer(unsigned(Address)));
	
end ROM_Memory;
