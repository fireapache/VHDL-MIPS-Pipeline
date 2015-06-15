transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/dec5p1.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/array32.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/reg.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/addSub.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/mux2to1.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/PC.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/signalExtensor.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/controller.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/flipflop.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/ULA.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/opULA.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/MIPS.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/memInst.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/memData.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/mux32to1.vhd}
vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/regBank.vhd}

vcom -93 -work work {C:/Users/Huberto/Documents/GitHub/VHDL-MIPS-Pipeline/simulation/modelsim/MIPS.vht}

vsim +altera -do MIPS_run_msim_rtl_vhdl.do -l msim_transcript -gui work.mips_vhd_tst 

do wave.do

run 1000ns

wave zoom full