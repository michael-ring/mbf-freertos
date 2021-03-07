unit MBF.SAMD51.GPIO;
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
  MuxI=$1800;
  MuxJ=$1900;
  MuxK=$1A00;
  MuxL=$1B00;
  MuxM=$1C00;
  MuxN=$1D00;

  Pad0=$100000;
  Pad1=$110000;
  Pad2=$120000;
  Pad3=$130000;

  PINMODE_INPUT           = 0;
  PINMODE_OUTPUT          = 1;
  PINMODE_INPUT_PULLUP    = 2;
  PINMODE_INPUT_PULLDOWN  = 3;


type
  TPinLevel=(Low=0,High=1);
  TPinValue=0..1;
  TPinIdentifier=-1..160;

  TPinMode = (Input=%00, Output=%01);
  TPinDrive = (None=%00,PullUp=%01,PullDown=%10);
  TPinOutputMode = (PushPull=0,OpenDrain=1);
  TPinOutputStrength = (Normal=%0, High=%1);

  eAnalogReference = (
    AR_DEFAULT,
    AR_INTERNAL1V0,
    AR_INTERNAL1V1,
    AR_INTERNAL1V2,
    AR_INTERNAL1V25,
    AR_INTERNAL2V0,
    AR_INTERNAL2V2,
    AR_INTERNAL2V23,
    AR_INTERNAL2V4,
    AR_INTERNAL2V5,
    AR_INTERNAL1V65,
    AR_EXTERNAL
  );

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

    {$if defined (has_gpioc)} PC0 =64;  PC1 =65;  PC2 =66;  PC3 =67;  PC4 =68;  PC5 =69;  PC6 =70;  PC7 =71;
                              PC8 =72;  PC9 =73;  PC10=74;  PC11=75;  PC12=76;  PC13=77;  PC14=78;  PC15=79;
                              PC16=80;  PC17=81;  PC18=82;  PC19=83;  PC20=84;  PC21=85;  PC22=86;  PC23=87;
                              PC24=88;  PC25=89;  PC26=90;  PC27=91;  PC28=92;  PC29=93;  PC30=94;  PC31=95; {$endif}

    {$if defined (has_gpiod)} PD0 =96;  PD1 =97;  PD2 =98;  PD3 =99;  PD4 =100; PD5 =101; PD6 =102; PD7 =103;
                              PD8 =104; PD9 =105; PD10=106; PD11=107; PD12=108; PD13=109; PD14=110; PD15=111;
                              PD16=112; PD17=113; PD18=114; PD19=115; PD20=116; PD21=117; PD22=118; PD23=119;
                              PD24=120; PD25=121; PD26=122; PD27=123; PD28=124; PD29=125; PD30=126; PD31=127; {$endif}

    {$if defined (has_gpioe)} PE0 =128; PE1 =129; PE2 =130; PE3 =131; PE4 =132; PE5 =133; PE6 =134; PE7 =135;
                              PE8 =136; PE9 =137; PE10=138; PE11=139; PE12=140; PE13=141; PE14=142; PE15=143;
                              PE16=144; PE17=145; PE18=146; PE19=147; PE20=148; PE21=149; PE22=150; PE23=151;
                              PE24=152; PE25=153; PE26=154; PE27=155; PE28=156; PE29=157; PE30=158; PE31=159; {$endif}
  end;

  {$if defined(has_arduinopins)}
    {$if defined(fpc_mcu_metro_m4) }
      type
        TArduinoPin = record
      const
        None=-1;
        D0 = TNativePin.PA23;  D1 = TNativePin.PA22;  D2 = TNativePin.PB17;  D3 = TNativePin.PB16;
        D4 = TNativePin.PB13;  D5 = TNativePin.PB14;  D6 = TNativePin.PB15;  D7 = TNativePin.PB12;

        D8 = TNativePin.PA21;  D9 = TNativePin.PA20;  D10= TNativePin.PA18;  D11= TNativePin.PA19;
        D12= TNativePin.PA17;  D13= TNativePin.PA16;  D14= TNativePin.PB2;   D15= TNativePin.PB3;

        A0 = TNativePin.PA2;   A1 = TNativePin.PA5;   A2 = TNativePin.PA6;   A3 = TNativePin.PA4;
        A4 = TNativePin.PB8;   A5 = TNativePin.PB9;
      end;
    {$endif}
    {$ifdef fpc_mcu_wio_terminal}
      type
        TArduinoPin = record
      const
        None=-1;
        D13= TNativePin.PA15;
      end;
    {$endif}

  {$endif}

  {$ifdef fpc_mcu_wio_terminal}
  const
    // LEDs
    PIN_LED_13	                 = 13;
    PIN_LED		         = PIN_LED_13;
    PIN_LED2		         = PIN_LED_13;
    PIN_LED3		         = PIN_LED_13;
    LED_BUILTIN		         = PIN_LED_13;
    PIN_NEOPIXEL	         = PIN_LED_13;

    //Digital PINs
    D0                           = 0;
    D1                           = 1;
    D2                           = 2;
    D3                           = 3;
    D4                           = 4;
    D5                           = 5;
    D6                           = 6;
    D7                           = 7;
    D8                           = 8;

    //Analog PINs
    A0                           = D0;
    A1                           = D1;
    A2                           = D2;
    A3                           = D3;
    A4                           = D4;
    A5                           = D5;
    A6                           = D6;
    A7                           = D7;
    A8                           = D8;

    // BUTTON
    BUTTON_1                     = 28;
    BUTTON_2                     = 29;
    BUTTON_3                     = 30;
    WIO_KEY_A                    = 28;
    WIO_KEY_B                    = 29;
    WIO_KEY_C                    = 30;

    // SWITCH
    SWITCH_X                     = 31;
    SWITCH_Y                     = 32;
    SWITCH_Z                     = 33;
    SWITCH_B                     = 34;
    SWITCH_U                     = 35;

    WIO_5S_UP                    = 31;
    WIO_5S_LEFT                  = 32;
    WIO_5S_RIGHT                 = 33;
    WIO_5S_DOWN                  = 34;
    WIO_5S_PRESS                 = 35;
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

