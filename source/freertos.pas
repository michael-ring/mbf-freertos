unit freertos;
{$if defined(CPUARM)}
  {$if defined(CPUARMV6M)}
    {$LINK libfreertos_cortexm0p.a}
  {$elseif defined(CPUARMV7M)}
    {$LINK libfreertos_cortexm3.a}
  {$elseif defined(CPUARMV7EM)}
    {$LINK libfreertos_cortexm4f.a}
  {$else}
    {$Error No FreeRTOS library available for this subarch}
  {$endif}
{$else}
  {$ERROR No FreeRTOS support currently available for this arch}
{$endif}
interface


type
  Tsize = uint32;
  TStackType = uint32;
  TStackTypeArray = array of TStackType;
  pTStackType = ^TStackType;
  pTStackTypeArray = ^TStackTypeArray;
  TBaseType = int32;
  TUBaseType = uint32;
  TTickType = uint32;
  TTaskFunction = procedure(_para1:pointer);
  TTaskHookFunction = function(_para1:pointer):TBaseType;
  TconfigSTACK_DEPTH_TYPE  = uint16;

const
  pdFalse:TBaseType=0;
  pdTrue:TBaseType=1;
  pdPass:TBaseType=1;
  pdFail:TBaseType=0;
  portNUM_CONFIGURABLE_REGIONS=1;
  configMINIMAL_STACK_SIZE=128;
  configTIMER_TASK_STACK_DEPTH=256;

type
  TStaticListItem = record
    xDummy2 : TTickType;
    pvDummy3 : array[0..3] of pointer;
  end;

  TStaticMiniListItem = record
    xDummy2 : TTickType;
    pvDummy3 : array[0..1] of pointer;
  end;

  TStaticList = record
    uxDummy2 : TUBaseType;
    pvDummy3 : pointer;
    xDummy4 : TStaticMiniListItem;
  end;

  TStaticTask = record
    pxDummy1 : pointer;
    xDummy3 : array[0..1] of TStaticListItem;
    uxDummy5 : TUBaseType;
    pxDummy6 : pointer;
    ucDummy7 : array[0..15] of uint8;
    uxDummy10 : array[0..1] of TUBaseType;
    uxDummy12 : array[0..1] of TUBaseType;
    ulDummy18 : uint32;
    ucDummy19 : uint8;
    uxDummy20 : uint8;
  end;
  pTStaticTask = ^TStaticTask;

  TStaticQueue = record
    pvDummy1 : array[0..2] of pointer;
    u : record
      case longint of
        0 : ( pvDummy2 : pointer );
        1 : ( uxDummy2 : TUBaseType );
      end;
    xDummy3 : array[0..1] of TStaticList;
    uxDummy4 : array[0..2] of TUBaseType;
    ucDummy5 : array[0..1] of uint8;
    ucDummy6 : uint8;
    uxDummy8 : TUBaseType;
    ucDummy9 : uint8;
  end;

  TStaticSemaphore = TStaticQueue;

  TStaticEventGroup = record
    xDummy1 : TTickType;
    xDummy2 : TStaticList;
    uxDummy3 : TUBaseType;
    ucDummy4 : uint8;
  end;

  TStaticTimer = record
    pvDummy1 : pointer;
    xDummy2 : TStaticListItem;
    xDummy3 : TTickType;
    pvDummy5 : pointer;
    pvDummy6 : TTaskFunction;
    uxDummy7 : TUBaseType;
    ucDummy8 : uint8;
  end;

  TStaticStreamBuffer = record
    uxDummy1 : array[0..3] of Tsize;
    pvDummy2 : array[0..2] of pointer;
    ucDummy3 : uint8;
    uxDummy4 : TUBaseType;
  end;

  TStaticMessageBuffer = TStaticStreamBuffer;

  TtskTaskControlBlock = record
  end;

  TTaskHandle = ^TtskTaskControlBlock;

  TeTaskState = (eRunning := 0,eReady,eBlocked,eSuspended,eDeleted,eInvalid);

  TeNotifyAction = (eNoAction := 0,eSetBits,eIncrement,eSetValueWithOverwrite,eSetValueWithoutOverwrite);

  TTimeOut = record
    xOverflowCount : TBaseType;
    xTimeOnEntering : TTickType;
  end;

  TMemoryRegion = record
    pvBaseAddress : pointer;
    ulLengthInBytes : uint32;
    ulParameters : uint32;
  end;

  TTaskParameters = record
    pvTaskCode : TTaskFunction;
    pcName : pChar;
    usStackDepth : TconfigSTACK_DEPTH_TYPE;
    pvParameters : pointer;
    uxPriority : TUBaseType;
    puxStackBuffer : ^TStackType;
    xRegions : array[0..(portNUM_CONFIGURABLE_REGIONS)-1] of TMemoryRegion;
  end;

  TTaskStatus = record
    xHandle : TTaskHandle;
    pcTaskName : pChar;
    xTaskNumber : TUBaseType;
    eCurrentState : TeTaskState;
    uxCurrentPriority : TUBaseType;
    uxBasePriority : TUBaseType;
    ulRunTimeCounter : uint32;
    pxStackBase : ^TStackType;
    usStackHighWaterMark : TconfigSTACK_DEPTH_TYPE;
  end;

  TeSleepModeStatus = (eAbortSleep := 0,eStandardSleep,eNoTasksWaitingTimeout);

  TtmrTimerControl = record
  end;


  TTimerHandle = ^TtmrTimerControl;

  TTimerCallbackFunction = procedure (xTimer:TTimerHandle);

  TPendedFunction = procedure (_para1:pointer; _para2:uint32);
  
  TListItem = record
    xItemValue : TTickType;
    pxNext : ^TListItem;
    pxPrevious : ^TListItem;
    pvOwner : pointer;
    pxContainer : ^TList;
  end;

  TMiniListItem = record
    xItemValue : TTickType;
    pxNext : ^TListItem;
    pxPrevious : ^TListItem;
  end;

  TList = record
    pxIndex : ^TListItem;
    xListEnd : TMiniListItem;
  end;

  TQueueDefinition = record
  end;

  TQueueHandle = ^TQueueDefinition;
  TQueueSetHandle = ^TQueueDefinition;
  TQueueSetMemberHandle = ^TQueueDefinition;

