unit freertos.heap_4;
{$if defined(CPUARM)}
  {$LINKLIB freertos_heap_4,static}
{$elseif defined(CPUXTENSA)}
  {$LINKLIB freertos_heap_4,static}
{$else}
  {$ERROR No FreeRTOS support currently available for current arch}
{$endif}

interface

function  pvPortMalloc(const xWantedSize : uint32):pointer; external;
procedure vPortFree(var pv : pointer); external;
function  xPortGetFreeHeapSize:uint32; external;
function  xPortGetMinimumEverFreeHeapSize:uint32; external;

implementation
begin
end.
