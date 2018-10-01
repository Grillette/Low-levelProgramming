# makefile of improved version
# "make" compile and upload the code

LD=arm-none-eabi-gcc
AS=arm-none-eabi-as
OBJCOPY=arm-none-eabi-objcopy

LDFLAGS=-nostdlib
ASFLAGS=-mcpu=cortex-m3 -mthumb -g

LINKERSCRIPT=efm32gg.ld

	
upload : ex1_interrupt.bin
	-eACommander.sh -r --address 0x00000000 -f "ex1_interrupt.bin" -r

	
ex1_interrupt.bin : ex1_interrupt.elf
	${OBJCOPY} -j .text -O binary $< $@

ex1_interrupt.elf : ex1_interrupt.o 
	${LD} -T ${LINKERSCRIPT} $^ -o $@ ${LDFLAGS} 

ex1_interrupt.o : ex1_interrupt.s efm32gg.o
	${AS} ${ASFLAGS} $< -o $@

efm32gg.o : efm32gg.s
	${AS} ${ASFLAGS} $< -o $@

 

.PHONY : clean
clean :
	-rm -rf *.o *.elf *.bin *.hex
