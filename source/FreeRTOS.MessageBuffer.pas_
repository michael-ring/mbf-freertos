{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit freertos.messagebuffer;
  {$mode objfpc}{$H+}
  interface
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
  type
    TMessageBufferHandle = pointer;
  {$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    function xMessageBufferCreate(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize):TMessageBufferHandle; inline;
  {$endif}

  {$if (configSUPPORT_STATIC_ALLOCATION = 1)}
    function xMessageBufferCreateStatic(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; pucStreamBufferStorageArea:Puint8; pxStaticStreamBuffer:pStaticStreamBuffer):TMessageBufferHandle; inline;
  {$endif}

  function  xMessageBufferSend(xStreamBuffer:TStreamBufferHandle; pvTxData:pointer; xDataLengthBytes:Tsize; xTicksToWait:TTickType):Tsize;external name 'xStreamBufferSend';
  function  xMessageBufferSendFromISR(xStreamBuffer:TStreamBufferHandle; pvTxData:pointer; xDataLengthBytes:Tsize; pxHigherPriorityTaskWoken:pTBaseType):Tsize;external name 'xStreamBufferSendFromISR';
  function  xMessageBufferReceive(xStreamBuffer:TStreamBufferHandle; pvRxData:pointer; xBufferLengthBytes:Tsize; xTicksToWait:TTickType):Tsize;cdecl;external name 'xStreamBufferReceive';
  function  xMessageBufferReceiveFromISR(xStreamBuffer:TStreamBufferHandle; pvRxData:pointer; xBufferLengthBytes:Tsize; pxHigherPriorityTaskWoken:pTBaseType):Tsize;external name 'xStreamBufferReceiveFromISR';
  procedure vMessageBufferDelete(xStreamBuffer:TStreamBufferHandle);external name 'vStreamBufferDelete';
  function  xMessageBufferIsFull(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferIsFull';
  function  xMessageBufferIsEmpty(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferIsEmpty';
  function  xMessageBufferReset(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferReset';

  function  xMessageBufferSpaceAvailable(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferSpacesAvailable';
  function  xMessageBufferSpacesAvailable(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferSpacesAvailable';

  function  xMessageBufferNextLengthBytes(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferNextMessageLengthBytes';
  function  xMessageBufferSendCompletedFromISR(xStreamBuffer:TStreamBufferHandle; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external name 'xStreamBufferSendCompletedFromISR';
  function  xMessageBufferReceiveCompletedFromISR(xStreamBuffer:TStreamBufferHandle; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external name 'xStreamBufferReceiveCompletedFromISR';

  {$if (configUSE_TRACE_FACILITY = 1)}
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
{$endif}

{$if not defined(INTERFACE)}
  {$if (configSUPPORT_DYNAMIC_ALLOCATION = 1)}
    function xMessageBufferCreate(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize):TMessageBufferHandle;
    begin
      Result := xStreamBufferGenericCreate(xBufferSizeBytes,xTriggerLevelBytes,pdFALSE);
    end;
  {$endif}

  {$if (configSUPPORT_STATIC_ALLOCATION = 1)}
    function xMessageBufferCreateStatic(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; pucStreamBufferStorageArea:Puint8; pxStaticStreamBuffer:pStaticStreamBuffer):TMessageBufferHandle;
    begin
      Result := xStreamBufferGenericCreateStatic(xBufferSizeBytes,xTriggerLevelBytes,pdFALSE,pucStreamBufferStorageArea,pxStaticStreamBuffer);
    end;
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

