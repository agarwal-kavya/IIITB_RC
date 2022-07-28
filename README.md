# iiitb_rc - Ring Counter
This is a design of Four bits ring counter.

## Introduction

A type of counter in which the output of the last flip-flop is connected as an input to the first flip-flop is known as a Ring counter. The input is shifted between the flip-flops in a ring shape which is why it is known as a Ring counter. A Ring counter is a synchronous counter. the synchronous counter has a common clock signal that triggers all the Flip-flops at the same time. Ring counter consists of D-flip flops connected in cascade setup with the output of last Flip-flop connected to the input of first Flip-flop. Each flip-flop constitutes a stage. Since, in a ring counter No. of flip flops is same as the no. of states in ring counter, so, for designing a 4-bit Ring counter we need 4 flip-flops. 

## Block Diagram 

we can see that the clock pulse (CLK) is applied to all the flip-flops simultaneously. Therefore, it is a Synchronous Counter. Also, here we use Overriding input (ORI) for each flip-flop. Preset (PR) and Clear (CLR) are used as ORI. When PR is 0, then the output is 1. And when CLR is 0, then the output is 0. Both PR and CLR are active low signal that always works in value 0.

![image](https://user-images.githubusercontent.com/110079729/181417113-eb003fc4-77b3-4095-9615-6f30c64786d1.png)

## Installing iverilog and Ubuntu

### For Ubuntu

Open your terminal and type the following to install iverilog and GTKWave

```
$   sudo apt get update
$   sudo apt get install iverilog gtkwave
```



## Functional Simulation

#### To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal:
```
 $ git clone https://github.com/agarwal-kavya/iiitb_rc
 
 $ cd iiitb_rc
 
 $ iverilog iiitb_rc.v iiitb__rc_tb.v
 
 $ ./a.out
 VCD info: dumpfile test.vcd opened for output.
 
 $ gtkwave iiitb_rc.vcd
```

## Functional GTKWAVE Characteristic

#### After running the given codes, the waveform generated in gtkwave would look like:



![wave](https://user-images.githubusercontent.com/110079729/181253577-7887020c-2db6-4e42-8fbd-b04b0a8f9d6e.png)



## Contributors

* Kavya Agarwal
* Kunal Ghosh
* Nanditha Rao
* Vasanthi D R
* Dantu Nandini Devi

## Acknowledments
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
* V N Muralidhara, Associate Professor, Programme Coordinator, IIIT-Bangalore
* Nanditha Rao, Professor, IIIT-Bangalore


## Contact Information

* Kavya Agarwal, Mtech Student, International Institute of Information Technology, Bangalore kavya11.ag@gmail.com
* Vasanthi D R, PhD Scholar, International Institute of Information Technology, Bangalore vasanthidr11@gmail.com
* Dantu Nandini Devi, MS Student, International Institute of Information Technology, Bangalore nandini.dantu@gmail.com
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
* Nanditha Rao, Professor, IIIT-Bangalore. nanditha.rao@iiitb.ac.in


