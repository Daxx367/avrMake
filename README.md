# About
This is a basic make file to allow for the easy flashing of AVR Micros from Linux or OSX.

## Requirements
It requires the following:
- avr-gcc
- avr-libc
- avrdude
- make
    
## Usage
1. (Not sure if required for OSX) Add your user to dialout - `sudo usermod -a -G dialout username` Note: you may need to relog for this to take effect.
2. Note: It is best to have a new directory for each project.
3. Place this file in the project directory.
4. Modify the Makefile to point to the desired directories.

- ```make``` will compile and link your program and attempt to flash to the avr.
- ```make build``` will only build the .hex.
- ```make flash``` will only attempt to flash.
- ```make clean``` will remove all object files and the output.hex.

This is currently set for the ATMEGA324A you will need to change both the -mmcu and the -p in avr-gcc and avrdude respectivly.

## WARNINGS
DO NOT DISCONNECT/POWEROFF THE AVR DURING FLASHING, YOU CAN SET A FUSE AND MAKE YOUR LIFE DIFFICULT!
