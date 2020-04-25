unit freertos.heap_4;
{$if defined(CPUARMV6M)}
{$LINK cortexm0p/heap_4.o}
{$elseif defined(CPUARMV7M)}
{$LINK cortexm3/heap_4.o}
{$elseif defined(CPUARMV7EM)}
{$LINK cortexm4f/heap_4.o}
{$else}
  {$Error  No FreeRTOS found for this subarch}
{$endif}
interface
//void *pvPortMalloc( size_t xWantedSize )
//void vPortFree( void *pv )
//size_t xPortGetFreeHeapSize( void )
//size_t xPortGetMinimumEverFreeHeapSize( void )

function  pvPortMalloc(const xWantedSize : uint32):pointer; external;
procedure vPortFree(var pv : pointer); external;
function  xPortGetFreeHeapSize:uint32; external;
function  xPortGetMinimumEverFreeHeapSize:uint32; external;

implementation

end.
