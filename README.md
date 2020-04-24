Microcontroller Board Framework for FreeRTOS is a cross-platform framework for developing code on ARM Cortex-M.
This library requires FreePascal latest from svn/git and Lazarus 1.7+

This project used Git Submodules for FreeRTOS Project and for libopencm3.

To properly clone this project do the following steps:

    git clone --recursive https://github.com/michael-ring/mbf-freertos.git

or

    git clone --recursive git@github.com:michael-ring/mbf-freertos.git

After cloning you need to build libopencm3 (this may change in the future)

For Linux and MacOS this is a pretty straightforward process, make sure that you have arm-none-eabi-gcc installed and put in path and then

    cd libopencm3
    make

For build on Windows please refer to the build instruction here:

https://github.com/libopencm3/libopencm3

You will also need to build arm-freertos target for freepascal.

On Linux/MacOS build can be done this way:

    git clone https://github.com/graemeg/freepascal.git

or

    git clone git@github.com:graemeg/freepascal.git

    cd freepascal

to install arm-freertos target side-by side in a fpcupdeluxe installation do the following steps:

    DELUXEDIR=$HOME/fpcupdeluxe (Change this directory to match your environment)
    BINDIR=${DELUXEDIR}/fpc/bin/x86_64-darwin (Change this directory to match your platform)

    UNITDIR=${DELUXEDIR}/fpc/units/arm-freertos/armv7em/rtl
    make -j clean CROSSINSTALL=1 OS_TARGET=freertos CPU_TARGET=arm SUBARCH=armv7em CROSSOPT="-XParm-embedded-" FPC=$DELUXEDIR/fpc/bin/x86_64-darwin/fpc.sh
    make -j clean buildbase installbase CROSSINSTALL=1 OS_TARGET=freertos CPU_TARGET=arm SUBARCH=armv7em CROSSOPT="-XParm-embedded- -CfFPV4_SP_D16" 
                                        FPC=$DELUXEDIR/fpc/bin/x86_64-darwin/fpc.sh INSTALL_PREFIX=${DELUXEDIR}/fpc INSTALL_BINDIR=${BINDIR} CROSSBINDIR=${BINDIR} INSTALL_UNITDIR=${UNITDIR}

