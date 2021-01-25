unit MBF.SAMD21.SERCOM;
{
  This file is part of Pascal Microcontroller Board Framework (MBF)
  Copyright (c) 2015 -  Michael Ring
  Copyright (c) 2018 -  Alfred Glänzer

  based on Pascal eXtended Library (PXL)
  Copyright (c) 2000 - 2015  Yuriy Kotsarenko

  This program is free software: you can redistribute it and/or modify it under the terms of the FPC modified GNU
  Library General Public License for more

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the FPC modified GNU Library General Public
  License for more details.
}
{< Atmel SAMD series GPIO functions. }

interface

{$include MBF.Config.inc}

uses
  MBF.SAMD21.SystemCore,
  MBF.SAMD21.GPIO,
  FreeRTOS;


  
type
  TSERCOMHandlerProc = procedure(var SERCOM : TSERCOM_Registers;const SERCOMNum : byte;var xHigherPriorityTaskWoken : uint32);

  TSERCOMClockSource = (
    APB1orAPB2 = %0
  );

  TSERCOMRegistersHelper = record helper for TSERCOM_Registers
  public
    function  Disable : boolean;
    procedure Enable;
    function  GetInstance : byte; inline;
    function  getRxStreamBufferHandle : TStreamBufferHandle; inline;
    function  getTXStreamBufferHandle : TStreamBufferHandle; inline;
    procedure SetCoreClockSource(aClockSource : TSERCOMClockSource);
    function  GetCoreClockSource : TSERCOMClockSource;
  end;

implementation
uses
  {$if defined(USE_SYSVIEW)}Segger.SysView,{$endif}
  MBF.BitHelpers;

{$if defined(HAS_SERCOM5)}
const
  MINSERCOM=0;
  MAXSERCOM=5;
{$else}
const
  MINSERCOM=0;
  MAXSERCOM=3;
{$endif}

var
  SercomTxStreamBufferHandles : array[MINSERCOM..MAXSERCOM] of TStreamBufferHandle;
  SercomRxStreamBufferHandles : array[MINSERCOM..MAXSERCOM] of TStreamBufferHandle;
  SercomIRQHandlers : array[MINSERCOM..MAXSERCOM] of TSERCOMHandlerProc;

procedure SERCOMGenericHandler(var SERCOM : TSERCOM_Registers;const SERCOMNum : byte; var xHigherPriorityTaskWoken : uint32);
begin
  {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_WarnfHost('DefaultSercom called %02x',[SERCOMNum]);{$endif}
end;

{$if defined(HAS_SERCOM0)}
  procedure SERCOM0_Handler; interrupt; public name 'SERCOM0_Handler';
  var
    xHigherPriorityTaskWoken : uint32;
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordEnterISR;{$endif}
    xHigherPriorityTaskWoken := pdFalse;
    SERCOMIRQHandlers[0](SERCOM0,0,xHigherPriorityTaskWoken);
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordExitISR;{$endif}
    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
  end;
{$endif}

{$if defined(HAS_SERCOM1)}
  procedure SERCOM1_Handler; interrupt; public name 'SERCOM1_Handler';
  var
    xHigherPriorityTaskWoken : uint32;
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordEnterISR;{$endif}
    xHigherPriorityTaskWoken := pdFalse;
    SERCOMIRQHandlers[1](SERCOM1,1,xHigherPriorityTaskWoken);
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordExitISR;{$endif}
    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
  end;
{$endif}

{$if defined(HAS_SERCOM2)}
  procedure SERCOM2_Handler; interrupt; public name 'SERCOM2_Handler';
  var
    xHigherPriorityTaskWoken : uint32;
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordEnterISR;{$endif}
    xHigherPriorityTaskWoken := pdFalse;
    SERCOMIRQHandlers[2](SERCOM2,2,xHigherPriorityTaskWoken);
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordExitISR;{$endif}
    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
  end;
{$endif}

{$if defined(HAS_SERCOM3)}
  procedure SERCOM3_Handler; interrupt; public name 'SERCOM3_Handler';
  var
    xHigherPriorityTaskWoken : uint32;
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordEnterISR;{$endif}
    xHigherPriorityTaskWoken := pdFalse;
    SERCOMIRQHandlers[3](SERCOM3,3,xHigherPriorityTaskWoken);
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordExitISR;{$endif}
    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
  end;
{$endif}

{$if defined(HAS_SERCOM4)}
  procedure SERCOM4_Handler; interrupt; public name 'SERCOM4_Handler';
  var
    xHigherPriorityTaskWoken : uint32;
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordEnterISR;{$endif}
    xHigherPriorityTaskWoken := pdFalse;
    SERCOMIRQHandlers[4](SERCOM4,4,xHigherPriorityTaskWoken);
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordExitISR;{$endif}
    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
  end;
{$endif}

{$if defined(HAS_SERCOM5)}
  procedure SERCOM5_IRQHandler; interrupt; public name 'SERCOM5_Handler';
  var
    xHigherPriorityTaskWoken : uint32;
  begin
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordEnterISR;{$endif}
    xHigherPriorityTaskWoken := pdFalse;
    SERCOMIRQHandlers[5](SERCOM5,5,xHigherPriorityTaskWoken);
    {$if defined(USE_SYSVIEW)}SEGGER_SYSVIEW_RecordExitISR;{$endif}
    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
  end;
{$endif}

function TSercomRegistersHelper.Disable : boolean;
begin
  Result :=  TSercom_Registers(Self).Disable;
end;

procedure TSercomRegistersHelper.Enable;
begin
  TSercom_Registers(Self).Enable;
end;

function TSercomRegistersHelper.GetInstance : byte; inline;
begin
  Result := (longWord(@self)-SERCOM0_BASE) shr 10);
end;

function TSercomRegistersHelper.getRxStreamBufferHandle : TStreamBufferHandle; inline;
begin
  Result := SercomRxStreamBufferHandles[self.GetInstance];
end;

procedure TSercomRegistersHelper.setRxStreamBufferHandle(aHandle : TStreamBufferHandle); inline;
begin
  SercomRxStreamBufferHandles[self.GetInstance] := aHandle;
end;

function TSercomRegistersHelper.getTXStreamBufferHandle : TStreamBufferHandle; inline;
begin
  Result := SercomTxStreamBufferHandles[self.GetInstance];
end;

procedure TSercomRegistersHelper.setTxStreamBufferHandle(aHandle : TStreamBufferHandle); inline;
begin
  SercomTxStreamBufferHandles[self.GetInstance] := aHandle;
end;

procedure TSercomRegistersHelper.SetCoreClockSource(aClockSource : TSERCOMClockSource);
begin
  setBit(PM.APBC,self.GetInstance+2);
end;

function TSercomRegistersHelper.GetCoreClockSource : TSERCOMClockSource;
begin
end;

{$ENDREGION}
var
  i : integer;
begin
  for i := MINSERCOM to MAXSERCOM do
  begin
    SercomRXStreamBufferHandles[i] := nil;
    SercomTXStreambufferHandles[i] := nil;
    SercomIRQHandlers[i] := @SercomGenericHandler;
  end;
end.