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
ExecStep $xv_path/bin/xelab -wto 8709da08940a43bc95d53171d75d85bd -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot TB_MIPS_TOP_behav xil_defaultlib.TB_MIPS_TOP -log elaborate.log
