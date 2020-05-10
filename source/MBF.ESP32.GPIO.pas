unit mbf.esp32.gpio;
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
{$WARN 4055 off : Conversion between ordinals and pointers is not portable}
interface

{$include MBF.Config.inc}

{$REGION PinDefinitions}
const
  ALT1=$1000;
  ALT2=$1100;
  ALT3=$1200;
  ALT4=$1300;
  ALT5=$1400;
  ALT6=$1500;

type
  TGPIO_Registers = record
    BT_SELECT_REG          : longWord;
    OUT_REG                : longWord;
    OUT_W1TS_REG           : longWord;
    OUT_W1TC_REG           : longWord;
    OUT1_REG               : longWord;
    OUT1_W1TS_REG          : longWord;
    OUT1_W1TC_REG          : longWord;
    SDIO_SELECT_REG        : longWord;
    ENABLE_REG             : longWord;
    ENABLE_W1TS_REG        : longWord;
    ENABLE_W1TC_REG        : longWord;
    ENABLE1_REG            : longWord;
    ENABLE1_W1TS_REG       : longWord;
    ENABLE1_W1TC_REG       : longWord;
    STRAP_REG              : longWord;
    IN_REG                 : longWord;
    IN1_REG                : longWord;
    STATUS_REG             : longWord;
    STATUS_W1TS_REG        : longWord;
    STATUS_W1TC_REG        : longWord;
    STATUS1_REG            : longWord;
    STATUS1_W1TS_REG       : longWord;
    STATUS1_W1TC_REG       : longWord;
    RESERVED0              : longWord;
    ACPU_INT_REG           : longWord;
    ACPU_NMI_INT_REG       : longWord;
    PCPU_INT_REG           : longWord;
    PCPU_NMI_INT_REG       : longWord;
    CPUSDIO_INT_REG        : longWord;
    ACPU_INT1_REG          : longWord;
    ACPU_NMI_INT1_REG      : longWord;
    PCPU_INT1_REG          : longWord;
    PCPU_NMI_INT1_REG      : longWord;
    CPUSDIO_INT1_REG       : longWord;
    PIN_REG                : array[0..39] of longWord; //Offset 0x88
    CALI_CONF_REG          : longWord;                 //Offset 0x128
    CALI_DATA_REG          : longWord;
    FUNC_IN_SEL_CFG    : array[0..255] of longWord;    //Offset 0x130
    FUNC_OUT_SEL_CFG   : array[0..39] of longWord;     //Offset 0x530
  end;
