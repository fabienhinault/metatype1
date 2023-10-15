# from https://tug.org/TUGboat/tb28-2/tb89hoeppner.pdf
METATYPE1 = /mt1

.PHONY: pfb tfm proof all

all: pfb tfm

proof: $(FONT).pdf

pfb: $(FONT).pfb

tfm: $(FONT).tfm

%.p: %.mp
	mpost "\generating:=0; \input $<"
	gawk -f $(METATYPE1)/mp2pf.awk \
		-vCD=$(METATYPE1)/pfcommon.dat \
		-vNAME=‘basename $< .mp‘

%.pn: %.p
	gawk -f $(METATYPE1)/packsubr.awk \
		-vVERBOSE=1 -vLEV=5 -vOUP=$@ $<

%.pfb: %.pn
	t1asm -b $< $@

%.tfm: %.mp
	mpost "\generating:=1; \input $<"

%.pdf: %.ps
	ps2pdf $< $@

%.ps: %.dvi
	dvips -o $@ $<

%.dvi: %.tex
	tex $<

%.tex: %.mp
	mpost $<
	cp $< _t_m_p.mp
	mft _t_m_p.mp -style=mt1form.mft
	echo ’\input mt1form.sty’ > $@
	test -f piclist.tex && cat piclist.tex >> $@
	test -f _t_m_p.tex && cat _t_m_p.tex >> $@
	echo ’\endproof’ >> $@
