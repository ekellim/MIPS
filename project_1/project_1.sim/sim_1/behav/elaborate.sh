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
ExecStep $xv_path/bin/xelab -wto d67e869c0b3c40baadd5f1d89b5868c1 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot TB_Registers_behav xil_defaultlib.TB_Registers -log elaborate.log