(*
#define PIN_CTRL                          (DR_REG_IO_MUX_BASE +0x00)
#define PERIPHS_IO_MUX_GPIO36_U           (DR_REG_IO_MUX_BASE +0x04)
#define PERIPHS_IO_MUX_GPIO37_U           (DR_REG_IO_MUX_BASE +0x08)
#define PERIPHS_IO_MUX_GPIO38_U           (DR_REG_IO_MUX_BASE +0x0c)
#define PERIPHS_IO_MUX_GPIO39_U           (DR_REG_IO_MUX_BASE +0x10)
#define PERIPHS_IO_MUX_GPIO34_U           (DR_REG_IO_MUX_BASE +0x14)
#define PERIPHS_IO_MUX_GPIO35_U           (DR_REG_IO_MUX_BASE +0x18)
#define PERIPHS_IO_MUX_GPIO32_U           (DR_REG_IO_MUX_BASE +0x1c)
#define PERIPHS_IO_MUX_GPIO33_U           (DR_REG_IO_MUX_BASE +0x20)
#define PERIPHS_IO_MUX_GPIO25_U           (DR_REG_IO_MUX_BASE +0x24)
#define PERIPHS_IO_MUX_GPIO26_U           (DR_REG_IO_MUX_BASE +0x28)
#define PERIPHS_IO_MUX_GPIO27_U           (DR_REG_IO_MUX_BASE +0x2c)
#define PERIPHS_IO_MUX_MTMS_U             (DR_REG_IO_MUX_BASE +0x30)
#define PERIPHS_IO_MUX_MTDI_U             (DR_REG_IO_MUX_BASE +0x34)
#define PERIPHS_IO_MUX_MTCK_U             (DR_REG_IO_MUX_BASE +0x38)
#define PERIPHS_IO_MUX_MTDO_U             (DR_REG_IO_MUX_BASE +0x3c)
#define PERIPHS_IO_MUX_GPIO2_U            (DR_REG_IO_MUX_BASE +0x40)
#define PERIPHS_IO_MUX_GPIO0_U            (DR_REG_IO_MUX_BASE +0x44)
#define PERIPHS_IO_MUX_GPIO4_U            (DR_REG_IO_MUX_BASE +0x48)
#define PERIPHS_IO_MUX_GPIO16_U           (DR_REG_IO_MUX_BASE +0x4c)
#define PERIPHS_IO_MUX_GPIO17_U           (DR_REG_IO_MUX_BASE +0x50)
#define PERIPHS_IO_MUX_SD_DATA2_U         (DR_REG_IO_MUX_BASE +0x54)
#define PERIPHS_IO_MUX_SD_DATA3_U         (DR_REG_IO_MUX_BASE +0x58)
#define PERIPHS_IO_MUX_SD_CMD_U           (DR_REG_IO_MUX_BASE +0x5c)
#define PERIPHS_IO_MUX_SD_CLK_U           (DR_REG_IO_MUX_BASE +0x60)
#define PERIPHS_IO_MUX_SD_DATA0_U         (DR_REG_IO_MUX_BASE +0x64)
#define PERIPHS_IO_MUX_SD_DATA1_U         (DR_REG_IO_MUX_BASE +0x68)
#define PERIPHS_IO_MUX_GPIO5_U            (DR_REG_IO_MUX_BASE +0x6c)
#define PERIPHS_IO_MUX_GPIO18_U           (DR_REG_IO_MUX_BASE +0x70)
#define PERIPHS_IO_MUX_GPIO19_U           (DR_REG_IO_MUX_BASE +0x74)
#define PERIPHS_IO_MUX_GPIO20_U           (DR_REG_IO_MUX_BASE +0x78)
#define PERIPHS_IO_MUX_GPIO21_U           (DR_REG_IO_MUX_BASE +0x7c)
#define PERIPHS_IO_MUX_GPIO22_U           (DR_REG_IO_MUX_BASE +0x80)
#define PERIPHS_IO_MUX_U0RXD_U            (DR_REG_IO_MUX_BASE +0x84)
#define PERIPHS_IO_MUX_U0TXD_U            (DR_REG_IO_MUX_BASE +0x88)
#define PERIPHS_IO_MUX_GPIO23_U           (DR_REG_IO_MUX_BASE +0x8c)
#define PERIPHS_IO_MUX_GPIO24_U           (DR_REG_IO_MUX_BASE +0x90)
*)
  TIO_MUX_Registers = record
    PIN_CTRL           : longWord;
    RESERVED0          : array[0..2] of longWord;
    REG                : array[0..35] of longWord;
  end;

  TNativePin = record
  const
    None=-1;
    {$if defined (has_gpioa)} PA0=  0;  PA1=  1;  PA2=  2;  PA3=  3;  PA4=  4;  PA5=  5;  PA6=  6;  PA7=  7;
                              PA8=  8;  PA9=  9; PA10= 10; PA11= 11; PA12= 12; PA13= 13; PA14= 14; PA15= 15;
                             PA16= 16; PA17= 17; PA18= 18; PA19= 19;           PA21= 21; PA22= 22; PA23= 23;
                                       PA25= 25; PA26= 26; PA27= 27;
                             PA32= 32; PA33= 33; PA34= 34; PA35= 35; PA36= 36; PA37= 37; PA38= 38; PA39= 39; {$endif}
  end;

  {$if defined(has_arduinopins) and defined(bpiuno32)}
  type
    TArduinoPin = record
    const
      None=-1;
      D0 =TNativePin.PA3;  D1 =TNativePin.PA1;  D2 =TNativePin.PA2;   D3 =TNativePin.PA4;
      D4 =TNativePin.PA15; D5 =TNativePin.PA13; D6 =TNativePin.PA12;  D7 =TNativePin.PA14;
      D8 =TNativePin.PA25; D9 =TNativePin.PA26; D10=TNativePin.PA5;   D11=TNativePin.PA23;
      D12=TNativePin.PA19; D13=TNativePin.PA18; D14=TNativePin.PA21;  D15=TNativePin.PA22;

      A0 =TNativePin.PA36; A1 =TNativePin.PA39; A2 =TNativePin.PA32;   A3 =TNativePin.PA34;
      A4 =TNativePin.PA34; A5 =TNativePin.PA35;
    end;
  {$endif}

{$endregion}
type
  TPinLevel=(Low=0,High=1);
  TPinValue=0..1;
  TPinIdentifier=-1..39;
  TPinMode = (Input=%00, Output=%01, Analog=%11, AF1=$10, AF2, AF3, AF4, AF5, AF6);
  TPinDrive = (None=%00,PullUp=%01,PullDown=%10);
  TPinOutputMode = (PushPull=0,OpenDrain=1);
  TPinOutputSpeed = (Slow=%00, Medium=%01, High=%10, VeryHigh=%11);

  TBit = (Bit0, Bit1, Bit2, Bit3, Bit4, Bit5, Bit6, Bit7,
          Bit8, Bit9, Bit10, Bit11, Bit12, Bit13, Bit14, Bit15);
  TBitSet = set of TBit;

