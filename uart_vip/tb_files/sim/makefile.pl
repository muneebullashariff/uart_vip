


#!usr/bin/perl

## A work directory will be created
system "vlib work";

## work directory is mapped with work directory of simulator\
system "vmap work work";


 ##vlog will compile all the files in the mentioned path  and  resultant log files are created in work directory 
system "vlog -work work -sv +incdir+../src/master_agent +incdir+../src/slave_agent +incdir+../src/env +incdir+../src/test ../src/test/test_pkg.sv ../src/env/uart_if.sv ../src/top/top.sv ";


## The above compiled files are simulated here 
system "vsim -voptargs=\"+acc=rnb\" -l uart_sim.log +UVM_VERBOSITY=UVM_HIGH -novopt top -c -do \"log -r /*; add wave -r /*; run -all;\" +UVM_TESTNAME=base_test -wlf waveform.wlf";
  
## +acc=rnb 
## Compile my design so that all of it has:
## registers (r)
## nets (n)
## vector bits (b)
## Visible so that backdoor access will work correctly#!u

