# Change src to the name of your C file.
# If you are having issues with Make complaing about spacing, make sure the 
# indents below are tabs i.e. \t rather then spaces.
src=lab15

clean:
	rm $(src).o $(src).elf $(src).hex

build:
	avr-gcc -mmcu=atmega324a -Wall -Os -c -o $(src).o $(src).c

object: build
	avr-gcc -mmcu=atmega324a -Wall -Os -o $(src).elf $(src).o

hex: object
	avr-objcopy -j .text -j .data -O ihex $(src).elf $(src).hex

flash: hex
	avrdude -p m324pa -c stk600 -P /dev/ttyACM0 -e -F -U flash:w:$(src).hex
