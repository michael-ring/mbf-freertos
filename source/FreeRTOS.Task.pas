{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit FreeRTOS.Task;
  {$mode objfpc}{$H+}
  interface
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
  const
    tskKERNEL_VERSION_NUMBER = KERNEL_VERSION_NUMBER;
    tskKERNEL_VERSION_MAJOR  = KERNEL_VERSION_MAJOR;
    tskKERNEL_VERSION_MINOR  = KERNEL_VERSION_MINOR;
    tskKERNEL_VERSION_BUILD  = KERNEL_VERSION_BUILD;

    tskMPU_REGION_READ_ONLY     = 1 shl 0;
    tskMPU_REGION_READ_WRITE    = 1 shl 1;
    tskMPU_REGION_EXECUTE_NEVER = 1 shl 2;
    tskMPU_REGION_NORMAL_MEMORY = 1 shl 3;
    tskMPU_REGION_DEVICE_MEMORY = 1 shl 4;

  type
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

    TtskTaskControlBlock = record
    end;
    TTaskHandle = ^TtskTaskControlBlock;

    TTaskHookFunction = function(_para1:pointer):TBaseType;

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
      {$ifdef configTASKLIST_INCLUDE_COREID}
        xCoreID: TBaseType_t;
      {$endif}
    end;

    TeSleepModeStatus = (eAbortSleep := 0,eStandardSleep,eNoTasksWaitingTimeout);

  const
    tskIDLE_PRIORITY=0;
    tskNO_AFFINITY=$7FFFFFFF;


  procedure taskYield; external name 'portYield';
  procedure taskENTER_CRITICAL; external name 'portENTER_CRITICAL';
  procedure taskENTER_CRITICAL_FROM_ISR; external name 'portSET_INTERRUPT_MASK_FROM_ISR';
  procedure taskEXIT_CRITICAL; external name 'portEXIT_CRITICAL';
  procedure taskEXIT_CRITICAL_FROM_ISR(ulMask : uint32); external name 'portCLEAR_INTERRUPT_MASK_FROM_ISR';
  procedure taskDISABLE_INTERRUPTS; external name 'portDISABLE_INTERRUPTS';
  procedure taskENABLE_INTERRUPTS; external name 'portENABLE_INTERRUPTS';

  const
    taskSCHEDULER_SUSPENDED   : TBaseType = 0;
    taskSCHEDULER_NOT_STARTED : TBaseType = 1;
    taskSCHEDULER_RUNNING     : TBaseType = 2;

  {$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    {$if defined(CPUARM)}
      function  xTaskCreate(pxTaskCode:TTaskFunction;
                            pcName:pChar;
                            usStackDepth:uint16;
                            pvParameters:pointer;
                            uxPriority:TUBaseType;
                            var pxCreatedTask:TTaskHandle):TBaseType;external;
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
      {$error Unknown Architecture}
    {$endif}
  {$endif}

  {$if (configSUPPORT_STATIC_ALLOCATION = 1)}
    {$if defined(CPUARM)}
      function  xTaskCreateStatic(pxTaskCode:TTaskFunction;
                                  pcName:pChar;
                                  ulStackDepth:uint32;
                                  pvParameters:pointer;
                                  uxPriority:TUBaseType;
                                  puxStackBuffer:pTStackTypeArray;
                                  var pxTaskBuffer:TStaticTask):TTaskHandle;external;
    {$elseif defined(CPUXTENSA)}
      function xTaskCreateStatic(pvTaskCode: TTaskFunction_t;
                                 pcName: PChar;
                                 ulStackDepth: uint32;
                                 pvParameters: pointer;
                                 uxPriority: TUBaseType;
                                 pxStackBuffer: pTStackTypeArray;
                                 var pxTaskBuffer: TStaticTask): TTaskHandle;
      function xTaskCreateStaticPinnedToCore(pvTaskCode: TTaskFunction_t;
                                             pcName: PChar;
                                             ulStackDepth: uint32;
                                             pvParameters: pointer;
                                             uxPriority: TUBaseType;
                                             pxStackBuffer: pTStackTypeArray;
                                             var pxTaskBuffer: TStaticTask;
                                             xCoreID: TBaseType): TTaskHandle; external;
    {$else}
      {$error Unknown Architecture}
    {$endif}
  {$endif}

  {$if (portUSING_MPU_WRAPPERS =  1)}
    {$if ( configSUPPORT_DYNAMIC_ALLOCATION = 1)}
      function xTaskCreateRestricted(var pxTaskDefinition: TTaskParameters;
                                     var pxCreatedTask: TTaskHandle): TBaseType; external;
    {$endif}

    {$if ( configSUPPORT_STATIC_ALLOCATION = 1)}
      function xTaskCreateRestrictedStatic(var pxTaskDefinition : TTaskParameters;
                                           var pxCreatedTask : TTaskHandle):TBaseType; inline;
    {$endif}
  {$endif}

  procedure vTaskAllocateMPURegions(xTask:TTaskHandle; var pxRegions:TMemoryRegion);external;
  procedure vTaskDelete(xTaskToDelete:TTaskHandle);external;
  procedure vTaskDelay(xTicksToDelay:TTickType);external;
  procedure xTaskDelayUntil(var pxPreviousWakeTime:TTickType; xTimeIncrement:TTickType);external;
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
  function  pcTaskGetName(xTaskToQuery:TTaskHandle):pchar;external;
  function  xTaskGetHandle(pcNameToQuery:pChar):TTaskHandle;external;
  function  uxTaskGetStackHighWaterMark(xTask:TTaskHandle):TUBaseType;external;
  function  uxTaskGetStackHighWaterMark2(xTask:TTaskHandle):uint16;external;
  {$if (configUSE_APPLICATION_TASK_TAG = 1)}
     procedure vTaskSetApplicationTaskTag(xTask : TTaskHandle; pxHookFunction : TTaskHookFunction);external;
     function  xTaskGetApplicationTaskTag(xTask : TTaskHandle): TTaskHookFunction;external;
     function  xTaskGetApplicationTaskTagFromISR(xTask : TTaskHandle): TTaskHookFunction;external;
  {$endif}
  {$if (configNUM_THREAD_LOCAL_STORAGE_POINTERS > 0 )}
    procedure vTaskSetThreadLocalStoragePointer(xTaskToSet : TTaskHandle; BaseType_t xIndex; pvValue : pointer ); external;
    function pvTaskGetThreadLocalStoragePointer(xTaskToQuery : TTaskHandle; xIndex : TBaseType): pointer; external;
  {$endif}
  function  xTaskCallApplicationTaskHook(xTask:TTaskHandle; pvParameter:pointer):TBaseType;external;
  function  xTaskGetIdleTaskHandle:TTaskHandle;external;
  function  uxTaskGetSystemState(var pxTaskStatusArray:TTaskStatus; uxArraySize:TUBaseType; var pulTotalRunTime:uint32):TUBaseType;external;
  procedure vTaskList(pcWriteBuffer:pChar);external;
  procedure vTaskGetRunTimeStats(pcWriteBuffer:pChar);external;
  function  ulTaskGetIdleRunTimeCounter:uint32;external;
  function  xTaskGenericNotify(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction;pulPreviousNotificationValue:puint32):TBaseType;external;
  function  xTaskNotify(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction) : TBaseType;
  function  xTaskNotifyAndQuery(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; pulPreviousNotificationValue:puint32) : TBaseType;inline;
  function  xTaskGenericNotifyFromISR(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; pulPreviousNotificationValue:puint32; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external;
  function  xTaskNotifyFromISR(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; pxHigherPriorityTaskWoken:pTBaseType):TBaseType; inline;
  function  xTaskNotifyAndQueryFromISR(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; pulPreviousNotificationValue:puint32; pxHigherPriorityTaskWoken:pTBaseType):TBaseType; external name 'xTaskGenericNotifyFromISR';
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
  function  eTaskConfirmSleepModeStatus:TeSleepModeStatus;external;
  function  pvTaskIncrementMutexHeldCount:TTaskHandle;external;
  procedure vTaskInternalSetTimeOutState(var pxTimeOut:TTimeOut);external;
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
{$endif}

{$if not defined(INTERFACE)}
  {$if defined(CPUARM) and (configSUPPORT_STATIC_ALLOCATION = 1)}
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

  function xTaskNotifyGive(xTaskToNotify: TTaskHandle): TBaseType; inline;
  begin
    Result := xTaskNotify(xTaskToNotify, 0, TeNotifyAction.eIncrement);
  end;

  function  xTaskNotify(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction) : TBaseType;
  begin
    Result := xTaskGenericNotify(xTaskToNotify,ulValue,eAction,nil);
  end;

  function  xTaskNotifyFromISR(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction; pxHigherPriorityTaskWoken:pTBaseType):TBaseType; inline;
  begin
    Result := xTaskGenericNotifyFromISR(xTaskToNotify,ulValue,eAction,nil,pxHigherPriorityTaskWoken);
  end;

  function  xTaskNotifyAndQuery(xTaskToNotify:TTaskHandle; ulValue:uint32; eAction:TeNotifyAction;pulPreviousNotificationValue:puint32) : TBaseType;inline;
  begin
    Result := xTaskGenericNotify(xTaskToNotify,ulValue,eAction,pulPreviousNotificationValue);
  end;

  procedure taskYieldFromISR(pxHigherPriorityTaskWoken : pTBaseType); inline;
  var
    portNVIC_INT_CTRL_REG : uint32 absolute $e000ed04;
  begin
    if (pxHigherPriorityTaskWoken <> nil) and (pxHigherPriorityTaskWoken^ <> 0) then
      portNVIC_INT_CTRL_REG := 1 shl 28;
  end;
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

