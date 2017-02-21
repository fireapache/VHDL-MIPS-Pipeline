library ieee;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS is
    Port (
		outs: out std_logic_vector(31 downto 0);
		clk, rst: in std_logic
	 );
end MIPS;

architecture rtl of MIPS is
	signal sig_OUT_PCP4_2, sig_OUT_jump, sig_OUT_memI_1, sig_inst, sig_regData, sig_dadoLido1, sig_dadoLido2,
	sig_imediate_ext, sig_dadoLido1_1,sig_dadoLido2_1, sig_imediate_ext_1, sig_somInPC,
	sig_IN1_ULA ,sig_IN2_ULA , sig_ULA_result, sig_OUT_PCP4_3, sig_in_PC, sig_out_PC,
	sig_OUT_jump_1, sig_ULA_result_1, sig_dadoLido2_2, sig_OUT_memD, 
	sig_OUT_memD_1, sig_ULA_result_2, sig_OUT_PCP4_1: std_logic_vector(31 downto 0);
	signal in_PIPE1, out_PIPE1: std_logic_vector(63 downto 0);
	signal sig_opcode, sig_function : std_logic_vector(5 downto 0);
	signal sig_ReadReg1, sig_ReadReg2, sig_regDest, sig_RegEsc, sig_ReadReg2_1, sig_regDest_1,
	sig_RegEsc_1, sig_RegEsc_0, sig_RegEsc_2 : std_logic_vector (4 downto 0);
	signal sig_imediate: std_logic_vector(15 downto 0);
	signal sig_adiantaB1,sig_adiantaA1 ,sig_adiantaA ,sig_adiantaB ,sig_ulaOp , sig_ulaOp_1: std_logic_vector(1 downto 0);
	signal sig_ulaFonte, sig_ulaFonte_1, sig_escMem, sig_escMem_1, sig_lerMem, 
	sig_lerMem_1, sig_DvC, sig_DvC_1, sig_memParaReg, sig_memParaReg_1, sig_fontePC, we3, 
	sig_escReg_1, sig_ULA_zero, sig_RegDST, sig_escMem_2, sig_lerMem_2,
	sig_DvC_2, sig_memParaReg_2, sig_escReg_2, sig_ULA_zero_1, sig_memParaReg_3, sig_escReg_3, sig_escReg, sig_RegDST_1,sig_fontePC2 : STD_LOGIC;
	signal sig_operULA: std_logic_vector(3 downto 0);
	signal in_PIPE3,  out_PIPE3: std_logic_vector (106 downto 0);
	signal in_PIPE4, out_PIPE4: std_logic_vector(70 downto 0);
---------------------------------------------------------------------------------------
	signal in_PIPE2, out_pipe2: std_logic_vector( 145 downto 0); -- MODIFICADO , RETIRADO BIT NO SIG_ULAFONTE
	signal in_PIPEAUX,out_pipeaux:std_logic_vector( 3 downto 0); -- 4 bits
