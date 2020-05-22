{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit freertos.queue;
  {$mode objfpc}{$H+}
  interface
  uses
    freertos.task;
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
type
  TStaticQueue = record
    pvDummy1 : array[1..3] of pointer;
    u : record
      case longint of
        0 : ( pvDummy2 : pointer );
        1 : ( uxDummy2 : TUBaseType );
      end;
    xDummy3 : array[1..2] of TStaticList;
    uxDummy4 : array[1..3] of TUBaseType;
    ucDummy5 : array[1..2] of uint8;
    {$if (configSUPPORT_STATIC_ALLOCATION = 1) and (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    ucDummy6 : uint8;
    {$endif}

    {$if (configUSE_QUEUE_SETS = 1)}
    pvDummy7 : pointer;
    {$endif}

    {$if (configUSE_TRACE_FACILITY = 1)}
    uxDummy8 : TUBaseType;
    ucDummy9 : uint8;
    {$endif}
  end;
  pTStaticQueue = ^TStaticQueue;

  TQueueDefinition = record
  end;
  TQueueHandle = ^TQueueDefinition;
  TQueueSetHandle = ^TQueueDefinition;
  TQueueSetMemberHandle = ^TQueueDefinition;


  {$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    function  xQueueGenericCreate(uxQueueLength:TUBaseType; uxItemSize:TUBaseType; ucQueueType:uint8):TQueueHandle;external;
    function  xQueueCreate(const uxQueueLength : TUBaseType; uxItemSize : TUBaseType) : TQueueHandle; inline;
    function  xQueueCreateMutex(ucQueueType:uint8):TQueueHandle;external;
    function  xQueueCreateCountingSemaphore(uxMaxCount:TUBaseType; uxInitialCount:TUBaseType):TQueueHandle;external;
  {$endif}

  {$if (configSUPPORT_STATIC_ALLOCATION = 1)}
    function  xQueueGenericCreateStatic(uxQueueLength:TUBaseType; uxItemSize:TUBaseType; pucQueueStorage:pByte; var pxStaticQueue:TStaticQueue; ucQueueType:uint8):TQueueHandle;external;
    function  xQueueCreateStatic(uxQueueLength : TUBaseType; uxItemSize : TUBaseType; pucQueueStorage : pointer; var pxStaticQueue : TStaticQueue) : TQueueHandle;
    function  xQueueCreateMutexStatic(ucQueueType:uint8; var pxStaticQueue:TStaticQueue):TQueueHandle;external;
    function  xQueueCreateCountingSemaphoreStatic(uxMaxCount:TUBaseType; uxInitialCount:TUBaseType; var pxStaticQueue:TStaticQueue):TQueueHandle;external;
  {$endif}

  function  xQueueSendToFront(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType;
  function  xQueueSendToBack(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType; inline;
  function  xQueueSend(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType;
  function  xQueueOverwrite(xQueue : TQueueHandle; pvItemToQueue : pointer) : TBaseType; inline;
  function  xQueueGenericSend(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType; xCopyPosition : TBaseType) : TBaseType; external;
  function  xQueuePeek(xQueue:TQueueHandle; pvBuffer:pointer; xTicksToWait:TTickType):TBaseType;external;
  function  xQueuePeekFromISR(xQueue:TQueueHandle; pvBuffer:pointer):TBaseType;external;
  function  xQueueReceive(xQueue:TQueueHandle; pvBuffer:pointer; xTicksToWait:TTickType):TBaseType;external;
  function  uxQueueMessagesWaiting(xQueue:TQueueHandle):TUBaseType;external;
  function  uxQueueSpacesAvailable(xQueue:TQueueHandle):TUBaseType;external;
  procedure vQueueDelete(xQueue:TQueueHandle);external;
  function  xQueueSendToFrontFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType) : TBaseType;
  function  xQueueSendToBackFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType) : TBaseType;
  function  xQueueOverwriteFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType) : TBaseType;
  function  xQueueSendFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer;pxHigherPriorityTaskWoken:pTBaseType) : TBaseType;
  function  xQueueGenericSendFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType; xCopyPosition : TBaseType) : TBaseType; external;
  function  xQueueGiveFromISR(xQueue:TQueueHandle; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external; 
  function  xQueueReceiveFromISR(xQueue:TQueueHandle; pvBuffer:pointer; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external;
  function  xQueueIsQueueEmptyFromISR(xQueue:TQueueHandle):TBaseType;external;
  function  xQueueIsQueueFullFromISR(xQueue:TQueueHandle):TBaseType;external;
  function  uxQueueMessagesWaitingFromISR(xQueue:TQueueHandle):TUBaseType;external;
  //function  xQueueCRSendFromISR(xQueue:TQueueHandle; pvItemToQueue:pointer; xCoRoutinePreviouslyWoken:TBaseType):TBaseType;external;
  //function  xQueueCRReceiveFromISR(xQueue:TQueueHandle; pvBuffer:pointer; var pxTaskWoken:TBaseType):TBaseType;external;
  //function  xQueueCRSend(xQueue:TQueueHandle; pvItemToQueue:pointer; xTicksToWait:TTickType):TBaseType;external;
  //function  xQueueCRReceive(xQueue:TQueueHandle; pvBuffer:pointer; xTicksToWait:TTickType):TBaseType;external;

  function  xQueueSemaphoreTake(xQueue:TQueueHandle; xTicksToWait:TTickType):TBaseType;external;
  function  xQueueGetMutexHolder(xSemaphore:TQueueHandle):TTaskHandle;external;
  function  xQueueGetMutexHolderFromISR(xSemaphore:TQueueHandle):TTaskHandle;external;

  function  xQueueTakeMutexRecursive(xMutex:TQueueHandle; xTicksToWait:TTickType):TBaseType;external;
  function  xQueueGiveMutexRecursive(xMutex:TQueueHandle):TBaseType;external;

  function  xQueueReset(xQueue:TQueueHandle) : TBaseType;
  function  xQueueGenericReset(xQueue:TQueueHandle;xNewQueue:TBaseType) : TBaseType; external;

  {$if (configQUEUE_REGISTRY_SIZE > 0)}
    procedure vQueueAddToRegistry(xQueue:TQueueHandle; pcQueueName:pChar);external;
    procedure vQueueUnregisterQueue(xQueue:TQueueHandle);external;
    function  pcQueueGetName(xQueue:TQueueHandle):pChar;external;
  {$endif}
  
  function  xQueueCreateSet(uxEventQueueLength:TUBaseType):TQueueSetHandle;external;
  function  xQueueAddToSet(xQueueOrSemaphore:TQueueSetMemberHandle; xQueueSet:TQueueSetHandle):TBaseType;external;
  function  xQueueRemoveFromSet(xQueueOrSemaphore:TQueueSetMemberHandle; xQueueSet:TQueueSetHandle):TBaseType;external;
  function  xQueueSelectFromSet(xQueueSet:TQueueSetHandle; xTicksToWait:TTickType):TQueueSetMemberHandle;external;
  function  xQueueSelectFromSetFromISR(xQueueSet:TQueueSetHandle):TQueueSetMemberHandle;external;

  //procedure vQueueWaitForMessageRestricted(xQueue:TQueueHandle; xTicksToWait:TTickType; xWaitIndefinitely:TBaseType);external;
  //function  xQueueGenericReset(xQueue:TQueueHandle; xNewQueue:TBaseType):TBaseType;external;
  //procedure vQueueSetQueueNumber(xQueue:TQueueHandle; uxQueueNumber:TUBaseType);external;
  //function  uxQueueGetQueueNumber(xQueue:TQueueHandle):TUBaseType;external;
  //function  ucQueueGetQueueType(xQueue:TQueueHandle):uint8;external;
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
{$endif}

{$if not defined(INTERFACE)}
  const
    queueSEND_TO_BACK  = 0;
    queueSEND_TO_FRONT = 1;
    queueOVERWRITE     = 2;

    queueQUEUE_TYPE_BASE               = 0;
    queueQUEUE_TYPE_SET                = 0;
    queueQUEUE_TYPE_MUTEX              = 1;
    queueQUEUE_TYPE_COUNTING_SEMAPHORE = 2;
    queueQUEUE_TYPE_BINARY_SEMAPHORE   = 3;
    queueQUEUE_TYPE_RECURSIVE_MUTEX    = 4;

  function xQueueCreate(const uxQueueLength : TUBaseType; uxItemSize : TUBaseType) : TQueueHandle; inline;
  begin
    Result := xQueueGenericCreate(uxQueueLength,uxItemSize,queueQUEUE_TYPE_BASE);
  end;

  function xQueueCreateStatic(uxQueueLength : TUBaseType; uxItemSize : TUBaseType; pucQueueStorage : pointer; var pxStaticQueue : TStaticQueue) : TQueueHandle;
  begin
    Result := xQueueGenericCreateStatic(uxQueueLength,uxItemSize,pucQueueStorage,pxStaticQueue,queueQUEUE_TYPE_BASE);
  end;

  function  xQueueSend(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType;
  begin
    Result := xQueueGenericSend(xQueue,pvItemToQueue,xTicksToWait,queueSEND_TO_BACK);
  end;

  function  xQueueOverwrite(xQueue : TQueueHandle; pvItemToQueue : pointer) : TBaseType; inline;
  begin
    Result := xQueueGenericSend(xQueue,pvItemToQueue,0,queueOVERWRITE);
  end;

  function  xQueueSendToFront(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType; inline;
  begin
    Result := xQueueGenericSend(xQueue,pvItemToQueue,xTicksToWait,queueSEND_TO_FRONT);
  end;

  function  xQueueSendToBack(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType; inline;
  begin
    Result := xQueueGenericSend(xQueue,pvItemToQueue,xTicksToWait,queueSEND_TO_BACK);
  end;

  function  xQueueSendFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType) : TBaseType; inline;
  begin
    Result := xQueueGenericSendFromISR(xQueue,pvItemToQueue,pxHigherPriorityTaskWoken,queueSEND_TO_BACK);
  end;

  function  xQueueOverwriteFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType) : TBaseType; inline;
  begin
    Result := xQueueGenericSendFromISR(xQueue,pvItemToQueue,pxHigherPriorityTaskWoken,queueOVERWRITE);
  end;

  function  xQueueSendToFrontFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType) : TBaseType; inline;
  begin
    Result := xQueueGenericSendFromISR(xQueue,pvItemToQueue,pxHigherPriorityTaskWoken,queueSEND_TO_FRONT);
  end;

  function  xQueueSendToBackFromISR(xQueue : TQueueHandle; pvItemToQueue : pointer; pxHigherPriorityTaskWoken:pTBaseType) : TBaseType; inline;
  begin
    Result := xQueueGenericSendFromISR(xQueue,pvItemToQueue,pxHigherPriorityTaskWoken,queueSEND_TO_BACK);
  end;

  function  xQueueReset(xQueue:TQueueHandle) : TBaseType; inline;
  begin
    Result := xQueueGenericReset(xQueue,pdFalse);
  end;
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

