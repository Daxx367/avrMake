#FLAGS
#Compiler
CC=avr-gcc
FLAGS=-mmcu=atmega324a -Wall
INC=-Isrc

#Modify to point to desired folders.
SRCDIR=src
INCDIR=src
OBJDIR=obj

#Name of .hex to output.
TARGET=output

#Get all .c and .h files :)
HEADERS=$(shell du -a $(SRCDIR) | grep -E '\.(h)$$' | awk '{print $$2}')

SOURCES=$(shell du -a $(SRCDIR) | grep -E '\.(c)$$' | awk '{print $$2}')

OBJECTS=$(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
#Debug to check if you are pointing to the right directory.
#$(info $(OBJECTS))


#Default behavior.
all: $(OBJECTS) $(TARGET) flash

#Build our objects.
$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	@$(CC) $(FLAGS) -Os -c $< -o $@
	$(info $< built!)

#Link our objects.
$(TARGET): $(OBJECTS)
	$(CC) $(FLAGS) -Os $(OBJECTS) -o $(TARGET).elf
	@avr-objcopy -j .text -j .data -O ihex $(TARGET).elf $(TARGET).hex
	$(info linked $(TARGET).hex!)
	@rm -f $(TARGET).elf

flash:
	avrdude -p m324pa -c stk600 -P /dev/ttyACM0 -e -F -U flash:w:$(TARGET).hex


.PHONY: clean

clean:
	@rm -f $(OBJDIR)/* $(TARGET).hex
