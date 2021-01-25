unit MBF.SAMD21.UART;
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
  TUART_Registers = TSERCOMUSART_INT_Registers;

{$REGION PinDefinitions}
//UART includes are complex and automagically created, so include them to keep Sourcecode clean
{$include MBF.SAMD21.UART.inc}
{$ENDREGION}

const
  DefaultUARTBaudrate=115200;
  DefaultUARTTimeout = 10000;

type
  TUARTHandlerProc = procedure(var UART : TUART_Registers;const UARTNum : byte;var xHigherPriorityTaskWoken : uint32);

  TUARTBitsPerWord = (
    Eight = %000,
    Nine  = %001,
    Five  = %101,
    Six   = %110,
    Seven = %111
  );

  TUARTParity = (
    None = %00000,
    Even = %00010,
    Odd  = %00011
  );

  TUARTStopBits = (
    One = %0,
    Two = %1
  );

  TUARTRegistersHelper = record helper for TUART_Registers
  private
    function  GetBaudRate: Cardinal;
    procedure SetBaudRate(const aBaudrate: Cardinal);
    function  GetBitsPerWord: TUARTBitsPerWord;
    procedure SetBitsPerWord(const aBitsPerWord: TUARTBitsPerWord);
    function  GetParity: TUARTParity;
    procedure SetParity(const aParity: TUARTParity);
    function  GetStopBits: TUARTStopBits;
    procedure SetStopBits(const aStopbit: TUARTStopBits);
    function  GetClockSource : TUARTClockSource;
    procedure SetClockSource(const aClockSource : TUARTClockSource);
  public
    procedure initialize(const ARxPin : TUARTRXPins;
                       const ATxPin : TUARTTXPins;aBaudRate : longWord = 115200);
    function Disable : boolean;
    procedure Enable;

    property BaudRate : Cardinal read getBaudRate write setBaudRate;
    property BitsPerWord : TUARTBitsPerWord read getBitsPerWord write setBitsPerWord;
    property Parity : TUARTParity read getParity write setParity;
    property StopBits : TUARTStopBits read getStopBits write setStopBits;
    property ClockSource : TUARTClockSource read getClockSource write setClockSource;
    procedure WaitForTXReady; inline;
    procedure WaitForRXReady; inline;

    function  WaitForTXReady(EndTime : TMilliSeconds):boolean; inline;
    function  WaitForRXReady(EndTime : TMilliSeconds):boolean; inline;

    procedure WriteDR(const Value : byte); inline;
    function ReadDR:byte; inline;
    {$DEFINE INTERFACE}
    { $I MBF.SAMD.UART.inc}
    {$UNDEF INTERFACE}
  end;

  var
  {$if defined(has_usart0)}USART0 : TSERCOMUSART_INT_Registers absolute SERCOM0_BASE;{$endif}
  {$if defined(has_usart1)}USART1 : TSERCOMUSART_INT_Registers absolute SERCOM1_BASE;{$endif}
  {$if defined(has_usart2)}USART2 : TSERCOMUSART_INT_Registers absolute SERCOM2_BASE;{$endif}
  {$if defined(has_usart3)}USART3 : TSERCOMUSART_INT_Registers absolute SERCOM3_BASE;{$endif}
  {$if defined(has_usart4)}USART4 : TSERCOMUSART_INT_Registers absolute SERCOM4_BASE;{$endif}
  {$if defined(has_usart5)}USART5 : TSERCOMUSART_INT_Registers absolute SERCOM5_BASE;{$endif}

  var
    i : integer;

{$IF DEFINED(HAS_ARDUINOPINS)}
  {$IF DEFINED(ARDUINOZERO)}
    var
      UART : TSERCOMUSART_INT_Registers absolute SERCOM0_BASE;
      DEBUG_UART : TSERCOMUSART_INT_Registers absolute SERCOM5_BASE;
  {$ELSEIF DEFINED(metro_m0)}
    var
      UART : TSERCOMUSART_INT_Registers absolute SERCOM0_BASE;
  {$ELSE}
    {$ERROR This Device has Arduinopins defined but is not yet known to MBF.SAMD21.UART}
  {$ENDIF}
{$ENDIF HAS ARDUINOPINS}

implementation
uses
  {$if defined(USE_SYSVIEW)}Segger.SysView,{$endif}
  MBF.SAMD21.SERCOM,
  MBF.BitHelpers;

procedure UARTGenericHandler(var UART : TUART_Registers;const UARTNum : byte; var xHigherPriorityTaskWoken : uint32);
begin
end;

procedure TUARTRegistersHelper.Initialize(const ARxPin : TUARTRXPins;
                       const ATxPin : TUARTTXPins; aBaudRate : longWord = 115200);
var
  aRXPO,aTXPO : longWord;
begin
  TSercom_Registers(Self).Initialize;
  TSercom_Registers(Self).SetCoreClockSource(GCLK_CLKCTRL_GEN_GCLK0); // use gclk0 at 1Mhz or 48MHz

  //Using 8N1 for setting the CTRLA/CTRLB registers

  //Setting the CTRLA register
  CTRLA:=
    SERCOM_USART_CTRLA_DORD OR // DWORD
    SERCOM_MODE_USART_INT_CLK;

  //Setting the CTRLB register
  CTRLB:=0;
  SetBit(CTRLB,SERCOM_USART_CTRLB_RXEN_Pos); //RX_EN
  SetBit(CTRLB,SERCOM_USART_CTRLB_TXEN_Pos); //TX_EN
  SetBaudRate(DefaultUARTBaudrate);
  SetRxPin(ARxPin);
  SetTxPin(ATxPin);
  Enable;
