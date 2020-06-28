{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit FreeRTOS.Port;
  {$mode objfpc}{$H+}
  interface
  {$if defined(USE_SYSVIEW)}
    uses
      Segger.SysView;
  {$endif}

  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
  {$if not defined(portHAS_STACK_OVERFLOW_CHECKING)}
    {$define portHAS_STACK_OVERFLOW_CHECKING := 0} 
  {$endif}

  const
    portMAX_DELAY:TTickType=$ffffffff;
    portTick_Period_MS:TTickType=1000 div configTICK_RATE_HZ;

  type
    THeapRegion = record
  	pucStartAddress : puint8;
  	xSizeInBytes : TSize;
    end;

    THeapStats = record
      xAvailableHeapSpaceInBytes : TSize;
      xSizeOfLargestFreeBlockInBytes : TSize;
      xSizeOfSmallestFreeBlockInBytes : TSize;
      xNumberOfFreeBlocks : TSize;
      xMinimumEverFreeBytesRemaining : TSize;
      xNumberOfSuccessfulAllocations : TSize;
      xNumberOfSuccessfulFrees : TSize;
    end;

  //procedure vPortYield; external name 'vPortYield';
  //procedure portYield; external name 'vPortYield';
  procedure vPortYield;
  procedure portYield;
  procedure portEND_SWITCHING_ISR(xSwitchRequired : TBaseType); public name 'portEND_SWITCHING_ISR';
  procedure portYIELD_FROM_ISR(xSwitchRequired : TBaseType); external name 'portEND_SWITCHING_ISR';

  procedure vPortEnterCritical; external name 'vPortEnterCritical';
  procedure vPortExitCritical; external name 'vPortExitCritical';
  function  ulSetInterruptMaskFromISR : uint32; external name 'ulSetInterruptMaskFromISR';
  procedure vClearInterruptMaskFromISR(ulMask : uint32); external name 'vClearInterruptMaskFromISR';

  function  portSET_INTERRUPT_MASK_FROM_ISR : uint32; external name 'ulSetInterruptMaskFromISR';
  procedure portCLEAR_INTERRUPT_MASK_FROM_ISR(ulMask : uint32); external name 'vClearInterruptMaskFromISR';
  procedure portDISABLE_INTERRUPTS; public name 'portDISABLE_INTERRUPTS';
  procedure portENABLE_INTERRUPTS; public name 'portENABLE_INTERRUPTS';
  procedure portENTER_CRITICAL; external name 'vPortEnterCritical';
  procedure portEXIT_CRITICAL; external name 'vPortExitCritical';

  {$if (portUSING_MPU_WRAPPERS = 1)}
    {$if (portHAS_STACK_OVERFLOW_CHECKING = 1)}
      function pxPortInitialiseStack(var pxTopOfStack : TStackType; var pxEndOfStack : TStackType;pxCode : TTaskFunction; pvParameters : pointer; xRunPrivileged : TBaseType ) : pTStackType; external name 'pxPortInitialiseStack';
    {$else}
      function pxPortInitialiseStack(var pxTopOfStack : TStackType; var pxEndOfStack : TStackType; void *pvParameters; xRunPrivileged : TBaseType ) : pTStackType; external name 'pxPortInitialiseStack';
    {$endif}
  {$else}
    {$if (portHAS_STACK_OVERFLOW_CHECKING = 1)}
      function pxPortInitialiseStack(var pxTopOfStack : TStackType; var pxEndOfStack : TStackType; pxCode : TTaskFunction; pvParameters : pointer) : pTStackType; external name 'pxPortInitialiseStack';
    {$else}
      function pxPortInitialiseStack( var pxTopOfStack : TStackType;pxCode : TTaskFunction; pvParameters : pointer) : pTStackType; external name 'pxPortInitialiseStack';
    {$endif}
  {$endif}

  procedure vPortDefineHeapRegions(var pxHeapRegions : THeapRegion); external name 'vPortDefineHeapRegions';
  procedure vPortGetHeapStats( var pxHeapStats : THeapStats); external name 'vPortGetHeapStats';
  function  pvPortMalloc(xSize:TSize):pointer; external name 'pvPortMalloc';
  //procedure vPortFree(pv : pointer); external name 'vPortFree';
  procedure vPortInitialiseBlocks; external name 'vPortInitialiseBlocks';
  function  xPortGetFreeHeapSize:TSize; external name 'xPortGetFreeHeapSize';
  function  xPortGetMinimumEverFreeHeapSize:TSize; external name 'xPortGetMinimumEverFreeHeapSize';
  function  xPortStartScheduler:TBaseType; external name 'xPortStartScheduler';
  procedure vPortEndScheduler; external name 'vPortEndScheduler';
  {$if (portUSING_MPU_WRAPPERS = 1)}
    struct xMEMORY_REGION;
    procedure vPortStoreTaskMPUSettings( xMPU_SETTINGS *xMPUSettings, const struct xMEMORY_REGION * const xRegions, StackType_t *pxBottomOfStack, uint32_t ulStackDepth );
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
{$endif}

{$if not defined(INTERFACE)}
  {$if defined(CPUARM)}
    procedure portDISABLE_INTERRUPTS; assembler; nostackframe;
    asm
      cpsid i
    end;
    
    procedure portENABLE_INTERRUPTS; assembler; nostackframe;
    asm
      cpsie i
    end;

    procedure vPortYield;
    var
      portNVIC_INT_CTRL_REG : uint32 absolute $e000ed04;
    begin
      portNVIC_INT_CTRL_REG := 1 shl 28;
      asm
        dsb
        isb
      end;
    end;

    procedure portYield;
    var
      portNVIC_INT_CTRL_REG : uint32 absolute $e000ed04;
    begin
      portNVIC_INT_CTRL_REG := 1 shl 28;
      asm
        dsb
        isb
      end;
    end;
    procedure portEND_SWITCHING_ISR(xSwitchRequired : TBaseType);
    var
      portNVIC_INT_CTRL_REG : uint32 absolute $e000ed04;
    begin
      if (xSwitchRequired <> 0) then
      {$if defined(USE_SYSVIEW)}
        begin
          traceISR_EXIT_TO_SCHEDULER();
          portNVIC_INT_CTRL_REG := 1 shl 28;
        end
        else
          traceISR_EXIT();
      {$else}
        portNVIC_INT_CTRL_REG := 1 shl 28;
      {$endif}
    end;

    procedure vPortFree; external name 'vPortFree';

    procedure vPortFreeStub; assembler; nostackframe;
    asm
      .long vPortFree
      .weak vPortFree
      .set  vPortFree,vPortFreeStub
      bkpt
    end;
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

