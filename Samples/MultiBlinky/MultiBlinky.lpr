program MultiBlinky;
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

procedure BlinkyTask1({%H-}pvParameters:pointer);
begin
  while true do
  begin
    GPIO.TogglePinValue(TArduinoPin.D11);
    SystemCore.Delay(500);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

procedure BlinkyTask2({%H-}pvParameters:pointer);
begin
  while true do
  begin
    GPIO.TogglePinValue(TArduinoPin.D12);
    SystemCore.Delay(750);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

procedure BlinkyTask3({%H-}pvParameters:pointer);
begin
  while true do
  begin
    GPIO.TogglePinValue(TArduinoPin.D13);
    SystemCore.Delay(1000);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

var
  BlinkyTask1Handle : TTaskHandle;
  BlinkyTask2Handle : TTaskHandle;
  BlinkyTask3Handle : TTaskHandle;
  BlinkyTask1Stack : array[1..configMINIMAL_STACK_SIZE] of longWord;
  BlinkyTask2Stack : array[1..configMINIMAL_STACK_SIZE] of longWord;
  BlinkyTask3Stack : array[1..configMINIMAL_STACK_SIZE] of longWord;
  BlinkyTask1TCB : TStaticTask;
  BlinkyTask2TCB : TStaticTask;
  BlinkyTask3TCB : TStaticTask;
begin
  SystemCore.Initialize;
  SystemCore.SetCPUFrequency(SystemCore.getMaxCPUFrequency);

  GPIO.Initialize;
  GPIO.PinMode[TArduinoPin.D11] := TPinMode.Output;
  GPIO.PinMode[TArduinoPin.D12] := TPinMode.Output;
  GPIO.PinMode[TArduinoPin.D13] := TPinMode.Output;
  GPIO.PinValue[TArduinoPin.D11] := 0;
  GPIO.PinValue[TArduinoPin.D12] := 0;
  GPIO.PinValue[TArduinoPin.D13] := 0;
  BlinkyTask1Handle :=  xTaskCreateStatic(@BlinkyTask1,
                                         'BlinkyTask1',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         @BlinkyTask1Stack,
                                         {%H-}BlinkyTask1TCB);
  BlinkyTask2Handle :=  xTaskCreateStatic(@BlinkyTask2,
                                         'BlinkyTask2',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         @BlinkyTask2Stack,
                                         {%H-}BlinkyTask2TCB);
  BlinkyTask3Handle :=  xTaskCreateStatic(@BlinkyTask3,
                                         'BlinkyTask3',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         @BlinkyTask3Stack,
                                         {%H-}BlinkyTask3TCB);
  if (blinkyTask1Handle <> nil) and (blinkyTask2Handle <> nil) and (blinkyTask3Handle <> nil) then
    vTaskStartScheduler;
  repeat
  until 1=0;
end.
