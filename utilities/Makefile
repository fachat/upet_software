
PRGS=geoex spritex
ASM=geoexutil 

all: $(PRGS) $(ASM) flashmon

$(ASM): % : %.a65 
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

flashmon: flashmon.a65 spi-UPET.s spi.inc
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

${PRGS}: % : %.bas
	petcat -w40 -o $@ $<

clean:
	

