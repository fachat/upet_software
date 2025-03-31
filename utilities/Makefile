
PRGS=geoex spritex
ASM=geoexutil

all: $(PRGS) $(ASM)

$(ASM): % : %.a65 
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

${PRGS}: % : %.bas
	petcat -w40 -o $@ $<

clean:
	

