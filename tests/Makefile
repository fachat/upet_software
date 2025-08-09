
ASM=map 8296screen virtpet i2c i2ckbd
BASIC=readflash rtcc batmem sdcard showcols eeprom

all: ${ASM} ${BASIC}

clean:
	rm -f ${ASM} ${BASIC}

${ASM}: %: %.a65
	xa -w -XMASM $< -o $@

${BASIC}: %: %.lst
	petcat -w40 -o $@ $<


