unit MBF.SAMD21.GPIO;
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
  MBF.BitHelpers;

const
  GPIO_PIN_FUNCTION_OFF          = $ffffffff;
  MuxA=$1000;
  MuxB=$1100;
  MuxC=$1200;
  MuxD=$1300;
  MuxE=$1400;
  MuxF=$1400;
  MuxG=$1600;
  MuxH=$1700;

  Pad0=$100000;
  Pad1=$110000;
  Pad2=$120000;
  Pad3=$130000;

type
  TPinLevel=(Low=0,High=1);
  TPinValue=0..1;
  TPinIdentifier=-1..63;
  TPinMode = (Input=%00, Output=%01, Analog=%11, AF0=$10, AF1, AF2, AF3, AF4, AF5, AF6, AF7, AF8, AF9, AF10, AF11, AF12, AF13);
  TPinDrive = (None=%00,PullUp=%01,PullDown=%10);
  TPinOutputMode = (PushPull=0,OpenDrain=1);
  TPinOutputStrength = (Normal=%0, High=%1);
{$REGION PinDefinitions}

type
  TNativePin = record
  const
    None=-1;
    {$if defined (has_gpioa)} PA0 = 0;  PA1 = 1;  PA2 = 2;  PA3 = 3;  PA4 = 4;  PA5 = 5;  PA6 = 6;  PA7 = 7;
                              PA8 = 8;  PA9 = 9;  PA10=10;  PA11=11;  PA12=12;  PA13=13;  PA14=14;  PA15=15;
                              PA16=16;  PA17=17;  PA18=18;  PA19=19;  PA20=20;  PA21=21;  PA22=22;  PA23=23;
                              PA24=24;  PA25=25;  PA26=26;  PA27=27;  PA28=28;  PA29=29;  PA30=30;  PA31=31; {$endif}

    {$if defined (has_gpiob)} PB0 =32;  PB1 =33;  PB2 =34;  PB3 =35;  PB4 =36;  PB5 =37;  PB6 =38;  PB7 =39;
                              PB8 =40;  PB9 =41;  PB10=42;  PB11=43;  PB12=44;  PB13=45;  PB14=46;  PB15=47;
                              PB16=48;  PB17=49;  PB18=50;  PB19=51;  PB20=52;  PB21=53;  PB22=54;  PB23=55;
                              PB24=56;  PB25=57;  PB26=58;  PB27=59;  PB28=60;  PB29=61;  PB30=62;  PB31=63; {$endif}

  end;

  {$if defined(has_arduinopins)}
    {$if defined(metro_m0) }
      type
        TArduinoPin = record
      const
        None=-1;
        D0 = TNativePin.PA11;  D1 = TNativePin.PA10;  D2 = TNativePin.PA14;  D3 = TNativePin.PA9;
        D4 = TNativePin.PA8;   D5 = TNativePin.PA15;  D6 = TNativePin.PA20;  D7 = TNativePin.PA21;

        D8 = TNativePin.PA6;   D9 = TNativePin.PA7;   D10= TNativePin.PA18;  D11= TNativePin.PA16;
        D12= TNativePin.PA19;  D13= TNativePin.PA17;  D14= TNativePin.PA22;  D15= TNativePin.PA23;

        A0 = TNativePin.PA2;   A1 = TNativePin.PB8;   A2 = TNativePin.PB9;   A3 = TNativePin.PA4;
        A4 = TNativePin.PA5;   A5 = TNativePin.PB2;
      end;
    {$endif}
  {$endif}

{$endregion}

