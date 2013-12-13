CC=avr-gcc
CPP=avr-g++
AR=avr-ar

default: build
build: libarduino.a

libarduino.a:   ${OBJS}
	${AR} crs libarduino.a $(OBJS)
	cp libarduino.a ${OUTPUTS}/lib/

.c.o: ${HDRS}
	${CC} -I ${VARIANT} ${CFLAGS} -c $*.c

.cpp.o: ${HDRS}
	${CPP} -I ${VARIANT} ${CPPFLAGS} -c $*.cpp

clean:
	rm -f *.o core a.out errs *.a
