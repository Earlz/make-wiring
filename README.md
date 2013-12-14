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






