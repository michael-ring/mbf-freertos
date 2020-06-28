{$IF DEFINED(INTERFACE)}

{ Attempts to read a byte from UART port.
  @param(TimeOut defines maximum time in milliseconds to wait for successful write)
  @returns(@True is returned when the operation was successful) }
function  ReadByte(var aReadByte: byte; const TimeOut: TMilliSeconds=DefaultUARTTimeOut):boolean;

{ Attempts to Write a byte to UART port.
  @param(aWriteByte The Data to write)
  @param(TimeOut defines maximum time in milliseconds to wait for successful write)
  @returns(@True is returned when the operation was successful)}
function  WriteByte(const aWriteByte: byte; const TimeOut: TMilliSeconds=DefaultUARTTimeOut) : boolean;

{ Reads multiple Bytes from UART port.
  Will block indefinitely until the bytes have been read.
  @param(aReadBuffer Array of Bytes where the data will be written to.) }
function  ReadBytes(var aReadBuffer: array of byte; const TimeOut: TMilliSeconds=DefaultUARTTimeOut) : boolean;

{ Reads multiple Bytes from UART port.
  @param(aReadBuffer Array of Bytes where the data will be written to.)
  @param(aReadCount  Number of bytes to read.)
  @param(TimeOut Maximum time in milliseconds to wait while attempting to read the buffer.)
  @returns(True when Data could be read without timeout otherwise false) }
function  ReadBytes(var aReadBuffer: array of byte; var aReadCount: TSize; const TimeOut:TMilliSeconds=DefaultUARTTimeOut):boolean;

{ Writes multiple bytes of data to UART port.
  Will block indefinitely until the bytes have been written.
  @param(aWriteBuffer array of bytes where the data will be read from.) }
function WriteBytes(const aWriteBuffer: array of byte; const TimeOut: TMilliSeconds=DefaultUARTTimeOut) : boolean;

