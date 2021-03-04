{$if defined(samd51g19a) }
  type
    TUARTTXPins = (
      PA8_UART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      PA12_UART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      PA16_UART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      PA22_UART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      PA10_UART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      PA14_UART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      PA18_UART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      PA20_UART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      PA24_UART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      PB22_UART1_PAD2 = MuxC or PAD2 or TNativePin.PB22
      PA0_UART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      PA4_UART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      PA9_UART2_PAD0 = MuxD or PAD0 or TNativePin.PA9
      PA13_UART4_PAD0 = MuxD or PAD0 or TNativePin.PA13
      PA17_UART3_PAD0 = MuxD or PAD0 or TNativePin.PA17
      PA23_UART5_PAD0 = MuxD or PAD0 or TNativePin.PA23
      PB2_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      PB8_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      PA6_UART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      PA10_UART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      PA14_UART4_PAD2 = MuxD or PAD2 or TNativePin.PA14
      PA18_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      PA20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      PA24_UART5_PAD2 = MuxD or PAD2 or TNativePin.PA24
      PA30_UART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      PB10_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      PB22_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
    );
    TUARTRXPins = (
      PA8_UART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      PA12_UART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      PA16_UART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      PA22_UART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      PA9_UART0_PAD1 = MuxC or PAD1 or TNativePin.PA9
      PA13_UART2_PAD1 = MuxC or PAD1 or TNativePin.PA13
      PA17_UART1_PAD1 = MuxC or PAD1 or TNativePin.PA17
      PA23_UART3_PAD1 = MuxC or PAD1 or TNativePin.PA23
      PA10_UART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      PA14_UART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      PA18_UART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      PA20_UART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      PA24_UART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      PB22_UART1_PAD2 = MuxC or PAD2 or TNativePin.PB22
      PA11_UART0_PAD3 = MuxC or PAD3 or TNativePin.PA11
      PA15_UART2_PAD3 = MuxC or PAD3 or TNativePin.PA15
      PA19_UART1_PAD3 = MuxC or PAD3 or TNativePin.PA19
      PA21_UART5_PAD3 = MuxC or PAD3 or TNativePin.PA21
      PA25_UART3_PAD3 = MuxC or PAD3 or TNativePin.PA25
      PB23_UART1_PAD3 = MuxC or PAD3 or TNativePin.PB23
      PA0_UART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      PA4_UART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      PA9_UART2_PAD0 = MuxD or PAD0 or TNativePin.PA9
      PA13_UART4_PAD0 = MuxD or PAD0 or TNativePin.PA13
      PA17_UART3_PAD0 = MuxD or PAD0 or TNativePin.PA17
      PA23_UART5_PAD0 = MuxD or PAD0 or TNativePin.PA23
      PB2_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      PB8_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      PA1_UART1_PAD1 = MuxD or PAD1 or TNativePin.PA1
      PA5_UART0_PAD1 = MuxD or PAD1 or TNativePin.PA5
      PA8_UART2_PAD1 = MuxD or PAD1 or TNativePin.PA8
      PA12_UART4_PAD1 = MuxD or PAD1 or TNativePin.PA12
      PA16_UART3_PAD1 = MuxD or PAD1 or TNativePin.PA16
      PA22_UART5_PAD1 = MuxD or PAD1 or TNativePin.PA22
      PB3_UART5_PAD1 = MuxD or PAD1 or TNativePin.PB3
      PB9_UART4_PAD1 = MuxD or PAD1 or TNativePin.PB9
      PA6_UART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      PA10_UART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      PA14_UART4_PAD2 = MuxD or PAD2 or TNativePin.PA14
      PA18_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      PA20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      PA24_UART5_PAD2 = MuxD or PAD2 or TNativePin.PA24
      PA30_UART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      PB10_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      PB22_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
      PA7_UART0_PAD3 = MuxD or PAD3 or TNativePin.PA7
      PA11_UART2_PAD3 = MuxD or PAD3 or TNativePin.PA11
      PA15_UART4_PAD3 = MuxD or PAD3 or TNativePin.PA15
      PA19_UART3_PAD3 = MuxD or PAD3 or TNativePin.PA19
      PA21_UART3_PAD3 = MuxD or PAD3 or TNativePin.PA21
      PA25_UART5_PAD3 = MuxD or PAD3 or TNativePin.PA25
      PA31_UART1_PAD3 = MuxD or PAD3 or TNativePin.PA31
      PB11_UART4_PAD3 = MuxD or PAD3 or TNativePin.PB11
      PB23_UART5_PAD3 = MuxD or PAD3 or TNativePin.PB23
    );
{$endif}
{$if defined(samd51j19a) }
  type
    TUARTTXPins = (
      PA8_UART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      PA12_UART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      PA16_UART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      PA22_UART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      PB12_UART4_PAD0 = MuxC or PAD0 or TNativePin.PB12
      PB16_UART5_PAD0 = MuxC or PAD0 or TNativePin.PB16
      PA10_UART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      PA14_UART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      PA18_UART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      PA20_UART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      PA24_UART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      PB14_UART4_PAD2 = MuxC or PAD2 or TNativePin.PB14
      PB22_UART1_PAD2 = MuxC or PAD2 or TNativePin.PB22
      PA0_UART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      PA4_UART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      PA9_UART2_PAD0 = MuxD or PAD0 or TNativePin.PA9
      PA13_UART4_PAD0 = MuxD or PAD0 or TNativePin.PA13
      PA17_UART3_PAD0 = MuxD or PAD0 or TNativePin.PA17
      PA23_UART5_PAD0 = MuxD or PAD0 or TNativePin.PA23
      PB2_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      PB8_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      PB31_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB31
      PA6_UART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      PA10_UART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      PA14_UART4_PAD2 = MuxD or PAD2 or TNativePin.PA14
      PA18_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      PA20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      PA24_UART5_PAD2 = MuxD or PAD2 or TNativePin.PA24
      PA30_UART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      PB0_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB0
      PB10_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      PB22_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
    );
    TUARTRXPins = (
      PA8_UART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      PA12_UART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      PA16_UART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      PA22_UART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      PB12_UART4_PAD0 = MuxC or PAD0 or TNativePin.PB12
      PB16_UART5_PAD0 = MuxC or PAD0 or TNativePin.PB16
      PA9_UART0_PAD1 = MuxC or PAD1 or TNativePin.PA9
      PA13_UART2_PAD1 = MuxC or PAD1 or TNativePin.PA13
      PA17_UART1_PAD1 = MuxC or PAD1 or TNativePin.PA17
      PA23_UART3_PAD1 = MuxC or PAD1 or TNativePin.PA23
      PB13_UART4_PAD1 = MuxC or PAD1 or TNativePin.PB13
      PB17_UART5_PAD1 = MuxC or PAD1 or TNativePin.PB17
      PA10_UART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      PA14_UART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      PA18_UART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      PA20_UART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      PA24_UART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      PB14_UART4_PAD2 = MuxC or PAD2 or TNativePin.PB14
      PB22_UART1_PAD2 = MuxC or PAD2 or TNativePin.PB22
      PA11_UART0_PAD3 = MuxC or PAD3 or TNativePin.PA11
      PA15_UART2_PAD3 = MuxC or PAD3 or TNativePin.PA15
      PA19_UART1_PAD3 = MuxC or PAD3 or TNativePin.PA19
      PA21_UART5_PAD3 = MuxC or PAD3 or TNativePin.PA21
      PA25_UART3_PAD3 = MuxC or PAD3 or TNativePin.PA25
      PB15_UART4_PAD3 = MuxC or PAD3 or TNativePin.PB15
      PB23_UART1_PAD3 = MuxC or PAD3 or TNativePin.PB23
      PA0_UART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      PA4_UART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      PA9_UART2_PAD0 = MuxD or PAD0 or TNativePin.PA9
      PA13_UART4_PAD0 = MuxD or PAD0 or TNativePin.PA13
      PA17_UART3_PAD0 = MuxD or PAD0 or TNativePin.PA17
      PA23_UART5_PAD0 = MuxD or PAD0 or TNativePin.PA23
      PB2_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      PB8_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      PB31_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB31
      PA1_UART1_PAD1 = MuxD or PAD1 or TNativePin.PA1
      PA5_UART0_PAD1 = MuxD or PAD1 or TNativePin.PA5
      PA8_UART2_PAD1 = MuxD or PAD1 or TNativePin.PA8
      PA12_UART4_PAD1 = MuxD or PAD1 or TNativePin.PA12
      PA16_UART3_PAD1 = MuxD or PAD1 or TNativePin.PA16
      PA22_UART5_PAD1 = MuxD or PAD1 or TNativePin.PA22
      PB3_UART5_PAD1 = MuxD or PAD1 or TNativePin.PB3
      PB9_UART4_PAD1 = MuxD or PAD1 or TNativePin.PB9
      PB30_UART5_PAD1 = MuxD or PAD1 or TNativePin.PB30
      PA6_UART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      PA10_UART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      PA14_UART4_PAD2 = MuxD or PAD2 or TNativePin.PA14
      PA18_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      PA20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      PA24_UART5_PAD2 = MuxD or PAD2 or TNativePin.PA24
      PA30_UART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      PB0_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB0
      PB10_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      PB22_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
      PA7_UART0_PAD3 = MuxD or PAD3 or TNativePin.PA7
      PA11_UART2_PAD3 = MuxD or PAD3 or TNativePin.PA11
      PA15_UART4_PAD3 = MuxD or PAD3 or TNativePin.PA15
      PA19_UART3_PAD3 = MuxD or PAD3 or TNativePin.PA19
      PA21_UART3_PAD3 = MuxD or PAD3 or TNativePin.PA21
      PA25_UART5_PAD3 = MuxD or PAD3 or TNativePin.PA25
      PA31_UART1_PAD3 = MuxD or PAD3 or TNativePin.PA31
      PB1_UART5_PAD3 = MuxD or PAD3 or TNativePin.PB1
      PB11_UART4_PAD3 = MuxD or PAD3 or TNativePin.PB11
      PB23_UART5_PAD3 = MuxD or PAD3 or TNativePin.PB23
    );
{$endif}
{$if defined(samd51p19a) }
  type
    TUARTTXPins = (
      PA8_UART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      PA12_UART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      PA16_UART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      PA22_UART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      PB12_UART4_PAD0 = MuxC or PAD0 or TNativePin.PB12
      PB16_UART5_PAD0 = MuxC or PAD0 or TNativePin.PB16
      PB20_UART3_PAD0 = MuxC or PAD0 or TNativePin.PB20
      PB24_UART0_PAD0 = MuxC or PAD0 or TNativePin.PB24
      PB26_UART2_PAD0 = MuxC or PAD0 or TNativePin.PB26
      PB30_UART7_PAD0 = MuxC or PAD0 or TNativePin.PB30
      PC4_UART6_PAD0 = MuxC or PAD0 or TNativePin.PC4
      PC12_UART7_PAD0 = MuxC or PAD0 or TNativePin.PC12
      PC16_UART6_PAD0 = MuxC or PAD0 or TNativePin.PC16
      PC22_UART1_PAD0 = MuxC or PAD0 or TNativePin.PC22
      PC27_UART1_PAD0 = MuxC or PAD0 or TNativePin.PC27
      PD8_UART7_PAD0 = MuxC or PAD0 or TNativePin.PD8
      PA10_UART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      PA14_UART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      PA18_UART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      PA20_UART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      PA24_UART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      PA30_UART7_PAD2 = MuxC or PAD2 or TNativePin.PA30
      PB14_UART4_PAD2 = MuxC or PAD2 or TNativePin.PB14
      PB18_UART5_PAD2 = MuxC or PAD2 or TNativePin.PB18
      PB22_UART1_PAD2 = MuxC or PAD2 or TNativePin.PB22
      PB28_UART2_PAD2 = MuxC or PAD2 or TNativePin.PB28
      PC6_UART6_PAD2 = MuxC or PAD2 or TNativePin.PC6
      PC10_UART6_PAD2 = MuxC or PAD2 or TNativePin.PC10
      PC14_UART7_PAD2 = MuxC or PAD2 or TNativePin.PC14
      PC18_UART6_PAD2 = MuxC or PAD2 or TNativePin.PC18
      PC24_UART0_PAD2 = MuxC or PAD2 or TNativePin.PC24
      PD10_UART7_PAD2 = MuxC or PAD2 or TNativePin.PD10
      PD20_UART1_PAD2 = MuxC or PAD2 or TNativePin.PD20
      PA0_UART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      PA4_UART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      PA9_UART2_PAD0 = MuxD or PAD0 or TNativePin.PA9
      PA13_UART4_PAD0 = MuxD or PAD0 or TNativePin.PA13
      PA17_UART3_PAD0 = MuxD or PAD0 or TNativePin.PA17
      PA23_UART5_PAD0 = MuxD or PAD0 or TNativePin.PA23
      PB2_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      PB8_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      PB21_UART7_PAD0 = MuxD or PAD0 or TNativePin.PB21
      PB25_UART2_PAD0 = MuxD or PAD0 or TNativePin.PB25
      PB27_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB27
      PB31_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB31
      PC13_UART6_PAD0 = MuxD or PAD0 or TNativePin.PC13
      PC17_UART0_PAD0 = MuxD or PAD0 or TNativePin.PC17
      PC23_UART3_PAD0 = MuxD or PAD0 or TNativePin.PC23
      PD9_UART6_PAD0 = MuxD or PAD0 or TNativePin.PD9
      PA6_UART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      PA10_UART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      PA14_UART4_PAD2 = MuxD or PAD2 or TNativePin.PA14
      PA18_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      PA20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      PA24_UART5_PAD2 = MuxD or PAD2 or TNativePin.PA24
      PA30_UART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      PB0_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB0
      PB10_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      PB18_UART7_PAD2 = MuxD or PAD2 or TNativePin.PB18
      PB22_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
      PB28_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB28
      PC10_UART7_PAD2 = MuxD or PAD2 or TNativePin.PC10
      PC14_UART6_PAD2 = MuxD or PAD2 or TNativePin.PC14
      PC18_UART0_PAD2 = MuxD or PAD2 or TNativePin.PC18
      PC24_UART2_PAD2 = MuxD or PAD2 or TNativePin.PC24
      PD10_UART6_PAD2 = MuxD or PAD2 or TNativePin.PD10
      PD20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PD20
    );
    TUARTRXPins = (
      PA8_UART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      PA12_UART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      PA16_UART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      PA22_UART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      PB12_UART4_PAD0 = MuxC or PAD0 or TNativePin.PB12
      PB16_UART5_PAD0 = MuxC or PAD0 or TNativePin.PB16
      PB20_UART3_PAD0 = MuxC or PAD0 or TNativePin.PB20
      PB24_UART0_PAD0 = MuxC or PAD0 or TNativePin.PB24
      PB26_UART2_PAD0 = MuxC or PAD0 or TNativePin.PB26
      PB30_UART7_PAD0 = MuxC or PAD0 or TNativePin.PB30
      PC4_UART6_PAD0 = MuxC or PAD0 or TNativePin.PC4
      PC12_UART7_PAD0 = MuxC or PAD0 or TNativePin.PC12
      PC16_UART6_PAD0 = MuxC or PAD0 or TNativePin.PC16
      PC22_UART1_PAD0 = MuxC or PAD0 or TNativePin.PC22
      PC27_UART1_PAD0 = MuxC or PAD0 or TNativePin.PC27
      PD8_UART7_PAD0 = MuxC or PAD0 or TNativePin.PD8
      PA9_UART0_PAD1 = MuxC or PAD1 or TNativePin.PA9
      PA13_UART2_PAD1 = MuxC or PAD1 or TNativePin.PA13
      PA17_UART1_PAD1 = MuxC or PAD1 or TNativePin.PA17
      PA23_UART3_PAD1 = MuxC or PAD1 or TNativePin.PA23
      PB13_UART4_PAD1 = MuxC or PAD1 or TNativePin.PB13
      PB17_UART5_PAD1 = MuxC or PAD1 or TNativePin.PB17
      PB21_UART3_PAD1 = MuxC or PAD1 or TNativePin.PB21
      PB25_UART0_PAD1 = MuxC or PAD1 or TNativePin.PB25
      PB27_UART2_PAD1 = MuxC or PAD1 or TNativePin.PB27
      PB31_UART7_PAD1 = MuxC or PAD1 or TNativePin.PB31
      PC5_UART6_PAD1 = MuxC or PAD1 or TNativePin.PC5
      PC13_UART7_PAD1 = MuxC or PAD1 or TNativePin.PC13
      PC17_UART6_PAD1 = MuxC or PAD1 or TNativePin.PC17
      PC23_UART1_PAD1 = MuxC or PAD1 or TNativePin.PC23
      PC28_UART1_PAD1 = MuxC or PAD1 or TNativePin.PC28
      PD9_UART7_PAD1 = MuxC or PAD1 or TNativePin.PD9
      PA10_UART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      PA14_UART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      PA18_UART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      PA20_UART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      PA24_UART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      PA30_UART7_PAD2 = MuxC or PAD2 or TNativePin.PA30
      PB14_UART4_PAD2 = MuxC or PAD2 or TNativePin.PB14
      PB18_UART5_PAD2 = MuxC or PAD2 or TNativePin.PB18
      PB22_UART1_PAD2 = MuxC or PAD2 or TNativePin.PB22
      PB28_UART2_PAD2 = MuxC or PAD2 or TNativePin.PB28
      PC6_UART6_PAD2 = MuxC or PAD2 or TNativePin.PC6
      PC10_UART6_PAD2 = MuxC or PAD2 or TNativePin.PC10
      PC14_UART7_PAD2 = MuxC or PAD2 or TNativePin.PC14
      PC18_UART6_PAD2 = MuxC or PAD2 or TNativePin.PC18
      PC24_UART0_PAD2 = MuxC or PAD2 or TNativePin.PC24
      PD10_UART7_PAD2 = MuxC or PAD2 or TNativePin.PD10
      PD20_UART1_PAD2 = MuxC or PAD2 or TNativePin.PD20
      PA11_UART0_PAD3 = MuxC or PAD3 or TNativePin.PA11
      PA15_UART2_PAD3 = MuxC or PAD3 or TNativePin.PA15
      PA19_UART1_PAD3 = MuxC or PAD3 or TNativePin.PA19
      PA21_UART5_PAD3 = MuxC or PAD3 or TNativePin.PA21
      PA25_UART3_PAD3 = MuxC or PAD3 or TNativePin.PA25
      PA31_UART7_PAD3 = MuxC or PAD3 or TNativePin.PA31
      PB15_UART4_PAD3 = MuxC or PAD3 or TNativePin.PB15
      PB19_UART5_PAD3 = MuxC or PAD3 or TNativePin.PB19
      PB23_UART1_PAD3 = MuxC or PAD3 or TNativePin.PB23
      PB29_UART2_PAD3 = MuxC or PAD3 or TNativePin.PB29
      PC7_UART6_PAD3 = MuxC or PAD3 or TNativePin.PC7
      PC11_UART6_PAD3 = MuxC or PAD3 or TNativePin.PC11
      PC15_UART7_PAD3 = MuxC or PAD3 or TNativePin.PC15
      PC19_UART6_PAD3 = MuxC or PAD3 or TNativePin.PC19
      PC25_UART0_PAD3 = MuxC or PAD3 or TNativePin.PC25
      PD11_UART7_PAD3 = MuxC or PAD3 or TNativePin.PD11
      PD21_UART1_PAD3 = MuxC or PAD3 or TNativePin.PD21
      PA0_UART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      PA4_UART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      PA9_UART2_PAD0 = MuxD or PAD0 or TNativePin.PA9
      PA13_UART4_PAD0 = MuxD or PAD0 or TNativePin.PA13
      PA17_UART3_PAD0 = MuxD or PAD0 or TNativePin.PA17
      PA23_UART5_PAD0 = MuxD or PAD0 or TNativePin.PA23
      PB2_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      PB8_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      PB21_UART7_PAD0 = MuxD or PAD0 or TNativePin.PB21
      PB25_UART2_PAD0 = MuxD or PAD0 or TNativePin.PB25
      PB27_UART4_PAD0 = MuxD or PAD0 or TNativePin.PB27
      PB31_UART5_PAD0 = MuxD or PAD0 or TNativePin.PB31
      PC13_UART6_PAD0 = MuxD or PAD0 or TNativePin.PC13
      PC17_UART0_PAD0 = MuxD or PAD0 or TNativePin.PC17
      PC23_UART3_PAD0 = MuxD or PAD0 or TNativePin.PC23
      PD9_UART6_PAD0 = MuxD or PAD0 or TNativePin.PD9
      PA1_UART1_PAD1 = MuxD or PAD1 or TNativePin.PA1
      PA5_UART0_PAD1 = MuxD or PAD1 or TNativePin.PA5
      PA8_UART2_PAD1 = MuxD or PAD1 or TNativePin.PA8
      PA12_UART4_PAD1 = MuxD or PAD1 or TNativePin.PA12
      PA16_UART3_PAD1 = MuxD or PAD1 or TNativePin.PA16
      PA22_UART5_PAD1 = MuxD or PAD1 or TNativePin.PA22
      PB3_UART5_PAD1 = MuxD or PAD1 or TNativePin.PB3
      PB9_UART4_PAD1 = MuxD or PAD1 or TNativePin.PB9
      PB20_UART7_PAD1 = MuxD or PAD1 or TNativePin.PB20
      PB24_UART2_PAD1 = MuxD or PAD1 or TNativePin.PB24
      PB26_UART4_PAD1 = MuxD or PAD1 or TNativePin.PB26
      PB30_UART5_PAD1 = MuxD or PAD1 or TNativePin.PB30
      PC12_UART6_PAD1 = MuxD or PAD1 or TNativePin.PC12
      PC16_UART0_PAD1 = MuxD or PAD1 or TNativePin.PC16
      PC22_UART3_PAD1 = MuxD or PAD1 or TNativePin.PC22
      PD8_UART6_PAD1 = MuxD or PAD1 or TNativePin.PD8
      PA6_UART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      PA10_UART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      PA14_UART4_PAD2 = MuxD or PAD2 or TNativePin.PA14
      PA18_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      PA20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      PA24_UART5_PAD2 = MuxD or PAD2 or TNativePin.PA24
      PA30_UART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      PB0_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB0
      PB10_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      PB18_UART7_PAD2 = MuxD or PAD2 or TNativePin.PB18
      PB22_UART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
      PB28_UART4_PAD2 = MuxD or PAD2 or TNativePin.PB28
      PC10_UART7_PAD2 = MuxD or PAD2 or TNativePin.PC10
      PC14_UART6_PAD2 = MuxD or PAD2 or TNativePin.PC14
      PC18_UART0_PAD2 = MuxD or PAD2 or TNativePin.PC18
      PC24_UART2_PAD2 = MuxD or PAD2 or TNativePin.PC24
      PD10_UART6_PAD2 = MuxD or PAD2 or TNativePin.PD10
      PD20_UART3_PAD2 = MuxD or PAD2 or TNativePin.PD20
      PA7_UART0_PAD3 = MuxD or PAD3 or TNativePin.PA7
      PA11_UART2_PAD3 = MuxD or PAD3 or TNativePin.PA11
      PA15_UART4_PAD3 = MuxD or PAD3 or TNativePin.PA15
      PA19_UART3_PAD3 = MuxD or PAD3 or TNativePin.PA19
      PA21_UART3_PAD3 = MuxD or PAD3 or TNativePin.PA21
      PA25_UART5_PAD3 = MuxD or PAD3 or TNativePin.PA25
      PA31_UART1_PAD3 = MuxD or PAD3 or TNativePin.PA31
      PB1_UART5_PAD3 = MuxD or PAD3 or TNativePin.PB1
      PB11_UART4_PAD3 = MuxD or PAD3 or TNativePin.PB11
      PB19_UART7_PAD3 = MuxD or PAD3 or TNativePin.PB19
      PB23_UART5_PAD3 = MuxD or PAD3 or TNativePin.PB23
      PB29_UART4_PAD3 = MuxD or PAD3 or TNativePin.PB29
      PC11_UART7_PAD3 = MuxD or PAD3 or TNativePin.PC11
      PC15_UART6_PAD3 = MuxD or PAD3 or TNativePin.PC15
      PC19_UART0_PAD3 = MuxD or PAD3 or TNativePin.PC19
      PC25_UART2_PAD3 = MuxD or PAD3 or TNativePin.PC25
      PD11_UART6_PAD3 = MuxD or PAD3 or TNativePin.PD11
      PD21_UART3_PAD3 = MuxD or PAD3 or TNativePin.PD21
    );
{$endif}