{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit freertos.timer;
  {$mode objfpc}{$H+}
  interface
  uses
    FreeRTOS.Task;
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
  type
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

    TtmrTimerControl = record
    end;
    TTimerHandle = ^TtmrTimerControl;

    TTimerCallbackFunction = procedure (xTimer:TTimerHandle);
    TPendedFunction = procedure (_para1:pointer; _para2:uint32);


  {$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
  //TODO Check Return Parameter for ESP32
    function  xTimerCreate(pcTimerName:pChar;
                           xTimerPeriodInTicks:TTickType;
                           uxAutoReload:TUBaseType;
                           pvTimerID:pointer;
                           pxCallbackFunction:TTimerCallbackFunction):TTimerHandle;external;
  {$endif}
  {$if (configSUPPORT_STATIC_ALLOCATION = 1)}
    function  xTimerCreateStatic(pcTimerName:pChar;
                                 xTimerPeriodInTicks:TTickType;
                                 uxAutoReload:TUBaseType;
                                 pvTimerID:pointer;
                                 pxCallbackFunction:TTimerCallbackFunction;
                                 var pxTimerBuffer:TStaticTimer):TTimerHandle;external;
  {$endif}
  function  pvTimerGetTimerID(xTimer:TTimerHandle):pointer;external;
  procedure vTimerSetTimerID(xTimer:TTimerHandle; pvNewID:pointer);external;
  function  xTimerIsTimerActive(xTimer:TTimerHandle):TBaseType;external;
  function  xTimerGetTimerDaemonTaskHandle:TTaskHandle;external;
  function  xTimerStart(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
  function  xTimerStop(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
  function  xTimerChangePeriod(xTimer: TTimerHandle; xNewPeriod, xTicksToWait: TTickType): longint; inline;
  function  xTimerDelete(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
  function  xTimerReset(xTimer: TTimerHandle; xTicksToWait: TTickType): TBaseType; inline;
  function  xTimerStartFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
  function  xTimerStopFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
  function  xTimerChangePeriodFromISR(xTimer: TTimerHandle; xNewPeriod: TTickType; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
  function  xTimerResetFromISR(xTimer: TTimerHandle; pxHigherPriorityTaskWoken: pTBaseType): TBaseType; inline;
  function  xTimerPendFunctionCallFromISR(xFunctionToPend:TPendedFunction; pvParameter1:pointer; ulParameter2:uint32; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external;
  function  xTimerPendFunctionCall(xFunctionToPend:TPendedFunction; pvParameter1:pointer; ulParameter2:uint32; xTicksToWait:TTickType):TBaseType;external;
  function  pcTimerGetName(xTimer:TTimerHandle):pChar;external;

  {$if (KERNEL_VERSION_MAJOR >=10)}
    procedure vTimerSetReloadMode(xTimer:TTimerHandle; uxAutoReload:TUBaseType);external;
    function  uxTimerGetReloadMode(xTimer:TTimerHandle):TUBaseType;external;
    function  xTimerGetPeriod(xTimer:TTimerHandle):TTickType;external;
    function  xTimerGetExpiryTime(xTimer:TTimerHandle):TTickType;external;
  {$endif}
  function  xTimerCreateTimerTask:TBaseType;external;
  function  xTimerGenericCommand(xTimer:TTimerHandle; xCommandID:TBaseType; xOptionalValue:TTickType; pxHigherPriorityTaskWoken:pTBaseType; xTicksToWait:TTickType):TBaseType;external;
  {$if (configUSE_TRACE_FACILITY = 1)}
    procedure vTimerSetTimerNumber(xTimer:TTimerHandle; uxTimerNumber:TUBaseType);external;
    function  uxTimerGetTimerNumber(xTimer:TTimerHandle):TUBaseType;external;
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
{$endif}
{$if not defined(INTERFACE)}
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
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}