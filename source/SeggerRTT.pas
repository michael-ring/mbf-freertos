unit seggerRTT;
{$if defined(CPUARM)}
  {$LINKLIB seggerrtt,static}
{$endif}
interface
  //function SEGGER_RTT_AllocDownBuffer(sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint; external;
  //function SEGGER_RTT_AllocUpBuffer(sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint; external;
  //function SEGGER_RTT_ConfigUpBuffer(BufferIndex:dword; sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint; external;
  //function SEGGER_RTT_ConfigDownBuffer(BufferIndex:dword; sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint; external;
  //function SEGGER_RTT_GetKey:longint; external;
  //function SEGGER_RTT_HasData(BufferIndex:dword):dword; external;
  //function SEGGER_RTT_HasKey:longint; external;
  //function SEGGER_RTT_HasDataUp(BufferIndex:dword):dword; external;
  //procedure SEGGER_RTT_Init; external;
  //function SEGGER_RTT_Read(BufferIndex:dword; pBuffer:pointer; BufferSize:dword):dword; external;
  //function SEGGER_RTT_ReadNoLock(BufferIndex:dword; pData:pointer; BufferSize:dword):dword; external;
  //function SEGGER_RTT_SetNameDownBuffer(BufferIndex:dword; sName:Pchar):longint; external;
  //function SEGGER_RTT_SetNameUpBuffer(BufferIndex:dword; sName:Pchar):longint; external;
  //function SEGGER_RTT_SetFlagsDownBuffer(BufferIndex:dword; Flags:dword):longint; external;
  //function SEGGER_RTT_SetFlagsUpBuffer(BufferIndex:dword; Flags:dword):longint; external;
  //function SEGGER_RTT_WaitKey:longint; external;
  function SEGGER_RTT_Write(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword; external;
  function SEGGER_RTT_WriteNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword; external;
  function SEGGER_RTT_WriteSkipNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword; external;
  function SEGGER_RTT_ASM_WriteSkipNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword; external;
  function SEGGER_RTT_WriteString(BufferIndex:dword; s:Pchar):dword; external;
  //procedure SEGGER_RTT_WriteWithOverwriteNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword); external;
  function SEGGER_RTT_PutChar(BufferIndex:dword; c:char):dword; external;
  function SEGGER_RTT_PutCharSkip(BufferIndex:dword; c:char):dword; external;
  function SEGGER_RTT_PutCharSkipNoLock(BufferIndex:dword; c:char):dword; external;
  function SEGGER_RTT_GetAvailWriteSpace(BufferIndex:dword):dword; external;
  function SEGGER_RTT_GetBytesInBuffer(BufferIndex:dword):dword; external;

implementation
uses
  strings;
function strlen(p: PChar):SizeInt; public name 'strlen';
begin
  Result := strings.strlen(p);
end;

end.

