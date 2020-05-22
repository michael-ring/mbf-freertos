{$MACRO ON}
{$if defined(CPUARM)}
  {$LINKLIB freertos,static}
  {$DEFINE KERNEL_VERSION_NUMBER := 'V10.3.1'}
  {$DEFINE KERNEL_VERSION_MAJOR  := 10}
  {$DEFINE KERNEL_VERSION_MINOR  := 3}
  {$DEFINE KERNEL_VERSION_BUILD  := 1}

  {$if defined(CPUARMV6M)}
    {$I FreeRTOSConfig-armv6m.inc}
  {$elseif defined(CPUARMV7M)}
    {$I FreeRTOSConfig-armv7m.inc}
  {$elseif defined(CPUARMV7EM)}
    {$I FreeRTOSConfig-armv7em.inc}
  {$else}
    {$ERROR FreeRTOSConfig.inc not available}
  {$endif}
{$elseif defined(CPUXTENSA)}
  {$LINKLIB freertos,static}
  {$DEFINE KERNEL_VERSION_NUMBER := 'V8.2.0'}
  {$DEFINE KERNEL_VERSION_MAJOR  := 8}
  {$DEFINE KERNEL_VERSION_MINOR  := 2}
  {$DEFINE KERNEL_VERSION_BUILD  := 0}
  {$if defined(CPULX6)}
    {$I FreeRTOSConfig-lx6.inc}
  {$endif}
{$else}
  {$ERROR No FreeRTOS support currently available for this arch}
{$endif}

type
  Tsize = uint32;
  TStackType = uint32;
  TStackTypeArray = array of TStackType;
  pTStackType = ^TStackType;
  pTStackTypeArray = ^TStackTypeArray;
  TBaseType = int32;
  pTBaseType = ^TBaseType;
  TUBaseType = uint32;
  TTickType = uint32;

  TconfigSTACK_DEPTH_TYPE  = uint16;

const
  pdFalse:TBaseType=0;
  pdTrue:TBaseType=1;
  pdPass:TBaseType=1;
  pdFail:TBaseType=0;
  portNUM_CONFIGURABLE_REGIONS=1;
  configMINIMAL_STACK_SIZE=128;
  configTIMER_TASK_STACK_DEPTH=256;

type
  TStaticListItem = record
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy1 : TTickType;
    {$endif}
    xDummy2 : TTickType;
    pvDummy3 : array[1..4] of pointer;
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy4 : TTickType;
    {$endif}
  end;
  pTStaticListItem = ^TStaticListItem;

  TStaticMiniListItem = record
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy1 : TTickType;
    {$endif}
    xDummy2 : TTickType;
    pvDummy3 : array[1..2] of pointer;
  end;
  pTStaticMiniListItem = ^TStaticMiniListItem;

  TStaticList = record
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy1 : TTickType;
    {$endif}
    uxDummy2 : TUBaseType;
    pvDummy3 : pointer;
    xDummy4 : TStaticMiniListItem;
    {$if (configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES = 1)}
    xDummy5 : TTickType;
    {$endif}
  end;
  pTStaticList = ^TStaticList;

  TListItem = record
    xItemValue : TTickType;
    pxNext : ^TListItem;
    pxPrevious : ^TListItem;
    pvOwner : pointer;
    pxContainer : ^TList;
  end;

  TMiniListItem = record
    xItemValue : TTickType;
    pxNext : ^TListItem;
    pxPrevious : ^TListItem;
  end;

  TList = record
    pxIndex : ^TListItem;
    xListEnd : TMiniListItem;
  end;

  TTaskFunction = procedure(_para1:pointer);



