quit -sim

if {[file exists work]} {
    vdel -lib work -all
}

vlib work

vlog -sv scancode_ascii_pkg.sv
vlog -sv decoder_scancode_ascii.sv
vcom decoder_scancode_ascii_map.vhd
vlog -sv tb.sv

vsim -voptargs=+acc -onfinish stop -wlfdeleteonquit work.decoder_scancode_ascii_tb

add wave sim:/*

run 1300 ns