transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/XPC/Desktop/Probelma\ 3\ parte\ 1 {C:/Users/XPC/Desktop/Probelma 3 parte 1/top.sv}
vlog -sv -work work +incdir+C:/Users/XPC/Desktop/Probelma\ 3\ parte\ 1 {C:/Users/XPC/Desktop/Probelma 3 parte 1/seven_seg_decoder.sv}
vlog -sv -work work +incdir+C:/Users/XPC/Desktop/Probelma\ 3\ parte\ 1 {C:/Users/XPC/Desktop/Probelma 3 parte 1/subtractor.sv}

vlog -sv -work work +incdir+C:/Users/XPC/Desktop/Probelma\ 3\ parte\ 1 {C:/Users/XPC/Desktop/Probelma 3 parte 1/subtractor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  subtractor_tb

add wave *
view structure
view signals
run -all
