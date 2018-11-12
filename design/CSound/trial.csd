<CsoundSynthesizer>
<CsOptions>
    -odac
</CsOptions>
<CsInstruments>
instr 1
   out(oscili(p4/2 + oscili:k(p4/2, p6), p5))
endin
instr 2
   out(oscili(p4, p5 + oscili:k(p5/100,p6)))
endin
instr 3
    schedule(1,0,1,0dbfs/2,180,3.5)
    schedule(2,1,1,0dbfs/2,210,3.5)
endin
</CsInstruments>
<CsScore>
    i 3 0 2
</CsScore>
</CsoundSynthesizer>