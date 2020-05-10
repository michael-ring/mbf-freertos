#!/bin/sh
echo "Compiling libopencm3"
cd libopencm3
make clean
make
rm -f ../lib/*.a
for file in libopencm3_stm32f0.a libopencm3_stm32g0.a libopencm3_stm32l0.a ; do
  cp lib/$file ../lib/armv6m/
done
for file in libopencm3_stm32f1.a libopencm3_stm32f2.a libopencm3_stm32l1.a ; do
  cp lib/$file ../lib/armv7m/
done
for file in libopencm3_stm32f3.a libopencm3_stm32f4.a libopencm3_stm32f7.a libopencm3_stm32g4.a libopencm3_stm32h7.a libopencm3_stm32l4.a ; do
  cp lib/$file ../lib/armv7em/
done
