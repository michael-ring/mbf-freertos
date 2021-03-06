program Queues;
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
  freertos.heap_4,
  SeggerRTT;

var
  Queue1Handle : TQueueHandle = nil;

procedure Task1({%H-}pvParameters:pointer);
var
  ByteToSend : byte;
  i : integer;
begin
  ByteToSend := 32;
  SEGGER_RTT_WriteString(0,'Task 1 running'#13#10);
  SEGGER_RTT_WriteString(0,'Filling up Queue'#13#10);
  for i := 1 to 10 do
    xQueueSend(Queue1Handle,@ByteToSend,10);
  SEGGER_RTT_WriteString(0,'Now trying to write to full queue'#13#10);
  for i := 1 to 10 do
  begin
    SEGGER_RTT_WriteString(0,'Writing char to queue'#13#10);
    xQueueSend(Queue1Handle,@ByteToSend,2000);
  end;
  SEGGER_RTT_WriteString(0,'Work done, deleting task'#13#10);
  vTaskDelete(nil);
end;

procedure Task2({%H-}pvParameters:pointer);
var
  ByteToReceive : byte;
begin
  while true do
  begin
    SEGGER_RTT_WriteString(0,'Task 2 running'#13#10);
    SEGGER_RTT_WriteString(0,'Task 2 sleeping for a second'#13#10);
    SystemCore.Delay(1000);
    while xQueueReceive(Queue1Handle,@ByteToReceive,1000)=pdTrue do
      SEGGER_RTT_WriteString(0,'Successfully received char'#13#10);
    SEGGER_RTT_WriteString(0,'Receive Queue timed out'#13#10);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

var
  Task1Handle : TTaskHandle = nil;
  Task2Handle : TTaskHandle = nil;

begin
  SystemCore.Initialize;
  SystemCore.SetCPUFrequency(SystemCore.getMaxCPUFrequency);
  SEGGER_RTT_WriteString(0,'System initialized'#13#10);

  xTaskCreate(@Task1,
              'Task1',
              configMINIMAL_STACK_SIZE,
              nil,
              tskIDLE_PRIORITY+1,
              Task1Handle);
  xTaskCreate(@Task2,
              'Task2',
              configMINIMAL_STACK_SIZE,
              nil,
              tskIDLE_PRIORITY+1,
              Task2Handle);
  Queue1Handle := xQueueCreate(10,sizeof(byte));

  if (Task1Handle <> nil) and (Task2Handle <> nil) and
     (Queue1Handle <> nil) then
  begin
    vTaskStartScheduler;
  end;

  SEGGER_RTT_WriteString(0,'Code after vTaskStartScheduler'#13#10);
  while true do
  begin
  end;
end.
