{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit freertos.streambuffer;
  {$mode objfpc}{$H+}
  interface
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
type
  TStaticStreamBuffer = record
    uxDummy1 : array[1..4] of Tsize;
    pvDummy2 : array[1..3] of pointer;
    ucDummy3 : uint8;
    {$if (configUSE_TRACE_FACILITY = 1)}
    uxDummy4 : TUBaseType;
    {$endif}
  end;
  TStreamBufferDefinition = record
  end;

  pStaticStreamBuffer = ^TStaticStreamBuffer;
  TStreamBufferHandle = ^TStreamBufferDefinition;
  pTStreamBufferHandle = ^TStreamBufferHandle;


function xStreamBufferSend(xStreamBuffer:TStreamBufferHandle; pvTxData:pointer; xDataLengthBytes:Tsize; xTicksToWait:TTickType):Tsize;external name 'xStreamBufferSend';
function xStreamBufferSendFromISR(xStreamBuffer:TStreamBufferHandle; pvTxData:pointer; xDataLengthBytes:Tsize; pxHigherPriorityTaskWoken:pTBaseType):Tsize;external name 'xStreamBufferSendFromISR';
function xStreamBufferReceive(xStreamBuffer:TStreamBufferHandle; pvRxData:pointer; xBufferLengthBytes:Tsize; xTicksToWait:TTickType):Tsize;cdecl;external name 'xStreamBufferReceive';
function xStreamBufferReceiveFromISR(xStreamBuffer:TStreamBufferHandle; pvRxData:pointer; xBufferLengthBytes:Tsize; pxHigherPriorityTaskWoken:pTBaseType):Tsize;external name 'xStreamBufferReceiveFromISR';
procedure vStreamBufferDelete(xStreamBuffer:TStreamBufferHandle);external name 'vStreamBufferDelete';
function xStreamBufferIsFull(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferIsFull';
function xStreamBufferIsEmpty(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferIsEmpty';
function xStreamBufferReset(xStreamBuffer:TStreamBufferHandle):TBaseType;external name 'xStreamBufferReset';
function xStreamBufferSpacesAvailable(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferSpacesAvailable';
function xStreamBufferBytesAvailable(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferBytesAvailable';
function xStreamBufferSetTriggerLevel(xStreamBuffer:TStreamBufferHandle; xTriggerLevel:Tsize):TBaseType;external name 'xStreamBufferSetTriggerLevel';
function xStreamBufferSendCompletedFromISR(xStreamBuffer:TStreamBufferHandle; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external name 'xStreamBufferSendCompletedFromISR';
function xStreamBufferReceiveCompletedFromISR(xStreamBuffer:TStreamBufferHandle; pxHigherPriorityTaskWoken:pTBaseType):TBaseType;external name 'xStreamBufferReceiveCompletedFromISR';
function xStreamBufferGenericCreate(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; xIsMessageBuffer:TBaseType):TStreamBufferHandle;external name 'xStreamBufferGenericCreate';
function xStreamBufferGenericCreateStatic(xBufferSizeBytes:Tsize; xTriggerLevelBytes:Tsize; xIsMessageBuffer:TBaseType; pucStreamBufferStorageArea:Puint8; pxStaticStreamBuffer:PStaticStreamBuffer):TStreamBufferHandle;external name 'xStreamBufferGenericCreateStatic';
function xStreamBufferNextMessageLengthBytes(xStreamBuffer:TStreamBufferHandle):Tsize;external name 'xStreamBufferNextMessageLengthBytes';
procedure vStreamBufferSetStreamBufferNumber(xStreamBuffer:TStreamBufferHandle; uxStreamBufferNumber:TUBaseType);external name 'vStreamBufferSetStreamBufferNumber';
function uxStreamBufferGetStreamBufferNumber(xStreamBuffer:TStreamBufferHandle):TUBaseType;external name 'uxStreamBufferGetStreamBufferNumber';
function ucStreamBufferGetStreamBufferType(xStreamBuffer:TStreamBufferHandle):uint8;external name 'ucStreamBufferGetStreamBufferType';

{$endif}
{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
implementation
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

