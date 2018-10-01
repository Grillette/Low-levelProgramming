# Example Makefile
#
# Exercise 1, TDT4258

LD=arm-none-eabi-gcc
AS=arm-none-eabi-as
OBJCOPY=arm-none-eabi-objcopy

LDFLAGS=-nostdlib
ASFLAGS=-mcpu=cortex-m3 -mthumb -g

LINKERSCRIPT=efm32gg.ld

ex1.bin : ex1.elf
	${OBJCOPY} -j .text -O binary $< $@

ex1.elf : ex1.o 
	${LD} -T ${LINKERSCRIPT} $^ -o $@ ${LDFLAGS} 

ex1.o : ex1.s efm32gg.o
	${AS} ${ASFLAGS} $< -o $@
	
ex1_interrupt.bin : ex1_interrupt.elf
	${OBJCOPY} -j .text -O binary $< $@

ex1_interrupt.elf : ex1_interrupt.o 
	${LD} -T ${LINKERSCRIPT} $^ -o $@ ${LDFLAGS} 

ex1_interrupt.o : ex1_interrupt.s efm32gg.o
	${AS} ${ASFLAGS} $< -o $@

efm32gg.o : efm32gg.s
	${AS} ${ASFLAGS} $< -o $@

all : ex1.bin ex1_interrupt.bin

polling : ex1.bin

interrupt : ex1_interrupt.bin 


.PHONY : upload
upload_polling :
	-eACommander.sh -r --address 0x00000000 -f "ex1.bin" -r
	
upload_interrupt :
	-eACommander.sh -r --address 0x00000000 -f "ex1_interrupt.bin" -r


.PHONY : clean
clean :
	-rm -rf *.o *.elf *.bin *.hex
