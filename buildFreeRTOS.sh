#!/bin/sh
FREERTOSDIR=FreeRTOS-Kernel/

mkdir -p lib/cortexm0p   2>/dev/null
mkdir -p lib/cortexm3    2>/dev/null
mkdir -p lib/cortexm4f   2>/dev/null
rm -f lib/cortexm0p/* 2>/dev/null
rm -f lib/cortexm3/*  2>/dev/null
rm -f lib/cortexm4f/* 2>/dev/null

echo "Compiling FreeRTOS for CortexM0+"
cp samples/templates/FreeRTOSConfig.h.cortexm0p FreeRTOSConfig.h

FLAGS="-mcpu=cortex-m0plus -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM0  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"
arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/cortexm0p/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM0/port.c"  $FLAGS -o lib/cortexm0p/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/cortexm0p/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/cortexm0p/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/cortexm0p/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/cortexm0p/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/cortexm0p/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/cortexm0p/timers.o

echo "Compiling FreeRTOS for CortexM3"
cp samples/templates/FreeRTOSConfig.h.cortexm3 FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m3     -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM3  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/cortexm3/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM3/port.c"  $FLAGS -o lib/cortexm3/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/cortexm3/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/cortexm3/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/cortexm3/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/cortexm3/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/cortexm3/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/cortexm3/timers.o

echo "Compiling FreeRTOS for CortexM4F"
cp samples/templates/FreeRTOSConfig.h.cortexm4f FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m4     -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM4F -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"
arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/cortexm4f/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM4F/port.c" $FLAGS -o lib/cortexm4f/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/cortexm4f/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/cortexm4f/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/cortexm4f/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/cortexm4f/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/cortexm4f/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/cortexm4f/timers.o

rm -f FreeRTOSConfig.h