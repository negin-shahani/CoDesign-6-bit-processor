-------------------------------------------------------------------------------
--
-- Description :This is our processor .in this file we connect the components 
-- to each other in order to have a full processor. also we have 3 MUX that are
-- gonna control the ALU and register's inputs.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Processor is
	  PORT( CLK: in std_logic ;
			RST: in std_logic ;
			out_REG0: out std_logic_vector(5 downto 0);
			out_REG1: out std_logic_vector(5 downto 0);
			out_REG2: out std_logic_vector(5 downto 0);
			out_REG3: out std_logic_vector(5 downto 0));
end Processor;

architecture Processor of Processor is	  
signal LD0, LD1, LD2, LD3, LDPC, LDIR, S00, S01, S10, S11, Bus_sel, CMD, INC, ZR0, ZR1, ZR2, ZR3: std_logic := '0';	 
Signal  MData, R0, R1, R2, R3, IN1, IN2, Address, tmpIR, Bus_tmp, tmpR : std_logic_vector(5 downto 0):= "000000"; 
begin 
	--------------------------------------------- MUX 	
	Bus_tmp <= tmpR when (Bus_Sel = '1') else
		   MData; 
		
	IN1 <= R0 when (S01 = '0' and S00 = '0') else
		   R1 when (S01 = '0' and S00 = '1') else
		   R2 when (S01 = '1' and S00 = '0') else
		   R3 ;
			 
	IN2 <= R0 when (S11 = '0' and S10 = '0') else
		   R1 when (S11 = '0' and S10 = '1') else
		   R2 when (S11 = '1' and S10 = '0') else	
		   R3 ; 

	---------------------------------------------------	sampling
	mainREG0 : Entity work.mainREG (mainREG)
			port map( RIN => Bus_tmp,
						  LD => LD0,
						  CLK => CLK,
						  ROUT => R0,
						  ZR => ZR0); 					  
	mainREG1 : Entity work.mainREG (mainREG)
		  	 port map( RIN => Bus_tmp,
						  ROUT => R1,
						  CLK => CLK,
						  ZR => ZR1,
						  LD => LD1); 					  
	mainREG2 : Entity work.mainREG (mainREG)
			port map( RIN => Bus_tmp,
						  LD => LD2,
			 			  CLK => CLK,
						  ROUT => R2, 
						  ZR => ZR2); 					  
	mainREG3 : Entity work.mainREG (mainREG)
			port map( RIN => Bus_tmp,
						  LD => LD3,	
						  CLK => CLK,
						  ROUT => R3,
						  ZR => ZR3); 
	ROM_Memory: Entity work.ROM_Memory (ROM_Memory)
	        port map( Address  => Address,
					    MData  => MData);					 
	PC_REG : Entity work.PC_REG (PC_REG)
			port map( RIN => Bus_tmp, 
						LD => LDPC,	
						CLK => CLK,	 
						INC => INC,
						CLR => RST,
						ROUT => Address);
	IR_REG : Entity work.IR_REG (IR_REG)
			port map( RIN => Bus_tmp,
						LD => LDIR,
						CLK => CLK,
						ROUT  => tmpIR);
	Mini_ALU : Entity work.Mini_ALU (Mini_ALU)
			port map( CMD => CMD,
						IN1 => IN1,
						IN2 => IN2,
						Result => tmpR);			
	Control_Unit : Entity work.Control_Unit(Control_Unit)
		 PORT MAP( ZR0 => ZR0, 
					  ZR1 => ZR1,
					  ZR2 => ZR2,
					  ZR3 => ZR3,
					  CLK => CLK,
					  RST => RST,
					  tmpIR => tmpIR,
					  LD0 => LD0,
					  LD1 => LD1,
					  LD2 => LD2,
					  LD3 => LD3,
					  LDPC => LDPC,
					  LDIR => LDIR,
					  S00 => S00,
					  S01 => S01,
					  S10 => S10,
					  S11 => S11,
					  Bus_Sel => Bus_Sel,
					  CMD => CMD,
					  INC => INC);
						 
	--------------------------------------------- out puts
	out_REG0<= R0;
	out_REG1<= R1; 
	out_REG2<= R2;	
	out_REG3<= R3; 

end Processor;
