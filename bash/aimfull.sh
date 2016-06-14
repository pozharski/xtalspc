#!/bin/bash
# SYNTAX: ./aimfull.sh <unmerged-mtz-file> <number-of-100-frame-blocks> <initial-resolution>
#         Program  runs pointless/aimless combo to merge data up to N00 frame, where N is 
#         from 1 to number-of-100-frame-blocks.  It then analyzes the log files to determine
#         the CC1/2-based resolution and completeness.  The number of frames, resolution,
#         and completeness in lowest resolution shell, highest resolution shell and overall
#         are listed in the output file named aimfull_<unmerged-mtz-file>.dat
#         IMPORTANT: It is assumed that the CCP4 is configured in your .bashrc or otherwise
#         programs pointless, aimless and ctruncate are known to bash.
#         Requires companion bash script aimrun.sh.
for i in {1..${2}}; do ./aimrun.sh ${1} ${i}00 ${3}; done
for i in {1..${2}} ; do echo -n ${i}00; grep 'dataset correlation C' aimless_${i}00.log | sed -n 1p | awk '{printf " %s ",$9;}'; grep 'Completeness  ' aimless_${i}00.log | awk '{print $2,$3,$4;}'; done > foo
cut -c -8 foo | awk -v MTZ=${1} '{print "./aimrun.sh ",MTZ,$0;}' | bash -sf
mv foo aimfull_${1}.dat
