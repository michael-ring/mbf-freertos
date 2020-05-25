{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit FreeRTOS.StreamBuffer;
  {$mode objfpc}{$H+}
  interface
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
  type
    TStreamBufferDefinition = record
    end;
    TStreamBufferHandle = ^TStreamBufferDefinition;
    TStaticStreamBuffer = record
      uxDummy1 : array[1..4] of Tsize;
      pvDummy2 : array[1..3] of pointer;
      ucDummy3 : uint8;
      {$if (configUSE_TRACE_FACILITY = 1)}
      uxDummy4 : TUBaseType;
      {$endif}
    end;
    pStaticStreamBuffer = ^TStaticStreamBuffer;

  {$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    function  xStreamBufferGenericCreate(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; xIsMessageBuffer:TBaseType):TStreamBufferHandle;external name 'xStreamBufferGenericCreate';
    function  xStreamBufferCreate(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize):TStreamBufferHandle;
  {$endif}

  {$if (configSUPPORT_STATIC_ALLOCATION = 1)}
    function  xStreamBufferGenericCreateStatic(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; xIsMessageBuffer:TBaseType; pucStreamBufferStorageArea:Puint8; pxStaticStreamBuffer:PStaticStreamBuffer):TStreamBufferHandle;external name 'xStreamBufferGenericCreateStatic';
    function  xStreamBufferCreateStatic(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; pucStreamBufferStorageArea:Puint8; pxStaticStreamBuffer:pStaticStreamBuffer):TStreamBufferHandle;
  {$endif}

  function  xStreamBufferSend(xStreamBuffer:TStreamBufferHandle; pvTxData:pointer; xDataLengthBytes:Tsize; xTicksToWait:TTickType):Tsize;external name 'xStreamBufferSend';
  function  xStreamBufferSendFromISR(xStreamBuffer:TStreamBufferHandle; pvTxData:pointer; xDataLengthBytes:Tsize; pxHigherPriorityTaskWoken:pTBaseType):Tsize;external name 'xStreamBufferSendFromISR';
  function  xStreamBufferReceive(xStreamBuffer:TStreamBufferHandle; pvRxData:pointer; xBufferLengthBytes:Tsize; xTicksToWait:TTickType):Tsize;cdecl;external name 'xStreamBufferReceive';
  function  xStreamBufferReceiveFromISR(xStreamBuffer:TStreamBufferHandle; pvRxData:pointer; xBufferLengthBytes:Tsize; pxHigherPriorityTaskWoken:pTBaseType):Tsize;external name 'xStreamBufferReceiveFromISR';
  procedure vStreamBufferDelete(xStreamBuffer:TStreamBufferHandle);external name 'vStreamBufferDelete';
  function  xStreamBufferIsFull(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferIsFull';
  function  xStreamBufferIsEmpty(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferIsEmpty';
  function  xStreamBufferReset(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferReset';
  function  xStreamBufferSpacesAvailable(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferSpacesAvailable';
  function  xStreamBufferBytesAvailable(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferBytesAvailable';
  function  xStreamBufferSetTriggerLevel(xStreamBuffer:TStreamBufferHandle; xTriggerLevel:Tsize):TBaseType;external name 'xStreamBufferSetTriggerLevel';
  function  xStreamBufferSendCompletedFromISR(xStreamBuffer:TStreamBufferHandle; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external name 'xStreamBufferSendCompletedFromISR';
  function  xStreamBufferReceiveCompletedFromISR(xStreamBuffer:TStreamBufferHandle; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external name 'xStreamBufferReceiveCompletedFromISR';
  function  xStreamBufferNextMessageLengthBytes(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferNextMessageLengthBytes';
  {$if (configUSE_TRACE_FACILITY = 1)}
    procedure vStreamBufferSetStreamBufferNumber(xStreamBuffer:TStreamBufferHandle; uxStreamBufferNumber:TUBaseType);external name 'vStreamBufferSetStreamBufferNumber';
    function uxStreamBufferGetStreamBufferNumber(xStreamBuffer:TStreamBufferHandle):TUBaseType;external name 'uxStreamBufferGetStreamBufferNumber';
    function ucStreamBufferGetStreamBufferType(xStreamBuffer:TStreamBufferHandle):uint8;external name 'ucStreamBufferGetStreamBufferType';
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
{$endif}

{$if not defined(INTERFACE)}
  {$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    function xStreamBufferCreate(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize):TStreamBufferHandle;
    begin
      Result := xStreamBufferGenericCreate(xBufferSizeBytes,xTriggerLevelBytes,pdFALSE);
    end;
  {$endif}

  {$if (configSUPPORT_STATIC_ALLOCATION = 1)}
    function xStreamBufferCreateStatic(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; pucStreamBufferStorageArea:Puint8; pxStaticStreamBuffer:pStaticStreamBuffer):TStreamBufferHandle;
    begin
      Result := xStreamBufferGenericCreateStatic(xBufferSizeBytes,xTriggerLevelBytes,pdFALSE,pucStreamBufferStorageArea,pxStaticStreamBuffer);
    end;
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

