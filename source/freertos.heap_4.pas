unit freertos.heap_4;
{$if defined(CPUARM)}
  {$if defined(CPUARMV6M)}
    {$LINK libfreertos_heap_4_cortexm0p.a}
  {$elseif defined(CPUARMV7M)}
    {$LINK libfreertos_heap_4_cortexm3.a}
  {$elseif defined(CPUARMV7EM)}
    {$LINK libfreertos_heap_4_cortexm4f.a}
  {$else}
    {$Error  No FreeRTOS library available for this subarch}
  {$endif}
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
