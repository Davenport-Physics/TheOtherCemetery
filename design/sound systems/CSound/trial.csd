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

    while p4 < p3 do
        schedule(1, p4, 1,0dbfs/2,180,3.5)
        schedule(2, p4 + 2, 1,0dbfs/2,210,3.5)
        p4 += 1
        print(p3)
    od

endin

instr 4
    icnt init 0
    while icnt < p3 do
        schedule(1, icnt*2, 2,0dbfs/2,180,3.5)
        icnt += 1
    od
endin

instr 5
    out oscili(p4, p5)
endin

instr 6

    inct init 0
    while inct < p3*2 do
        schedule(5, inct*.5, 3/9, 10000, 180)
        inct += 1
    od

endin

</CsInstruments>
<CsScore>
    ;i 4 0 2 6
    ;i 3 0 8 0
    ;i 4 8 8
    i 6 0 5
</CsScore>
</CsoundSynthesizer>