---------------------------------------------------------------------------------------
	signal sig_saida_bit_sujo1,sig_saida_bit_sujo2,sig_saida_bit_sujo3,saida_bit_sujo1,saida_bit_sujo2,saida_bit_sujo3 : std_logic; -- saidas dos pipes dos bitsujos
	------------------------------------------------------------------------------------
	signal saidaprimeiromux,saidasegundopipe,saidaprimeiropipe ,saidadoprimeiroreg ,saidaor: std_logic;
	signal sig_imediate_extende2  : std_LOGIC_VECTOR(31 downto 0); -- extende o 2 , manda o sinal extendido 2 estagio.
	signal sig_out_dinamic_control: std_LOGIC_VECTOR(31 downto 0); -- saida das decisoes jumps
	signal dinamic_controle_1,dinamic_controle : std_logic;-- controla os dois mux do segundo estagio
	signal sig_out_pulo2 : std_logic_vector(31 downto 0);
	signal sig_out_dinamic_control_1 : std_LOGIC_VECTOR(31 downto 0);
	signal sig_control_first_muxs :std_LOGIC; -- controla o problema se o beq pulou errado , la nos primeiros muxs 
	component reg
		generic(
			DATA_WIDTH : natural := 8
		);
		port(
			clk, rst, en : in std_logic;  
			D : in  std_logic_vector ((DATA_WIDTH-1) downto 0);  
			Q : out std_logic_vector ((DATA_WIDTH-1) downto 0)
		); 
	END component ;
	component mux2to11bit
		Port (
		SEL : in  STD_logic;
		A, B   : in  STD_logic;
		X   : out STD_LOGIC
	);
	end component;
	component memInst
		PORT(
			address	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		   : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component memInst2
		generic (
			wlength: integer := 32;
			words  : integer := 10
		);
		Port(
			data: IN std_logic_vector(wlength-1 downto 0);
			address: IN std_logic_vector(words-1 downto 0);
			clock, wren: IN std_logic;
			q: OUT std_logic_vector(wlength-1 downto 0)
		);
	end component;
	
	component memData
		PORT(
			address	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		   : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component addSub
		generic(
			DATA_WIDTH : natural := 8
		);

		port(
			a		: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			b		: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			add_sub : in std_logic;
			result	: out std_logic_vector ((DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component mux2to1
		generic(
			DATA_WIDTH : natural := 32
		);
		port (
			SEL : in  STD_LOGIC;
			A, B   : in  STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0);
			X   : out STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0)
		);
	end component;
	
	component mux4to1 
		generic(
			DATA_WIDTH : natural := 32
		);
		Port (
			SEL : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			A, B, C, D : in  STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0);
			X   : out STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0)
		);
   end component;
	
	
	component PC
		generic(
			DATA_WIDTH : natural := 5
		);
		port(
			clk, rst: in std_logic;  
			D : in  std_logic_vector ((DATA_WIDTH-1) downto 0);  
			Q : out std_logic_vector ((DATA_WIDTH-1) downto 0)
		);  
	end component;
	
	component regbank
		port (
			A1, A2, A3: in std_logic_vector(4 downto 0);
			clk, rst, we3: in std_logic;
			wd3: in std_logic_vector(31 downto 0);
			out1, out2 : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component signalExtensor
		Port (
			in16: in std_logic_vector(15 downto 0);
			out32: out std_logic_vector(31 downto 0)
		);
	end component;
	---Ula fonte retirado , adicionado adiantaA E adiantaB
	component controller
		PORT (
		clk : in std_logic;
		rst	: in std_logic;
		opcode : IN std_logic_vector(5 downto 0);
		ulaOp : out std_logic_vector(1 downto 0);
		RegDst, escMem, lerMem, DvC, memParaReg, escReg: out std_logic;
		reg1,reg2,reg3 : in std_logic_vector(4 downto 0);
		fontepc			: in std_logic;
		adiantaA,adiantaB :out std_logic_vector(1 downto 0);
		dinamic_controle,dinamic_controle_1:out std_logic
	);
	END component;
	------------------------------------------------
	component flipflop1b
		port(
		clk, rst : in std_logic;  
		D : in  std_logic;  
		Q : out std_logic
	);
	end component;
	------------------------------------------------
	component flipflop
		generic(
			DATA_WIDTH : natural := 32
		);
		port(
			clk, rst : in std_logic;  
			D : in  std_logic_vector ((DATA_WIDTH-1) downto 0);  
			Q : out std_logic_vector ((DATA_WIDTH-1) downto 0)
		);  
	end component;
	
	component ULA
		port (
			in0, in1: in std_logic_vector(31 downto 0);
			oper: in std_logic_vector(3 downto 0);
			zero: out std_logic;
			output : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component opULA
		PORT (
			ULAop :in std_logic_vector(1 downto 0);
			funct :in std_logic_vector(5 downto 0);
			oper :out std_logic_vector(3 downto 0)
		);
	END component;
begin
	
	-- PRIMEIRO ESTÁGIO --
	
	PC1: PC GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		clk => clk,
		rst => rst,
		D => sig_in_PC,
		Q => sig_out_PC
	);
	
	mux_IN_PC: mux2to1 GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		sel => sig_fontePC2,
		A => sig_OUT_PCP4_1,
		B => sig_out_dinamic_control,
		X => sig_in_PC
	);
	-----------------------------------------------------
	PCP4: addSub GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		a => sig_out_PC,
		b => "00000000000000000000000000000100", -- 4
		add_sub => '1',
		result => sig_OUT_PCP4_1
	);
	-----------------------------------------------------
	
	memI: memInst2 PORT MAP (
		address	 => sig_out_PC(11 downto 2),
		clock	 => clk,
		data => (others => '0'),
		wren => '0',
		q	 => sig_OUT_memI_1
	);
	
	in_PIPE1 <= sig_OUT_PCP4_1 & sig_OUT_memI_1;
	
	PIPE1: flipflop GENERIC MAP (DATA_WIDTH => 64) PORT MAP (
		clk => clk,
		rst => rst,
		D => in_PIPE1,
		Q => out_PIPE1
	);
	
	-- SEGUNDO ESTÁGIO --
	
	sig_OUT_PCP4_2 <= out_PIPE1(63 downto 32);
	sig_inst <= out_PIPE1(31 downto 0);
	
	sig_opcode   <= sig_inst(31 downto 26); --opcode 
	sig_ReadReg1 <= sig_inst(25 downto 21); -- reg 1  
	sig_ReadReg2 <= sig_inst(20 downto 16); -- reg 2
	sig_imediate <= sig_inst(15 downto 0);	 -- imediato
	sig_regDest  <= sig_inst(15 downto 11); -- registrador destino

	
	controle: controller PORT MAP (
		clk => clk,
		rst => rst,
		opcode => sig_opcode,
		ulaOp => sig_ulaOp,
		RegDST => sig_RegDST, 
		---------------------------------------------------------------------------
		-- NOVO SINAL DE DOIS BITS TAMBEM QUE CONTROLARA O OUTRO MULTIPLEXADOR
		---------------------------------------------------------------------------
		--ulaFonte => sig_ulaFonte, -- deve ser modificado  de dois bits para  4 bits
		---------------------------------------------------------------------------
		escMem  => sig_escMem,
		lerMem  => sig_lerMem,
		DvC     => sig_DvC,
		memParaReg => sig_memParaReg,
		escReg  => sig_escReg,
		reg1    => sig_regDest, -- registrador destino
		reg2    => sig_ReadReg1,-- registrador dado lido 1
		reg3    => sig_ReadReg2,-- registrador dado lido 2
		fontepc => sig_fontePC2,
		adiantaA => sig_adiantaA,
		adiantaB => sig_adiantaB,
		dinamic_controle=>dinamic_controle,
		dinamic_controle_1=>dinamic_controle_1
	);
    
	registradores: regbank PORT MAP (
		A1 => sig_ReadReg1,
		A2 => sig_ReadReg2,
		A3 => sig_RegEsc_2,
		clk => clk,
		rst => rst,
		we3 => sig_escReg_3,
		wd3 => sig_regData,
		out1 => sig_dadoLido1,
		out2 => sig_dadoLido2
	);

	ExtSinal: signalExtensor PORT MAP (
		in16 => sig_imediate,
		out32 => sig_imediate_ext
	);
												--sig_ulaFonte	RETIRADO
	in_PIPE2 <= sig_ulaOp & sig_RegDST & sig_escMem & sig_lerMem & sig_DvC & sig_memParaReg & sig_escReg & sig_OUT_PCP4_2 & sig_dadoLido1 & sig_dadoLido2 & sig_imediate_ext & sig_ReadReg2 & sig_regDest;
	-----------------------------------------------------------------------------
	-- extender dois bits a esquerda a partir do fio , --sig_imediate_ext
	-- declarado o sinal sig_imediate_extende2
	sig_imediate_extende2 <= sig_imediate_ext_1(29 downto 0) & "00"; -- foi por extendido pra 32 bits o beq
	-----------------------------------------------------------------------------
	-- pegar endereço atual e somar com o 32 bits de beq
	som_pulo_imediate: addSub GENERIC MAP (DATA_WIDTH => 32) PORT MAP ( -- soma endereco atual com o pulo do beq
		a => sig_imediate_extende2,
		b => sig_OUT_PCP4_2, -- 4
		add_sub => '1',
		result => sig_out_pulo2
	);
	-- fio sig_out_pulo2 entra no mux na entrada 1 , mux controlado por dinamic_controle
	-- entrada 0 :sig_OUT_jump_1
	-----------------------------------------------------------------------------
	-- fio de saida mux antes do controle de jump:sig_out_dinamic_control
	
	mux_dinamic_controle_1 : mux2to1 GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		sel => dinamic_controle_1, 	  -- dinamic_controle 
		A => sig_OUT_PCP4_2,		 	  -- pc + 4 
		B => sig_out_pulo2,  -- o imediato extendido e com 2 bits a esquerda somado com +4 = pulo do beq imediato
		X => sig_out_dinamic_control_1 -- fio de saida entra o saida + 4 
	);
	
	mux_dinamic_controle_2 : mux2to1 GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		sel => dinamic_controle, 	  -- dinamic_controle 
		A => sig_OUT_jump_1,		 	  -- saida do 4 estagio de calculo do pulo do beq
		B => sig_out_dinamic_control_1,  -- o imediato extendido e com 2 bits a esquerda somado com +4 = pulo do beq imediato
		X => sig_out_dinamic_control
	);
	
	-----------------------------------------------------------------------------
	in_PIPEAUX <= sig_adiantaA & sig_adiantaB;
	-----------------------------------------------------------------------------
	
	PIPE2: flipflop GENERIC MAP (DATA_WIDTH => 146) PORT MAP (
		clk => clk,
		rst => rst,
		D => in_PIPE2,
		Q => out_PIPE2
	);
