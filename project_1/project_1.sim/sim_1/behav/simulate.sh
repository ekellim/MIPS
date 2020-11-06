#!/bin/bash -f
xv_path="/home/student/Xilinx/Vivado/2016.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim TB_Registers_behav -key {Behavioral:sim_1:Functional:TB_Registers} -tclbatch TB_Registers.tcl -log simulate.log
