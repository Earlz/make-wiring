make-wiring
===========

I got fed up with it being difficult to build Arduino libraries from the command line/without the Arduino IDE..
so I did something about it. 

This is a copy of the Arduino libraries (placed in src), a Makefile template, and a fancy build helper written in Ruby

# Usage

Usage is quite simple

    ./build.sh build arduino
    ./build.sh build Wire
    
and afterwards, you'll have the relevant header files and compiled libraries in the `output` directory

There are three possible options for every library

1. build -- This will build the library. It will not do more work than necessary
2. clean -- This will remove all the compiled files from the src directory. It will not remove files from the output directory
3. rebuild -- will clean and then build

# Retargetting

I could've crafted a crufty set of makefiles, but I chose this because it's RIDICULOUSLY EASY to retarget. 

I have everything configured by default for atmega328p with the "standard" pin layout. This is trivial to change though. 
Just open up build.rb and change the relevant files

    VARIANT='standard' #where to get the `pins_arduino.h` file
    CPUFREQ="16000000UL"
    MCU="atmega328p"

If you're unsure of your board's "variant", frequency, or other variables, you can look at `boards.txt` to get a few clues.
It should be straight forward to map your board's configuration to this build file for easy building of libraries.

You can also tweak other parameters like `CFLAGS` to your liking as well.

# Usage from within programs

After compiling your dependent libraries, using them from your own programs is easy.

    avr-g++ -o hello.elf hello.c ${CFLAGS} -L~/make-wiring/output/lib -I~/make-wiring/output/include -lSoftwareSerial -lWire -lArduino

Of course, yours will probably vary, but you get the point. Everything is put in one simple place, the output directory.

# Updating

I pulled these from Master on Arduino at the moment. If you want to update (or downgrade), it's trivial.

1. Clone the [Arduino](https://github.com/arduino/Arduino) git repository
2. Checkout the appropriate version
3. `cp -r Arduino/libraries/* make-wiring/src/`
4. `cp -r Arduino/hardware/arduino/cores/* make-wiring/src/`

Note, this puts "cores" as "libraries" while this isn't really the case. So, basically, don't build both `robot` and `arduino`. 
They conflict with each other