-------------------------------------------------------------------------------	
	PIPE_AUX_BIT_SUJO1: flipflop1b PORT MAP(
		clk => clk,
		rst => rst,
		D   => sig_fontePC2,
		Q   => saida_bit_sujo1	
	);
	
--------------------------------------------------------------------------------
	PIPEAUX: flipflop GENERIC MAP(DATA_WIDTH => 4) PORT MAP(
		clk => clk,
		rst => rst,
		D	 => in_PIPEAUX,
		Q	 => out_pipeaux
		);
--------------------------------------------------------------------------------
	-- TERCEIRO ESTÁGIO --

	sig_ulaOp_1 <= out_PIPE2(145 downto 144);
	sig_RegDST_1 <= out_PIPE2(143);
	sig_escMem_1 <= out_PIPE2(142);
	sig_lerMem_1 <= out_PIPE2(141);
	sig_DvC_1 <= out_PIPE2(140);
	sig_memParaReg_1 <= out_PIPE2(139);
	sig_escReg_1 <= out_PIPE2(138);
	sig_OUT_PCP4_3 <= out_PIPE2(137 downto 106);
	sig_dadoLido1_1 <= out_PIPE2(105 downto 74);
	sig_dadoLido2_1 <= out_PIPE2(73 downto 42);
	sig_imediate_ext_1 <= out_PIPE2(41 downto 10);
	sig_function <= sig_imediate_ext_1(5 downto 0);
	sig_ReadReg2_1 <= out_PIPE2(9 downto 5);
	sig_regDest_1 <= out_PIPE2(4 downto 0);
	sig_somInPC <= sig_imediate_ext_1(29 downto 0) & "00";
