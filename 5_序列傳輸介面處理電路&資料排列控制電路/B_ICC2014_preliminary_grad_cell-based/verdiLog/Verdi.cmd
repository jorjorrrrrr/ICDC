debImport "/home/jorjor/CIC/B_ICC2014_preliminary_grad_cell-based/testfixture1.v" \
          "/home/jorjor/CIC/B_ICC2014_preliminary_grad_cell-based/STI_DAC.v" \
          -path {/home/jorjor/CIC/B_ICC2014_preliminary_grad_cell-based}
schCreateWindow -delim "." -win $_nSchema1 -scope "testfixture1"
schZoomIn -win $_nSchema2 -pos 24852 16679
schZoomIn -win $_nSchema2 -pos 24852 16678
schZoomIn -win $_nSchema2 -pos 24852 16678
schZoomOut -win $_nSchema2 -pos 20139 22266
schZoom {17361} {13597} {19213} {28410} -win $_nSchema2
schZoomOut -win $_nSchema2 -pos 10541 21660
schZoomOut -win $_nSchema2 -pos 10540 21660
schZoomOut -win $_nSchema2 -pos 10541 21660
schZoomOut -win $_nSchema2 -pos 10541 21660
schZoomIn -win $_nSchema2 -pos 10540 21660
schZoomIn -win $_nSchema2 -pos 10540 21659
schZoomIn -win $_nSchema2 -pos 10539 21659
schZoomIn -win $_nSchema2 -pos 10538 21658
schZoomIn -win $_nSchema2 -pos 10538 21658
schZoomOut -win $_nSchema2 -pos 10538 21657
schZoomOut -win $_nSchema2 -pos 10538 21657
schZoomOut -win $_nSchema2 -pos 10538 21657
schZoomOut -win $_nSchema2 -pos 10539 21657
schZoomOut -win $_nSchema2 -pos 10539 21657
schZoomOut -win $_nSchema2 -pos 10538 21657
schZoom {13352} {27847} {13446} {31787} -win $_nSchema2
schZoomIn -win $_nSchema2 -pos 13292 30454
schZoomIn -win $_nSchema2 -pos 13292 30454
schZoomOut -win $_nSchema2 -pos 13286 30453
schZoomOut -win $_nSchema2 -pos 13286 30453
schZoomOut -win $_nSchema2 -pos 13286 30454
schZoomOut -win $_nSchema2 -pos 13285 30453
schZoomOut -win $_nSchema2 -pos 8666 27414
schZoomOut -win $_nSchema2 -pos 8665 27415
schZoomOut -win $_nSchema2 -pos 8665 27608
schZoomOut -win $_nSchema2 -pos 8666 27637
schZoomOut -win $_nSchema2 -pos 8666 27637
schZoomOut -win $_nSchema2
schZoomIn -win $_nSchema2 -pos 20528 7747
schZoomIn -win $_nSchema2 -pos 20527 7747
schZoomOut -win $_nSchema2 -pos 20527 7747
schZoomIn -win $_nSchema2 -pos 20527 7747
schZoomIn -win $_nSchema2 -pos 20527 7746
schZoomIn -win $_nSchema2 -pos 20527 7746
schZoomOut -win $_nSchema2 -pos 20526 7746
schZoomOut -win $_nSchema2 -pos 20526 7746
schZoomOut -win $_nSchema2 -pos 20525 7745
schZoomOut -win $_nSchema2 -pos 20525 7746
schZoomOut -win $_nSchema2 -pos 20524 7745
schZoomOut -win $_nSchema2 -pos 20524 7745
schZoomOut -win $_nSchema2 -pos 20524 7745
schZoomIn -win $_nSchema2 -pos 20524 7745
schZoomIn -win $_nSchema2 -pos 20524 7745
schZoomIn -win $_nSchema2 -pos 20523 7744
schZoomOut -win $_nSchema2 -pos 20522 7744
schZoomOut -win $_nSchema2 -pos 20522 7744
schSelect -win $_nSchema2 -instport "u_rtl" "oem_finish"
schSelect -win $_nSchema2 -inst "u_rtl"
schSelect -win $_nSchema2 -inst "u_rtl"
schSelect -win $_nSchema2 -inst "u_rtl"
schPushViewIn -win $_nSchema2
schSelect -win $_nSchema2 -inst "STI_DAC\(@1\):FSM0:44:187:FSM"
schSelect -win $_nSchema2 -inst "STI_DAC\(@1\):FSM0:44:187:FSM"
schPushViewIn -win $_nSchema2
fsmSetCurrentWindow -win $_nState3
fsmResizeWindow 0 27 1285 415 -win $_nState3
fsmResizeWindow 0 27 1285 415 -win $_nState3
fsmResizeWindow 0 27 1285 415 -win $_nState3
schCreateWindow -delim "." -win $_nSchema1 -scope "testfixture1"
wvCreateWindow
verdiWindowBeWindow -win $_nWave5
wvResizeWindow -win $_nWave5 0 27 1920 414
wvResizeWindow -win $_nWave5 8 31 1920 414
wvResizeWindow -win $_nWave5 0 23 1920 1017
wvSetPosition -win $_nWave5 {("G1" 0)}
wvOpenFile -win $_nWave5 \
           {/home/jorjor/CIC/B_ICC2014_preliminary_grad_cell-based/STI_DAC.fsdb}
