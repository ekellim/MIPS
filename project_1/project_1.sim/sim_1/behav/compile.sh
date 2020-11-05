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
echo "xvhdl -m64 --relax -prj TB_Top_InstructionFetch_vhdl.prj"
ExecStep $xv_path/bin/xvhdl -m64 --relax -prj TB_Top_InstructionFetch_vhdl.prj 2>&1 | tee -a compile.log
