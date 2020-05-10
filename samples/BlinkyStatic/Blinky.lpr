program Blinky;
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

{ Demo program for GPIO functionalities. }

{$INCLUDE MBF.Config.inc}

uses
  MBF.__CONTROLLERTYPE__.SystemCore,
  MBF.__CONTROLLERTYPE__.GPIO,
  freertos;

procedure BlinkyTask({%H-}pvParameters:pointer);
begin
  while true do
  begin
    GPIO.PinValue[TArduinoPin.D13] := 1;
    SystemCore.Delay(500);
    GPIO.PinValue[TArduinoPin.D13] := 0;
    SystemCore.Delay(500);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

var
  BlinkyTaskHandle : TTaskHandle;
  BlinkyTaskTCB : TStaticTask;
  BlinkyTaskStack : array[0..configMINIMAL_STACK_SIZE-1] of TStackType;
begin
  SystemCore.Initialize;
  SystemCore.SetCPUFrequency(SystemCore.getMaxCPUFrequency);

  GPIO.Initialize;
  GPIO.PinMode[TArduinoPin.D13] := TPinMode.Output;
  //Create a Static Task, This way FreeRTOS does not need to allocate Memory
  BlinkyTaskHandle := xTaskCreateStatic(@BlinkyTask,'BlinkyTask',configMINIMAL_STACK_SIZE,nil,1,@BlinkyTaskStack,@BlinkyTaskTCB);
  if BlinkyTaskHandle <> nil then
    vTaskStartScheduler;

  repeat
  until 1=0;
end.