------------------------------------------------------------------
		--RECEBENDO OS SINAIS DO PIPE AUX E MANDANDO PROS CONTROLADORE DOS MULTIPLEXADORES
	sig_adiantaA1 <= out_pipeaux(3 DOWNTO 2);
	sig_adiantaB1 <= out_pipeaux(1 DOWNTO 0);
------------------------------------------------------------------
--RECEBE O SINAL DA SAIDA DO REGISTRADOR DE BIT SUJO
	sig_saida_bit_sujo1 <= saida_bit_sujo1;
------------------------------------------------------------------	
	
	inPC: addSub GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		a => sig_OUT_PCP4_3,
		b => sig_somInPC,       --b de 10 recebe de 32 --  
		add_sub => '1',
		result => sig_OUT_jump
	);

------------------------------------------------------------------------------------	
	
	mux_IN_ULA_4_1: mux4to1 GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		sel => sig_adiantaA1 ,
		A => sig_dadoLido1_1 , -- PRIMEIRA SAIDA DO BANCO DE REGISTRADORES
		B => sig_regData , --  EH A REDIRACAO DA SAIDA DEPOIS DO MULTIPLEXADOR
		C => sig_ULA_result_1 ,-- RESULTADO POS ULA 
		D =>"00000000000000000000000000000000",
		X => sig_IN1_ULA -- PRIMEIRA ENTRADA DE ULA
	);