function  xTaskCreate(pxTaskCode:TTaskFunction; pcName:pChar; usStackDepth:uint16; pvParameters:pointer; uxPriority:TUBaseType; var pxCreatedTask:TTaskHandle):TBaseType;external;
function  xTaskCreateStatic(pxTaskCode:TTaskFunction; pcName:pChar; ulStackDepth:uint32; pvParameters:pointer; uxPriority:TUBaseType; puxStackBuffer:pTStackTypeArray; pxTaskBuffer:pTStaticTask):TTaskHandle;external;
procedure vTaskAllocateMPURegions(xTask:TTaskHandle; var pxRegions:TMemoryRegion);external;
procedure vTaskDelete(xTaskToDelete:TTaskHandle);external;
procedure vTaskDelay(xTicksToDelay:TTickType);external;
procedure vTaskDelayUntil(var pxPreviousWakeTime:TTickType; xTimeIncrement:TTickType);external;
function  xTaskAbortDelay(xTask:TTaskHandle):TBaseType;external;
function  uxTaskPriorityGet(xTask:TTaskHandle):TUBaseType;external;
function  uxTaskPriorityGetFromISR(xTask:TTaskHandle):TUBaseType;external;
function  eTaskGetState(xTask:TTaskHandle):TeTaskState;external;
procedure vTaskGetInfo(xTask:TTaskHandle; var pxTaskStatus:TTaskStatus; xGetFreeStackSpace:TBaseType; eState:TeTaskState);external;
procedure vTaskPrioritySet(xTask:TTaskHandle; uxNewPriority:TUBaseType);external;
procedure vTaskSuspend(xTaskToSuspend:TTaskHandle);external;
procedure vTaskResume(xTaskToResume:TTaskHandle);external;
function  xTaskResumeFromISR(xTaskToResume:TTaskHandle):TBaseType;external;
procedure vTaskStartScheduler;external;
procedure vTaskEndScheduler;external;
procedure vTaskSuspendAll;external;
function  xTaskResumeAll:TBaseType;external;
function  xTaskGetTickCount:TTickType;external;
function  xTaskGetTickCountFromISR:TTickType;external;
function  uxTaskGetNumberOfTasks:TUBaseType;external;
function  pcTaskGetName(xTaskToQuery:TTaskHandle):ppchar;external;
function  xTaskGetHandle(pcNameToQuery:pChar):TTaskHandle;external;
function  uxTaskGetStackHighWaterMark(xTask:TTaskHandle):TUBaseType;external;
function  uxTaskGetStackHighWaterMark2(xTask:TTaskHandle):uint16;external;
function  xTaskCallApplicationTaskHook(xTask:TTaskHandle; pvParameter:pointer):TBaseType;external;
function  xTaskGetIdleTaskHandle:TTaskHandle;external;
function  uxTaskGetSystemState(var pxTaskStatusArray:TTaskStatus; uxArraySize:TUBaseType; var pulTotalRunTime:uint32):TUBaseType;external;
procedure vTaskList(pcWriteBuffer:pChar);external;
procedure vTaskGetRunTimeStats(pcWriteBuffer:pChar);external;
function  ulTaskGetIdleRunTimeCounter:uint32;external;
function  xTaskGenericNotify(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; var pulPreviousNotificationValue:uint32):TBaseType;external;
function  xTaskGenericNotifyFromISR(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; var pulPreviousNotificationValue:uint32; var pxHigherPriorityTaskWoken:TBaseType):TBaseType;external;
function  xTaskNotifyWait(ulBitsToClearOnEntry:uint32; ulBitsToClearOnExit:uint32; var pulNotificationValue:uint32; xTicksToWait:TTickType):TBaseType;external;
procedure vTaskNotifyGiveFromISR(xTaskToNotify:TTaskHandle; var pxHigherPriorityTaskWoken:TBaseType);external;
function  ulTaskNotifyTake(xClearCountOnExit:TBaseType; xTicksToWait:TTickType):uint32;external;
function  xTaskNotifyStateClear(xTask:TTaskHandle):TBaseType;external;
function  ulTaskNotifyValueClear(xTask:TTaskHandle; ulBitsToClear:uint32):uint32;external;
procedure vTaskSetTimeOutState(var pxTimeOut:TTimeOut);external;
function  xTaskCheckForTimeOut(var pxTimeOut:TTimeOut; var pxTicksToWait:TTickType):TBaseType;external;
function  xTaskIncrementTick:TBaseType;external;
procedure vTaskPlaceOnEventList(var pxEventList:TList; xTicksToWait:TTickType);external;
procedure vTaskPlaceOnUnorderedEventList(var pxEventList:TList; xItemValue:TTickType; xTicksToWait:TTickType);external;
procedure vTaskPlaceOnEventListRestricted(var pxEventList:TList; xTicksToWait:TTickType; xWaitIndefinitely:TBaseType);external;
function  xTaskRemoveFromEventList(var pxEventList:TList):TBaseType;external;
procedure vTaskRemoveFromUnorderedEventList(var pxEventListItem:TListItem; xItemValue:TTickType);external;
procedure vTaskSwitchContext;external;
function  uxTaskResetEventItemValue:TTickType;external;
function  xTaskGetCurrentTaskHandle:TTaskHandle;external;
procedure vTaskMissedYield;external;
function  xTaskGetSchedulerState:TBaseType;external;
function  xTaskPriorityInherit(pxMutexHolder:TTaskHandle):TBaseType;external;
function  xTaskPriorityDisinherit(pxMutexHolder:TTaskHandle):TBaseType;external;
procedure vTaskPriorityDisinheritAfterTimeout(pxMutexHolder:TTaskHandle; uxHighestPriorityWaitingTask:TUBaseType);external;
function  uxTaskGetTaskNumber(xTask:TTaskHandle):TUBaseType;external;
procedure vTaskSetTaskNumber(xTask:TTaskHandle; uxHandle:TUBaseType);external;
procedure vTaskStepTick(xTicksToJump:TTickType);external;
function  xTaskCatchUpTicks(xTicksToCatchUp:TTickType):TBaseType;external;
function  eTaskConfirmSleepModeStatus:TeSleepModeStatus;external;
function  pvTaskIncrementMutexHeldCount:TTaskHandle;external;
procedure vTaskInternalSetTimeOutState(var pxTimeOut:TTimeOut);external;

