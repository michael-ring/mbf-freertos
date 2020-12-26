#!/bin/sh
FREERTOSDIR=FreeRTOS-Kernel/

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
rm -f lib/libfreertos.a 2>/dev/null
rm -f lib/libfreertos_heap_4.a 2>/dev/null
rm -f lib/libfreertos_heap_5.a 2>/dev/null

echo "Compiling FreeRTOS for armv6m"
cp samples/templates/FreeRTOSConfig.h.armv6m FreeRTOSConfig.h

FLAGS="-mcpu=cortex-m0plus -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O2 -I$FREERTOSDIR/portable/GCC/ARM_CM0  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c" $FLAGS -E | grep -f freertos-defines.txt | sed -e "s,(,,g" -e "s,),,g" -e "s,uint16_t,,g" -e "s,TickType_t,,g" -e "s,size_t,,g" -e "s,[ ][ ]*, ,g" -e "s,[ ][ ]*$,,g" -e "s,#define ,{\$define,g" -e "s,$,},g" -e "s, , := ,g" -e "s,{\$define,{\$define ,g" -e "s,_STACK_,__STACK_,g" >source/FreeRTOSConfig-armv6m.inc
echo "{\$define tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE := 1}" >>source/FreeRTOSConfig-armv6m.inc
arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/armv6m/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_5.c"    $FLAGS -o lib/armv6m/heap_5.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM0/port.c"  $FLAGS -o lib/armv6m/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/armv6m/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/armv6m/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/armv6m/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/armv6m/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/armv6m/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/armv6m/timers.o
arm-none-eabi-ar rcs lib/armv6m/libfreertos.a lib/armv6m/port.o lib/armv6m/event_groups.o lib/armv6m/list.o lib/armv6m/queue.o lib/armv6m/stream_buffer.o lib/armv6m/tasks.o lib/armv6m/timers.o
arm-none-eabi-ar rcs lib/armv6m/libfreertos_heap_4.a lib/armv6m/heap_4.o
arm-none-eabi-ar rcs lib/armv6m/libfreertos_heap_5.a lib/armv6m/heap_5.o

echo "Compiling FreeRTOS for armv7m"
cp samples/templates/FreeRTOSConfig.h.armv7m FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m3     -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O2 -I$FREERTOSDIR/portable/GCC/ARM_CM3  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$FREERTOSDIR/tasks.c" $FLAGS -E | grep -f freertos-defines.txt | sed -e "s,(,,g" -e "s,),,g" -e "s,uint16_t,,g" -e "s,TickType_t,,g" -e "s,size_t,,g" -e "s,[ ][ ]*, ,g" -e "s,[ ][ ]*$,,g" -e "s,#define ,{\$define,g" -e "s,$,},g" -e "s, , := ,g" -e "s,{\$define,{\$define ,g" -e "s,_STACK_,__STACK_,g" >source/FreeRTOSConfig-armv7m.inc
echo "{\$define tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE := 1}" >>source/FreeRTOSConfig-armv7m.inc

arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/armv7m/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_5.c"    $FLAGS -o lib/armv7m/heap_5.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM3/port.c"  $FLAGS -o lib/armv7m/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/armv7m/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/armv7m/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/armv7m/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/armv7m/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/armv7m/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/armv7m/timers.o
arm-none-eabi-ar rcs lib/armv7m/libfreertos.a lib/armv7m/port.o lib/armv7m/event_groups.o lib/armv7m/list.o lib/armv7m/queue.o lib/armv7m/stream_buffer.o lib/armv7m/tasks.o lib/armv7m/timers.o
arm-none-eabi-ar rcs lib/armv7m/libfreertos_heap_4.a lib/armv7m/heap_4.o
arm-none-eabi-ar rcs lib/armv7m/libfreertos_heap_5.a lib/armv7m/heap_5.o

echo "Compiling FreeRTOS for armv7em nvic_prio_bits_3"
cp samples/templates/FreeRTOSConfig.h.armv7em.priobits3 FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m4     -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O2 -I$FREERTOSDIR/portable/GCC/ARM_CM4F -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c" $FLAGS -E | grep -f freertos-defines.txt | sed -e "s,(,,g" -e "s,),,g" -e "s,uint16_t,,g" -e "s,TickType_t,,g" -e "s,size_t,,g" -e "s,[ ][ ]*, ,g" -e "s,[ ][ ]*$,,g" -e "s,#define ,{\$define,g" -e "s,$,},g" -e "s, , := ,g" -e "s,{\$define,{\$define ,g" -e "s,_STACK_,__STACK_,g" >source/FreeRTOSConfig-armv7em.inc
echo "{\$define tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE := 1}" >>source/FreeRTOSConfig-armv7em.inc

arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM4F/port.c" $FLAGS -o lib/armv7em/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/armv7em/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/armv7em/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/armv7em/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/armv7em/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/armv7em/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/armv7em/timers.o
arm-none-eabi-ar rcs lib/armv7em/libfreertos_priobits3.a lib/armv7em/port.o lib/armv7em/event_groups.o lib/armv7em/list.o lib/armv7em/queue.o lib/armv7em/stream_buffer.o lib/armv7em/tasks.o lib/armv7em/timers.o

echo "Compiling FreeRTOS for armv7em nvic_prio_bits_4"
cp samples/templates/FreeRTOSConfig.h.armv7em.priobits4 FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m4     -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$FREERTOSDIR/include -O2 -I$FREERTOSDIR/portable/GCC/ARM_CM4F -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c" $FLAGS -E | grep -f freertos-defines.txt | sed -e "s,(,,g" -e "s,),,g" -e "s,uint16_t,,g" -e "s,TickType_t,,g" -e "s,size_t,,g" -e "s,[ ][ ]*, ,g" -e "s,[ ][ ]*$,,g" -e "s,#define ,{\$define,g" -e "s,$,},g" -e "s, , := ,g" -e "s,{\$define,{\$define ,g" -e "s,_STACK_,__STACK_,g" >source/FreeRTOSConfig-armv7em.inc
echo "{\$define tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE := 1}" >>source/FreeRTOSConfig-armv7em.inc

arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_4.c"    $FLAGS -o lib/armv7em/heap_4.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/MemMang/heap_5.c"    $FLAGS -o lib/armv7em/heap_5.o
arm-none-eabi-gcc "$FREERTOSDIR/portable/GCC/ARM_CM4F/port.c" $FLAGS -o lib/armv7em/port.o
arm-none-eabi-gcc "$FREERTOSDIR/event_groups.c"               $FLAGS -o lib/armv7em/event_groups.o
arm-none-eabi-gcc "$FREERTOSDIR/list.c"                       $FLAGS -o lib/armv7em/list.o
arm-none-eabi-gcc "$FREERTOSDIR/queue.c"                      $FLAGS -o lib/armv7em/queue.o
arm-none-eabi-gcc "$FREERTOSDIR/stream_buffer.c"              $FLAGS -o lib/armv7em/stream_buffer.o
arm-none-eabi-gcc "$FREERTOSDIR/tasks.c"                      $FLAGS -o lib/armv7em/tasks.o
arm-none-eabi-gcc "$FREERTOSDIR/timers.c"                     $FLAGS -o lib/armv7em/timers.o
arm-none-eabi-ar rcs lib/armv7em/libfreertos_priobits4.a lib/armv7em/port.o lib/armv7em/event_groups.o lib/armv7em/list.o lib/armv7em/queue.o lib/armv7em/stream_buffer.o lib/armv7em/tasks.o lib/armv7em/timers.o
arm-none-eabi-ar rcs lib/armv7em/libfreertos_heap_4.a lib/armv7em/heap_4.o
arm-none-eabi-ar rcs lib/armv7em/libfreertos_heap_5.a lib/armv7em/heap_5.o

LIBCBASE="$(arm-none-eabi-gcc -print-sysroot)/lib"
LIBCARMV6M="$(arm-none-eabi-gcc -print-multi-lib | grep v6-m | awk -F\; '{print $1}')"
if [ -f "$LIBCBASE/$LIBCARMV6M/libc_nano.a" ]; then 
  cp "$LIBCBASE/$LIBCARMV6M/libc_nano.a" lib/armv6m/
else
  echo "Could not find libc_nano.a for armv6m, please copy manually to lib/armv6m/"
  exit 1
fi
LIBCARMV7M="$(arm-none-eabi-gcc -print-multi-lib | grep v7-m | awk -F\; '{print $1}')"
if [ -f "$LIBCBASE/$LIBCARMV7M/libc_nano.a" ]; then 
  cp "$LIBCBASE/$LIBCARMV7M/libc_nano.a" lib/armv7m/
else
  echo "Could not find libc_nano.a for armv7m, please copy manually to lib/armv7m/"
  exit 1
fi
LIBCARMV7EM="$(arm-none-eabi-gcc -print-multi-lib | grep v7e-m | grep "fpv4-sp/hard" | awk -F\; '{print $1}')"
if [ -f "$LIBCBASE/$LIBCARMV7EM/libc_nano.a" ]; then 
  cp "$LIBCBASE/$LIBCARMV7EM/libc_nano.a" lib/armv7em/
else
  echo "Could not find libc_nano.a for armv6m, please copy manually to lib/armv7em/"
  exit 1
fi

rm -f FreeRTOSConfig.h
rm -f tasks.d
for dir in armv6m armv7m armv7em ; do
  rm -f lib/$dir/*.d 2>/dev/null
  rm -f lib/$dir/*.o 2>/dev/null
  rm -f lib/$dir/*.su 2>/dev/null
done