type
  TGPIO = record helper for TGPIO_Registers
  private
    function  GetPinMode(const Pin: TPinIdentifier): TPinMode;
    procedure SetPinMode(const Pin: TPinIdentifier; const Value: TPinMode);
    //function  GetPinDrive(const Pin: TPinIdentifier): TPinDrive;
    //procedure SetPinDrive(const Pin: TPinIdentifier; const Value: TPinDrive);
    //function  GetPinOutputMode(const Pin: TPinIdentifier): TPinOutputMode;
    //procedure SetPinOutputMode(const Pin: TPinIdentifier; const Value: TPinOutputMode);
    //function  GetPinOutputSpeed(const Pin: TPinIdentifier): TPinOutputSpeed;
    //procedure SetPinOutputSpeed(const Pin: TPinIdentifier; const Value: TPinOutputSpeed);
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
    //property PinDrive[const Pin : TPinIdentifier] : TPinDrive read getPinDrive write setPinDrive;
    //property PinOutputMode[const Pin : TPinIdentifier] : TPinOutputMode read getPinOutputMode write setPinOutputMode;
    //property PinOutputSpeed[const Pin : TPinIdentifier] : TPinOutputSpeed read getPinOutputSpeed write setPinOutputSpeed;
    property PinValue[const Pin : TPinIdentifier] : TPinValue read getPinValue write setPinValue;
    property PinLevel[const Pin : TPinIdentifier] : TPinLevel read getPinLevel write setPinLevel;
  end;

  (*
  TGPIOPort = record helper for TGPIO_Registers
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
  end;
 *)
var
  GPIO : TGPIO_Registers absolute $3ff44000;
  IO_MUX : TIO_MUX_Registers absolute $3ff49000;

implementation
uses
  MBF.BitHelpers;

procedure gpio_pad_select_gpio(gpio_num: byte); external;
function gpio_set_direction(gpio_num: byte; mode: byte): longWord; external;
function gpio_set_level(gpio_num: byte; level: byte): longWord; external;


function  TGPIO.GetPinMode(const Pin: TPinIdentifier): TPinMode;
begin
  //TODO
  Result := TPinMode.Output;
end;

procedure TGPIO.SetPinMode(const Pin: TPinIdentifier; const Value: TPinMode);
begin
  case Value of
    TPinMode.Output: begin
       gpio_pad_select_gpio(Pin);
       gpio_set_direction(Pin, %010); //Output Mode
    end;
    TPinMode.Input: begin
       gpio_pad_select_gpio(Pin);
       gpio_set_direction(Pin, %001); //Input Mode
    end;
  (*
  if pin <32 then
  begin
    Self.PIN[pin] := 0;
    case Value of
      TPinMode.Input: begin
        IO_MUX.REG[pin] := $300;
      end;
      TPinMode.Output: begin
        FUNC_OUT_SEL_CFG[pin] := $100;
      end;
      TPinMode.Analog: begin

      end;
    else
      begin

      end;
    end;
  end *)
  else
    begin
      //TODO
    end;
  end;
end;

procedure TGPIO.Initialize;
begin
end;

function  TGPIO.GetPinValue(const Pin: TPinIdentifier): TPinValue;
begin
  if pin <32 then
    Result := GetBit(IN_REG,pin)
  else
    Result := GetBit(IN1_REG,pin and %11111);
end;

procedure TGPIO.SetPinValue(const Pin: TPinIdentifier; const Value: TPinValue);
begin
  gpio_set_level(Pin,Value);
(*
  if pin <32 then
    SetBitValue(OUT_W1TS_REG,pin,value)
  else
    SetBitValue(OUT1_W1TS_REG,pin and %11111,value);
*)
end;

function  TGPIO.GetPinLevel(const Pin: TPinIdentifier): TPinLevel;
begin
  if pin <32 then
    Result := TPinLevel(GetBit(IN_REG,pin))
  else
    Result := TPinLevel(GetBit(IN1_REG,pin and %11111));
end;

procedure TGPIO.SetPinLevel(const Pin: TPinIdentifier; const Level: TPinLevel);
begin
  if pin <32 then
    SetBitValue(OUT_W1TS_REG,pin,byte(Level))
  else
    SetBitValue(OUT1_W1TS_REG,pin and %11111,byte(Level));
end;

procedure TGPIO.SetPinLevelHigh(const Pin: TPinIdentifier);
begin
  if pin <32 then
    SetBit(OUT_W1TS_REG,pin)
  else
    SetBit(OUT1_W1TS_REG,pin and %11111);
end;

procedure TGPIO.SetPinLevelLow(const Pin: TPinIdentifier);
begin
  if pin <32 then
    SetBit(OUT_W1TC_REG,pin)
  else
    SetBit(OUT1_W1TC_REG,pin and %11111);
end;

procedure TGPIO.TogglePinValue(const Pin: TPinIdentifier);
begin
  if pin <32 then
    if GetBit(OUT_REG,pin) = 0 then
      SetBit(OUT_W1TS_REG,pin)
    else
      SetBit(OUT_W1TC_REG,pin)
  else
    if GetBit(OUT1_REG,pin) = 0 then
      SetBit(OUT1_W1TS_REG,pin)
    else
      SetBit(OUT1_W1TC_REG,pin)
end;

procedure TGPIO.TogglePinLevel(const Pin: TPinIdentifier);
begin
  if pin <32 then
    if GetBit(OUT_REG,pin) = 0 then
      SetBit(OUT_W1TS_REG,pin)
    else
      SetBit(OUT_W1TC_REG,pin)
  else
    if GetBit(OUT1_REG,pin) = 0 then
      SetBit(OUT1_W1TS_REG,pin)
    else
      SetBit(OUT1_W1TC_REG,pin)
end;

end.