end;

procedure TUARTRegistersHelper.SetRxPin(const Value : TUARTRXPins);
var
  aRXPO : longWord;
  ReEnable : boolean;
begin
  ReEnable := Disable;
  aRXPO := (longword(Value) shr 16) and %11;
  GPIO.PinMux[longWord(Value) and $ff] := TPinMux((longWord(Value) shr 8) and %111);
  CTRLA:= CTRLA OR (SERCOM_USART_CTRLA_RXPO_Msk AND ((aRXPO) shl SERCOM_USART_CTRLA_RXPO_Pos));
  if ReEnable then
    Enable;
end;

procedure TUARTRegistersHelper.SetTxPin(const Value : TUARTTXPins);
var
  aTXPO : longWord;
var
  ReEnable : boolean;
begin
  ReEnable := Disable;
  //TX has only 2 possible Pads (PAD0 and PAD2) and the following Pad (PAD1 and PAD3) is reserved for Clock
  //When PAD0 is used only PAD2 and PAD3 can be used for RX
  //When PAD2 is used only PAD0 and PAD1 can be used for RX
  aTXPO := (longWord(Value) shr 17) and %1;

  GPIO.PinMux[longWord(Value) and $ff] := TPinMux((longWord(Value) shr 8) and %111);

  CTRLA:= CTRLA or (SERCOM_USART_CTRLA_TXPO_Msk AND ((aTXPO) shl SERCOM_USART_CTRLA_TXPO_Pos));
  if ReEnable then
    Enable;
end;

function TUARTRegistersHelper.Disable : boolean;
begin
  Result :=  TSercom_Registers(Self).Disable;
end;

procedure TUARTRegistersHelper.Enable;
begin
  TSercom_Registers(Self).Enable;
end;

function TUARTRegistersHelper.GetBaudRate: Cardinal;
begin
  Result := (uint64(SystemCore.CPUFrequency)*(65536-BAUD)) shr 4 shr 16 //Divide by 16, Divide by 65536
end;

procedure TUARTRegistersHelper.SetBaudRate(const Value: Cardinal);
const
  SHIFT=32;
var
  ratio,scale,temp1:uint64;
  ReEnable : boolean;
begin
  ReEnable := Disable;
  temp1 := ((uint64(USART_SAMPLE_NUM) * uint64(Value)) shl SHIFT);
  ratio := temp1 DIV SystemCore.CPUFrequency;
  scale := (uint64(1) shl SHIFT) - ratio;
  BAUD := ((65536 * scale) shr SHIFT);
  if ReEnable then
    Enable;
end;

function TUARTRegistersHelper.GetBitsPerWord: TUARTBitsPerWord;
begin
  Result := TUARTBitsPerWord(CTRLB and %111);
end;

procedure TUARTRegistersHelper.SetBitsPerWord(const Value: TUARTBitsPerWord);
var
  ReEnable : boolean;
begin
  ReEnable := Disable;
  CTRLB := (CTRLB and (not %111)) or longWord(Value);
  if ReEnable then
    Enable;
end;

function TUARTRegistersHelper.GetParity: TUARTParity;
begin
  if not odd(CTRLA shr 24) then
    Result := TUARTParity.None
  else
    if not odd(CTRLB shr 13) then
      Result := TUARTParity.Even
    else
      Result := TUARTParity.Odd;
end;

procedure TUARTRegistersHelper.SetParity(const Value: TUARTParity);
var
  ReEnable : boolean;
begin
  ReEnable := Disable;
  CTRLA := (CTRLA and ((not %1111) shl 24)) or ((longWord(Value) shr 1) shl 24);
  CTRLB := CTRLB and (not (%1 shl 13)) or ((longWord(Value) and %1) shl 13);
  if ReEnable then
    Enable;
end;

function TUARTRegistersHelper.GetStopBits: TUARTStopBits;
begin
  Result := TUARTStopBits((CTRLB shr 6) and %1);
end;

procedure TUARTRegistersHelper.SetStopBits(const Value: TUARTStopBits);
var
  ReEnable : boolean;
begin
  ReEnable := Disable;
  CTRLB := CTRLB and (not (%1 shl 6)) or (longWord(Value) shl 6);
  if ReEnable then
    Enable;
end;

procedure TUARTRegistersHelper.WaitForTXReady; inline;
begin
  WaitBitIsSet(self.SR,7);
end;

procedure TUARTRegistersHelper.WaitForRXReady; inline;
begin
  WaitBitIsSet(self.SR,5);
end;

function TUARTRegistersHelper.WaitForTXReady(EndTime : TMilliSeconds):boolean; inline;
begin
  Result := WaitBitIsSet(self.SR,7,EndTime);
end;

function TUARTRegistersHelper.WaitForRXReady(EndTime : TMilliSeconds):boolean; inline;
begin
  Result := WaitBitIsSet(self.SR,5,EndTime);
end;

procedure TUARTRegistersHelper.WriteDR(const Value : byte); inline;
begin
  self.DR := Value;
end;

function TUARTRegistersHelper.ReadDR : byte ; inline;
begin
  Result := self.DR;
end;

{$DEFINE IMPLEMENTATION}
{ $I MBF.SAMD.UART.inc}
{$UNDEF IMPLEMENTATION}

{$ENDREGION}
begin
end.