unit freertos;
{$MACRO ON}
{$if defined(CPUARM)}
  {$LINKLIB freertos,static}
  {$if defined(CPUARMV6M)}
    {$I FreeRTOSConfig-armv6m.inc}
  {$elseif defined(CPUARMV7M)}
    {$I FreeRTOSConfig-armv7m.inc}
  {$elseif defined(CPUARMV7EM)}
    {$I FreeRTOSConfig-armv7em.inc}
  {$else}
    {$ERROR FreeRTOSConfig.inc not available}
  {$endif}
{$elseif defined(CPUXTENSA)}
  {$LINKLIB freertos,static}
  {$if defined(CPULX6)}
    {$I FreeRTOSConfig-lx6.inc}
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
  pTBaseType = ^TBaseType;
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
  tskNO_AFFINITY=$7FFFFFFF;

// Definitions coming from FreeRTOS.h
type
  TStaticListItem = record
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy1 : TTickType;
    {$endif}
    xDummy2 : TTickType;
    pvDummy3 : array[1..4] of pointer;
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy4 : TTickType;
    {$endif}
  end;
  pTStaticListItem = ^TStaticListItem;

  TStaticMiniListItem = record
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy1 : TTickType;
    {$endif}
    xDummy2 : TTickType;
    pvDummy3 : array[1..2] of pointer;
  end;
  pTStaticMiniListItem = ^TStaticMiniListItem;

  TStaticList = record
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy1 : TTickType;
    {$endif}
    uxDummy2 : TUBaseType;
    pvDummy3 : pointer;
    xDummy4 : TStaticMiniListItem;
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy5 : TTickType;
    {$endif}
  end;
  pTStaticList = ^TStaticList;

  TStaticTCB = record
    pxDummy1 : pointer;
    {$if (portUSING_MPU_WRAPPERS = 1)}
    xDummy2 : xMPU_SETTINGS;
    {$endif}
    xDummy3 : array[1..2] of TStaticListItem;
    uxDummy5 : TUBaseType;
    pxDummy6 : pointer;
    ucDummy7 : array[1..configMAX_TASK_NAME_LEN] of uint8;
    {$if (portSTACK_GROWTH > 0) or (configRECORD__STACK_HIGH_ADDRESS = 1)}
    pxDummy8 : pointer;
    {$endif}
    {$if (portCRITICAL_NESTING_IN_TCB = 1)}
    uxDummy9 : TUBaseType;
    {$endif}
    {$if (configUSE_TRACE_FACILITY = 1)}
    uxDummy10 : array[1..2] of TUBaseType;
    {$endif}
    {$if (configUSE_MUTEXES = 1)}
      uxDummy12 : array[1..2] of TUBaseType;
    {$endif}
    {$if configUSE_APPLICATION_TASK_TAG = 1)}
    pxDummy14 : pointer;
    {$endif}
    {$if (configNUM_THREAD_LOCAL_STORAGE_POINTERS > 0)}
    pvDummy15 : array[1..configNUM_THREAD_LOCAL_STORAGE_POINTERS] of pointer;
    {$endif}
    {$if (configGENERATE_RUN_TIME_STATS = 1)}
    uint32_t ulDummy16;
    {$endif}
    {$if (configUSE_NEWLIB_REENTRANT = 1)}
    struct _reent xDummy17;
    {$endif}
    {$if (configUSE_TASK_NOTIFICATIONS = 1)}
    ulDummy18 : uint32;
    ucDummy19 : uint8;
    {$endif}
    {$if (tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE <> 0)}
    uxDummy20 : uint8;
    {$endif}
    {$if (INCLUDE_xTaskAbortDelay = 1)}
    ucDummy21 : uint8;
    {$endif}
    {$if (configUSE_POSIX_ERRNO) = 1}
    iDummy22 : integer;
    {$endif}
  end;
  pTStaticTaskTCB = ^TStaticTCB;
  TStaticTask = TStaticTCB;
  pTStaticTask = ^TStaticTask;

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
  TStaticSemaphore = TStaticQueue;

  pTStaticQueue = ^TStaticQueue;
  pTStaticSemaphore = ^TStaticSemaphore;

  TStaticEventGroup = record
    xDummy1 : TTickType;
    xDummy2 : TStaticList;
    {$if (configUSE_TRACE_FACILITY = 1)}
    uxDummy3 : TUBaseType;
    {$endif}
    {$if (configSUPPORT_STATIC_ALLOCATION = 1) and (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    ucDummy4 : uint8;
    {$endif}
  end;

  TStaticTimer = record
    pvDummy1 : pointer;
    xDummy2 : TStaticListItem;
    xDummy3 : TTickType;
    pvDummy5 : pointer;
    pvDummy6 : TTaskFunction;
    {$if (configUSE_TRACE_FACILITY = 1)}
    uxDummy7 : TUBaseType;
    {$endif}
    ucDummy8 : uint8;
  end;

  TStaticStreamBuffer = record
    uxDummy1 : array[1..4] of Tsize;
    pvDummy2 : array[1..3] of pointer;
    ucDummy3 : uint8;
    {$if (configUSE_TRACE_FACILITY = 1)}
    uxDummy4 : TUBaseType;
    {$endif}
  end;

  TStaticMessageBuffer = TStaticStreamBuffer;

  //Definitions coming from task.h

const
  tskKERNEL_VERSION_NUMBER = 'V10.3.1';
  tskKERNEL_VERSION_MAJOR  = 10;
  tskKERNEL_VERSION_MINOR  = 3;
  tskKERNEL_VERSION_BUILD  = 1;
type
  TtskTaskControlBlock = record
  end;

  TTaskHandle = ^TtskTaskControlBlock;

  //function BaseType_t (*TaskHookFunction_t)( void * ) : BaseType;

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
    {$if (portUSING_MPU_WRAPPERS = 1) and (configSUPPORT_STATIC_ALLOCATION = 1)}
      pxTaskBuffer : pTStaticTask;
    {$endif}
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

  // definitions coming from timers.h

const
  tmrCOMMAND_EXECUTE_CALLBACK_FROM_ISR = -2;
  tmrCOMMAND_EXECUTE_CALLBACK          = -1;
  tmrCOMMAND_START_DONT_TRACE          = 0;
  tmrCOMMAND_START                     = 1;
  tmrCOMMAND_RESET                     = 2;
  tmrCOMMAND_STOP                      = 3;
  tmrCOMMAND_CHANGE_PERIOD             = 4;
  tmrCOMMAND_DELETE                    = 5;

  tmrFIRST_FROM_ISR_COMMAND            = 6;
  tmrCOMMAND_START_FROM_ISR            = 6;
  tmrCOMMAND_RESET_FROM_ISR            = 7;
  tmrCOMMAND_STOP_FROM_ISR             = 8;
  tmrCOMMAND_CHANGE_PERIOD_FROM_ISR    = 9;

type
  TtmrTimerControl = record
  end;

  TTimerHandle = ^TtmrTimerControl;

  TTimerCallbackFunction = procedure (xTimer:TTimerHandle);

  TPendedFunction = procedure (_para1:pointer; _para2:uint32);

  // definitions coming from list.h

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

  // definitions coming from queue.h

  TQueueDefinition = record
  end;

  TQueueHandle = ^TQueueDefinition;
  TQueueSetHandle = ^TQueueDefinition;
  TQueueSetMemberHandle = ^TQueueDefinition;

  // definitions coming from semphr.h
  TSemaphoreHandle =TQueueHandle ;
const
  semBINARY_SEMAPHORE_QUEUE_LENGTH = 1;
  semSEMAPHORE_QUEUE_ITEM_LENGTH   = 0;
  semGIVE_BLOCK_TIME               = 0;

  // routines from task.h
{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
  {$if defined(CPUARM)}
  function  xTaskCreate(pxTaskCode:TTaskFunction; pcName:pChar; usStackDepth:uint16; pvParameters:pointer; uxPriority:TUBaseType; var pxCreatedTask:TTaskHandle):TBaseType;external;
  {$elseif defined(CPUXTENSA)}
    function  xTaskCreate(pxTaskCode:TTaskFunction;
                                      pcName:pChar; usStackDepth:uint16;
                                      pvParameters:pointer;
                                      uxPriority:TUBaseType;
                                      var pxCreatedTask:TTaskHandle):TBaseType;
    function  xTaskCreatePinnedToCore(pxTaskCode:TTaskFunction;
                                      pcName:pChar; usStackDepth:uint16;
                                      pvParameters:pointer;
                                      uxPriority:TUBaseType;
                                      var pxCreatedTask:TTaskHandle;
                                      xCoreID:TBaseType):TBaseType;external;
  {$else}
  {$endif}
{$endif}

{$if (configSUPPORT_STATIC_ALLOCATION = 1)}
function  xTaskCreateStatic(pxTaskCode:TTaskFunction;
                                  pcName:pChar; ulStackDepth:uint32;
                                  pvParameters:pointer;
                                  uxPriority:TUBaseType;
                                  puxStackBuffer:pTStackTypeArray;
                                  pxTaskBuffer:pTStaticTask):TTaskHandle;external;
{$endif}
{$if (portUSING_MPU_WRAPPERS =  1)}
function xTaskCreateRestricted(var pxTaskDefinition: TTaskParameters;
                               var pxCreatedTask: TTaskHandle): TBaseType; external;
{$endif}

{$if ( portUSING_MPU_WRAPPERS = 1 ) and ( configSUPPORT_STATIC_ALLOCATION = 1 )}
function xTaskCreateRestrictedStatic(var pxTaskDefinition : TTaskParameters;
                                     var pxCreatedTask : TTaskHandle):TBaseType; inline;
{$endif}

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
{$if (configUSE_APPLICATION_TASK_TAG = 1)}
TaskHookFunction_t xTaskGetApplicationTaskTag( TaskHandle_t xTask ) PRIVILEGED_FUNCTION;
TaskHookFunction_t xTaskGetApplicationTaskTagFromISR( TaskHandle_t xTask ) PRIVILEGED_FUNCTION;
{$endif}
{$if (configNUM_THREAD_LOCAL_STORAGE_POINTERS > 0 )}
void vTaskSetThreadLocalStoragePointer( TaskHandle_t xTaskToSet, BaseType_t xIndex, void *pvValue ) PRIVILEGED_FUNCTION;
void *pvTaskGetThreadLocalStoragePointer( TaskHandle_t xTaskToQuery, BaseType_t xIndex ) PRIVILEGED_FUNCTION;
{$endif}
function  xTaskCallApplicationTaskHook(xTask:TTaskHandle; pvParameter:pointer):TBaseType;external;
function  xTaskGetIdleTaskHandle:TTaskHandle;external;
function  uxTaskGetSystemState(var pxTaskStatusArray:TTaskStatus; uxArraySize:TUBaseType; var pulTotalRunTime:uint32):TUBaseType;external;
procedure vTaskList(pcWriteBuffer:pChar);external;
procedure vTaskGetRunTimeStats(pcWriteBuffer:pChar);external;
function  ulTaskGetIdleRunTimeCounter:uint32;external;
function  xTaskGenericNotify(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction;pulPreviousNotificationValue:puint32):TBaseType;external;
function  xTaskNotify(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction) : TBaseType; inline;
function  xTaskNotifyAndQuery(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; pulPreviousNotificationValue:puint32) : TBaseType;inline;
function  xTaskGenericNotifyFromISR(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; var pulPreviousNotificationValue:uint32; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external;
function  xTaskNotifyWait(ulBitsToClearOnEntry:uint32; ulBitsToClearOnExit:uint32; var pulNotificationValue:uint32; xTicksToWait:TTickType):TBaseType;external;
function  xTaskNotifyGive(xTaskToNotify:TTaskHandle):TBaseType; inline;
procedure vTaskNotifyGiveFromISR(xTaskToNotify:TTaskHandle; pxHigherPriorityTaskWoken:pTBaseType);external;
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

// routines from list.h
(*
procedure vListInitialise(var pxList:TList);external;
procedure vListInitialiseItem(var pxItem:TListItem);external;
procedure vListInsert(var pxList:TList; var pxNewListItem:TListItem);external;
procedure vListInsertEnd(var pxList:TList; var pxNewListItem:TListItem);external;
function  uxListRemove(var pxItemToRemove:TListItem):TUBaseType;external;
*)

// routines from timers.h
{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
function  xTimerCreate(pcTimerName:pChar; xTimerPeriodInTicks:TTickType; uxAutoReload:TUBaseType; pvTimerID:pointer; pxCallbackFunction:TTimerCallbackFunction):TTimerHandle;external;
{$endif}
{$if (configSUPPORT_STATIC_ALLOCATION = 1)}
function  xTimerCreateStatic(pcTimerName:pChar; xTimerPeriodInTicks:TTickType; uxAutoReload:TUBaseType; pvTimerID:pointer; pxCallbackFunction:TTimerCallbackFunction; var pxTimerBuffer:TStaticTimer):TTimerHandle;external;
{$endif}
function  pvTimerGetTimerID(xTimer:TTimerHandle):pointer;external;
procedure vTimerSetTimerID(xTimer:TTimerHandle; pvNewID:pointer);external;
function  xTimerIsTimerActive(xTimer:TTimerHandle):TBaseType;external;
function  xTimerGetTimerDaemonTaskHandle:TTaskHandle;external;
function xTimerStart(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
function xTimerStop(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
function xTimerChangePeriod(xTimer: TTimerHandle; xNewPeriod, xTicksToWait: TTickType): longint; inline;
function xTimerDelete(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
function xTimerReset(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
function xTimerStartFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
function xTimerStopFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
function xTimerChangePeriodFromISR(xTimer: TTimerHandle; xNewPeriod: TTickType; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
function xTimerResetFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
function  xTimerPendFunctionCallFromISR(xFunctionToPend:TPendedFunction; pvParameter1:pointer; ulParameter2:uint32; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external;
function  xTimerPendFunctionCall(xFunctionToPend:TPendedFunction; pvParameter1:pointer; ulParameter2:uint32; xTicksToWait:TTickType):TBaseType;external;
function  pcTimerGetName(xTimer:TTimerHandle):ppChar;external;
procedure vTimerSetReloadMode(xTimer:TTimerHandle; uxAutoReload:TUBaseType);external;
function  uxTimerGetReloadMode(xTimer:TTimerHandle):TUBaseType;external;
function  xTimerGetPeriod(xTimer:TTimerHandle):TTickType;external;
function  xTimerGetExpiryTime(xTimer:TTimerHandle):TTickType;external;
function  xTimerCreateTimerTask:TBaseType;external;
function  xTimerGenericCommand(xTimer:TTimerHandle; xCommandID:TBaseType; xOptionalValue:TTickType; pxHigherPriorityTaskWoken:pTBaseType; xTicksToWait:TTickType):TBaseType;external;
{$if (configUSE_TRACE_FACILITY = 1 )}
procedure vTimerSetTimerNumber(xTimer:TTimerHandle; uxTimerNumber:TUBaseType);external;
function  uxTimerGetTimerNumber(xTimer:TTimerHandle):TUBaseType;external;
{$endif}

// routines from queue.h
{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
function xQueueCreate(const uxQueueLength : TUBaseType; uxItemSize : TUBaseType) : TQueueHandle; inline;
{$endif}
{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
function xQueueCreateStatic(uxQueueLength : TUBaseType; uxItemSize : TUBaseType; pucQueueStorage : pointer; pxStaticQueue : pTStaticQueue) : TQueueHandle; inline;
{$endif}
function  xQueueSendToFront(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType; inline;
function  xQueueSendToBack(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType; inline;
function  xQueueSend(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType; inline;
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
function  xQueueReset(xQueue:TQueueHandle) : TBaseType;
function  xQueueGenericReset(xQueue:TQueueHandle;xNewQueue:TBaseType) : TBaseType; external;
{$if (configQUEUE_REGISTRY_SIZE > 0)}
procedure vQueueAddToRegistry(xQueue:TQueueHandle; pcQueueName:pChar);external;
procedure vQueueUnregisterQueue(xQueue:TQueueHandle);external;
function  pcQueueGetName(xQueue:TQueueHandle):pChar;external;
{$endif}
{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
function  xQueueGenericCreate(uxQueueLength:TUBaseType; uxItemSize:TUBaseType; ucQueueType:uint8):TQueueHandle;external;
{$endif}
{$if (configSUPPORT_STATIC_ALLOCATION = 1)}
  function  xQueueGenericCreateStatic(uxQueueLength:TUBaseType; uxItemSize:TUBaseType; pucQueueStorage:pByte; pxStaticQueue:pTStaticQueue; ucQueueType:uint8):TQueueHandle;external;
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

{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
procedure vSemaphoreCreateBinary(xSemaphore : TSemaphoreHandle);
{$endif}
function  xSemaphoreCreateBinary : TSemaphoreHandle;
function  xSemaphoreCreateBinaryStatic(pxSemaphoreBuffer : pTStaticSemaphore) : TSemaphoreHandle;
function  xSemaphoreCreateCounting(uxMaxCount :  TUBaseType; uxInitialCount : TUBaseType) : TSemaphoreHandle;
function  xSemaphoreCreateCountingStatic(uxMaxCount : TUBaseType;uxInitialCount : TUBaseType;pxSempahoreBuffer : pTStaticSemaphore) : TSemaphoreHandle;
function  xSemaphoreCreateMutex : TSemaphoreHandle;
function  xSemaphoreCreateMutexStatic( pxMutexBuffer : pTStaticSemaphore) : TSemaphoreHandle;
function  xSemaphoreCreateRecursiveMutex : TSemaphoreHandle;
function  xSemaphoreCreateRecursiveMutex(pxMutexBuffer : pTStaticSemaphore) : TSemaphoreHandle;
procedure vSemaphoreDelete(xSemaphore : TSemaphoreHandle);
function  uxSemaphoreGetCount(xSemaphore : TSemaphoreHandle) : TUBaseType;
function  xSemaphoreGetMutexHolder(xMutex : TSemaphoreHandle) : TTaskHandle;
function  xSemaphoreGive(xSemaphore :TSemaphoreHandle) : TBaseType;
function  xSemaphoreGiveFromISR(xSemaphore :  TSemaphoreHandle;var pxHigherPriorityTaskWoken : TBaseType) : TBaseType;
function  xSemaphoreGiveRecursive(xMutex : TSemaphoreHandle) : TBaseType;
function  xSemaphoreTake(xSemaphore : TSemaphoreHandle;xTicksToWait : TTickType) : TBaseType;
function  xSemaphoreTakeFromISR(xSemaphore : TSemaphoreHandle; var pxHigherPriorityTaskWoken : TBaseType ) : TBaseType;
function  xSemaphoreTakeRecursive(xMutex : TSemaphoreHandle;xTicksToWait:TTickType) : TBaseType;

procedure vPortEndScheduler; external;
procedure vPortEnterCritical; external;
procedure vPortExitCritical; external;

{$if defined(CPUARM)}
function memset(pxBuffer:pointer; value : uint32; count : Tsize):pointer; public name 'memset';
function memcpy(pxTarget : pointer; pxSource : pointer; count : Tsize):pointer; public name 'memcpy';
procedure vApplicationGetIdleTaskMemory(var ppxIdleTaskTCBBuffer:pTStaticTask; var ppxIdleTaskStackBuffer:pTStackType; var pulIdleTaskStackSize:uint32); public name 'vApplicationGetIdleTaskMemory';
procedure vApplicationGetTimerTaskMemory(var ppxTimerTaskTCBBuffer:pTStaticTask; var ppxTimerTaskStackBuffer:pTStackType; var pulTimerTaskStackSize:uint32); public name 'vApplicationGetTimerTaskMemory';
{$endif}
{$if defined(CPUARMV6M)}
function  __aeabi_uidiv(const numerator : uint32; denominator : uint32):uint32; public name '__aeabi_uidiv';
{$endif}

implementation
{$OPTIMIZATION ON}
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

{$if defined(CPUARM)}
var
  xIdleTaskTCB : TStaticTask;
  uxIdleTaskStack : array[0..configMINIMAL_STACK_SIZE-1] of TStackType; 
  xTimerTaskTCB : TStaticTask;
  uxTimerTaskStack : array[0..configTIMER_TASK_STACK_DEPTH-1] of TStackType;
{$endif}

{$if defined(CPUXTENSA)}
function  xTaskCreate(pxTaskCode:TTaskFunction; pcName:pChar; usStackDepth:uint16; pvParameters:pointer; uxPriority:TUBaseType; var pxCreatedTask:TTaskHandle):TBaseType;
begin
  Result := xTaskCreatePinnedToCore(pxTaskCode,pcName,usStackDepth,pvParameters,uxPriority,pxCreatedTask,tskNO_AFFINITY);
end;
{$endif}
{$if defined(CPUARM)}
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
{$endif}
{$if defined(CPUARMV6M)}
function __aeabi_uidiv(const numerator : uint32; denominator : uint32):uint32;
begin
  Result := numerator div denominator;
end;
{$endif}

function xTaskNotifyGive(xTaskToNotify: TTaskHandle): TBaseType; inline;
begin
  Result := xTaskNotify(xTaskToNotify, 0, eIncrement);
end;

function  xTaskNotify(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction) : TBaseType; inline;
begin
  xTaskGenericNotify(xTaskToNotify,ulValue,eAction,nil);
end;

function  xTaskNotifyAndQuery(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction;pulPreviousNotificationValue:puint32) : TBaseType;inline;
begin
  xTaskGenericNotify(xTaskToNotify,ulValue,eAction,pulPreviousNotificationValue);
end;

function xTimerStart(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_START,xTaskGetTickCount,nil,xTicksToWait);
end;

function xTimerStop(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_STOP,0,nil,xTicksToWait);
end;

function xTimerChangePeriod(xTimer: TTimerHandle; xNewPeriod, xTicksToWait: TTickType): longint; inline;
begin
    Result := xTimerGenericCommand(xTimer,tmrCOMMAND_CHANGE_PERIOD,xNewPeriod,nil,xTicksToWait);
end;

function xTimerDelete(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_DELETE,0,nil,xTicksToWait);
end;

function xTimerReset(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_RESET,xTaskGetTickCount,nil,xTicksToWait);
end;

function xTimerStartFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_START_FROM_ISR,xTaskGetTickCountFromISR,pxHigherPriorityTaskWoken,0);
end;

function xTimerStopFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_STOP_FROM_ISR,0,pxHigherPriorityTaskWoken,0);
end;

function xTimerChangePeriodFromISR(xTimer: TTimerHandle; xNewPeriod: TTickType; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_CHANGE_PERIOD_FROM_ISR,xNewPeriod,pxHigherPriorityTaskWoken,0);
end;

function xTimerResetFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
begin
  Result := xTimerGenericCommand(xTimer,tmrCOMMAND_RESET_FROM_ISR,xTaskGetTickCountFromISR,pxHigherPriorityTaskWoken,0);
end;

function xQueueCreate(const uxQueueLength : TUBaseType; uxItemSize : TUBaseType) : TQueueHandle; inline;
begin
  Result := xQueueGenericCreate(uxQueueLength,uxItemSize,queueQUEUE_TYPE_BASE);
end;

function xQueueCreateStatic(uxQueueLength : TUBaseType; uxItemSize : TUBaseType; pucQueueStorage : pointer; pxStaticQueue : pTStaticQueue) : TQueueHandle; inline;
begin
  Result := xQueueGenericCreateStatic(uxQueueLength,uxItemSize,pucQueueStorage,pxStaticQueue,queueQUEUE_TYPE_BASE);
end;

function  xQueueSend(xQueue : TQueueHandle; pvItemToQueue : pointer; xTicksToWait : TTickType) : TBaseType; inline;
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

{$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
//TODO Something is odd with xSemaphore beeing an out parameter
procedure vSemaphoreCreateBinary(xSemaphore : TSemaphoreHandle); inline;
begin
   xSemaphore := xQueueGenericCreate(1,semSEMAPHORE_QUEUE_ITEM_LENGTH,queueQUEUE_TYPE_BINARY_SEMAPHORE);
   if xsemaphore <> nil then
     xSemaphoreGive(xSemaphore);
end;

function  xSemaphoreCreateBinary : TSemaphoreHandle; inline;
begin
  xQueueGenericCreate(1,semSEMAPHORE_QUEUE_ITEM_LENGTH,queueQUEUE_TYPE_BINARY_SEMAPHORE);
end;
{$endif}
{$if (configSUPPORT_STATIC_ALLOCATION = 1)}
function  xSemaphoreCreateBinaryStatic(pxSemaphoreBuffer : pTStaticSemaphore) : TSemaphoreHandle; inline;
begin
  xQueueGenericCreateStatic(1,semSEMAPHORE_QUEUE_ITEM_LENGTH,nil,pxSemaphoreBuffer,queueQUEUE_TYPE_BINARY_SEMAPHORE);
end;
{$endif}

function  xSemaphoreCreateCounting(uxMaxCount :  TUBaseType; uxInitialCount : TUBaseType) : TSemaphoreHandle; inline;
begin

end;

function  xSemaphoreCreateCountingStatic(uxMaxCount : TUBaseType;uxInitialCount : TUBaseType;pxSempahoreBuffer : pTStaticSemaphore) : TSemaphoreHandle; inline;
begin

end;

function  xSemaphoreCreateMutex : TSemaphoreHandle; inline;
begin

end;

function  xSemaphoreCreateMutexStatic( pxMutexBuffer : pTStaticSemaphore) : TSemaphoreHandle; inline;
begin

end;

function  xSemaphoreCreateRecursiveMutex : TSemaphoreHandle; inline;
begin

end;

function  xSemaphoreCreateRecursiveMutex(pxMutexBuffer : pTStaticSemaphore) : TSemaphoreHandle; inline;
begin

end;

procedure vSemaphoreDelete(xSemaphore : TSemaphoreHandle); inline;
begin

end;

function  uxSemaphoreGetCount(xSemaphore : TSemaphoreHandle) : TUBaseType; inline;
begin

end;

function  xSemaphoreGetMutexHolder(xMutex : TSemaphoreHandle) : TTaskHandle; inline;
begin

end;

function  xSemaphoreGive(xSemaphore :TSemaphoreHandle) : TBaseType; inline;
begin

end;

function  xSemaphoreGiveFromISR(xSemaphore :  TSemaphoreHandle;var pxHigherPriorityTaskWoken : TBaseType) : TBaseType; inline;
begin

end;

function  xSemaphoreGiveRecursive(xMutex : TSemaphoreHandle) : TBaseType; inline;
begin

end;

function  xSemaphoreTake(xSemaphore : TSemaphoreHandle;xTicksToWait : TTickType) : TBaseType; inline;
begin

end;

function  xSemaphoreTakeFromISR(xSemaphore : TSemaphoreHandle; var pxHigherPriorityTaskWoken : TBaseType ) : TBaseType; inline;
begin

end;

function  xSemaphoreTakeRecursive(xMutex : TSemaphoreHandle;xTicksToWait:TTickType) : TBaseType; inline;
begin

end;

{$OPTIMIZATION DEFAULT}
end.
