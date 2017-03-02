transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/controle_beq.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/Tabela_de_controle.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/memInst2.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/dec5p1.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/array32.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/reg.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/addSub.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/mux2to1.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/PC.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/signalExtensor.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/controller.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/flipflop.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/ULA.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/opULA.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/MIPS.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/memData.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/mux4to1.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/comparador.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/geradordesinais.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/flipflop1b.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/mux2to11bit.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/gerador_sinais_simples.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/mux32to1.vhd}
vcom -93 -work work {/home/lucas/Downloads/Mips fisico/MIPS/regBank.vhd}

