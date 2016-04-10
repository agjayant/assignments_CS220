#!/bin/bash

nasm -f elf $1.asm 2>&1
ld -m elf_i386 -s -o $1 $1.o 2>&1 
