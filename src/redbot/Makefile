#BSD licensed, see http://lastyearswishes.com/static/Makefile for full license

#Change this for different MCUs. Standard includes atmega328
VARIANT = ../variants/standard 

HDRS=RedBot.h

OBJS=RedBot.o RedBotAccel.o RedBotMotor.o RedBotSensor.o


CPPFLAGS = -I../arduino/ -I./ -DF_CPU=16000000UL -Os -mmcu=atmega328p

CC=avr-gcc
CPP=avr-g++
AR=avr-ar


default: libredbot.a

libredbot.a:   ${OBJS}
	${AR} crs libredbot.a $(OBJS)

.c.o: ${HDRS}
	${CC} -I ${VARIANT} ${CFLAGS} -c $*.c

.cpp.o: ${HDRS}
	${CPP} -I ${VARIANT} ${CPPFLAGS} -c $*.cpp

clean:
	rm -f ${OBJS} core a.out errs *.a

install: libarduino.a
	mkdir -p ${PREFIX}/lib
	mkdir -p ${PREFIX}/include
	cp *.h ${PREFIX}/include
	cp *.a ${PREFIX}/lib
