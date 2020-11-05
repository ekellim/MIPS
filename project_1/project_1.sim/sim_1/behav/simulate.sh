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
ExecStep $xv_path/bin/xsim TB_Top_ProgramCounter_behav -key {Behavioral:sim_1:Functional:TB_Top_ProgramCounter} -tclbatch TB_Top_ProgramCounter.tcl -log simulate.log