type
  TGPIO = record
    function  GetPinMode(const Pin: TPinIdentifier): TPinMode;
    procedure SetPinMode(const Pin: TPinIdentifier; const Value: TPinMode);
    function  GetPinDrive(const Pin: TPinIdentifier): TPinDrive;
    procedure SetPinDrive(const Pin: TPinIdentifier; const Value: TPinDrive);
    function  GetPinOutputMode(const Pin: TPinIdentifier): TPinOutputMode;
    procedure SetPinOutputMode(const Pin: TPinIdentifier; const Value: TPinOutputMode);
    function  GetPinOutputStrength(const Pin: TPinIdentifier): TPinOutputStrength;
    procedure SetPinOutputStrength(const Pin: TPinIdentifier; const Value: TPinOutputStrength);
  public
    procedure Initialize;
    function  GetPinValue(const Pin: TPinIdentifier): TPinValue;
    procedure SetPinValue(const Pin: TPinIdentifier; const Value: TPinValue);
    function  GetPinLevel(const Pin: TPinIdentifier): TPinLevel;
    procedure SetPinLevel(const Pin: TPinIdentifier; const Level: TPinLevel);

    procedure SetPinLevelHigh(const Pin: TPinIdentifier);
    procedure SetPinLevelLow(const Pin: TPinIdentifier);
    procedure TogglePinValue(const Pin: TPinIdentifier);
    procedure TogglePinLevel(const Pin: TPinIdentifier);

    property PinMode[const Pin : TPinIdentifier]: TPinMode read getPinMode write setPinMode;
    property PinDrive[const Pin : TPinIdentifier] : TPinDrive read getPinDrive write setPinDrive;
    property PinOutputMode[const Pin : TPinIdentifier] : TPinOutputMode read getPinOutputMode write setPinOutputMode;
    property PinOutputStrength[const Pin : TPinIdentifier] : TPinOutputStrength read getPinOutputStrength write setPinOutputStrength;
    property PinValue[const Pin : TPinIdentifier] : TPinValue read getPinValue write setPinValue;
    property PinLevel[const Pin : TPinIdentifier] : TPinLevel read getPinLevel write setPinLevel;
  end;

  (*TGPIOPort = record helper for TGPIO_Registers
  public
    procedure Initialize;
    function GetPortValues : word;
    function GetPortBits : TBitSet;
    procedure SetPortValues(const Values : Word);
    procedure SetPortBits(const Bits : TBitSet);
    procedure ClearPortBits(const Bits : TBitSet);
    procedure SetPortMode(PortMode : TPinMode);
    procedure SetPortOutputSpeed(Speed : TPinOutputSpeed);
    procedure SetPortDrive(Drive : TPinDrive);
    procedure SetPortOutputMode(OutputMode : TPinOutputMode);
  end; *)


var
  GPIO : TGPIO;

implementation
procedure TGPIO.Initialize;
begin
end;

function TGPIO.GetPinMode(const Pin: TPinIdentifier): TPinMode;
begin
  if getBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],0) = 0 then
  begin
    if getBit(Port.Group[Pin shr 5].DIR,Pin and $1f) = 0 then
      Result := TPinMode.Input
    else
     Result := TPinMode.Output;
  end
  else
  begin
    if Pin and %1 = 0 then
      Result := TPinMode(getNibble(Port.Group[Pin shr 5].PMUX[(Pin and $1f) shr 1],0) or $10)
    else
      Result := TPinMode(getNibble(Port.Group[Pin shr 5].PMUX[(Pin and $1f) shr 1],4) or $10);
  end;
end;

procedure TGPIO.SetPinMode(const Pin: TPinIdentifier; const Value: TPinMode);
begin
  case Value of
    TPinMode.Input     : begin
                           clearBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],0);
                           Port.Group[Pin shr 5].DIRCLR := 1 shl (Pin and $1f);
    end;
    TPinMode.Output    : begin
                           clearBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],0);
                           Port.Group[Pin shr 5].DIRSET := 1 shl (Pin and $1f);
    end;

    TPinMode.Analog    : begin
                           Port.Group[Pin shr 5].DIRCLR := 1 shl (Pin and $1f);
                           if Pin and %1 = 0 then
                             SetNibble(Port.Group[Pin shr 5].PMUX[(Pin and $1f) shr 1],%0001,0)
                           else 
                             SetNibble(Port.Group[Pin shr 5].PMUX[(Pin and $1f) shr 1],%0001,4);
                           SetBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],0);
    end
    else
                         begin
                           if Pin and %1 = 0 then
                             SetNibble(Port.Group[Pin shr 5].PMUX[(Pin and $1f) shr 1],Value and %1111,0)
                           else 
                             SetNibble(Port.Group[Pin shr 5].PMUX[(Pin and $1f) shr 1],Value and %1111,4);
                           SetBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],0);
    end;
  end;
