# iiitb_rc - Ring Counter
This is a design of Four bits ring counter.

## Introduction

A type of counter in which the output of the last flip-flop is connected as an input to the first flip-flop is known as a Ring counter. The input is shifted between the flip-flops in a ring shape which is why it is known as a Ring counter. A Ring counter is a synchronous counter. the synchronous counter has a common clock signal that triggers all the Flip-flops at the same time. Ring counter consists of D-flip flops connected in cascade setup with the output of last Flip-flop connected to the input of first Flip-flop. Each flip-flop constitutes a stage. Since, in a ring counter No. of flip flops is same as the no. of states in ring counter, so, for designing a 4-bit Ring counter we need 4 flip-flops. 

## Block Diagram 

we can see that the clock pulse (CLK) is applied to all the flip-flops simultaneously. Therefore, it is a Synchronous Counter. Also, here we use Overriding input (ORI) for each flip-flop. Preset (PR) and Clear (CLR) are used as ORI. When PR is 0, then the output is 1. And when CLR is 0, then the output is 0. Both PR and CLR are active low signal that always works in value 0.

![image](https://user-images.githubusercontent.com/110079729/181417113-eb003fc4-77b3-4095-9615-6f30c64786d1.png)

## Icarus Verilog (iverilog) & Yosys Installation on Ubuntu

### For Ubuntu

- Open your terminal and type the following to install `iverilog` and `GTKWave`

```
$   sudo apt get update
$   sudo apt get install iverilog gtkwave
```

- Type the following commands to install `Yosys`

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

1. Go to the directory where verilog code is present and open the terminal.

2. Invoke yosys.

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

3. Invoke GLS

```
$ iverilog ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v iiitb_rc_net.v iiitb_rc_tb.v
$ ./a.out
$ gtkwave iiitb_rc_tb.vcd
```

4. Gate Level Simulation


![gls sim](https://user-images.githubusercontent.com/110079729/184848738-13364382-2cda-484c-b417-568001ac2706.png)



## Physical Design from Netlist to GDSII
Physical design is process of transforming netlist into layout which is manufacture-able [GDS]. Physical design process is often referred as PnR (Place and Route). Main steps in physical design are placement of all logical cells, clock tree synthesis & routing. During this process of physical design timing, power, design & technology constraints have to be met. Further design might require being optimized w.r.t power, performance and area.

### OpenLane and Magic Tool Installation
#### Installation of Python3
```
$ sudo apt install -y build-essential python3 python3-venv python3-pip
```
#### Installation of Docker
```
$ sudo apt-get remove docker docker-engine docker.io containerd runc (removes older version of docker if installed)
$ sudo apt-get update
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release    
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null  
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
$ apt-cache madison docker-ce (copy the version string you want to install)
$ sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io docker-compose-plugin (paste the version string copies in place of <VERSION_STRING>)
$ sudo docker run hello-world (If the docker is successfully installed u will get a success message here)
```
#### Installation of OpenLane on ubuntu
```
$ git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$ cd OpenLane/
$ make
$ make test
```
#### Installation of magic on ubuntu
Additional packages to be installed as a part of system requirements to compile magic before magic installation.<br>
##### Installing M4 preprocessor
```
$ sudo apt-get install m4
```
##### Installing tcsh shell
```
$ sudo apt-get install tcsh
```
##### Installing csh shell
```
$ sudo apt-get install csh 
```
##### Installing Xlib.h
```
$ sudo apt-get install libx11-dev
```
##### Installing Tcl/Tk
```
$ sudo apt-get install tcl-dev tk-dev
```
##### Installing Cairo
```
$ sudo apt-get install libcairo2-dev
```
##### Installing OpenGL
```
$ sudo apt-get install mesa-common-dev libglu1-mesa-dev
```
##### Installing ncurses
```
$ sudo apt-get install libncurses-dev
```
##### Installing Magic
```
$ git clone https://github.com/RTimothyEdwards/magic
$ cd magic
$ ./configure
$ make
$ make install
```
#### Installing Klayout
```
$ sudo apt-get install klayout
```
### Design Preparation
Creating iiitb_rc design file in openlane directory
```
$ cd OpenLane
$ cd designs
$ mkdir iiitb_rc
$ mkdir src
$ cd src 
$ touch iiitb_rc.v
$ cd ../
$ touch config.json
```

<b>Config.json File</b>
```
{
    "DESIGN_NAME": "iiitb_rc",
    "VERILOG_FILES": "dir::src/iiitb_rc.v",
    "CLOCK_PORT": "clk",
    "CLOCK_NET": "clk",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 10,
    "PL_TARGET_DENSITY": 0.7,
    "FP_SIZING" : "relative",
"LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
"LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
"LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
"LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",  
"TEST_EXTERNAL_GLOB": "dir::../iiitb_rtc/src/*",
"SYNTH_DRIVING_CELL":"sky130_vsdinv",
    "pdk::sky130*": {
        "FP_CORE_UTIL": 30,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 20
        }
    }
   
}
```

### Including sky130_vsdinv cell to the design
```
$ cd OpenLane
$ cd vsdstdcelldesign
$ cp sky130_vsdinv.lef /home/kavya/OpenLane/designs/iiitb_rc/src
$ cd libs
$ cp sky130_fd_sc_hd__* /home/kavya/OpenLane/designs/iiitb_rc/src
```
### Invoking openlane tcl console
```
$ cd OpenLane
$ ./flow.tcl -interactive
```
In tcl console commnd to load openlane package
```
% package require openlane 0.9
```
Preparing design
```
% prep -design iiitb_rc
``` 
The following commands are to merge external the lef files to the merged.nom.lef. In our case sky130_vsdinv is getting merged to the lef file
```
% set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
% add_lefs -src $lefs
```

### Synthesis
Type the command on tickle after preparing design to synthesize design
```
% run_synthesis
```

![Screenshot from 2022-08-30 16-11-45](https://user-images.githubusercontent.com/110079729/187751181-d00f05ff-f37d-4ed0-81df-d415457f21ce.png)


#### Synthesis Reports
<b>Statistics</b>

![Screenshot from 2022-08-30 22-44-11](https://user-images.githubusercontent.com/110079729/187751498-71fd1a97-6c21-47c9-856b-bc3f1098c352.png)

Slack
![Screenshot from 2022-08-30 22-46-42](https://user-images.githubusercontent.com/110079729/187751626-42e68b89-0cb5-4b86-a687-101ee0f2d79c.png)


### Floorplan
Command to run the floorplan
```
% run_floorplan
```
![Screenshot from 2022-08-30 22-49-36](https://user-images.githubusercontent.com/110079729/187751997-3bad3ab3-67fe-4596-965e-89edce58bf41.png)

#### Floorplan Results
Command to view floorplan on magic
```
magic -T /home/kavya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_rc.def
```
![Screenshot from 2022-08-30 22-51-51](https://user-images.githubusercontent.com/110079729/187752051-261a2440-bddc-4c34-98fd-2aa8041e0ae3.png)
<b>Floorplan</b>

![fp1](https://user-images.githubusercontent.com/110079729/187752157-c7764c99-629d-4a33-ace1-04c852e98b3b.png)

![fp2](https://user-images.githubusercontent.com/110079729/187752190-2d26e41f-433f-41e9-8a15-c76b40f2be01.png)

#### Floorplan Reports

##### Core area

![Screenshot from 2022-08-30 22-50-45](https://user-images.githubusercontent.com/110079729/187752492-08b544d1-e347-4996-8908-490c72cc3109.png)


##### Die area

![Screenshot from 2022-08-30 22-50-52](https://user-images.githubusercontent.com/110079729/187752474-33632e8c-d0dd-47c8-9b2f-752a3ab663cb.png)



### Placement
Command to run placement
```
% run_placement
```

![Screenshot from 2022-08-30 22-52-15](https://user-images.githubusercontent.com/110079729/187752801-bfdf42e0-9c2f-4df3-9883-5593f3f88232.png)

#### Placement results
Command to view placement on magic
```
magic -T /home/kavya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_rc.def
```

<b>Placement</b>

![Screenshot from 2022-08-30 22-54-32](https://user-images.githubusercontent.com/110079729/187753018-2bb0f23f-3772-4ddd-843a-dd6c56ec81f0.png)


<b>Placement of sky130_vsdinv cell</b>

![Screenshot from 2022-08-30 23-14-39](https://user-images.githubusercontent.com/110079729/187753036-b6a3e735-d9db-45d4-aa55-9643d81e3275.png)


### Clock-tree synthesis
Clock Tree Synthesis (CTS) is one of the most important stages in PnR. CTS QoR decides timing convergence & power. In most of the ICs clock consumes 30-40 % of total power. So efficient clock architecture, clock gating & clock tree implementation helps to reduce power.

Command to run clock-tree synthesis
```
run_cts
```
![Screenshot from 2022-08-30 23-20-53](https://user-images.githubusercontent.com/110079729/187754118-fd82c7b0-a15e-4c5a-86a9-74adbc6c919f.png)
### Routing
Command to run routing
```
run_routing
```
![routing](https://user-images.githubusercontent.com/110079729/187754086-4a454ce3-774b-43e7-8918-1c65af828318.png)

#### Routing results

![r1](https://user-images.githubusercontent.com/110079729/187754349-da23b343-351e-46aa-a3ed-16b1926ce505.png)


<b>sky130_vsdinv in the routing view </b>

![r2](https://user-images.githubusercontent.com/110079729/187754776-14d7ffdd-a130-4c89-906e-c8f331adff42.png)


<b> Area report by magic: </b> 

![Screenshot from 2022-08-31 02-23-01](https://user-images.githubusercontent.com/110079729/187755159-03c926f5-01ae-452e-914f-19e657af25b2.png)




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


