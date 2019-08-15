-- Baseado no código de FPGA Prototyping by VHDL Examples - Pong P. Chu
-- Adaptacao para a placa DE1 da Altera
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SomadorFlutuante is
   port(
      --dp: in std_logic;
		LEDR: out std_logic_vector(7 downto 0);
		LEDG: out std_logic_vector(7 downto 0);
		SW: in std_logic_vector(7 downto 0);
		HEX3, HEX2, HEX1, HEX0:
            out std_logic_vector(7 downto 0);
		KEY: in std_logic_vector(1 downto 0)
   );
end SomadorFlutuante;

architecture arch of SomadorFlutuante is
	signal estado: std_logic_vector(2 downto 0);
	signal sign1, sign2: std_logic;
	signal exp1, exp2: std_logic_vector(3 downto 0);
	signal frac1, frac2: std_logic_vector(7 downto 0);
	signal sign_out: std_logic;
	signal exp_out: std_logic_vector(3 downto 0);
	signal frac_out: std_logic_vector(7 downto 0);
	signal thex0: std_logic_vector(3 downto 0);
	signal thex1: std_logic_vector(3 downto 0);
	signal thex2: std_logic_vector(3 downto 0);
	signal sign_show: std_logic;
	
	
begin
	process (KEY)
		variable tmp: std_logic_vector(2 downto 0);
			begin
				if (KEY(1)='0') then
					tmp := "000";
				elsif (rising_edge(KEY(0))) then
					tmp := tmp + "001";
					if (tmp = "111") then
						tmp := "000";
					end if;
				end if;
					estado <= tmp;							
		end process;
	process(estado, SW)
	begin
		case estado is
			when "000" =>
				sign1 <= SW(4);
				exp1 <= SW(3 downto 0);
				sign_show <= SW(4);
				thex0 <= SW(3 downto 0);
				thex1 <= "0000";
				thex2 <= "0000";
				LEDR(4) <= '0';
				LEDR(3 downto 0) <= "0000";
				LEDG(7 downto 0) <= "00000000";
			when "001" =>
				sign_show <= sign1;
				frac1 <= SW(7 downto 0);
				thex1 <= SW(3 downto 0);
				thex2 <= SW(7 downto 4);
			when "010" =>
				sign_show <= sign1;
				thex0 <= exp1;
				thex1 <= frac1(3 downto 0);
				thex2 <= frac1(7 downto 4);
			when "011" =>
				sign2 <= SW(4);
				exp2 <= SW(3 downto 0);
				sign_show <= SW(4);
				thex0 <= SW(3 downto 0);
				thex1 <= "0000";
				thex2 <= "0000";
			when "100" =>
				sign_show <= sign2;
				frac2 <= SW(7 downto 0);
				thex1 <= SW(3 downto 0);
				thex2 <= SW(7 downto 4);
			when "101" =>
				sign_show <= sign2;
				thex0 <= exp2;
				thex1 <= frac2(3 downto 0);
				thex2 <= frac2(7 downto 4);
			when "110" =>
				-- instantiate fp adder
				LEDR(4) <= sign_out;
				LEDR(3 downto 0) <= exp_out;
				LEDG(7 downto 0) <= frac_out;
				sign_show <= sign_out;
				thex0 <= exp_out;
				thex1 <= frac_out(3 downto 0);
				thex2 <= frac_out(7 downto 4);
				
			
			when others => null;
		end case;
	end process;
	fp_add_unit: entity work.fp_adder
		port map(
			sign1=>sign1, sign2=>sign2, exp1=>exp1, exp2=>exp2,
			frac1=>frac1, frac2=>frac2,
			sign_out=>sign_out, exp_out=>exp_out,
			frac_out=>frac_out
		);
	-- instantiate three instances of hex decoders
	-- exponent
	sseg_unit_0: entity work.hex_to_sseg
	  port map(hex=>thex0, dp=>'0', sseg=>HEX0);
	-- 4 LSBs of fraction
	sseg_unit_1: entity work.hex_to_sseg
	  port map(hex=>thex1,
			   dp=>'1', sseg=>HEX1);
	-- 4 MSBs of fraction
	sseg_unit_2: entity work.hex_to_sseg
	  port map(hex=>thex2,
			   dp=>'0', sseg=>HEX2);
	-- sign
	HEX3 <= "10111111" when sign_show='1' else -- middle bar
		   "11111111";   

end arch;