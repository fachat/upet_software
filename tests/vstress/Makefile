
PRGS=

all: vstress 

vstress: pet_burnin.a65 *.a65 */*.a65
	xa -w -XMASM -l $@.lab -o $@ $<

vstress.hex: 
	hexdump -C $@ > $@.hex
	#diff -u $@.hex ../8296_burnin/8296\ burnin.hex


${PRGS}: % : %.lst
	petcat -w40 -o $@ $<

clean:
	rm -f vstress.lab 

