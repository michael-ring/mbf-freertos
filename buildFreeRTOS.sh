#!/bin/sh
FREERTOSDIR=FreeRTOS-Kernel/

mkdir -p lib/armv6m   2>/dev/null
mkdir -p lib/armv7m   2>/dev/null
mkdir -p lib/armv7em  2>/dev/null
rm -f lib/armv6m/*    2>/dev/null
rm -f lib/armv7m/*    2>/dev/null
rm -f lib/armv7em/*   2>/dev/null
rm -f lib/libfreertos* 2>/dev/null

echo "Compiling FreeRTOS for armv6m"
cp samples/templates/FreeRTOSConfig.h.armv6m FreeRTOSConfig.h

FLAGS="-mcpu=cortex-m0plus -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM0  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c" $FLAGS -E | grep -f freertos-defines.txt | sed -e "s,(,,g" -e "s,),,g" -e "s,uint16_t,,g" -e "s,TickType_t,,g" -e "s,size_t,,g" -e "s,[ ][ ]*, ,g" -e "s,[ ][ ]*$,,g" -e "s,#define ,{\$define,g" -e "s,$,},g" -e "s, , := ,g" -e "s,{\$define,{\$define ,g" -e "s,_STACK_,__STACK_,g" >source/FreeRTOSConfig-armv6m.inc
echo "{\$define tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE := 1}" >>source/FreeRTOSConfig-armv6m.inc
arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/armv6m/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM0/port.c"  $FLAGS -o lib/armv6m/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/armv6m/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/armv6m/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/armv6m/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/armv6m/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/armv6m/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/armv6m/timers.o
arm-none-eabi-ar rcs lib/armv6m/libfreertos.a lib/armv6m/port.o lib/armv6m/event_groups.o lib/armv6m/list.o lib/armv6m/queue.o lib/armv6m/stream_buffer.o lib/armv6m/tasks.o lib/armv6m/timers.o
arm-none-eabi-ar rcs lib/armv6m/libfreertos_heap_4.a lib/armv6m/heap_4.o

echo "Compiling FreeRTOS for armv7m"
cp samples/templates/FreeRTOSConfig.h.armv7m FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m3     -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM3  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$FREERTOSDIR/tasks.c" $FLAGS -E | grep -f freertos-defines.txt | sed -e "s,(,,g" -e "s,),,g" -e "s,uint16_t,,g" -e "s,TickType_t,,g" -e "s,size_t,,g" -e "s,[ ][ ]*, ,g" -e "s,[ ][ ]*$,,g" -e "s,#define ,{\$define,g" -e "s,$,},g" -e "s, , := ,g" -e "s,{\$define,{\$define ,g" -e "s,_STACK_,__STACK_,g" >source/FreeRTOSConfig-armv7m.inc
echo "{\$define tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE := 1}" >>source/FreeRTOSConfig-armv7m.inc

arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/armv7m/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM3/port.c"  $FLAGS -o lib/armv7m/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/armv7m/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/armv7m/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/armv7m/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/armv7m/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/armv7m/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/armv7m/timers.o
arm-none-eabi-ar rcs lib/armv7m/libfreertos.a lib/armv7m/port.o lib/armv7m/event_groups.o lib/armv7m/list.o lib/armv7m/queue.o lib/armv7m/stream_buffer.o lib/armv7m/tasks.o lib/armv7m/timers.o
arm-none-eabi-ar rcs lib/armv7m/libfreertos_heap_4.a lib/armv7m/heap_4.o

echo "Compiling FreeRTOS for armv7em"
cp samples/templates/FreeRTOSConfig.h.armv7em FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m4     -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O0 -I$FREERTOSDIR/portable/GCC/ARM_CM4F -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c" $FLAGS -E | grep -f freertos-defines.txt | sed -e "s,(,,g" -e "s,),,g" -e "s,uint16_t,,g" -e "s,TickType_t,,g" -e "s,size_t,,g" -e "s,[ ][ ]*, ,g" -e "s,[ ][ ]*$,,g" -e "s,#define ,{\$define,g" -e "s,$,},g" -e "s, , := ,g" -e "s,{\$define,{\$define ,g" -e "s,_STACK_,__STACK_,g" >source/FreeRTOSConfig-armv7em.inc
echo "{\$define tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE := 1}" >>source/FreeRTOSConfig-armv7em.inc

arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/armv7em/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM4F/port.c" $FLAGS -o lib/armv7em/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/armv7em/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/armv7em/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/armv7em/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/armv7em/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/armv7em/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/armv7em/timers.o
arm-none-eabi-ar rcs lib/armv7em/libfreertos.a lib/armv7em/port.o lib/armv7em/event_groups.o lib/armv7em/list.o lib/armv7em/queue.o lib/armv7em/stream_buffer.o lib/armv7em/tasks.o lib/armv7em/timers.o
arm-none-eabi-ar rcs lib/armv7em/libfreertos_heap_4.a lib/armv7em/heap_4.o

rm -f FreeRTOSConfig.h
