program queuemethods;
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
  freertos,
  freertos.heap_4;
const
  QueueData : array of byte = (1,2,3,4);
var
  QueueHandle,
  QueueHandle2 : TQueueHandle;
  QueueSetMemberHandle : TQueueSetMemberHandle;
  QueueSetHandle : TQueueSetHandle;
  QueueItemCount : uint32;
  PassFail: uint32;
  HigherPriorityTaskWoken : int32;
  QueueStorageBuffer : array[0..9] of byte;
  StaticQueue : TStaticQueue;
  QueueName : pChar;
  QueueReceiveData : array[0..9] of byte;
begin
  QueueHandle := xQueueCreate(10,sizeOf(byte));
  vQueueAddToRegistry(QueueHandle,'Queue1');
  QueueName := pcQueueGetName(QueueHandle);
  {$IF DEFINED(configUSE_QUEUE_SETS)}
  QueueSetHandle := xQueueCreateSet(10);
  PassFail := xQueueAddToSet(QueueSetMemberHandle,QueueSetHandle);
  QueueSetMemberHandle := xQueueSelectFromSet(QueueSetHandle,10);
  QueueSetMemberHandle := xQueueSelectFromSetFromISR(QueueSetHandle);
  PassFail := xQueueRemoveFromSet(QueueSetMemberHandle,QueueSetHandle);
  {$ENDIF}
  QueueHandle2 := xQueueCreateStatic(length(QueueStorageBuffer),sizeOf(byte),@QueueStorageBuffer,@StaticQueue);
  vQueueDelete(QueueHandle);
  PassFail := xQueueIsQueueEmptyFromISR(QueueHandle);
  PassFail := xQueueIsQueueFullFromISR(QueueHandle);
  QueueItemCount := uxQueueMessagesWaiting(QueueHandle);
  QueueItemCount := uxQueueMessagesWaitingFromISR(QueueHandle);
  PassFail := xQueueOverwrite(QueueHandle,@QueueData);
  PassFail := xQueueOverwriteFromISR(QueueHandle,@QueueData,HigherPriorityTaskWoken);
  PassFail := xQueuePeek(QueueHandle,@QueueReceiveData,10);
  PassFail := xQueuePeekFromISR(QueueHandle,@QueueReceiveData);
  PassFail := xQueueReceive(QueueHandle,@QueueReceiveData,10);
  PassFail := xQueueReceiveFromISR(QueueHandle,@QueueReceiveData,HigherPriorityTaskWoken);
  PassFail := xQueueReset(QueueHandle);
  PassFail := xQueueSend(QueueHandle,@QueueData,10);
  PassFail := xQueueSendToFront(QueueHandle,@QueueData,10);
  PassFail := xQueueSendToBack(QueueHandle,@QueueData,10);
  PassFail := xQueueSendFromISR(QueueHandle,@QueueData,HigherPriorityTaskWoken);
  PassFail := xQueueSendToFrontFromISR(QueueHandle,@QueueData,HigherPriorityTaskWoken);
  PassFail := xQueueSendToBackFromISR(QueueHandle,@QueueData,HigherPriorityTaskWoken);
  QueueItemCount := uxQueueSpacesAvailable(QueueHandle);
end.
