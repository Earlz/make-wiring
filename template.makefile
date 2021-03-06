default: build
build: ${LIBOUT}
rebuild: clean build

${LIBOUT}:   ${OBJS}
	${AR} crs ${LIBOUT} $(OBJS)
	cp *.h ${OUTPUTS}/include/
	cp ${LIBOUT} ${OUTPUTS}/lib/

.c.o: ${HDRS}
	${CC} ${CFLAGS} -c $*.c

.cpp.o: ${HDRS}
	${CPP} ${CPPFLAGS} -c $*.cpp

clean:
	rm -f *.o core a.out errs *.a
