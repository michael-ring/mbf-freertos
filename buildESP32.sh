#!/bin/sh
if [ -z "$IDF_PATH" ]; then
  echo "IDF_PATH is not set, please read documentation here:"
  echo ""
  echo "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/index.html"
  echo ""
  echo "on how to initially setup your environment for ESP32 development"
  echo ""
  exit 1
fi

if [ -z "$IDF_TOOLS_PATH" ]; then
  if [ ! -d "$HOME/.espressif" ]; then
    echo "Cannot find directory $HOME/.espressif and IDF_TOOLS_PATH is not set, please read documentation here:"
    echo ""
    echo "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/index.html"
    echo ""
    echo "on how to initially setup your environment for ESP32 development"
    echo ""
    exit 1
  fi
fi

if [ -n "$IDF_TOOLS_PATH" ]; then
  if [ ! -d "$IDF_TOOLS_PATH" ]; then
    echo "IDF_TOOLS_PATH is set to $IDF_TOOLS_PATH but I cannot find this directory, please read documentation here:"
    echo ""
    echo "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/index.html"
    echo ""
    echo "on how to initially setup your environment for ESP32 development"
    echo ""
    exit 1
  fi
fi

type idf.py >/dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "Cannot find idf.py script, you need to source export.sh script as described in the documentation here:"  
  echo ""
  echo "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/index.html"
  echo ""
  exit 1
fi

type xtensa-esp32-elf-as >/dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "Cannot find xtensa-esp32-elf-as, something is very wrong with your environment, reset it based on the documentation here:"  
  echo ""
  echo "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/index.html"
  echo ""
  exit 1
fi

rm -rf lib/lx6 2>/dev/null
mkdir -p lib/lx6 2>/dev/null

(
  cd SamplesBoardSpecific/HelloWorldESP32

  idf.py menuconfig

  if [ ! -f sdkconfig ]; then
    echo "You must save sdkconfig in order to be able to continue..."
    echo ""
    exit 1
  fi

  idf.py fullclean
  idf.py build

  find . -path ./build/bootloader -prune -o -name "*.a" -exec cp {} ../../lib/lx6/ \;
  find $IDF_PATH/components -name "*.a" -exec cp {} ../../lib/lx6 \;
  cp ./build/partition_table/partition-table.bin ../../lib/lx6
  cp ./build/bootloader/bootloader.bin ../../lib/lx6
)
