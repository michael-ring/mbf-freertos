{$OPTIMIZATION ON}
unit FreeRTOS;
interface
{$I FreeRTOS.config.inc}
{$define INTERFACE}
{$INCLUDE FreeRTOS.Port.pas}
{$INCLUDE FreeRTOS.Task.pas}
{$INCLUDE FreeRTOS.Queue.pas}
{$INCLUDE FreeRTOS.Timer.pas}
{$INCLUDE FreeRTOS.Semaphore.pas}
{$INCLUDE FreeRTOS.StreamBuffer.pas}
{$INCLUDE FreeRTOS.MessageBuffer.pas}
{$undef INTERFACE}

{$if defined(CPUARM)}
//function memset(pxBuffer:pointer; value : uint32; count : Tsize):pointer; public name 'memset';
//function memcpy(pxTarget : pointer; pxSource : pointer; count : Tsize):pointer; public name 'memcpy';
procedure vApplicationGetIdleTaskMemory(var ppxIdleTaskTCBBuffer:pTStaticTaskTCB; var ppxIdleTaskStackBuffer:pTStackType; var pulIdleTaskStackSize:uint32); public name 'vApplicationGetIdleTaskMemory';
procedure vApplicationGetTimerTaskMemory(var ppxTimerTaskTCBBuffer:pTStaticTaskTCB; var ppxTimerTaskStackBuffer:pTStackType; var pulTimerTaskStackSize:uint32); public name 'vApplicationGetTimerTaskMemory';
{$endif}
{$if defined(CPUARMV6M)}
function  __aeabi_uidiv(const numerator : uint32; denominator : uint32):uint32; public name '__aeabi_uidiv';
{$endif}

implementation
{$define IMPLEMENTATION}
{$INCLUDE FreeRTOS.Port.pas}
{$INCLUDE FreeRTOS.Task.pas}
{$INCLUDE FreeRTOS.Queue.pas}
{$INCLUDE FreeRTOS.Timer.pas}
{$INCLUDE FreeRTOS.Semaphore.pas}
{$INCLUDE FreeRTOS.StreamBuffer.pas}
{$INCLUDE FreeRTOS.MessageBuffer.pas}
{$undef IMPLEMENTATION}

{$if defined(CPUARM)}
(*
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
*)
procedure vApplicationGetIdleTaskMemory(var ppxIdleTaskTCBBuffer:pTStaticTaskTCB; var ppxIdleTaskStackBuffer:pTStackType; var pulIdleTaskStackSize:uint32);
begin
  ppxIdleTaskTCBBuffer := @xIdleTaskTCB;
  ppxIdleTaskStackBuffer := @uxIdleTaskStack;
  pulIdleTaskStackSize := configMINIMAL_STACK_SIZE;
end;

procedure vApplicationGetTimerTaskMemory(var ppxTimerTaskTCBBuffer:pTStaticTaskTCB; var ppxTimerTaskStackBuffer:pTStackType; var pulTimerTaskStackSize:uint32);
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

begin
end.