wvGetSignalOpen -win $_nWave5
wvGetSignalSetScope -win $_nWave5 "/testfixture1"
wvGetSignalSetScope -win $_nWave5 "/testfixture1/u_rtl"
wvSetPosition -win $_nWave5 {("G1" 5)}
wvSetPosition -win $_nWave5 {("G1" 5)}
wvAddSignal -win $_nWave5 -clear
wvAddSignal -win $_nWave5 -group {"G1" \
{/testfixture1/u_rtl/clk} \
{/testfixture1/u_rtl/reset} \
{/testfixture1/u_rtl/oem_finish} \
{/testfixture1/u_rtl/state\[3:0\]} \
{/testfixture1/u_rtl/even1_wr} \
{/testfixture1/u_rtl/nstate\[3:0\]} \
}
wvAddSignal -win $_nWave5 -group {"G2" \
}
wvSelectSignal -win $_nWave5 {( "G1" 5 )} 
wvSetPosition -win $_nWave5 {("G1" 5)}
wvSetPosition -win $_nWave5 {("G1" 5)}
wvSetPosition -win $_nWave5 {("G1" 5)}
wvAddSignal -win $_nWave5 -clear
wvAddSignal -win $_nWave5 -group {"G1" \
{/testfixture1/u_rtl/clk} \
{/testfixture1/u_rtl/reset} \
{/testfixture1/u_rtl/oem_finish} \
{/testfixture1/u_rtl/state\[3:0\]} \
{/testfixture1/u_rtl/even1_wr} \
{/testfixture1/u_rtl/nstate\[3:0\]} \
}
wvAddSignal -win $_nWave5 -group {"G2" \
}
wvSelectSignal -win $_nWave5 {( "G1" 5 )} 
wvSetPosition -win $_nWave5 {("G1" 5)}
wvGetSignalClose -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvGetSignalOpen -win $_nWave5
wvGetSignalSetScope -win $_nWave5 "/testfixture1"
wvGetSignalSetScope -win $_nWave5 "/testfixture1/u_rtl"
wvSetPosition -win $_nWave5 {("G1" 7)}
wvSetPosition -win $_nWave5 {("G1" 7)}
wvAddSignal -win $_nWave5 -clear
wvAddSignal -win $_nWave5 -group {"G1" \
{/testfixture1/u_rtl/clk} \
{/testfixture1/u_rtl/reset} \
{/testfixture1/u_rtl/oem_finish} \
{/testfixture1/u_rtl/even1_wr} \
{/testfixture1/u_rtl/load} \
{/testfixture1/u_rtl/pi_end} \
{/testfixture1/u_rtl/state\[3:0\]} \
{/testfixture1/u_rtl/nstate\[3:0\]} \
}
wvAddSignal -win $_nWave5 -group {"G2" \
}
wvSelectSignal -win $_nWave5 {( "G1" 7 )} 
wvSetPosition -win $_nWave5 {("G1" 7)}
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvSelectSignal -win $_nWave5 {( "G1" 6 )} 
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomIn -win $_nWave5
wvSelectSignal -win $_nWave5 {( "G1" 5 )} 
wvSelectSignal -win $_nWave5 {( "G1" 6 )} 
wvDisplayGridCount -win $_nWave5 -off
wvGetSignalClose -win $_nWave5
wvReloadFile -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvZoomIn -win $_nWave5
wvResizeWindow -win $_nWave5 0 23 1920 1017
wvResizeWindow -win $_nWave5 0 23 1920 1017
wvSelectSignal -win $_nWave5 {( "G1" 3 )} 
wvSelectAll -win $_nWave5
wvCut -win $_nWave5
wvSetPosition -win $_nWave5 {("G1" 0)}
wvGetSignalOpen -win $_nWave5
wvSetPosition -win $_nWave5 {("G1" 26)}
wvSetPosition -win $_nWave5 {("G1" 26)}
wvAddSignal -win $_nWave5 -clear
wvAddSignal -win $_nWave5 -group {"G1" \
{/testfixture1/u_rtl/clk} \
{/testfixture1/u_rtl/count\[5:0\]} \
{/testfixture1/u_rtl/data\[31:0\]} \
{/testfixture1/u_rtl/even1_wr} \
{/testfixture1/u_rtl/even2_wr} \
{/testfixture1/u_rtl/even3_wr} \
{/testfixture1/u_rtl/even4_wr} \
{/testfixture1/u_rtl/load} \
{/testfixture1/u_rtl/nstate\[3:0\]} \
{/testfixture1/u_rtl/odd1_wr} \
{/testfixture1/u_rtl/odd2_wr} \
{/testfixture1/u_rtl/odd3_wr} \
{/testfixture1/u_rtl/odd4_wr} \
{/testfixture1/u_rtl/oem_addr\[4:0\]} \
{/testfixture1/u_rtl/oem_dataout\[7:0\]} \
{/testfixture1/u_rtl/oem_finish} \
{/testfixture1/u_rtl/pi_data\[15:0\]} \
{/testfixture1/u_rtl/pi_end} \
{/testfixture1/u_rtl/pi_fill} \
{/testfixture1/u_rtl/pi_length\[1:0\]} \
{/testfixture1/u_rtl/pi_low} \
{/testfixture1/u_rtl/pi_msb} \
{/testfixture1/u_rtl/reset} \
{/testfixture1/u_rtl/so_data} \
{/testfixture1/u_rtl/so_valid} \
{/testfixture1/u_rtl/state\[3:0\]} \
}
wvAddSignal -win $_nWave5 -group {"G2" \
}
wvSelectSignal -win $_nWave5 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 23 24 25 26 )} 
wvSetPosition -win $_nWave5 {("G1" 26)}
wvDisplayGridCount -win $_nWave5 -off
wvGetSignalClose -win $_nWave5
wvReloadFile -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvZoomOut -win $_nWave5
wvSelectSignal -win $_nWave5 {( "G1" 17 )} 
wvSetCursor -win $_nWave5 986968.252001 -snap {("G1" 17)}
wvSetCursor -win $_nWave5 1000571.913818 -snap {("G1" 19)}
wvSetCursor -win $_nWave5 1069306.205101 -snap {("G1" 17)}
wvSelectSignal -win $_nWave5 {( "G1" 22 )} 
wvSetCursor -win $_nWave5 1042456.872568 -snap {("G1" 9)}
wvSetCursor -win $_nWave5 1040666.917066 -snap {("G1" 9)}
wvSetCursor -win $_nWave5 1037802.988263 -snap {("G1" 8)}
wvSetCursor -win $_nWave5 1130164.692174 -snap {("G1" 9)}
