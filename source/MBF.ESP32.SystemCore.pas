unit MBF.ESP32.SystemCore;
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
{$INCLUDE MBF.ESP32.SystemCore.inc}
{$UNDEF INTERFACE}

{$if defined(ESP32)}
const
  MaxCPUFrequency=240000000;
{$else}
  {$error Unknown Chip series, please define maximum CPU Frequency}
{$endif}

const
  HSIClockFrequency = 16000000;
  LSIClockFreq = 32768;

var
  HSEClockFrequency : longWord = 0;
  XTALRTCFreq : longword = 32768;

type
  TClockType = (HSI,HSE,PLLHSI,PLLHSE);

type
  TESP32SystemCore = record helper for TSystemCore
  private
    procedure ConfigureSystem;
    //function GetFrequencyParameters(aHCLKFrequency : longWord;aClockType : TClockType):TOSCParameters;
    //function GetSysTickClockFrequency : longWord;
    //function GetHCLKFrequency : longWord;
  public
    procedure Initialize;
    //function GetSYSCLKFrequency: longWord;
    procedure SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.PLLHSI);
    function GetCPUFrequency: longWord;
    function getMaxCPUFrequency : longWord;
  end;

var
  SystemCore : TSystemCore;
  //This var is needed to communicate CPU Speed to FreeRTOS
  SystemCoreClock : uint32; cvar;

implementation

uses
  FreeRTOS;

{$DEFINE IMPLEMENTATION}
{$INCLUDE MBF.ESP32.SystemCore.inc}
{$UNDEF IMPLEMENTATION}

{$REGION 'TSystemCore'}

procedure TESP32SystemCore.Initialize;
begin
  ConfigureSystem;
  ConfigureTimer;
end;

procedure TESP32SystemCore.ConfigureSystem;
begin
end;

procedure TESP32SystemCore.SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.PLLHSI);
begin
  //SystemCoreClock := getHCLKFrequency;
  ConfigureTimer;
end;

function TESP32SystemCore.GetCPUFrequency : longWord;
begin
  Result := SystemCoreClock;
end;

function TESP32SystemCore.GetMaxCPUFrequency : longWord;
begin
  Result := MaxCPUFrequency;
end;

{$ENDREGION}

begin
  //SystemCoreClock := HSIClockFrequency;
end.
