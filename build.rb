#!/bin/ruby
VARIANT='standard'
CPUFREQ="16000000UL"
MCU="atmega328p"

CFLAGS="-Os"
CPPFLAGS="-Os"

ARFLAGS=""


SOURCES="src"
OUTPUTS="output"

def getfiles(dir, ending)
  t=""
  Dir["#{dir}/*.#{ending}"].each{ |f|  t+='"'+File.basename(f)+'" '; }
  t
end

def domake(src, action, objs,hdrs, cppflags, cflags, arflags, out, lib)
  puts "make -C #{src} #{action} OBJS=\"#{objs}\" CPPFLAGS=\"#{cppflags}\" CFLAGS=\"#{cflags}\" ARFLAGS=\"#{arflags}\" OUTPUTS=\"#{out}\" HDRS=\"#{hdrs}\" LIBOUT=\"#{lib}\""
  `make -C #{src} #{action} OBJS="#{objs}" CPPFLAGS="#{cppflags}" CFLAGS="#{cflags}" ARFLAGS="#{arflags}" OUTPUTS="#{out}" HDRS="#{hdrs}" LIBOUT="#{lib}"`
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
objs=getfiles(dir, "c").gsub(".c",".o");
objs+=" "+getfiles(dir, "cpp").gsub(".cpp", ".o");
out="../../#{OUTPUTS}"
cflags="-I#{out}/include -I./ -I../../variants/#{VARIANT} -mmcu=#{MCU} -DF_CPU=#{CPUFREQ}"
cppflags=cflags
hdrs=getfiles(dir, "h")
arflags=""

domake("#{dir}", action, objs, hdrs, cppflags, cflags, arflags, out, "lib#{library}.a")