end;

function TGPIO.GetPinValue(const Pin: TPinIdentifier): TPinValue;
begin
  Result := GetBitValue(Port.Group[Pin shr 5].&IN,Pin and $1f);
end;

procedure TGPIO.SetPinValue(const Pin: TPinIdentifier; const Value: TPinValue);
begin
  if Value = 1 then
    Port.Group[Pin shr 5].OUTSET := 1 shl (Pin and $1f)
  else
    Port.Group[Pin shr 5].OUTCLR := 1 shl (Pin and $1f);
end;

function TGPIO.GetPinLevel(const Pin: TPinIdentifier): TPinLevel;
begin
  if GetBitValue(Port.Group[Pin shr 5].&IN,Pin and $1f) <> 0 then
    Result := TPinLevel.High
  else
    Result := TPinLevel.Low;
end;

procedure TGPIO.SetPinLevel(const Pin: TPinIdentifier; const Level: TPinLevel);
begin
  if Level = TPinLevel.High then
    Port.Group[Pin shr 5].OUTSET := 1 shl (Pin and $1f)
  else
    Port.Group[Pin shr 5].OUTCLR := 1 shl (Pin and $1f);
end;

procedure TGPIO.SetPinLevelHigh(const Pin: TPinIdentifier);
begin
  Port.Group[Pin shr 5].OUTSET := 1 shl (Pin and $1f);
end;

procedure TGPIO.SetPinLevelLow(const Pin: TPinIdentifier);
begin
  Port.Group[Pin shr 5].OUTCLR := 1 shl (Pin and $1f);
end;

procedure TGPIO.TogglePinValue(const Pin: TPinIdentifier);
begin
  SetBit(Port.Group[Pin shr 5].OUTTGL,Pin and $1f)
end;

procedure TGPIO.TogglePinLevel(const Pin: TPinIdentifier);
begin
  SetBit(Port.Group[Pin shr 5].OUTTGL,Pin and $1f)
end;

function TGPIO.GetPinDrive(const Pin: TPinIdentifier): TPinDrive;
begin
  if GetBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],2) = 1 then
    Result := TPinDrive.PullUp
  else
    Result := TPinDrive.None;
end;

procedure TGPIO.SetPinDrive(const Pin: TPinIdentifier; const Value: TPinDrive);
begin
  case Value of
    TPinDrive.None :     ClearBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],2);
    TPinDrive.PullUp :   SetBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],2);
  end;
end;

function TGPIO.GetPinOutputMode(const Pin: TPinIdentifier): TPinOutputMode;
begin
end;

procedure TGPIO.SetPinOutputMode(const Pin: TPinIdentifier; const Value: TPinOutputMode);
begin
end;

function TGPIO.GetPinOutputStrength(const Pin: TPinIdentifier): TPinOutputStrength;
begin
end;

procedure TGPIO.SetPinOutputStrength(const Pin: TPinIdentifier; const Value: TPinOutputStrength);
begin
end;
(*
procedure TGPIOPort.Initialize;
begin
end;

function TGPIOPort.GetPortValues : longWord; inline;
begin
  Result := Self.&IN;
end;

function TGPIOPort.GetPortBits : TBitSet; inline;
begin
  Result := TBitSet(Self.&IN);
end;

procedure TGPIOPort.SetPortValues(const Values : longWord); inline;
begin
  Self.&OUT := Values;
end;

procedure TGPIOPort.SetPortBits(const Bits : TBitSet); inline;
begin
  Self.&OUT := longWord(Bits);
end;

procedure TGPIOPort.ClearPortBits(const Bits : TBitSet); inline;
begin
  Self.OUTCLR := longWord(Bits);
end;

procedure TGPIOPort.SetPortMode(PortMode : TPinMode); inline;
begin
end;

procedure TGPIOPort.SetPortOutputSpeed(Speed : TPinOutputSpeed); inline;
begin
end;

procedure TGPIOPort.SetPortDrive(Drive : TPinDrive); inline;
begin
end;

procedure TGPIOPort.SetPortOutputMode(OutputMode : TPinOutputMode); inline;
begin
end;
*)
end.
