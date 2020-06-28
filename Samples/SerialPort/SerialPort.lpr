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
  {$if defined(USE_SYSVIEW)}Segger.SysView,{$endif}
  FreeRTOS,
  FreeRTOS.Heap_4;

const
  CRLF : String = #13#10;

procedure UARTTask({%H-}pvParameters:pointer);
begin
  while true do
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_PRINT('Start Sending');{$endif}
    DEBUG_UART.WriteString('CPU Frequency: ');
    DEBUG_UART.WriteUnsignedInt(SystemCore.GetCPUFrequency);
    DEBUG_UART.WriteString(CRLF);
    DEBUG_UART.WriteString('Exact Baudrate: ');
    DEBUG_UART.WriteUnsignedInt(DEBUG_UART.BaudRate);
    DEBUG_UART.WriteString(' Baud');
    DEBUG_UART.WriteString(CRLF);
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_PRINT('Stop Sending');{$endif}
    SystemCore.Delay(2000);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

var
  UARTTaskHandle : TTaskHandle;

begin
  SystemCore.Initialize;
  Systemcore.setCPUFrequency(MaxCPUFrequency);
  {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_Conf('N=SerialPort,I#54=USART2');{$endif}
  GPIO.Initialize;
  DEBUG_UART.Initialize(TUARTRXPins.DEBUG_UART,TUARTTXPins.DEBUG_UART,38400);
  UARTTaskHandle := nil;

  if xTaskCreate(@UARTTask,
                 'UARTTask',
                 //Using Strings in Tasks increases Stack Size quite a lot when we use ShortStrings
                 1024,//configMINIMAL_STACK_SIZE,
                 nil,
                 tskIDLE_PRIORITY+1,
                 UARTTaskHandle) = pdPass then
    begin
      vTaskStartScheduler;
    end;

  repeat
  until 1=0;
end.
