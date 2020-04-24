#!/bin/sh
echo "Compiling libopencm3"
cd libopencm3
make clean
make
rm -f ../lib/*.a
cp lib/*.a ../lib/