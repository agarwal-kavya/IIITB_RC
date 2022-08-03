# read design

read_verilog iiitb_rc.v

# generic synthesis
synth -top iiitb_rc

# mapping to mycells.lib
dfflibmap -liberty /home/kavya/Desktop/iiitb_rc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/kavya/Desktop/iiitb_rc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten

# write synthesized design
write_verilog -noattr iiitb_rc_synth.v

# for specifications
stat
