transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/XPC/Desktop/Problema 2/problema2_top.vhd}
vcom -93 -work work {C:/Users/XPC/Desktop/Problema 2/sumador_1bit.vhd}
vcom -93 -work work {C:/Users/XPC/Desktop/Problema 2/sumador_fpga.vhd}

vcom -93 -work work {C:/Users/XPC/Desktop/Problema 2/problema2_top_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  problema2_top_tb

add wave *
view structure
view signals
run -all