{ Attempts to write multiple bytes of data to UART port.
  @param(aWriteBuffer array of bytes where the data will be read from.)
  @param(aWriteCount Number of bytes to write.)
  @param(TimeOut Maximum time (in milliseconds) to wait while attempting to write the buffer.
  @returns(True when Data could be read without timeout otherwise false.) }
function  WriteBytes(const aWriteBuffer: array of byte; const aWriteCount : TSize; const TimeOut: TMilliSeconds=DefaultUARTTimeOut) : boolean;

{ Attempts to read a String of data from UART port.
  @param(aReadString String where the data will be written to)
  @param(aReadCount Number of bytes to read)
  @param(TimeOut Maximum time (in milliseconds) to wait while attempting to write the buffer.
  @returns(True when Data could be read without timeout otherwise false.) }
function  ReadString(var aReadString: String;   var aReadCount: TSize; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): Boolean;

{ Attempts to read a String of data from UART port until a delimiter was read
  @param(aReadString String where the data will be written to)
  @param(aDelimiter The delimiter char. It will not be included in the returned string)
  @param(TimeOut Maximum time (in milliseconds) to wait while attempting to read the string.
  @returns(True when Data could be read without timeout otherwise false.) }
function  ReadString(var aReadString: String; const aDelimiter : char; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): Boolean;

{ Writes a string to UART port.
  @param(aWriteString String where the data will be read from.) }
function  WriteUnsignedInt(const aNumber: longword; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): Boolean;
function  WriteSignedInt(const aNumber: longint; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): Boolean;
function  WriteHexInt(const aNumber: longword;const aLength : byte; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): Boolean;

{ Attempts to write a String to UART port.
  @param(aWriteString String where the data will be read from.)
  @param(TimeOut Maximum time (in milliseconds) to wait while attempting to write the buffer.)
  @returns(True when Data could be written without timeout otherwise false.) }
function  WriteString(const aWriteString: String; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): Boolean;

{ Reads data buffer from UART port.
  @param(aReadBuffer Pointer to data buffer where the data will be written to.)
  @param(aReadCount  Number of bytes to read.)
  @param(TimeOut Maximum time (in milliseconds) to wait while attempting to read the buffer.
  @returns(True when Data could be read without timeout otherwise false}
function  ReadBuffer(aReadBuffer: Pointer;   var aReadCount : TSize; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): boolean;

{ Writes data buffer to UART (serial) port.
  @param(aWriteBuffer Pointer to data buffer where the data will be read from.)
  @param(aWriteCount Number of bytes to write.)
  @param(TimeOut Maximum time (in milliseconds) to wait while attempting to write the buffer.
  @returns(True when Data could be read without timeout otherwise false.) }
function  WriteBuffer(const aWriteBuffer: Pointer; const aWriteCount : TSize; const TimeOut: TMilliSeconds=DefaultUARTTimeOut): boolean;

{$ENDIF}

{$IF DEFINED(IMPLEMENTATION)}

function TUARTRegistersHelper.ReadByte(var aReadByte: byte; const TimeOut: TMilliSeconds):boolean;
begin
  Result := xStreamBufferReceive(getRxStreamBufferHandle,@aReadByte,1,Timeout) = 1;
end;

function TUARTRegistersHelper.WriteByte(const aWriteByte: byte; const TimeOut: TMilliSeconds) : boolean;
begin
  Result := xStreamBufferSend(getTxStreamBufferHandle,@aWriteByte,1,Timeout) = 1;
  setBit(UART.CR1,7);
end;

function TUARTRegistersHelper.ReadBytes(var aReadBuffer: array of byte; const TimeOut: TMilliSeconds):boolean;
begin
  Result := xStreamBufferReceive(getRxStreamBufferHandle,@aReadBuffer[0],High(aReadBuffer)+1,Timeout) = TSize(High(aReadBuffer)+1);
end;

function TUARTRegistersHelper.ReadBytes(var aReadBuffer: array of byte; var aReadCount : TSize; const TimeOut: TMilliSeconds):boolean;
begin
  Result := xStreamBufferReceive(getRxStreamBufferHandle,@aReadBuffer[0],aReadCount,Timeout) = aReadCount;
end;

function TUARTRegistersHelper.WriteBytes(const aWriteBuffer: array of byte; const TimeOut: TMilliSeconds) : boolean;
begin
  Result := xStreamBufferSend(getTxStreamBufferHandle,@aWriteBuffer[0],High(aWriteBuffer)+1,Timeout) = TSize(High(aWriteBuffer)+1);
  setBit(UART.CR1,7);
end;

function TUARTRegistersHelper.WriteBytes(const aWriteBuffer: array of byte; const aWriteCount : TSize; const TimeOut: TMilliSeconds) : boolean;
begin
  Result := xStreamBufferSend(getTxStreamBufferHandle,@aWriteBuffer[0],aWriteCount,Timeout) = aWriteCount;
  setBit(UART.CR1,7);
end;

function TUARTRegistersHelper.ReadString(var aReadString: String; var aReadCount: Tsize; const TimeOut: TMilliSeconds): Boolean;
begin
  Result := xStreamBufferReceive(getRxStreamBufferHandle,@aReadString[1],aReadCount,Timeout) = aReadCount;
  aReadString[0] := char(aReadCount);
end;

function TUARTRegistersHelper.ReadString(var aReadString: String; const aDelimiter: char;
  const TimeOut: TMilliSeconds): Boolean;
var
  EndTime : longWord;
  CharRead : char;
begin
  Result := false;
  aReadString := '';
  EndTime := SystemCore.GetTickCount + TimeOut;

  repeat
    if WaitForRXReady(EndTime) = false then
      exit(false);
    CharRead := char(ReadDR);
    if CharRead = aDelimiter then
      exit(true);
    aReadString := aReadString + CharRead;
  until 1=0;
end;

function TUARTRegistersHelper.WriteString(const aWriteString: String; const TimeOut: TMilliSeconds): Boolean;
begin
  Result := xStreamBufferSend(getTxStreamBufferHandle,@aWriteString[1],length(aWriteString),Timeout) = length(aWriteString);
  setBit(UART.CR1,7);
end;

function  TUARTRegistersHelper.WriteUnsignedInt(const aNumber: longword; const TimeOut: TMilliSeconds) : boolean;
var
  TempString : String[10];
begin
  Str(aNumber,TempString);
  Result := xStreamBufferSend(getTxStreamBufferHandle,@TempString[1],length(TempString),Timeout) = length(Tempstring);
  setBit(UART.CR1,7);
end;

function TUARTRegistersHelper.WriteSignedInt(const aNumber: longint; const TimeOut: TMilliSeconds):boolean;
var
  TempString : String[11];
begin
  Str(aNumber,TempString);
  Result := xStreamBufferSend(getTxStreamBufferHandle,@TempString[1],length(TempString),Timeout) = length(Tempstring);
  setBit(UART.CR1,7);
end;

function TUARTRegistersHelper.WriteHexInt(const aNumber: longword;const aLength:byte; const TimeOut: TMilliSeconds) : boolean;
var
  i : integer;
  temp : byte;
begin
  for i := alength-1 downto 0 do
  begin
    temp := ((aNumber shr (4*i)) and %1111)+ord('0');
    if temp > ord('9') then
      temp := temp-ord('9')+ord('a')-1;
    Result := xStreamBufferSend(getTxStreamBufferHandle,@temp,1,Timeout) = 1;
    if Result = false then
      break;
  end;
  setBit(UART.CR1,7);
end;

function TUARTRegistersHelper.ReadBuffer(aReadBuffer: Pointer; var aReadCount : TSize; const TimeOut: TMilliSeconds): boolean;
var
  Temp : TSize;
begin
  Temp := aReadCount;
  aReadCount := xStreamBufferReceive(getRxStreamBufferHandle,aReadBuffer,aReadCount,Timeout);
  Result := aReadCount = Temp;
end;

function TUARTRegistersHelper.WriteBuffer(const aWriteBuffer: Pointer; const aWriteCount : TSize; const TimeOut: TMilliSeconds): boolean;
begin
  Result := xStreamBufferSend(getTxStreamBufferHandle,@aWriteBuffer,aWriteCount,Timeout) = aWriteCount;
  setBit(UART.CR1,7);
end;

{$ENDIF}

