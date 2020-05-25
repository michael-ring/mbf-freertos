program SerialPort;
{
  This file is part of Pascal Microcontroller Board Framework (MBF)
  Copyright (c) 2015 -  Michael Ring
  based on Pascal eXtended Library (PXL)
  Copyright (c) 2000 - 2015  Yuriy Kotsarenko

  This program is free software: you can redistribute it and/or modify it under the terms of the FPC modified GNU
  Library General Public License for more

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the FPC modified GNU Library General Public
  License for more details.
}

{$INCLUDE MBF.Config.inc}

uses
  MBF.__CONTROLLERTYPE__.SystemCore,
  MBF.__CONTROLLERTYPE__.GPIO,
  MBF.__CONTROLLERTYPE__.UART,
  MBF.TypeHelpers,
  FreeRTOS,
  Segger.SysView,
  freertos.heap_4;
var
  CRLF : String = #13#10;

procedure UARTTask({%H-}pvParameters:pointer);
begin
  SEGGER_SYSVIEW_NameMarker(1,'UARTTASK');
  while true do
  begin
    SEGGER_SYSVIEW_MarkStart(1);
    DEBUG_UART.WriteString('CPU Frequency: ');
    DEBUG_UART.WriteUnsignedInt(SystemCore.GetCPUFrequency);
    DEBUG_UART.WriteString(CRLF);
    DEBUG_UART.WriteString('Exact Baudrate: ');
    DEBUG_UART.WriteUnsignedInt(DEBUG_UART.BaudRate);
    DEBUG_UART.WriteString(' Baud'+CRLF);
    if (DEBUG_UART.Parity = TUARTParity.None) and (DEBUG_UART.BitsPerWord=TUARTBitsPerWord.Eight) and (DEBUG_UART.StopBits=TUARTStopBits.One) then
    begin
      DEBUG_UART.WriteString('No Parity Eight Bits, One StopBit');
      DEBUG_UART.WriteString(CRLF);
    end;
    DEBUG_UART.WriteString(CRLF);
    SystemCore.Delay(1000);
    SEGGER_SYSVIEW_MarkStop(1);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

var
  UARTTaskHandle : TTaskHandle;

begin
  SystemCore.Initialize;
  GPIO.Initialize;
  SEGGER_SYSVIEW_Conf;

  // This Initializes the default UART for Arduino compatible Boards (connected to pins D0 and D1 on Arduino Header)
  // On lots of Boards this UART is also looped through the On-Board JTAG Debugger Chip as an USB Device to your PC.
  // If the board is not Arduino compatible then you will have to use 'real' UARTs instead which are usually named UART0, UART1 ....
  // Also, if you plan to use more than one UART you should always use 'real' UART names to avoid accidentially using an UART twice.
  // Default Initialization is 115200,n,8,1

  //To make this program plug and play we use another UART named DEBUG_UART
  //It will be identical to UART on Boards that loop the Arduino Pins D0 and D1 through the On-Board JTAG Debugger Chip
  //But some Boards (like most Nucleo or Discovery Boards or SAMD20-XPRO or SAMD21-XPRO) use another UART to interface to the On-Board JTAG Debugger Chip
  //So using DEBUG_UART will make sure that you always have output through the to the On-Board JTAG Debugger Chip if available.

  DEBUG_UART.Initialize(TUARTRXPins.DEBUG_UART,TUARTTXPins.DEBUG_UART);
  UARTTaskHandle := nil;
  if xTaskCreate(@UARTTask,
                 'UARTTask',
                 configMINIMAL_STACK_SIZE,
                 nil,
                 tskIDLE_PRIORITY+1,
                 UARTTaskHandle) = pdPass then
    vTaskStartScheduler;

  repeat
  until 1=0;end.

