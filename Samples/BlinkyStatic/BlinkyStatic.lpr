program BlinkyStatic;
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

{
  This example uses static Initialization of FreeRTOS, this means you need to allocate
  all memory for FreeRTOS Objects in FreePascal.
}

{$INCLUDE MBF.Config.inc}

uses
  MBF.__CONTROLLERTYPE__.SystemCore,
  MBF.__CONTROLLERTYPE__.GPIO,
  FreeRTOS;

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
  BlinkyTaskStack : array[1..configMINIMAL_STACK_SIZE] of longWord;
  BlinkyTaskTCB : TStaticTask;
begin
  SystemCore.Initialize;
  SystemCore.SetCPUFrequency(SystemCore.getMaxCPUFrequency);

  GPIO.Initialize;
  GPIO.PinMode[TArduinoPin.D13] := TPinMode.Output;
  BlinkyTaskHandle :=  xTaskCreateStatic(@BlinkyTask,
                                         'BlinkyTask',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         @BlinkyTaskStack,
                                         BlinkyTaskTCB);
  if blinkyTaskHandle <> nil then
    vTaskStartScheduler;
  repeat
  until 1=0;
end.
