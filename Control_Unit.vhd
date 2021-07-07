-------------------------------------------------------------------------------
--
-- Description :  This is our controlunit.we implemented ASM chart . 
-- If reset=0 all the outputs gonna be zero.
-- And for prevent the making FF we give zero to all the outputs before checking the states.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Control_Unit is
	PORT( ZR0: in std_logic;
			ZR1: in std_logic;
			ZR2: in std_logic;
			ZR3: in std_logic;
			CLK: in std_logic;
		    RST: in std_logic;
			tmpIR :in std_logic_vector(5 downto 0):="000000";
			Bus_sel: out std_logic;
			CMD: out std_logic;
			LD0: out std_logic;
			LD1: out std_logic;
			LD2: out std_logic;
			LD3: out std_logic;
			LDPC: out std_logic;
			LDIR: out std_logic;
			S00: out std_logic;
			S01: out std_logic;
			S10: out std_logic;
			S11: out std_logic;
			INC: out std_logic) ;
			
end Control_Unit;

architecture Control_Unit of Control_Unit is
TYPE state is (S0, S1, D, S2, S3, S4, S5, S6, S7);
Signal P_S: state;
Signal ZR : std_logic_vector(3 downto 0);
Signal i: integer;
begin  
	---------------------------------------------------	partitions
	i <= to_integer(unsigned(tmpIR(3 downto 2)));
	ZR(0) <= ZR0;
	ZR(1) <= ZR1;
	ZR(2) <= ZR2;
	ZR(3) <= ZR3; 

	 --------------------------------------------------- state machin 
	process(CLK, RST)
	begin
	   if( RST = '1') then
			P_S <= S0;
			LDIR <='0';
			INC <= '0';
			LD0 <= '0';
			LD1 <= '0';
			LD2 <= '0';
			LD3 <= '0';	
			Bus_Sel <= '0';
		elsif Rising_edge(CLK)then
			Case P_S is 
			When S0 => 
				P_S <= S1;
				INC <= '1';
			    LDIR <= '1';
		        LDPC <='0';
			    LD0 <= '0';
			    LD1 <= '0'; 
			    LD2 <= '0';
			    LD3 <= '0';	
				 Bus_Sel <= '0';
		    When S1 =>
				P_S <= D;
				INC <= '0';	
			    LDIR <= '0';	
			when D =>
				if( tmpIR = "111111")then
					P_S <= S2;
				else
					if(tmpIR(5 downto 4) = "00")then
						P_S <= S3;
					elsif(tmpIR(5 downto 4) = "01")then
						P_S <= S4;
					elsif(tmpIR(5 downto 4) = "10")then
						P_S <= S5;
					elsE
						if(ZR(i) = '0')then
							P_S <= S6;
						else
							P_S <= S7;
						end if;
					end if;
				end if;
			when S2 =>
				P_S <= S2;
			when S3 =>
				if(tmpIR(3 downto 2) = "00")then
					LD0 <= '1';
				elsif(tmpIR(3 downto 2) = "01")then
					LD1 <= '1';
				elsif(tmpIR(3 downto 2) = "10")then
					LD2 <= '1';
				elsE
					LD3 <= '1';
				end if;
				INC <= '1';
				P_S <= S0;
			when S4 =>
				if(tmpIR(3 downto 2) = "00")then
					LD0 <= '1';
				elsif(tmpIR(3 downto 2) = "01")then
					LD1 <= '1';
				elsif(tmpIR(3 downto 2) = "10")then
					LD2 <= '1';
				elsif(tmpIR(3 downto 2) = "11")then
					LD3 <= '1';
				end if;	
				S01 <= tmpIR(3);
				S00 <= tmpIR(2);
				S11 <= tmpIR(1);
				S10 <= tmpIR(0);
				P_S <= S0;
				CMD <= '0';
				Bus_Sel <= '1';
			when S5 =>
				if(tmpIR(3 downto 2) = "00")then
					LD0 <= '1';
				elsif(tmpIR(3 downto 2) = "01")then
					LD1 <= '1';
				elsif(tmpIR(3 downto 2) = "10")then
					LD2 <= '1';
				elsif(tmpIR(3 downto 2) = "11")then
					LD3 <= '1';
				end if;	
				S01 <= tmpIR(3);
				S00 <= tmpIR(2);
				S11 <= tmpIR(1);
				S10 <= tmpIR(0);
				CMD <= '1';
				P_S <= S0;	
				Bus_Sel <= '1';
			when S6 =>
				LDPC <= '1';
				P_S <= S0;
			when S7 =>
				INC <= '1';
				P_S <= S0;
			end case;
		end if;
	end process;
	
end Control_Unit;
