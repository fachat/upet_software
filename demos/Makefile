
PRGS=
ASM=updemo #term

all: $(PRGS) $(ASM)

updemo.hex: updemo
	hexdump -C $< > $@.hex

$(ASM): % : %.a65 *.i65
	xa -w -XCA65 -P$@.lst -l $@.lab -o $@ $<

${PRGS}: % : %.bas
	petcat -w40 -o $@ $<

clean:
	rm -f updemo.lab updemo.hex

