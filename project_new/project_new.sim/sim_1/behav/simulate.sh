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
ExecStep $xv_path/bin/xsim TB_MIPS_TOP_behav -key {Behavioral:sim_1:Functional:TB_MIPS_TOP} -tclbatch TB_MIPS_TOP.tcl -log simulate.log
