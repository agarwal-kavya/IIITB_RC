# iiitb_rc - Ring Counter
This is a design of Four bits ring counter.

## Introduction

A type of counter in which the output of the last flip-flop is connected as an input to the first flip-flop is known as a Ring counter. The input is shifted between the flip-flops in a ring shape which is why it is known as a Ring counter. A Ring counter is a synchronous counter. the synchronous counter has a common clock signal that triggers all the Flip-flops at the same time. Ring counter consists of D-flip flops connected in cascade setup with the output of last Flip-flop connected to the input of first Flip-flop. Each flip-flop constitutes a stage. Since, in a ring counter No. of flip flops is same as the no. of states in ring counter, so, for designing a 4-bit Ring counter we need 4 flip-flops. 

## Block Diagram 

we can see that the clock pulse (CLK) is applied to all the flip-flops simultaneously. Therefore, it is a Synchronous Counter. Also, here we use Overriding input (ORI) for each flip-flop. Preset (PR) and Clear (CLR) are used as ORI. When PR is 0, then the output is 1. And when CLR is 0, then the output is 0. Both PR and CLR are active low signal that always works in value 0.

![image](https://user-images.githubusercontent.com/110079729/181417113-eb003fc4-77b3-4095-9615-6f30c64786d1.png)

## Icarus Verilog (iverilog) & Yosys Installation on Ubuntu

### For Ubuntu

*Open your terminal and type the following to install `iverilog` and `GTKWave`

```
$   sudo apt get update
$   sudo apt get install iverilog gtkwave
```

*Type the following commands to install `Yosys`

```
$ git clone https://github.com/YosysHQ/yosys.git

$ sudo apt install make

$ sudo apt-get install build-essential clang bison flex \
   libreadline-dev gawk tcl-dev libffi-dev git \
   graphviz xdot pkg-config python3 libboost-system-dev \
   libboost-python-dev libboost-filesystem-dev zlib1g-dev
 
$ sudo make install
```



## RTL Simulation

#### To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal:
```
 $ git clone https://github.com/agarwal-kavya/iiitb_rc
 
 $ cd iiitb_rc
 
 $ iverilog iiitb_rc.v iiitb__rc_tb.v
 
 $ ./a.out
 VCD info: dumpfile test.vcd opened for output.
 
 $ gtkwave iiitb_rc.vcd
```
#### After running the given codes, the waveform generated in gtkwave would look like:



![rtl sim](https://user-images.githubusercontent.com/110079729/184848839-bc6fda3b-7b1a-4f3c-9929-4b8b9c85650f.png)



## Gate Level Simulation

GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.

*1. Go to the directory where verilog code is present and open the terminal.

*2. Invoke yosys.

Give the following commands for synthesis:

```
// reads the library file from sky130//
yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

// reads the verilog files//
yosys> read_verilog iiitb_rc.v

//synthesize the top module of verilog file//
yosys> synth -top iiitb_rc

//Generates netlist//
yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

//Simplified netlist//
yosys> flatten

//Displays the Netlist circuit//
yosys> show

```
### Synthesized Circuit

![Screenshot from 2022-08-11 16-41-42](https://user-images.githubusercontent.com/110079729/184848899-8eea05dd-32da-4d02-ae93-8eff9c5f9351.png)



```
//Writing Netlist//
yosys> write_verilog -noattr iiitb_rc_net.v
```

*3. Invoke GLS

```
$ iverilog ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v iiitb_rc_net.v iiitb_rc_tb.v
$ ./a.out
$ gtkwave iiitb_rc_tb.vcd
```

*4. Gate Level Simulation


![gls sim](https://user-images.githubusercontent.com/110079729/184848738-13364382-2cda-484c-b417-568001ac2706.png)



## Contributors

* Kavya Agarwal
* Kunal Ghosh
* Nanditha Rao
* Vasanthi D R
* Dantu Nandini Devi

## Acknowledgements
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
* V N Muralidhara, Associate Professor, Programme Coordinator, IIIT-Bangalore
* Nanditha Rao, Professor, IIIT-Bangalore


## Contact Information

* Kavya Agarwal, Mtech Student, International Institute of Information Technology, Bangalore kavya11.ag@gmail.com
* Vasanthi D R, PhD Scholar, International Institute of Information Technology, Bangalore vasanthidr11@gmail.com
* Dantu Nandini Devi, MS Student, International Institute of Information Technology, Bangalore nandini.dantu@gmail.com
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
* Nanditha Rao, Professor, IIIT-Bangalore. nanditha.rao@iiitb.ac.in


