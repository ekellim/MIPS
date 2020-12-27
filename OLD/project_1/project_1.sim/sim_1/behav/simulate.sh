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
ExecStep $xv_path/bin/xsim TB_ALU_Control_behav -key {Behavioral:sim_1:Functional:TB_ALU_Control} -tclbatch TB_ALU_Control.tcl -log simulate.log
