unit MBF.SAMD21.SystemCore;
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

{$if defined(SAMD21)}
const
  OSC8MFrequency=8000000;
  MaxCPUFrequency=48000000;
{$else}
  {$error Unknown Chip series, please define maximum CPU Frequency}
{$endif}

type
  TClockType = (OSC8M);

type
  TOSCParameters = record
    FREQUENCY : longWord;
  end;

type
  TSAMD21SystemCore = record helper for TSystemCore
  private
    procedure ConfigureSystem;
    function GetSysTickClockFrequency : longWord;
  public
    procedure Initialize;
    //function GetSYSCLKFrequency: longWord;
    procedure SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.OSC8M);
    procedure SetCPUFrequency(const Params: TOscParameters; aClockType : TClockType = TClockType.OSC8M);
    function GetCPUFrequency: longWord;
    function getMaxCPUFrequency : longWord;
  end;

var
  SystemCore : TSystemCore;
  //This var is needed to communicate CPU Speed to FreeRTOS
  SystemCoreClock : uint32; cvar;

implementation

uses
  FreeRTOS,
  MBF.BitHelpers;

{$DEFINE IMPLEMENTATION}
{$INCLUDE MBF.ARM.SystemCore.inc}
{$UNDEF IMPLEMENTATION}

{$REGION 'TSystemCore'}

function TSAMD21SystemCore.GetSysTickClockFrequency : longWord; [public, alias: 'MBF_GetSysTickClockFrequency'];
begin
  Result := GetCPUFrequency;
  if GetBit(SysTick.CTRL,2) = 0 then
    Result := Result div 8;
end;

procedure TSAMD21SystemCore.Initialize;
begin
  ConfigureSystem;
  ConfigureTimer;
end;

procedure TSAMD21SystemCore.ConfigureSystem;
begin
end;

procedure TSAMD21SystemCore.SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.OSC8M);
begin
  //SetCPUFrequency(getFrequencyParameters(Value,aClockType),aClockType);
end;

procedure TSAMD21SystemCore.SetCPUFrequency(const Params: TOscParameters; aClockType : TClockType = TClockType.OSC8M);
begin
end;

//function TSAMD21SystemCore.GetSysClockFrequency : longWord;
//begin
//  Result := OSC8MFrequency;
//end;

function TSAMD21SystemCore.GetCPUFrequency : longWord;
begin
  Result := OSC8MFrequency div 8;
end;

function TSAMD21SystemCore.GetMaxCPUFrequency : longWord;
begin
  Result := MaxCPUFrequency;
end;

{$ENDREGION}

begin
  SystemCoreClock := OSC8MFrequency div 8;
end.
