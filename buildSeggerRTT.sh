#!/bin/sh
SEGGERRTTDIR=SeggerRTT/

mkdir -p lib/armv6m      2>/dev/null
mkdir -p lib/armv7m      2>/dev/null
mkdir -p lib/armv7em     2>/dev/null
rm -f lib/armv6m/*.o     2>/dev/null
rm -f lib/armv6m/*.d     2>/dev/null
rm -f lib/armv6m/*.su    2>/dev/null
rm -f lib/armv7m/*.o     2>/dev/null
rm -f lib/armv7m/*.d     2>/dev/null
rm -f lib/armv7m/*.su    2>/dev/null
rm -f lib/armv7em/*.o    2>/dev/null
rm -f lib/armv7em/*.d    2>/dev/null
rm -f lib/armv7em/*.su   2>/dev/null
rm -f lib/libseggerrtt.a 2>/dev/null

echo "Compiling SeggerRTT for armv6m"

FLAGS="-mcpu=cortex-m0plus -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM0  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$SEGGERRTTDIR/SEGGER_RTT.c"    $FLAGS -o lib/armv6m/SEGGER_RTT.o
arm-none-eabi-ar rcs lib/armv6m/libseggerrtt.a lib/armv6m/SEGGER_RTT.o 

echo "Compiling SeggerRTT for armv7m"
FLAGS="-mcpu=cortex-m3     -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM3  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$SEGGERRTTDIR/SEGGER_RTT.c"    $FLAGS -o lib/armv7m/SEGGER_RTT.o
arm-none-eabi-ar rcs lib/armv7m/libseggerrtt.a lib/armv7m/SEGGER_RTT.o

echo "Compiling SeggerRTT for armv7em"
FLAGS="-mcpu=cortex-m4     -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM4F -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$SEGGERRTTDIR/SEGGER_RTT.c"    $FLAGS -o lib/armv7em/SEGGER_RTT.o
arm-none-eabi-ar rcs lib/armv7em/libseggerrtt.a lib/armv7em/SEGGER_RTT.o