procedure vListInitialise(var pxList:TList);external;
procedure vListInitialiseItem(var pxItem:TListItem);external;
procedure vListInsert(var pxList:TList; var pxNewListItem:TListItem);external;
procedure vListInsertEnd(var pxList:TList; var pxNewListItem:TListItem);external;
function  uxListRemove(var pxItemToRemove:TListItem):TUBaseType;external;

function  xTimerCreate(pcTimerName:pChar; xTimerPeriodInTicks:TTickType; uxAutoReload:TUBaseType; pvTimerID:pointer; pxCallbackFunction:TTimerCallbackFunction):TTimerHandle;external;
function  xTimerCreateStatic(pcTimerName:pChar; xTimerPeriodInTicks:TTickType; uxAutoReload:TUBaseType; pvTimerID:pointer; pxCallbackFunction:TTimerCallbackFunction; var pxTimerBuffer:TStaticTimer):TTimerHandle;external;
function  pvTimerGetTimerID(xTimer:TTimerHandle):pointer;external;
procedure vTimerSetTimerID(xTimer:TTimerHandle; pvNewID:pointer);external;
function  xTimerIsTimerActive(xTimer:TTimerHandle):TBaseType;external;
function  xTimerGetTimerDaemonTaskHandle:TTaskHandle;external;
function  xTimerPendFunctionCallFromISR(xFunctionToPend:TPendedFunction; pvParameter1:pointer; ulParameter2:uint32; var pxHigherPriorityTaskWoken:TBaseType):TBaseType;external;
function  xTimerPendFunctionCall(xFunctionToPend:TPendedFunction; pvParameter1:pointer; ulParameter2:uint32; xTicksToWait:TTickType):TBaseType;external;
function  pcTimerGetName(xTimer:TTimerHandle):ppChar;external;
procedure vTimerSetReloadMode(xTimer:TTimerHandle; uxAutoReload:TUBaseType);external;
function  uxTimerGetReloadMode(xTimer:TTimerHandle):TUBaseType;external;
function  xTimerGetPeriod(xTimer:TTimerHandle):TTickType;external;
function  xTimerGetExpiryTime(xTimer:TTimerHandle):TTickType;external;
function  xTimerCreateTimerTask:TBaseType;external;
function  xTimerGenericCommand(xTimer:TTimerHandle; xCommandID:TBaseType; xOptionalValue:TTickType; var pxHigherPriorityTaskWoken:TBaseType; xTicksToWait:TTickType):TBaseType;external;
procedure vTimerSetTimerNumber(xTimer:TTimerHandle; uxTimerNumber:TUBaseType);external;
function  uxTimerGetTimerNumber(xTimer:TTimerHandle):TUBaseType;external;

