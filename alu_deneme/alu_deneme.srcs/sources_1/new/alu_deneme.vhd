library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;


entity alu_deneme is
  Port ( 
        a, b : in std_logic_vector(7 downto 0);
        cin : in std_logic;
        opcode : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(7 downto 0)
        );
end alu_deneme;

architecture Behavioral of alu_deneme is
    signal a_sig, b_sig, y_sig : signed(7 downto 0);
    signal y_unsig : std_logic_vector(7 downto 0);
    signal msb_value : integer range 0 to 1;
begin
    with opcode(2 downto 0) select
        y_unsig <= not a when "000",
                   not b when "001",
                   a and b when "010",
                   a or b when "011",
                   a nand b when "100",
                   a nor b when "101",
                   a xor b when "110",
                   a xnor b when "111";
    
    a_sig <= signed(a);
    b_sig <= signed(b);
    msb_value <= 1 when cin = '1' else 0;
    with opcode(2 downto 0) select
        y_sig <= a_sig when "000",
                 b_sig when "001",
                 a_sig + 1 when "010",
                 b_sig + 1 when "011",
                 a_sig - 1 when "100",
                 b_sig - 1 when "101",
                 a_sig + b_sig when "110",
                 a_sig + b_sig + msb_value when "111";
                 
    with opcode(3) select
        y <= std_logic_vector(y_sig) when '1',
             y_unsig when '0';

end Behavioral;
