if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work  divisor_clock.sv
vlog -work work  divisor_clock_multiplexado.sv
vlog -work work  divisor_clock_multiplexado_tb.sv

vsim -voptargs=+acc -wlfdeleteonquit work.divisor_clock_multiplexado_tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1 

add wave sim:/*



run -all

