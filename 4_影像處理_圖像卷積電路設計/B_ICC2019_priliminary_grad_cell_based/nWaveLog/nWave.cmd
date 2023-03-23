wvResizeWindow -win $_nWave1 0 23 1920 1017
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/jorjor/CIC/B_ICC2019_priliminary_grad_cell_based/CONV.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/testfixture"
wvGetSignalSetScope -win $_nWave1 "/testfixture/u_CONV"
wvSetPosition -win $_nWave1 {("G1" 24)}
wvSetPosition -win $_nWave1 {("G1" 24)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/testfixture/u_CONV/L0_ans\[19:0\]} \
{/testfixture/u_CONV/bias\[19:0\]} \
{/testfixture/u_CONV/busy} \
{/testfixture/u_CONV/caddr_rd\[11:0\]} \
{/testfixture/u_CONV/caddr_wr\[11:0\]} \
{/testfixture/u_CONV/cdata_rd\[19:0\]} \
{/testfixture/u_CONV/cdata_wr\[19:0\]} \
{/testfixture/u_CONV/clk} \
{/testfixture/u_CONV/crd} \
{/testfixture/u_CONV/csel\[2:0\]} \
{/testfixture/u_CONV/cwr} \
{/testfixture/u_CONV/i\[31:0\]} \
{/testfixture/u_CONV/iaddr\[11:0\]} \
{/testfixture/u_CONV/idata\[19:0\]} \
{/testfixture/u_CONV/kernel} \
{/testfixture/u_CONV/mul\[39:0\]} \
{/testfixture/u_CONV/nstate\[4:0\]} \
{/testfixture/u_CONV/ready} \
{/testfixture/u_CONV/reset} \
{/testfixture/u_CONV/state\[4:0\]} \
{/testfixture/u_CONV/total\[39:0\]} \
{/testfixture/u_CONV/weight\[19:0\]} \
{/testfixture/u_CONV/x\[5:0\]} \
{/testfixture/u_CONV/y\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 23 24 )} 
wvSetPosition -win $_nWave1 {("G1" 24)}
wvSetPosition -win $_nWave1 {("G1" 24)}
wvSetPosition -win $_nWave1 {("G1" 24)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/testfixture/u_CONV/L0_ans\[19:0\]} \
{/testfixture/u_CONV/bias\[19:0\]} \
{/testfixture/u_CONV/busy} \
{/testfixture/u_CONV/caddr_rd\[11:0\]} \
{/testfixture/u_CONV/caddr_wr\[11:0\]} \
{/testfixture/u_CONV/cdata_rd\[19:0\]} \
{/testfixture/u_CONV/cdata_wr\[19:0\]} \
{/testfixture/u_CONV/clk} \
{/testfixture/u_CONV/crd} \
{/testfixture/u_CONV/csel\[2:0\]} \
{/testfixture/u_CONV/cwr} \
{/testfixture/u_CONV/i\[31:0\]} \
{/testfixture/u_CONV/iaddr\[11:0\]} \
{/testfixture/u_CONV/idata\[19:0\]} \
{/testfixture/u_CONV/kernel} \
{/testfixture/u_CONV/mul\[39:0\]} \
{/testfixture/u_CONV/nstate\[4:0\]} \
{/testfixture/u_CONV/ready} \
{/testfixture/u_CONV/reset} \
{/testfixture/u_CONV/state\[4:0\]} \
{/testfixture/u_CONV/total\[39:0\]} \
{/testfixture/u_CONV/weight\[19:0\]} \
{/testfixture/u_CONV/x\[5:0\]} \
{/testfixture/u_CONV/y\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 23 24 )} 
wvSetPosition -win $_nWave1 {("G1" 24)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 2297122.035859 -snap {("G2" 0)}
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvSelectSignal -win $_nWave1 {( "G1" 12 )} 
wvSelectSignal -win $_nWave1 {( "G1" 13 )} 
wvSelectSignal -win $_nWave1 {( "G1" 13 )} 
wvSelectSignal -win $_nWave1 {( "G1" 22 )} 
wvSetCursor -win $_nWave1 6025.269535 -snap {("G1" 22)}
wvSetCursor -win $_nWave1 6070.150500 -snap {("G1" 22)}
