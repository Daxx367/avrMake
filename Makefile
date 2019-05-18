#Build parameters
#Compiler.
CC=avr-gcc
#Compiler flags.
CCFLAGS= -mmcu=atmega324pa -Wall -Os
#Flag to indicate location of our header files.
INC=-Isrc

#Modify to point to desired folders.
#Our source code ".c".
SRCDIR=src
#Our include directory ".h".
INCDIR=src
#Where we want to store our objects.
OBJDIR=obj

#Name of .hex to output.
TARGET=output

#Get all .c and .h files in the directories we outlined above.
HEADERS=$(shell du -a $(SRCDIR) | grep -E '\.(h)$$' | awk '{print $$2}')
SOURCES=$(shell du -a $(SRCDIR) | grep -E '\.(c)$$' | awk '{print $$2}')

#Generate the names of the objects we are going to build.
OBJECTS=$(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

#Debug to check if you are pointing to the right directory.
#$(info $(OBJECTS))

#Make our object target directory if it does not exist.
$(shell mkdir -p $(OBJDIR))

#Default behavior e.g "make" we build our objects, link them and flash.
all: build flash

build: $(OBJECTS) $(TARGET) translate

#Build our objects.
$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	@$(CC) $(CCFLAGS) $(INC) -c $< -o $@
	$(info $< built!)

#Link our objects.
$(TARGET): $(OBJECTS)
	@$(CC) $(CCFLAGS) $(OBJECTS) -o $(TARGET).elf
	$(info linked $(TARGET).hex!)
	
translate: $(TARGET).elf
	@avr-objcopy -j .text -j .data -O ihex $(TARGET).elf $(TARGET).hex
	@rm -f $(TARGET).elf
	$(info translated $< to $(TARGET).hex)

flash:
	avrdude -p m324pa -c stk600 -P /dev/ttyACM0 -F -U flash:w:$(TARGET).hex

erase:
	avrdude -p m324pa -c stk600 -P /dev/ttyACM0 -F -e

.PHONY: clean

clean:
	@rm -f $(OBJDIR)/* $(TARGET).hex
