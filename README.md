# About
This is a basic make file to allow for the easy flashing of AVR Micros from Linux or OSX.
Note: in our makefile and scripts we specify the device name as the atmega342pa even though we are using the atmega342a.
This is because there is no entry for the atmega342a however they share the architeture and memory space which you can see for yourself in the manual.

## The Makefile

### Requirements
It requires the following:
- avr-gcc
- avr-libc
- avrdude
- make
    
### Usage
1. (Not sure if required for OSX) Add your user to dialout - ```sudo usermod -a -G dialout username``` Note: you may need to relog for this to take effect.
2. Note: It is best to have a new directory for each project.
3. Place this file in the project directory.
4. Modify the Makefile to point to the desired directories.

- ```make``` will compile and link your program and attempt to flash to the avr.
- ```make build``` will only build the .hex.
- ```make flash``` will only attempt to flash.
- ```make clean``` will remove all object files and the output.hex.

This is currently set for the ATMEGA324A you will need to change both the -mmcu and the -p in avr-gcc and avrdude respectivly.

## The extra scripts

To use the scripts remember to make them executable with chmod +x name_of_script.sh.

```./connect_to_serial.sh```
- requires gnu screen
- need to check the serial port in /dev/ (mine was /dev/ttyUSB0)

```./recover_fuses_atmega324a.sh```
- dont use this unless you are sure you have witten to some undesired fuses, I suggest using ATMEL studio to attempt to reset the fuses first

## Note on linting in VScode 
If you wish to have linting working in VScode, you will need to point it to the include folder of avr-libc.
For me this was ```/usr/avr/include/``` but this may differ on your distribution.
If you add /yourAvrInclude/** to the "Include path" of VScodes C/C++ Configurations this will allow for the use of AVR related headers.
i.e. ```/usr/avr/include/**``` in the "Include path" box leaving any existing values there as they allow it to find headers in the working directory.

Then in the Defines add ```__AVR_ATmega324A__``` this will tell the linter to add this to the top of every file.
This is needed as this would normaly be done by the -mmcu command of the avr-gcc, at linking/ compile time.


