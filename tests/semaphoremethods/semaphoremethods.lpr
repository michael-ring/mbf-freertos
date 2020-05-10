program semaphoremethods;
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
  FreeRTOS,FreeRTOS.heap_4;
var
  SemaphoreHandle : TSemaphoreHandle;
  pxSemaphoreBuffer : pTStaticSemaphore;
  pxMutexBuffer : pTStaticSemaphore;
  xSemaphore : TSemaphoreHandle;
  xMutex : TSemaphoreHandle;
  value : TUBaseType;
  taskHandle : TTaskHandle;
  status : TBaseType;
  pxHigherPriorityTaskWoken : pTBaseType;
  xTicksToWait : TTickType;
begin
  vSemaphoreCreateBinary(SemaphoreHandle);
  SemaphoreHandle := xSemaphoreCreateBinary;
  SemaphoreHandle := xSemaphoreCreateBinaryStatic(pxSemaphoreBuffer);
  SemaphoreHandle := xSemaphoreCreateCounting(10,1);
  SemaphoreHandle := xSemaphoreCreateCountingStatic(10,1,pxSemaphoreBuffer);
  SemaphoreHandle := xSemaphoreCreateMutex;
  SemaphoreHandle := xSemaphoreCreateMutexStatic( pxMutexBuffer);
  SemaphoreHandle := xSemaphoreCreateRecursiveMutex;
  SemaphoreHandle := xSemaphoreCreateRecursiveMutex(pxMutexBuffer);
  vSemaphoreDelete(xSemaphore);
  value := uxSemaphoreGetCount(xSemaphore);
  taskHandle := xSemaphoreGetMutexHolder(xMutex);
  status := xSemaphoreGive(xSemaphore);
  status := xSemaphoreGiveFromISR(xSemaphore,pxHigherPriorityTaskWoken);
  status := xSemaphoreGiveRecursive(xMutex);
  status := xSemaphoreTake(xSemaphore,xTicksToWait);
  status := xSemaphoreTakeFromISR(xSemaphore,pxHigherPriorityTaskWoken);
  status := xSemaphoreTakeRecursive(xMutex,xTicksToWait);
end.
