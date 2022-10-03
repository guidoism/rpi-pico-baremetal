
ARMGNU ?= arm-none-eabi

XCPU = -mcpu=cortex-m0

AOPS = --warn --fatal-warnings $(XCPU)
COPS = -Wall -O2 -ffreestanding $(XCPU)
LOPS = -nostdlib

all : notmain.uf2

pdf:
	python list_to_tex.py < blinker00.txt > blinker00.tex && luatex blinker00 && open blinker00.pdf

makeuf2 : makeuf2.c crcpico.h
	gcc -O2 makeuf2.c -o makeuf2

notmain.uf2 : notmain.bin makeuf2
	./makeuf2 notmain.bin notmain.uf2

blink.o: blink.s
	$(ARMGNU)-as $(AOPS) blink.s -o blink.o

notmain.bin: memmap.ld blink.o
	$(ARMGNU)-ld $(LOPS) -T memmap.ld blink.o -o notmain.elf
	$(ARMGNU)-objdump -D notmain.elf > notmain.list
	$(ARMGNU)-objcopy -O binary notmain.elf notmain.bin
