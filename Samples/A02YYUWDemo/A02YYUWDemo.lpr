program A02YYUWDemo;
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
  MBF.Devices.A02YYUW,
  {$if defined(USE_SYSVIEW)}Segger.SysView,{$endif}
  FreeRTOS,
  FreeRTOS.Heap_4;

var
  A02YYUW : TA02YYUW;
  A02YYUWTaskHandle : TTaskHandle;

procedure A02YYUWTask({%H-}pvParameters:pointer);
var
  distance : integer;
begin
  while true do
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_PRINT('Start Receiving');{$endif}
    distance := A02YYUW.ReadDistance;
    if distance >=0 then
    begin
      {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_PrintfHost('Distance: %d',[distance]);{$endif}
    end
    else
    begin
      {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_Print('Sensor not connected');{$endif}
    end;
    SystemCore.Delay(2000);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

begin
  SystemCore.Initialize;
  Systemcore.setCPUFrequency(MaxCPUFrequency);
  {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_Conf('N=A02YYUW,I#53=USART1');{$endif}
  GPIO.Initialize;
  UART.Initialize(TUARTRXPins.D0_UART,TUARTTXPins.NONE_USART,9600);
  A02YYUW.initialize(UART,TArduinoPin.D2);
  A02YYUWTaskHandle := nil;

  if xTaskCreate(@A02YYUWTask,
                 'A02YYUW',
                 //Using Strings in Tasks increases Stack Size quite a lot when we use ShortStrings
                 1024,//configMINIMAL_STACK_SIZE,
                 nil,
                 tskIDLE_PRIORITY+1,
                 A02YYUWTaskHandle) = pdPass then
    begin
      vTaskStartScheduler;
    end;

  repeat
  until 1=0;
end.
