unit MBF.Devices.A02YYUW;

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

interface

{$INCLUDE MBF.Config.inc}
uses
  MBF.Types,
  MBF.__CONTROLLERTYPE__.SystemCore,
  MBF.__CONTROLLERTYPE__.GPIO,
  MBF.__CONTROLLERTYPE__.UART;

type
  TA02YYUW = object
    var
      _pUART : ^TUART_Registers;
      _EnablePin : TPinIdentifier;
    constructor Initialize(var UART: TUART_Registers; const EnablePin : TPinIdentifier=TNativepin.None);
    function ReadDistance : integer;
  end;

implementation

constructor TA02YYUW.Initialize(var UART: TUART_Registers; const Enablepin : TPinIdentifier);
begin
  _EnablePin := EnablePin;
  _pUART := @UART;
  UART.BaudRate := 9600;
  if EnablePin <> TNativePin.None then
  begin
    GPIO.PinMode[EnablePin] := TPinMode.Output;
    //Turn Sensor off
    GPIO.PinLevel[EnablePin] := TPinLevel.Low;
  end;
end;

function TA02YYUW.ReadDistance:integer;
var
  tmpPos : longword;
  tmp : array[0..3] of byte;
begin
  //Turn on Sensor
  if _EnablePin <> TNativePin.None then
    GPIO.PinLevel[_EnablePin] := TPinLevel.High;
  SystemCore.Delay(600);
  if _pUART^.ReadBytes(tmp,500) = true then
  begin
    while (tmp[0] <> $ff) and (((tmp[0]+tmp[1]+tmp[2]) and $ff) <> tmp[3]) do
    begin
       tmp[0] := tmp[1];
       tmp[1] := tmp[2];
       tmp[2] := tmp[3];
       if _pUART^.ReadBytes(tmp[3],500) = false then
       begin
         Result := -1;
         break;
       end;
    end;
    Result := tmp[1]*256+tmp[2];
  end
  else
    Result := -1;
  //Turn off Sensor
  if _EnablePin <> TNativePin.None then
    GPIO.PinLevel[_EnablePin] := TPinLevel.Low;
end;

end.
