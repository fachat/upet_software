
PRGS=geoex
ASM=

all: $(PRGS) $(ASM)

$(ASM): % : %.a65 *.i65
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

${PRGS}: % : %.bas
	petcat -w40 -o $@ $<

clean:
	

