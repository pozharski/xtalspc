#!/bin/bash
pointless hklout pointless_tmp.mtz << eof | tee pointless.log
hklin $1
eof
aimless hklin pointless_tmp.mtz hklout aimless_tmp.mtz << eof | tee aimless_${2}.log
resolution low 40.0 high ${3}
output mtz merged
run 1 batch 1 to ${2}
eof
ctruncate -hklin aimless_tmp.mtz -hklout ctruncate.mtz -colin "/*/*/[IMEAN,SIGIMEAN]" -colano "/*/*/[I(+),SIGI(+),I(-),SIGI(-)]" -colout XDSdataset | tee ctruncate.log
rm aimless_tmp.mtz ANOMPLOT  CORRELPLOT  NORMPLOT  pointless_tmp.mtz  ROGUEPLOT  ROGUES  SCALES
