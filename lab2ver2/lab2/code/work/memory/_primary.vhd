library verilog;
use verilog.vl_types.all;
entity memory is
    generic(
        S0              : integer := 0;
        S1              : integer := 1
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        WrEn            : in     vl_logic;
        RdEn            : in     vl_logic;
        RdEn_Opcode     : in     vl_logic_vector(1 downto 0);
        RdBus           : out    vl_logic_vector(31 downto 0);
        BitAddr         : in     vl_logic_vector(4 downto 0);
        ByteAddr        : in     vl_logic_vector(1 downto 0);
        Addr            : in     vl_logic_vector(15 downto 0);
        WrBus           : in     vl_logic_vector(31 downto 0);
        StudentId       : in     vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
end memory;
