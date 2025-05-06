
PRGS=geoex spritex
ASM=geoexutil optmenu

all: $(PRGS) $(ASM) flashmon flashrom

$(ASM): % : %.a65 
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

flashmon: flashmon.a65 flashlib.a65 spi-UPET.s spi.inc
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

flashrom: flashrom.a65 flashlib.a65 spi-UPET.s spi.inc
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

${PRGS}: % : %.bas
	petcat -w40 -o $@ $<

clean:
	rm -f *.lst *.lab