function  xQueueGenericSend(xQueue:TQueueHandle; pvItemToQueue:pointer; xTicksToWait:TTickType; xCopyPosition:TBaseType):TBaseType;external;
function  xQueuePeek(xQueue:TQueueHandle; pvBuffer:pointer; xTicksToWait:TTickType):TBaseType;external;
function  xQueuePeekFromISR(xQueue:TQueueHandle; pvBuffer:pointer):TBaseType;external;
function  xQueueReceive(xQueue:TQueueHandle; pvBuffer:pointer; xTicksToWait:TTickType):TBaseType;external;
function  uxQueueMessagesWaiting(xQueue:TQueueHandle):TUBaseType;external;
function  uxQueueSpacesAvailable(xQueue:TQueueHandle):TUBaseType;external;
procedure vQueueDelete(xQueue:TQueueHandle);external;
function  xQueueGenericSendFromISR(xQueue:TQueueHandle; pvItemToQueue:pointer; var pxHigherPriorityTaskWoken:TBaseType; xCopyPosition:TBaseType):TBaseType;external;
function  xQueueGiveFromISR(xQueue:TQueueHandle; var pxHigherPriorityTaskWoken:TBaseType):TBaseType;external;
function  xQueueReceiveFromISR(xQueue:TQueueHandle; pvBuffer:pointer; var pxHigherPriorityTaskWoken:TBaseType):TBaseType;external;
function  xQueueIsQueueEmptyFromISR(xQueue:TQueueHandle):TBaseType;external;
function  xQueueIsQueueFullFromISR(xQueue:TQueueHandle):TBaseType;external;
function  uxQueueMessagesWaitingFromISR(xQueue:TQueueHandle):TUBaseType;external;
function  xQueueCRSendFromISR(xQueue:TQueueHandle; pvItemToQueue:pointer; xCoRoutinePreviouslyWoken:TBaseType):TBaseType;external;
function  xQueueCRReceiveFromISR(xQueue:TQueueHandle; pvBuffer:pointer; var pxTaskWoken:TBaseType):TBaseType;external;
function  xQueueCRSend(xQueue:TQueueHandle; pvItemToQueue:pointer; xTicksToWait:TTickType):TBaseType;external;
function  xQueueCRReceive(xQueue:TQueueHandle; pvBuffer:pointer; xTicksToWait:TTickType):TBaseType;external;
function  xQueueCreateMutex(ucQueueType:uint8):TQueueHandle;external;
function  xQueueCreateMutexStatic(ucQueueType:uint8; var pxStaticQueue:TStaticQueue):TQueueHandle;external;
function  xQueueCreateCountingSemaphore(uxMaxCount:TUBaseType; uxInitialCount:TUBaseType):TQueueHandle;external;
function  xQueueCreateCountingSemaphoreStatic(uxMaxCount:TUBaseType; uxInitialCount:TUBaseType; var pxStaticQueue:TStaticQueue):TQueueHandle;external;
function  xQueueSemaphoreTake(xQueue:TQueueHandle; xTicksToWait:TTickType):TBaseType;external;
function  xQueueGetMutexHolder(xSemaphore:TQueueHandle):TTaskHandle;external;
function  xQueueGetMutexHolderFromISR(xSemaphore:TQueueHandle):TTaskHandle;external;
function  xQueueTakeMutexRecursive(xMutex:TQueueHandle; xTicksToWait:TTickType):TBaseType;external;
function  xQueueGiveMutexRecursive(xMutex:TQueueHandle):TBaseType;external;
procedure vQueueAddToRegistry(xQueue:TQueueHandle; pcQueueName:pChar);external;
procedure vQueueUnregisterQueue(xQueue:TQueueHandle);external;
function  pcQueueGetName(xQueue:TQueueHandle):ppChar;external;
function  xQueueGenericCreate(uxQueueLength:TUBaseType; uxItemSize:TUBaseType; ucQueueType:uint8):TQueueHandle;external;
function  xQueueGenericCreateStatic(uxQueueLength:TUBaseType; uxItemSize:TUBaseType; var pucQueueStorage:uint8; var pxStaticQueue:TStaticQueue; ucQueueType:uint8):TQueueHandle;external;
function  xQueueCreateSet(uxEventQueueLength:TUBaseType):TQueueSetHandle;external;
function  xQueueAddToSet(xQueueOrSemaphore:TQueueSetMemberHandle; xQueueSet:TQueueSetHandle):TBaseType;external;
function  xQueueRemoveFromSet(xQueueOrSemaphore:TQueueSetMemberHandle; xQueueSet:TQueueSetHandle):TBaseType;external;
function  xQueueSelectFromSet(xQueueSet:TQueueSetHandle; xTicksToWait:TTickType):TQueueSetMemberHandle;external;
function  xQueueSelectFromSetFromISR(xQueueSet:TQueueSetHandle):TQueueSetMemberHandle;external;
procedure vQueueWaitForMessageRestricted(xQueue:TQueueHandle; xTicksToWait:TTickType; xWaitIndefinitely:TBaseType);external;
function  xQueueGenericReset(xQueue:TQueueHandle; xNewQueue:TBaseType):TBaseType;external;
procedure vQueueSetQueueNumber(xQueue:TQueueHandle; uxQueueNumber:TUBaseType);external;
function  uxQueueGetQueueNumber(xQueue:TQueueHandle):TUBaseType;external;
function  ucQueueGetQueueType(xQueue:TQueueHandle):uint8;external;

