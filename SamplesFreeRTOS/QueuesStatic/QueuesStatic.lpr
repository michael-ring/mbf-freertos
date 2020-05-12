program FreeRTOSQueuesstatic;
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
  MBF.Types,
  MBF.__CONTROLLERTYPE__.SystemCore,
  freertos,
  SeggerRTT;

procedure Task1({%H-}pvParameters:pointer);
begin
  while true do
  begin
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

procedure Task2({%H-}pvParameters:pointer);
begin
  while true do
  begin
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

var
  Task1Handle : TTaskHandle;
  Task1Stack : array[1..configMINIMAL_STACK_SIZE] of longWord;
  Task1TCB : TStaticTask;
  Task2Handle : TTaskHandle;
  Task2Stack : array[1..configMINIMAL_STACK_SIZE] of longWord;
  Task2TCB : TStaticTask;

begin
  SystemCore.Initialize;
  SystemCore.SetCPUFrequency(SystemCore.getMaxCPUFrequency);
  SEGGER_RTT_WriteString(0,'System initialized');

  Task1Handle :=  xTaskCreateStatic(@Task1,
                                         'Task1',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         @Task1Stack,
                                         @Task1TCB);
  Task2Handle :=  xTaskCreateStatic(@Task2,
                                         'Task2',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         @Task2Stack,
                                         @Task2TCB);

  if (Task1Handle <> nil) and (Task2Handle <> nil) then
  begin
    vTaskStartScheduler;
  end;

  SEGGER_RTT_WriteString(0,'Code after vTaskStartScheduler');
  while true do
  begin
  end;
end.
