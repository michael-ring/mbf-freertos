{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit freertos.semaphore;
  {$mode objfpc}{$H+}
  interface
  uses
    freertos.task,freertos.queue;
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
const
  semBINARY_SEMAPHORE_QUEUE_LENGTH = 1;
  semSEMAPHORE_QUEUE_ITEM_LENGTH   = 0;
  semGIVE_BLOCK_TIME               = 0;

type
  TStaticSemaphore = TStaticQueue;

  pTStaticSemaphore = ^TStaticSemaphore;

  TSemaphoreHandle =TQueueHandle ;

{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
procedure vSemaphoreCreateBinary(xSemaphore : TSemaphoreHandle);
{$endif}

function  xSemaphoreCreateBinary : TSemaphoreHandle;
function  xSemaphoreCreateBinaryStatic(var pxSemaphoreBuffer : TStaticSemaphore) : TSemaphoreHandle;
function  xSemaphoreCreateCounting(uxMaxCount :  TUBaseType; uxInitialCount : TUBaseType) : TSemaphoreHandle; external name 'xQueueCreateCountingSemaphore';
function  xSemaphoreCreateCountingStatic(uxMaxCount : TUBaseType;uxInitialCount : TUBaseType;pxSempahoreBuffer : pTStaticSemaphore) : TSemaphoreHandle; external name 'xQueueCreateCountingSemaphoreStatic';
function  xSemaphoreCreateMutex : TSemaphoreHandle;
function  xSemaphoreCreateMutexStatic( var pxMutexBuffer : TStaticSemaphore) : TSemaphoreHandle;
function  xSemaphoreCreateRecursiveMutex : TSemaphoreHandle;
function  xSemaphoreCreateRecursiveMutexStatic(var pxMutexBuffer : TStaticSemaphore) : TSemaphoreHandle;
procedure vSemaphoreDelete(xSemaphore : TSemaphoreHandle); external name 'vQueueDelete';
function  uxSemaphoreGetCount(xSemaphore : TSemaphoreHandle) : TUBaseType; external name 'uxQueueMessagesWaiting';
function  xSemaphoreGetMutexHolder(xMutex : TSemaphoreHandle) : TTaskHandle; external name 'xQueueGetMutexHolder';
function  xSemaphoreGetMutexHolderFromISR(xMutex : TSemaphoreHandle) : TTaskHandle; external name 'xQueueGetMutexHolderFromISR';
function  xSemaphoreGive(xSemaphore :TSemaphoreHandle) : TBaseType;
function  xSemaphoreGiveFromISR(xSemaphore :  TSemaphoreHandle;pxHigherPriorityTaskWoken : pTBaseType) : TBaseType; external name 'xQueueGiveFromISR';
function  xSemaphoreGiveRecursive(xMutex : TSemaphoreHandle) : TBaseType; external name 'xQueueGiveMutexRecursive';
function  xSemaphoreTake(xSemaphore : TSemaphoreHandle;xTicksToWait : TTickType) : TBaseType; external name 'xQueueSemaphoreTake';
function  xSemaphoreTakeFromISR(xSemaphore : TSemaphoreHandle; pxHigherPriorityTaskWoken : pTBaseType ) : TBaseType;
function  xSemaphoreTakeRecursive(xMutex : TSemaphoreHandle;xTicksToWait:TTickType) : TBaseType; external name 'xQueueTakeMutexRecursive';

{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
  const
    // For internal use only. */
    queueSEND_TO_BACK  = 0;
    queueSEND_TO_FRONT = 1;
    queueOVERWRITE     = 2;

  const
    // For internal use only.  These definitions *must* match those in queue.c. */
    queueQUEUE_TYPE_BASE               = 0;
    queueQUEUE_TYPE_SET                = 0;
    queueQUEUE_TYPE_MUTEX              = 1;
    queueQUEUE_TYPE_COUNTING_SEMAPHORE = 2;
    queueQUEUE_TYPE_BINARY_SEMAPHORE   = 3;
    queueQUEUE_TYPE_RECURSIVE_MUTEX    = 4;
{$endif}

{$if not defined(INTERFACE)}

{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
procedure vSemaphoreCreateBinary(xSemaphore : TSemaphoreHandle); inline;
begin
   xSemaphore := xQueueGenericCreate(1,semSEMAPHORE_QUEUE_ITEM_LENGTH,queueQUEUE_TYPE_BINARY_SEMAPHORE);
   if xsemaphore <> nil then
     xSemaphoreGive(xSemaphore);
end;

function  xSemaphoreCreateBinary : TSemaphoreHandle; inline;
begin
  Result := xQueueGenericCreate(1,semSEMAPHORE_QUEUE_ITEM_LENGTH,queueQUEUE_TYPE_BINARY_SEMAPHORE);
end;
//function  xSemaphoreCreateCounting(uxMaxCount :  TUBaseType; uxInitialCount : TUBaseType) : TSemaphoreHandle; inline;
//begin
//
//end;
function  xSemaphoreCreateMutex : TSemaphoreHandle; inline;
begin
  Result := xQueueCreateMutex(queueQUEUE_TYPE_MUTEX);
end;

function  xSemaphoreCreateRecursiveMutex : TSemaphoreHandle; inline;
begin
  Result := xQueueCreateMutex(queueQUEUE_TYPE_RECURSIVE_MUTEX);
end;
{$endif}
{$if (configSUPPORT_STATIC_ALLOCATION = 1)}
function  xSemaphoreCreateBinaryStatic(var pxSemaphoreBuffer : TStaticSemaphore) : TSemaphoreHandle; inline;
begin
  Result := xQueueGenericCreateStatic(1,semSEMAPHORE_QUEUE_ITEM_LENGTH,nil,pxSemaphoreBuffer,queueQUEUE_TYPE_BINARY_SEMAPHORE);
end;
//function  xSemaphoreCreateCountingStatic(uxMaxCount : TUBaseType;uxInitialCount : TUBaseType;pxSempahoreBuffer : pTStaticSemaphore) : TSemaphoreHandle; inline;
//begin
//
//end;
function  xSemaphoreCreateMutexStatic(var pxMutexBuffer : TStaticSemaphore) : TSemaphoreHandle; inline;
begin
  Result := xQueueCreateMutexStatic(queueQUEUE_TYPE_MUTEX,pxMutexBuffer);
end;

function  xSemaphoreCreateRecursiveMutexStatic(var pxMutexBuffer : TStaticSemaphore) : TSemaphoreHandle; inline;
begin
  Result := xQueueCreateMutexStatic(queueQUEUE_TYPE_RECURSIVE_MUTEX,pxMutexBuffer);
end;
{$endif}

//procedure vSemaphoreDelete(xSemaphore : TSemaphoreHandle); inline;
//begin
//
//end;

//function  uxSemaphoreGetCount(xSemaphore : TSemaphoreHandle) : TUBaseType; inline;
//begin
//
//end;

//function  xSemaphoreGetMutexHolder(xMutex : TSemaphoreHandle) : TTaskHandle; inline;
//begin
//
//end;

function  xSemaphoreGive(xSemaphore :TSemaphoreHandle) : TBaseType; inline;
begin
  Result := xQueueGenericSend(xSemaphore,nil,semGIVE_BLOCK_TIME,queueSEND_TO_BACK);
end;

//function  xSemaphoreGiveFromISR(xSemaphore :  TSemaphoreHandle; pxHigherPriorityTaskWoken : pTBaseType) : TBaseType; inline;
//begin
//  Result := xQueueGiveFromISR(xSemaphore,pxHigherPriorityTaskWoken);
//end;

//function  xSemaphoreGiveRecursive(xMutex : TSemaphoreHandle) : TBaseType; inline;
//begin
//
//end;

//function  xSemaphoreTake(xSemaphore : TSemaphoreHandle;xTicksToWait : TTickType) : TBaseType; inline;
//begin
//  Result := xQueueSemasphoreTake(xSemaphore : TSemaphoreHandle;xTicksToWait : TTickType);
//end;

function  xSemaphoreTakeFromISR(xSemaphore : TSemaphoreHandle; pxHigherPriorityTaskWoken : pTBaseType ) : TBaseType; inline;
begin
  Result := xQueueReceiveFromISR(xSemaphore,nil,pxHigherPriorityTaskWoken);
end;

//function  xSemaphoreTakeRecursive(xMutex : TSemaphoreHandle;xTicksToWait:TTickType) : TBaseType; inline;
//begin
//
//end;

{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