------------------------------------------------------------------------------------	
	mux_IN_ULA_4_2: mux4to1 GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		sel => sig_adiantaB1  ,
		A => sig_dadoLido2_1  ,-- SEGUNDA SAIDA DO BANCO DE REGISTRADORES
		B => sig_regData, --  REDIRAÇAO DO ULTIMO MULTIPLEX
		C => sig_ULA_result_1  ,  -- RESULTADO POS ULA
		D => sig_somInPC ,  -- SAIDA DO IMEDIATO
		X => sig_IN2_ULA -- SEGUNDA ENTRADA DE ULA
		);
------------------------------------------------------------------------------------
	operaULA: opULA PORT MAP (
		ULAop => sig_ulaOp_1,
		funct => sig_function,
		oper => sig_operULA
	);

	ULA1: ULA PORT MAP (
		in0 => sig_IN1_ULA, --sig_dadoLido1_1, -- modificado para outro sinal , guardar sinal de saido do banco de register
		in1 => sig_IN2_ULA,
		oper => sig_operULA,
		zero => sig_ULA_zero, -- 
		output => sig_ULA_result
	);
	sig_control_first_muxs <= (sig_DvC_1 and (not (sig_ULA_zero)));
	muxEscReg: mux2to1 GENERIC MAP (DATA_WIDTH => 5) PORT MAP (
		sel => sig_RegDST_1,
		A => sig_ReadReg2_1,
		B => sig_regDest_1,
		X => sig_RegEsc_0
	);
---------------------------------------------------------------------------------------------------
	mux_ANTES_DO_SEGUNDO_PIPEDOBITSUJO : mux2to11bit  PORT MAP (
		sel => sig_fontePC2,
		A => sig_saida_bit_sujo1,
		B => sig_fontePC2,
		X => saida_bit_sujo2
	);

