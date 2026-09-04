quit -sim

if {[file exists work]} {
    vdel -lib work -all
}

vlib work

vlog -sv scancode_ascii_pkg.sv
vlog -sv decoder_scancode_ascii.sv

vsim -voptargs=+acc -onfinish stop -wlfdeleteonquit work.decoder_scancode_ascii

add wave sim:/*

force -freeze sim:/scancode_in(0) 1 0, 0 {5 ns} -r 10
force -freeze sim:/scancode_in(1) 1 0, 0 {10 ns} -r 20
force -freeze sim:/scancode_in(2) 1 0, 0 {20 ns} -r 40
force -freeze sim:/scancode_in(3) 1 0, 0 {40 ns} -r 80
force -freeze sim:/scancode_in(4) 1 0, 0 {80 ns} -r 160
force -freeze sim:/scancode_in(5) 1 0, 0 {160 ns} -r 320
force -freeze sim:/scancode_in(6) 1 0, 0 {320 ns} -r 640
force -freeze sim:/scancode_in(7) 1 0, 0 {640 ns} -r 1280

run 1300 ns