procedure vPortEndScheduler; external;
procedure vPortEnterCritical; external;
procedure vPortExitCritical; external;

function memset(pxBuffer:pointer; value : uint32; count : Tsize):pointer; public name 'memset';
function memcpy(pxTarget : pointer; pxSource : pointer; count : Tsize):pointer; public name 'memcpy';

{$if defined(CPUARMV6M)}
function  __aeabi_uidiv(const numerator : uint32; denominator : uint32):uint32; public name '__aeabi_uidiv';
{$endif}
procedure vApplicationGetIdleTaskMemory(var ppxIdleTaskTCBBuffer:pTStaticTask; var ppxIdleTaskStackBuffer:pTStackType; var pulIdleTaskStackSize:uint32); public name 'vApplicationGetIdleTaskMemory';
procedure vApplicationGetTimerTaskMemory(var ppxTimerTaskTCBBuffer:pTStaticTask; var ppxTimerTaskStackBuffer:pTStackType; var pulTimerTaskStackSize:uint32); public name 'vApplicationGetTimerTaskMemory';

implementation
var
  xIdleTaskTCB : TStaticTask;
  uxIdleTaskStack : array[0..configMINIMAL_STACK_SIZE-1] of TStackType; 
  xTimerTaskTCB : TStaticTask;
  uxTimerTaskStack : array[0..configTIMER_TASK_STACK_DEPTH-1] of TStackType;

