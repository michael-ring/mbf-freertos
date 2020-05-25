#!/bin/sh
SEGGERSYSVIEWDIR=SeggerSYSVIEW/
SEGGERRTTDIR=SeggerRTT
FREERTOSDIR=FreeRTOS-Kernel

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

echo "Compiling SeggerSYSVIEW for armv6m"
cp samples/templates/FreeRTOSConfig.h.armv6m FreeRTOSConfig.h
FLAGS="-mcpu=cortex-m0plus -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$SEGGERRTTDIR -I$FREERTOSDIR/include -O2 -I$FREERTOSDIR/portable/GCC/ARM_CM0  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$SEGGERSYSVIEWDIR/SEGGER_SYSVIEW.c"    $FLAGS -o lib/armv6m/SEGGER_SYSVIEW.o
arm-none-eabi-ar rcs lib/armv6m/libseggersysview.a lib/armv6m/SEGGER_SYSVIEW.o 

arm-none-eabi-gcc "$SEGGERSYSVIEWDIR/SEGGER_SYSVIEW_FreeRTOS.c"    $FLAGS -o lib/armv6m/SEGGER_SYSVIEW_FreeRTOS.o
arm-none-eabi-ar rcs lib/armv6m/libseggersysview_freertos.a lib/armv6m/SEGGER_SYSVIEW_FreeRTOS.o 

exit 1

echo "Compiling SeggerSYSVIEW for armv7m"
FLAGS="-mcpu=cortex-m3     -mfloat-abi=soft                   -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$SEGGERRTTDIR -I$FREERTOSDIR/include -O2 -I$FREERTOSDIR/portable/GCC/ARM_CM3  -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$SEGGERSYSVIEWDIR/SEGGER_SYSVIEW.c"    $FLAGS -o lib/armv7m/SEGGER_SYSVIEW.o
arm-none-eabi-ar rcs lib/armv7m/libseggersysview.a lib/armv7m/SEGGER_SYSVIEW.o 

echo "Compiling SeggerSYSVIEW for armv7em"
FLAGS="-mcpu=cortex-m4     -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -std=gnu11 -g3 -DDEBUG -c \
       -I. -I$SEGGERRTTDIR -I$FREERTOSDIR/include -O2 -I$FREERTOSDIR/portable/GCC/ARM_CM4F -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP --specs=nano.specs"

arm-none-eabi-gcc "$SEGGERSYSVIEWDIR/SEGGER_SYSVIEW.c"    $FLAGS -o lib/armv7em/SEGGER_SYSVIEW.o
arm-none-eabi-ar rcs lib/armv7em/libseggersysview.a lib/armv7em/SEGGER_SYSVIEW.o 
