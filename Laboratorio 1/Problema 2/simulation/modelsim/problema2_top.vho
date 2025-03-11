-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "03/10/2025 21:30:37"

-- 
-- Device: Altera 5CSXFC6D6F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	problema2_top IS
    PORT (
	SW : IN std_logic_vector(8 DOWNTO 0);
	HEX0 : BUFFER std_logic_vector(6 DOWNTO 0);
	HEX1 : BUFFER std_logic_vector(6 DOWNTO 0)
	);
END problema2_top;

-- Design Ports Information
-- HEX0[0]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[1]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[2]	=>  Location: PIN_AG17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[3]	=>  Location: PIN_AG16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[4]	=>  Location: PIN_AH17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[5]	=>  Location: PIN_AG18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[6]	=>  Location: PIN_AH18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[0]	=>  Location: PIN_AF16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[1]	=>  Location: PIN_V16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[2]	=>  Location: PIN_AE16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[3]	=>  Location: PIN_AD17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[4]	=>  Location: PIN_AE18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[5]	=>  Location: PIN_AE17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[6]	=>  Location: PIN_V17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[0]	=>  Location: PIN_AB30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[4]	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[8]	=>  Location: PIN_AC29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[1]	=>  Location: PIN_Y27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[5]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[2]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[6]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[3]	=>  Location: PIN_AC30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[7]	=>  Location: PIN_AD30,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF problema2_top IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_SW : std_logic_vector(8 DOWNTO 0);
SIGNAL ww_HEX0 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX1 : std_logic_vector(6 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \SW[6]~input_o\ : std_logic;
SIGNAL \SW[5]~input_o\ : std_logic;
SIGNAL \SW[0]~input_o\ : std_logic;
SIGNAL \SW[4]~input_o\ : std_logic;
SIGNAL \SW[8]~input_o\ : std_logic;
SIGNAL \SW[1]~input_o\ : std_logic;
SIGNAL \U0|U1|Cout~0_combout\ : std_logic;
SIGNAL \SW[2]~input_o\ : std_logic;
SIGNAL \U0|U2|S~combout\ : std_logic;
SIGNAL \U0|U1|S~combout\ : std_logic;
SIGNAL \SW[7]~input_o\ : std_logic;
SIGNAL \SW[3]~input_o\ : std_logic;
SIGNAL \U0|U3|S~combout\ : std_logic;
SIGNAL \U0|U0|S~combout\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \U0|U3|Cout~0_combout\ : std_logic;
SIGNAL \ALT_INV_SW[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \U0|U3|ALT_INV_S~combout\ : std_logic;
SIGNAL \U0|U2|ALT_INV_S~combout\ : std_logic;
SIGNAL \U0|U1|ALT_INV_Cout~0_combout\ : std_logic;
SIGNAL \U0|U1|ALT_INV_S~combout\ : std_logic;
SIGNAL \U0|U0|ALT_INV_S~combout\ : std_logic;

BEGIN

ww_SW <= SW;
HEX0 <= ww_HEX0;
HEX1 <= ww_HEX1;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_SW[7]~input_o\ <= NOT \SW[7]~input_o\;
\ALT_INV_SW[3]~input_o\ <= NOT \SW[3]~input_o\;
\ALT_INV_SW[6]~input_o\ <= NOT \SW[6]~input_o\;
\ALT_INV_SW[2]~input_o\ <= NOT \SW[2]~input_o\;
\ALT_INV_SW[5]~input_o\ <= NOT \SW[5]~input_o\;
\ALT_INV_SW[1]~input_o\ <= NOT \SW[1]~input_o\;
\ALT_INV_SW[8]~input_o\ <= NOT \SW[8]~input_o\;
\ALT_INV_SW[4]~input_o\ <= NOT \SW[4]~input_o\;
\ALT_INV_SW[0]~input_o\ <= NOT \SW[0]~input_o\;
\ALT_INV_Mux0~0_combout\ <= NOT \Mux0~0_combout\;
\U0|U3|ALT_INV_S~combout\ <= NOT \U0|U3|S~combout\;
\U0|U2|ALT_INV_S~combout\ <= NOT \U0|U2|S~combout\;
\U0|U1|ALT_INV_Cout~0_combout\ <= NOT \U0|U1|Cout~0_combout\;
\U0|U1|ALT_INV_S~combout\ <= NOT \U0|U1|S~combout\;
\U0|U0|ALT_INV_S~combout\ <= NOT \U0|U0|S~combout\;

-- Location: IOOBUF_X60_Y0_N19
\HEX0[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(0));

-- Location: IOOBUF_X80_Y0_N2
\HEX0[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(1));

-- Location: IOOBUF_X50_Y0_N93
\HEX0[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(2));

-- Location: IOOBUF_X50_Y0_N76
\HEX0[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(3));

-- Location: IOOBUF_X56_Y0_N36
\HEX0[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(4));

-- Location: IOOBUF_X58_Y0_N76
\HEX0[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(5));

-- Location: IOOBUF_X56_Y0_N53
\HEX0[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(6));

-- Location: IOOBUF_X52_Y0_N53
\HEX1[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \U0|U3|Cout~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(0));

-- Location: IOOBUF_X52_Y0_N2
\HEX1[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_HEX1(1));

-- Location: IOOBUF_X52_Y0_N36
\HEX1[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_HEX1(2));

-- Location: IOOBUF_X64_Y0_N19
\HEX1[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \U0|U3|Cout~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(3));

-- Location: IOOBUF_X66_Y0_N42
\HEX1[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \U0|U3|Cout~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(4));

-- Location: IOOBUF_X50_Y0_N42
\HEX1[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \U0|U3|Cout~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(5));

-- Location: IOOBUF_X60_Y0_N2
\HEX1[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_HEX1(6));

-- Location: IOIBUF_X89_Y20_N78
\SW[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(6),
	o => \SW[6]~input_o\);

-- Location: IOIBUF_X89_Y20_N61
\SW[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(5),
	o => \SW[5]~input_o\);

-- Location: IOIBUF_X89_Y21_N4
\SW[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(0),
	o => \SW[0]~input_o\);

-- Location: IOIBUF_X89_Y20_N44
\SW[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(4),
	o => \SW[4]~input_o\);

-- Location: IOIBUF_X89_Y20_N95
\SW[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(8),
	o => \SW[8]~input_o\);

-- Location: IOIBUF_X89_Y25_N21
\SW[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(1),
	o => \SW[1]~input_o\);

-- Location: LABCELL_X83_Y16_N42
\U0|U1|Cout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \U0|U1|Cout~0_combout\ = ( \SW[8]~input_o\ & ( \SW[1]~input_o\ & ( ((\SW[4]~input_o\) # (\SW[0]~input_o\)) # (\SW[5]~input_o\) ) ) ) # ( !\SW[8]~input_o\ & ( \SW[1]~input_o\ & ( ((\SW[0]~input_o\ & \SW[4]~input_o\)) # (\SW[5]~input_o\) ) ) ) # ( 
-- \SW[8]~input_o\ & ( !\SW[1]~input_o\ & ( (\SW[5]~input_o\ & ((\SW[4]~input_o\) # (\SW[0]~input_o\))) ) ) ) # ( !\SW[8]~input_o\ & ( !\SW[1]~input_o\ & ( (\SW[5]~input_o\ & (\SW[0]~input_o\ & \SW[4]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000101010001010101010111010101110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[5]~input_o\,
	datab => \ALT_INV_SW[0]~input_o\,
	datac => \ALT_INV_SW[4]~input_o\,
	datae => \ALT_INV_SW[8]~input_o\,
	dataf => \ALT_INV_SW[1]~input_o\,
	combout => \U0|U1|Cout~0_combout\);

-- Location: IOIBUF_X89_Y21_N38
\SW[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(2),
	o => \SW[2]~input_o\);

-- Location: LABCELL_X83_Y16_N21
\U0|U2|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \U0|U2|S~combout\ = ( \SW[2]~input_o\ & ( !\SW[6]~input_o\ $ (\U0|U1|Cout~0_combout\) ) ) # ( !\SW[2]~input_o\ & ( !\SW[6]~input_o\ $ (!\U0|U1|Cout~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100110000111100001100111100001111001100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_SW[6]~input_o\,
	datac => \U0|U1|ALT_INV_Cout~0_combout\,
	datae => \ALT_INV_SW[2]~input_o\,
	combout => \U0|U2|S~combout\);

-- Location: LABCELL_X83_Y16_N39
\U0|U1|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \U0|U1|S~combout\ = ( \SW[8]~input_o\ & ( \SW[1]~input_o\ & ( !\SW[5]~input_o\ $ (((\SW[0]~input_o\) # (\SW[4]~input_o\))) ) ) ) # ( !\SW[8]~input_o\ & ( \SW[1]~input_o\ & ( !\SW[5]~input_o\ $ (((\SW[4]~input_o\ & \SW[0]~input_o\))) ) ) ) # ( 
-- \SW[8]~input_o\ & ( !\SW[1]~input_o\ & ( !\SW[5]~input_o\ $ (((!\SW[4]~input_o\ & !\SW[0]~input_o\))) ) ) ) # ( !\SW[8]~input_o\ & ( !\SW[1]~input_o\ & ( !\SW[5]~input_o\ $ (((!\SW[4]~input_o\) # (!\SW[0]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010111111010010111111010000011111010000001011010000001011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[4]~input_o\,
	datac => \ALT_INV_SW[0]~input_o\,
	datad => \ALT_INV_SW[5]~input_o\,
	datae => \ALT_INV_SW[8]~input_o\,
	dataf => \ALT_INV_SW[1]~input_o\,
	combout => \U0|U1|S~combout\);

-- Location: IOIBUF_X89_Y25_N38
\SW[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(7),
	o => \SW[7]~input_o\);

-- Location: IOIBUF_X89_Y25_N55
\SW[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(3),
	o => \SW[3]~input_o\);

-- Location: LABCELL_X83_Y16_N54
\U0|U3|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \U0|U3|S~combout\ = ( \SW[2]~input_o\ & ( \SW[3]~input_o\ & ( !\SW[7]~input_o\ $ (((\SW[6]~input_o\) # (\U0|U1|Cout~0_combout\))) ) ) ) # ( !\SW[2]~input_o\ & ( \SW[3]~input_o\ & ( !\SW[7]~input_o\ $ (((\U0|U1|Cout~0_combout\ & \SW[6]~input_o\))) ) ) ) # 
-- ( \SW[2]~input_o\ & ( !\SW[3]~input_o\ & ( !\SW[7]~input_o\ $ (((!\U0|U1|Cout~0_combout\ & !\SW[6]~input_o\))) ) ) ) # ( !\SW[2]~input_o\ & ( !\SW[3]~input_o\ & ( !\SW[7]~input_o\ $ (((!\U0|U1|Cout~0_combout\) # (!\SW[6]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100111100001111001111000011110000110000111100001100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \U0|U1|ALT_INV_Cout~0_combout\,
	datac => \ALT_INV_SW[7]~input_o\,
	datad => \ALT_INV_SW[6]~input_o\,
	datae => \ALT_INV_SW[2]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \U0|U3|S~combout\);

-- Location: LABCELL_X83_Y16_N30
\U0|U0|S\ : cyclonev_lcell_comb
-- Equation(s):
-- \U0|U0|S~combout\ = ( \SW[8]~input_o\ & ( !\SW[0]~input_o\ $ (\SW[4]~input_o\) ) ) # ( !\SW[8]~input_o\ & ( !\SW[0]~input_o\ $ (!\SW[4]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100110000111100001100111100001111001100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_SW[0]~input_o\,
	datac => \ALT_INV_SW[4]~input_o\,
	datae => \ALT_INV_SW[8]~input_o\,
	combout => \U0|U0|S~combout\);

-- Location: LABCELL_X83_Y16_N0
\Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = ( \U0|U0|S~combout\ & ( (!\U0|U2|S~combout\ & (!\U0|U1|S~combout\ $ (\U0|U3|S~combout\))) # (\U0|U2|S~combout\ & (!\U0|U1|S~combout\ & \U0|U3|S~combout\)) ) ) # ( !\U0|U0|S~combout\ & ( (\U0|U2|S~combout\ & (!\U0|U1|S~combout\ & 
-- !\U0|U3|S~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010000000000010001000000000010001000011001101000100001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \U0|U2|ALT_INV_S~combout\,
	datab => \U0|U1|ALT_INV_S~combout\,
	datad => \U0|U3|ALT_INV_S~combout\,
	dataf => \U0|U0|ALT_INV_S~combout\,
	combout => \Mux6~0_combout\);

-- Location: LABCELL_X83_Y16_N6
\Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = ( \U0|U2|S~combout\ & ( \U0|U0|S~combout\ & ( !\U0|U1|S~combout\ $ (\U0|U3|S~combout\) ) ) ) # ( !\U0|U2|S~combout\ & ( \U0|U0|S~combout\ & ( (\U0|U1|S~combout\ & \U0|U3|S~combout\) ) ) ) # ( \U0|U2|S~combout\ & ( !\U0|U0|S~combout\ & ( 
-- (\U0|U3|S~combout\) # (\U0|U1|S~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110011111100000011000000111100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \U0|U1|ALT_INV_S~combout\,
	datac => \U0|U3|ALT_INV_S~combout\,
	datae => \U0|U2|ALT_INV_S~combout\,
	dataf => \U0|U0|ALT_INV_S~combout\,
	combout => \Mux5~0_combout\);

-- Location: LABCELL_X83_Y16_N3
\Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = ( \U0|U0|S~combout\ & ( (\U0|U2|S~combout\ & (\U0|U1|S~combout\ & \U0|U3|S~combout\)) ) ) # ( !\U0|U0|S~combout\ & ( (!\U0|U2|S~combout\ & (\U0|U1|S~combout\ & !\U0|U3|S~combout\)) # (\U0|U2|S~combout\ & ((\U0|U3|S~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010010100100101001001010010010100000001000000010000000100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \U0|U2|ALT_INV_S~combout\,
	datab => \U0|U1|ALT_INV_S~combout\,
	datac => \U0|U3|ALT_INV_S~combout\,
	dataf => \U0|U0|ALT_INV_S~combout\,
	combout => \Mux4~0_combout\);

-- Location: LABCELL_X83_Y16_N12
\Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux3~0_combout\ = ( \U0|U0|S~combout\ & ( (!\U0|U2|S~combout\ & (!\U0|U1|S~combout\ & !\U0|U3|S~combout\)) # (\U0|U2|S~combout\ & (\U0|U1|S~combout\)) ) ) # ( !\U0|U0|S~combout\ & ( (!\U0|U2|S~combout\ & (\U0|U1|S~combout\ & \U0|U3|S~combout\)) # 
-- (\U0|U2|S~combout\ & (!\U0|U1|S~combout\ & !\U0|U3|S~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010000100010010001000010001010011001000100011001100100010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \U0|U2|ALT_INV_S~combout\,
	datab => \U0|U1|ALT_INV_S~combout\,
	datad => \U0|U3|ALT_INV_S~combout\,
	dataf => \U0|U0|ALT_INV_S~combout\,
	combout => \Mux3~0_combout\);

-- Location: LABCELL_X83_Y16_N15
\Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux2~0_combout\ = ( \U0|U0|S~combout\ & ( (!\U0|U3|S~combout\) # ((!\U0|U2|S~combout\ & !\U0|U1|S~combout\)) ) ) # ( !\U0|U0|S~combout\ & ( (\U0|U2|S~combout\ & (!\U0|U1|S~combout\ & !\U0|U3|S~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100000001000000010000000100000011111000111110001111100011111000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \U0|U2|ALT_INV_S~combout\,
	datab => \U0|U1|ALT_INV_S~combout\,
	datac => \U0|U3|ALT_INV_S~combout\,
	dataf => \U0|U0|ALT_INV_S~combout\,
	combout => \Mux2~0_combout\);

-- Location: LABCELL_X83_Y16_N48
\Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = ( \U0|U0|S~combout\ & ( !\U0|U3|S~combout\ $ (((\U0|U2|S~combout\ & !\U0|U1|S~combout\))) ) ) # ( !\U0|U0|S~combout\ & ( (!\U0|U2|S~combout\ & (\U0|U1|S~combout\ & !\U0|U3|S~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000100000001000000010000010110100101101001011010010110100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \U0|U2|ALT_INV_S~combout\,
	datab => \U0|U1|ALT_INV_S~combout\,
	datac => \U0|U3|ALT_INV_S~combout\,
	dataf => \U0|U0|ALT_INV_S~combout\,
	combout => \Mux1~0_combout\);

-- Location: LABCELL_X83_Y16_N51
\Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = ( \U0|U0|S~combout\ & ( (!\U0|U2|S~combout\ $ (!\U0|U1|S~combout\)) # (\U0|U3|S~combout\) ) ) # ( !\U0|U0|S~combout\ & ( (!\U0|U2|S~combout\ $ (!\U0|U3|S~combout\)) # (\U0|U1|S~combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111101101111011011110110111101101101111011011110110111101101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \U0|U2|ALT_INV_S~combout\,
	datab => \U0|U1|ALT_INV_S~combout\,
	datac => \U0|U3|ALT_INV_S~combout\,
	dataf => \U0|U0|ALT_INV_S~combout\,
	combout => \Mux0~0_combout\);

-- Location: LABCELL_X83_Y16_N27
\U0|U3|Cout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \U0|U3|Cout~0_combout\ = ( \SW[2]~input_o\ & ( \SW[3]~input_o\ & ( ((\U0|U1|Cout~0_combout\) # (\SW[6]~input_o\)) # (\SW[7]~input_o\) ) ) ) # ( !\SW[2]~input_o\ & ( \SW[3]~input_o\ & ( ((\SW[6]~input_o\ & \U0|U1|Cout~0_combout\)) # (\SW[7]~input_o\) ) ) ) 
-- # ( \SW[2]~input_o\ & ( !\SW[3]~input_o\ & ( (\SW[7]~input_o\ & ((\U0|U1|Cout~0_combout\) # (\SW[6]~input_o\))) ) ) ) # ( !\SW[2]~input_o\ & ( !\SW[3]~input_o\ & ( (\SW[7]~input_o\ & (\SW[6]~input_o\ & \U0|U1|Cout~0_combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000101010001010101010111010101110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[7]~input_o\,
	datab => \ALT_INV_SW[6]~input_o\,
	datac => \U0|U1|ALT_INV_Cout~0_combout\,
	datae => \ALT_INV_SW[2]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \U0|U3|Cout~0_combout\);

-- Location: LABCELL_X66_Y33_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


