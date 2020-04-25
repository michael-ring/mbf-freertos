#!/bin/sh
APPNAME=$1

if [ -z "$1" ]; then
	echo Usage: 
	echo genlpi.sh Projectname
	exit 1
fi

if [ ! -d $APPNAME ]; then
  echo Project "$APPNAME" does not exist in current directory
  exit 1
fi

rm -f $APPNAME/*.lpi
rm -f $APPNAME/*.svd
rm -f $APPNAME/*.SVD
rm -f $APPNAME/*.user

cat devicelist | grep -v "^#" | while read BOARD_OR_CPU SUBARCH DEVICE DEVICESVD; do
  ARCH=
  BINUTILS_PATH=

  if [ "$SUBARCH" = ARMV6M ]; then
    ARCH=arm
    ARCHSVD=Cortex-M0.svd
  fi

  if [ "$SUBARCH" = ARMV7M ]; then
    ARCH=arm
    ARCHSVD=Cortex-M3.svd
  fi

  if [ "$SUBARCH" = ARMV7EM ]; then
    ARCH=arm
    ARCHSVD=Cortex-M4.svd
  fi

  if [ "$SUBARCH" = MIPS32R2 ]; then
    ARCH=mipsel
  fi

  if [ "$SUBARCH" = RISCV32 ]; then
    ARCH=riscv32
    ARCHSVD=
  fi

  if [ "$SUBARCH" = AVR5 ]; then
    ARCH=avr
  fi

  BINUTILS_PATH=$ARCH-embedded-

  HEAPSIZE=8192
  STACKSIZE=8192

  cat templates/template.lpi | sed -e "s,%%APPNAME%%,$APPNAME,g" \
                       -e "s,%%ARCH%%,$ARCH,g" \
                       -e "s,%%SUBARCH%%,$SUBARCH,g" \
                       -e "s,%%BINUTILS_PATH%%,$BINUTILS_PATH,g" \
                       -e "s,%%HEAPSIZE%%,$HEAPSIZE,g" \
                       -e "s,%%STACKSIZE%%,$STACKSIZE,g" \
                       -e "s,%%EXTRACUSTOMOPTION1%%,$EXTRACUSTOMOPTION1,g" \
                       -e "s,%%EXTRACUSTOMOPTION2%%,$EXTRACUSTOMOPTION2,g" \
                       -e "s,%%EXTRACUSTOMOPTION3%%,$EXTRACUSTOMOPTION3,g" \
                       -e "s,%%BOARD_OR_CPU%%,$BOARD_OR_CPU,g" >$APPNAME/$APPNAME-$BOARD_OR_CPU.lpi
  echo $APPNAME/$APPNAME-$BOARD_OR_CPU.lpi created
  if [ -n "$ARCHSVD" ]; then
    cat templates/template.jdebug | sed -e "s,%%APPNAME%%,$APPNAME,g" \
                                      -e "s,%%ARCHSVD%%,$ARCHSVD,g" \
                                      -e "s,%%DEVICESVD%%,$DEVICESVD,g" \
                                      -e "s,%%DEVICE%%,$DEVICE,g" >$APPNAME/$APPNAME-$BOARD_OR_CPU.jdebug
    echo $APPNAME/$APPNAME-$BOARD_OR_CPU.jdebug created
  fi

  if [ ! -f $APPNAME/$APPNAME.lpr ]; then
    cat templates/template.lpr | sed "s,%%APPNAME%%,$APPNAME,g" >$APPNAME/$APPNAME.lpr
    echo $APPNAME/$APPNAME.lpr created
  fi
done
