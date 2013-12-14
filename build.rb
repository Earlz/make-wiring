#!/bin/ruby
VARIANT='standard'
CPUFREQ="16000000UL"
MCU="atmega328p"

CFLAGS="-Os -Wl,--gc-sections -ffunction-sections  -fdata-sections"
CPPFLAGS="-Os -Wl,--gc-sections -ffunction-sections  -fdata-sections"

ARFLAGS=""

CC="avr-gcc"
CPP="avr-g++"
AR="avr-ar"


SOURCES="src"
OUTPUTS="output"

def getfiles(dir, ending)
  t=""
  Dir["#{dir}/*.#{ending}"].each{ |f|  t+='"'+File.basename(f)+'" '; }
  t
end

def domake(src, action, objs,hdrs, cppflags, cflags, arflags, out, lib)
  `make -C #{src} #{action} OBJS="#{objs}" CPPFLAGS="#{CPPFLAGS} #{cppflags}" CFLAGS="#{CFLAGS} #{cflags}"\
      ARFLAGS="#{arflags}" OUTPUTS="#{out}" HDRS="#{hdrs}" LIBOUT="#{lib}" \
      AR="#{AR}" CC="#{CC}" CPP="#{CPP}" \
      1>&2`
  #make sure to redirect STDOUT to STDERR so it's visible
end

if ARGV.length < 2
  puts 'usage: ./build.rb action library'
  exit
end

`mkdir -p output/include`
`mkdir -p output/lib`
`cp variants/#{VARIANT}/pins_arduino.h #{OUTPUTS}/include/`

action=ARGV[0] 
library=ARGV[1]

dir="#{SOURCES}/#{library}"
`cp template.makefile #{SOURCES}/#{library}/Makefile`
objs=getfiles(dir, "c").gsub(".c",".o");
objs+=" "+getfiles(dir, "cpp").gsub(".cpp", ".o");
out="../../#{OUTPUTS}"
cflags="-I#{out}/include -I./ -I./utility/ -I../../variants/#{VARIANT} -mmcu=#{MCU} -DF_CPU=#{CPUFREQ}"
cppflags=cflags
hdrs=getfiles(dir, "h")
arflags=""

domake("#{dir}", action, objs, hdrs, cppflags, cflags, arflags, out, "lib#{library}.a")
`rm -f "#{SOURCES}/#{library}/Makefile"`