---------------------------------------------------------------------------------------------------
	in_PIPE3 <= sig_escMem_1 & sig_lerMem_1 & sig_DvC_1 & sig_memParaReg_1 & sig_escReg_1 & sig_OUT_jump & sig_ULA_zero & sig_ULA_result & sig_dadoLido2_1 & sig_RegEsc_0;

	PIPE3: flipflop GENERIC MAP (DATA_WIDTH => 107) PORT MAP (
		clk => clk,
		rst => rst,
		D => in_PIPE3,
		Q => out_PIPE3
	);

	-- QUARTO ESTÁGIO --
	------------------------------------------------------------------------
	sig_saida_bit_sujo2 <= saida_bit_sujo2; -- saida do pipe bit sujo 2
	-------------------------------------------------------------------------
	sig_escMem_2 <=  (not(sig_saida_bit_sujo2 )) and out_PIPE3(106);  --HAZARD DE CONTROLE 
	sig_lerMem_2 <= out_PIPE3(105);
	sig_DvC_2 <= out_PIPE3(104);
	sig_memParaReg_2 <= out_PIPE3(103);
	sig_escReg_2 <= out_PIPE3(102);
	sig_OUT_jump_1 <= out_PIPE3(101 downto 70);
	sig_ULA_zero_1 <= out_PIPE3(69);
	-----------------------------------------------------------------------
	sig_ULA_result_1 <= out_PIPE3(68 downto 37); -- redirecionar
	-----------------------------------------------------------------------
	sig_dadoLido2_2 <= out_PIPE3(36 downto 5);
	sig_RegEsc_1 <= out_PIPE3(4 downto 0);
	---------------------------------------------------------------
	sig_fontePC <= sig_DvC_2 and sig_ULA_zero_1;
	---------------------------------------------------------------
	memD: memData PORT MAP (
		address	 => sig_ULA_result_1(11 downto 2),
		clock	 => clk,
		data => sig_dadoLido2_2,
		wren => sig_escMem_2,
		q	 => sig_OUT_memD
	);

	in_PIPE4 <= sig_memParaReg_2 & sig_escReg_2 & sig_OUT_memD & sig_ULA_result_1 & sig_RegEsc_1;
-----------------------------------------------------------------------------
	
	
-----------------------------------------------------------------------------
	
	primeiro_mux_antes_do_pipe: mux2to11bit  PORT MAP (
		sel => saidaor,
		A 	 => sig_fontePC,
		B 	 => '0',
		X   => saidaprimeiromux
	);
-----------------------------------------------------------------------------
	PIPE_depois_mux: flipflop1b PORT MAP(
		clk => clk,
		rst => rst,
		D   => saidaprimeiromux,
		Q   => saidaprimeiropipe
	);	
-----------------------------------------------------------------------------	
	PIPE_depois_pipe1: flipflop1b PORT MAP(
		clk => clk,
		rst => rst,
		D   => saidaprimeiropipe,
		Q   => saidasegundopipe
	);	
-----------------------------------------------------------------------------
	segundo_mux_depois_da_or: mux2to11bit  PORT MAP (
		sel => saidaor,
		A 	 => sig_fontePC,
		B 	 => '0',
		X   => sig_fontePC2 
	);	
-----------------------------------------------------------------------------
	--sig_fontePC2 --recebe ultima saida do mux
-----------------------------------------------------------------------------	
	saidaor <= (saidaprimeiropipe or saidasegundopipe);
-----------------------------------------------------------------------------	
	PIPE_4_bit_sujo: flipflop1b PORT MAP (
			clk => clk,
			rst => rst,
			D => sig_saida_bit_sujo2,
			Q => saida_bit_sujo3
		);

-----------------------------------------------------------------------------
	
	
	PIPE4: flipflop GENERIC MAP (DATA_WIDTH => 71) PORT MAP (
		clk => clk,
		rst => rst,
		D => in_PIPE4,
		Q => out_PIPE4
	);

	-- QUINTO ESTÁGIO --
	
	
------------------------------------------------------------------------
	sig_saida_bit_sujo3 <= saida_bit_sujo3;
------------------------------------------------------------------------
	sig_memParaReg_3 <= out_PIPE4(70);
	sig_escReg_3 <= ((not(sig_saida_bit_sujo3))and out_PIPE4(69)); --HAZARD DE CONTROLE 
	sig_OUT_memD_1 <= out_PIPE4(68 downto 37);
	sig_ULA_result_2 <= out_PIPE4(36 downto 5);
	sig_RegEsc_2 <= out_PIPE4(4 downto 0);
	muxEscReg2: mux2to1 GENERIC MAP (DATA_WIDTH => 32) PORT MAP (
		sel => sig_memParaReg_3,
		A => sig_ULA_result_2,
		B => sig_OUT_memD_1,
		X => sig_regData
	);
	
	outs <= sig_regData;
	--sig_regData redirecionar
	
end rtl;