{$ifdef freertos_fat}
procedure freertos_pinMode(ulPin:DWORD;ulMode:DWORD); external name 'pinMode';
procedure freertos_digitalWrite(ulPin:DWORD;ulVal:DWORD); external name 'digitalWrite';
function  freertos_digitalRead(ulPin:DWORD):integer; external name 'digitalRead';

procedure freertos_analogReference(ulMode:byte); external name 'analogReference';
procedure freertos_analogWrite(ulPin:DWORD; ulValue:DWORD); external name 'analogWrite';
function  freertos_analogRead(ulPin:DWORD):DWORD; external name 'analogRead';
procedure freertos_analogReadResolution(res:integer); external name 'analogReadResolution';
procedure freertos_analogWriteResolution(res:integer); external name 'analogWriteResolution';
procedure freertos_analogOutputInit; external name 'analogOutputInit';
{$endif freertos_fat}


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

{$ifdef freertos_fat}
procedure TGPIO.SetPinMode(const Pin: TPinIdentifier; const Value: TPinMode);
begin
  case Value of
    TPinMode.Input     :  freertos_pinMode(Pin,PINMODE_INPUT);
    TPinMode.Output    :  freertos_pinMode(Pin,PINMODE_OUTPUT);
  end;
end;

procedure TGPIO.SetPinValue(const Pin: TPinIdentifier; const Value: TPinValue);
begin
  freertos_digitalWrite(Pin,Value);
end;

procedure TGPIO.SetPinDrive(const Pin: TPinIdentifier; const Value: TPinDrive);
begin
  case Value of
    TPinDrive.None : freertos_pinMode(Pin,PINMODE_INPUT);
    TPinDrive.PullUp : freertos_pinMode(Pin,PINMODE_INPUT_PULLUP);
    TPinDrive.PullDown : freertos_pinMode(Pin,PINMODE_INPUT_PULLDOWN);
  end;
end;

function TGPIO.GetPinValue(const Pin: TPinIdentifier): TPinValue;
begin
  result:=freertos_digitalRead(Pin);
end;

{$else}
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
  end;
end;

procedure TGPIO.SetPinValue(const Pin: TPinIdentifier; const Value: TPinValue);
begin
  if Value = 1 then
    Port.Group[Pin shr 5].OUTSET := 1 shl (Pin and $1f)
  else
    Port.Group[Pin shr 5].OUTCLR := 1 shl (Pin and $1f);
end;

procedure TGPIO.SetPinDrive(const Pin: TPinIdentifier; const Value: TPinDrive);
begin
  case Value of
    TPinDrive.None :     ClearBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],2);
    TPinDrive.PullUp :   SetBit(Port.Group[Pin shr 5].PINCFG[Pin and $1f],2);
  end;
end;

function TGPIO.GetPinValue(const Pin: TPinIdentifier): TPinValue;
begin
  Result := GetBitValue(Port.Group[Pin shr 5].&IN,Pin and $1f);
end;

    {$endif freertos_fat}



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
