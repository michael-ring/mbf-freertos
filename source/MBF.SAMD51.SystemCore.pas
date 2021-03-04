unit MBF.SAMD51.SystemCore;
{
  This file is part of Pascal Microcontroller Board Framework (MBF)
  Copyright (c) 2015 -  Michael Ring
  based on Pascal eXtended Library (PXL)
  Copyright (c) 2000 - 2015  Yuriy Kotsarenko

  This program is free software: you can redistribute it and/or modify it under the terms of the FPC modified GNU
  Library General Public License for more

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the FPC modified GNU Library General Public
  License for more details.
}
{
  Related Reference Manuals

}

interface

{$INCLUDE MBF.Config.inc}

{$DEFINE INTERFACE}
{$INCLUDE MBF.ARM.SystemCore.inc}
{$UNDEF INTERFACE}

{$ifdef freertos_fat}

  {$LINKLIB libfreertos_wio.a}
  {$LINKLIB libstdc++_nano.a,static}
  {$LINKLIB libm.a,static}
  {$LINKLIB libc_nano.a,static}
  {$LINKLIB libgcc.a,static}
  {$LINKLIB libnosys.a,static}

  procedure BasicSystemInit; cdecl; external name 'SAMD51SystemInit';

  procedure BasicTickHandler; cdecl; external name 'SysTick_DefaultHandler';
  function  FreeRTOSSysTickHook:integer; cdecl; external name 'sysTickHook';

  function  roundf(x:single):Cardinal; cdecl; external name 'lroundf';
  function  round(x:double):Cardinal; cdecl; external name 'lround';

  function  cosf(x:single):single; cdecl; external name 'cosf';
  function  sinf(x:single):single; cdecl; external name 'sinf';
  function  cos(x:double):double; cdecl; external name 'cos';
  function  sin(x:double):double; cdecl; external name 'sin';

  function  acosf(x:single):single; cdecl; external name 'acosf';
  function  acos(x:double):double; cdecl; external name 'acos';
  function  asinf(x:single):single; cdecl; external name 'asinf';
  function  asin(x:double):double; cdecl; external name 'asin';

{$endif freertos_fat}

{$if defined(SAMD51)}
const
  OSC48MFrequency= 48000000;
  MaxCPUFrequency=120000000;
  GENERIC_CLOCK_GENERATOR_48M=1;
  GENERIC_CLOCK_GENERATOR_100M=2;
  GENERIC_CLOCK_GENERATOR_XOSC32K=3;
  GENERIC_CLOCK_GENERATOR_12M=4;

{$else}
  {$error Unknown Chip series, please define maximum CPU Frequency}
{$endif}

type
  TClockType = (DFLL48M,DFLL48M_XOSC32,FDPLL200M,XOSC);

type
  TSAMD51SystemCore = record helper for TSystemCore
  private
    procedure ConfigureSystem;
    function GetSysTickClockFrequency : longWord;
  public
    procedure Initialize;
    //function GetSYSCLKFrequency: longWord;
    procedure SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.DFLL48M);
    function GetCPUFrequency: longWord;
    function GetMaxCPUFrequency : longWord;
  end;

var
  SystemCore : TSystemCore;
  //This var is needed to communicate CPU Speed to FreeRTOS
  {$ifdef freertos_fat}
  SystemCoreClock : uint32; cvar; external;
  {$else}
  SystemCoreClock : uint32; cvar;
  {$endif freertos_fat}

implementation

uses
  FreeRTOS,
  MBF.BitHelpers;

{$DEFINE IMPLEMENTATION}
{$INCLUDE MBF.ARM.SystemCore.inc}
{$UNDEF IMPLEMENTATION}

{$REGION 'TSystemCore'}

{$ifdef freertos_fat}
procedure delay(ms:dword); [public, alias: 'delay'];
begin
  if (xTaskGetSchedulerState() <> taskSCHEDULER_NOT_STARTED) then
      vTaskDelay(ms);
end;
{$endif freertos_fat}

function TSAMD51SystemCore.GetSysTickClockFrequency : longWord; [public, alias: 'MBF_GetSysTickClockFrequency'];
begin
  Result := GetCPUFrequency;
  if GetBit(SysTick.CTRL,2) = 0 then
    Result := Result div 8;
end;

procedure TSAMD51SystemCore.Initialize;
begin
  ConfigureSystem;
  ConfigureTimer;
end;

procedure TSAMD51SystemCore.ConfigureSystem;
begin
    // Preset clocks similar to Arduino

end;

procedure TSAMD51SystemCore.SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.DFLL48M);
begin
  //SetCPUFrequency(getFrequencyParameters(Value,aClockType),aClockType);
end;

//function TSAMD51SystemCore.GetSysClockFrequency : longWord;
//begin
//  Result := OSC48MFrequency;
//end;

function TSAMD51SystemCore.GetCPUFrequency : longWord;
begin
  Result := OSC48MFrequency;
end;

function TSAMD51SystemCore.GetMaxCPUFrequency : longWord;
begin
  Result := MaxCPUFrequency;
end;

{$ENDREGION}

begin
  SystemCoreClock := OSC48MFrequency;
end.
