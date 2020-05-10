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
  ARCHSVD=
  BINUTILS_PATH=

  if [ "$SUBARCH" = armv6m ]; then
    ARCH=arm
    ARCHSVD=Cortex-M0.svd
  fi

  if [ "$SUBARCH" = armv7m ]; then
    ARCH=arm
    ARCHSVD=Cortex-M3.svd
  fi

  if [ "$SUBARCH" = armv7em ]; then
    ARCH=arm
    ARCHSVD=Cortex-M4.svd
  fi

  if [ "$SUBARCH" = lx6 ]; then
    ARCH=xtensa
  fi

  if [ "$SUBARCH" = mips32r2 ]; then
    ARCH=mipsel
  fi

  if [ "$SUBARCH" = riscv32 ]; then
    ARCH=riscv32
  fi

  if [ "$SUBARCH" = avr5 ]; then
    ARCH=avr
  fi

  BINUTILS_PATH=$ARCH-embedded-
  if [ "$SUBARCH" == "lx6" ]; then
    BINUTILS_PATH=xtensa-esp32-elf-
  fi

  DONOTGENERATE=
  if [ -f $APPNAME/devicelist.ignore ]; then
    grep "$BOARD_OR_CPU" $APPNAME/devicelist.ignore >/dev/null
    if [ "$?" == "0" ]; then
      DONOTGENERATE=yes
    fi
  fi
  if [ -z "$DONOTGENERATE" ]; then
    cat templates/template.lpi | sed -e "s,%%APPNAME%%,$APPNAME,g" \
                         -e "s,%%ARCH%%,$ARCH,g" \
                         -e "s,%%SUBARCH%%,$SUBARCH,g" \
                         -e "s,%%BINUTILS_PATH%%,$BINUTILS_PATH,g" \
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
  fi

  if [ ! -f $APPNAME/$APPNAME.lpr ]; then
    cat templates/template.lpr | sed "s,%%APPNAME%%,$APPNAME,g" >$APPNAME/$APPNAME.lpr
    echo $APPNAME/$APPNAME.lpr created
  fi
done