procedure vPortFree; external name 'vPortFree';

procedure vPortFreeStub; assembler; nostackframe;
asm
  .long vPortFree
  .weak vPortFree
  .set  vPortFree,vPortFreeStub
  bkpt
end;

function memset(pxBuffer:pointer; value : uint32; count : Tsize):pointer;
begin
  FillChar(pxBuffer^,count,value);
  Result := pxBuffer;
end;

function memcpy(pxTarget : pointer; pxSource : pointer; count : Tsize):pointer;
begin
  Move(pxSource^,pxTarget^,count);
  Result := pxTarget;
end;

procedure vApplicationGetIdleTaskMemory(var ppxIdleTaskTCBBuffer:pTStaticTask; var ppxIdleTaskStackBuffer:pTStackType; var pulIdleTaskStackSize:uint32);
begin
  ppxIdleTaskTCBBuffer := @xIdleTaskTCB;
  ppxIdleTaskStackBuffer := @uxIdleTaskStack;
  pulIdleTaskStackSize := configMINIMAL_STACK_SIZE;
end;

procedure vApplicationGetTimerTaskMemory(var ppxTimerTaskTCBBuffer:pTStaticTask; var ppxTimerTaskStackBuffer:pTStackType; var pulTimerTaskStackSize:uint32);
begin
  ppxTimerTaskTCBBuffer := @xTimerTaskTCB;
  ppxTimerTaskStackBuffer := @uxTimerTaskStack;
  pulTimerTaskStackSize := configTIMER_TASK_STACK_DEPTH;
end;

{$if defined(CPUARMV6M)}
function __aeabi_uidiv(const numerator : uint32; denominator : uint32):uint32;
begin
  Result := numerator div denominator;
end;
{$endif}

end.
