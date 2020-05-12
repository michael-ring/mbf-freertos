
unit SEGGER_RTT;
interface

{
  Automatically converted by H2Pas 1.0.0 from SEGGER_RTT.h
  The following command line parameters were used:
    SEGGER_RTT.h
}

  Type
  Pchar  = ^char;
  Pva_list  = ^va_list;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  {********************************************************************
  *                    SEGGER Microcontroller GmbH                     *
  *                        The Embedded Experts                        *
  **********************************************************************
  *                                                                    *
  *            (c) 1995 - 2019 SEGGER Microcontroller GmbH             *
  *                                                                    *
  *       www.segger.com     Support: support@segger.com               *
  *                                                                    *
  **********************************************************************
  *                                                                    *
  *       SEGGER RTT * Real Time Transfer for embedded targets         *
  *                                                                    *
  **********************************************************************
  *                                                                    *
  * All rights reserved.                                               *
  *                                                                    *
  * SEGGER strongly recommends to not make any changes                 *
  * to or modify the source code of this software in order to stay     *
  * compatible with the RTT protocol and J-Link.                       *
  *                                                                    *
  * Redistribution and use in source and binary forms, with or         *
  * without modification, are permitted provided that the following    *
  * condition is met:                                                  *
  *                                                                    *
  * o Redistributions of source code must retain the above copyright   *
  *   notice, this condition and the following disclaimer.             *
  *                                                                    *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND             *
  * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,        *
  * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF           *
  * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE           *
  * DISCLAIMED. IN NO EVENT SHALL SEGGER Microcontroller BE LIABLE FOR *
  * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR           *
  * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT  *
  * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;    *
  * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF      *
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT          *
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE  *
  * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH   *
  * DAMAGE.                                                            *
  *                                                                    *
  **********************************************************************
  ---------------------------END-OF-HEADER------------------------------
  File    : SEGGER_RTT.h
  Purpose : Implementation of SEGGER real-time transfer which allows
            real-time communication on targets which support debugger 
            memory accesses while the CPU is running.
  Revision: $Rev: 17697 $
  ----------------------------------------------------------------------
   }
{$ifndef SEGGER_RTT_H}
{$define SEGGER_RTT_H}  
{$include "SEGGER_RTT_Conf.h"}
  {********************************************************************
  *
  *       Defines, defaults
  *
  **********************************************************************
   }
{$ifndef RTT_USE_ASM}
{$if (defined __SES_ARM)                       // SEGGER Embedded Studio}

  const
    _CC_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __CROSSWORKS_ARM)              // Rowley Crossworks}

  const
    _CC_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __GNUC__)                      // GCC}

  const
    _CC_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __clang__)                     // Clang compiler}

  const
    _CC_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __IASMARM__)                   // IAR assembler}

  const
    _CC_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __ICCARM__)                    // IAR compiler}

  const
    _CC_HAS_RTT_ASM_SUPPORT = 1;    
{$else}

  const
    _CC_HAS_RTT_ASM_SUPPORT = 0;    
{$endif}
{$if (defined __ARM_ARCH_7M__)                 // Cortex-M3/4}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __ARM_ARCH_7EM__)              // Cortex-M7}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __ARM_ARCH_8M_MAIN__)          // Cortex-M33}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 1;    
(*** was #elif ****){$else (defined __ARM7M__)                     // IAR Cortex-M3/4}
{$if (__CORE__ == __ARM7M__)}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 1;    
{$else}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 0;    
{$endif}
(*** was #elif ****){$else (defined __ARM7EM__)                    // IAR Cortex-M7}
{$if (__CORE__ == __ARM7EM__)}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 1;    
{$else}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 0;    
{$endif}
{$else}

  const
    _CORE_HAS_RTT_ASM_SUPPORT = 0;    
{$endif}
  { }
  { If IDE and core support the ASM version, enable ASM version by default }
  { }
{$if (_CC_HAS_RTT_ASM_SUPPORT && _CORE_HAS_RTT_ASM_SUPPORT)}

  const
    RTT_USE_ASM = 1;    
{$else}

  const
    RTT_USE_ASM = 0;    
{$endif}
{$endif}
{$ifndef SEGGER_RTT_ASM  // defined when SEGGER_RTT.h is included from assembly file}
{$include <stdlib.h>}
{$include <stdarg.h>}
  {********************************************************************
  *
  *       Defines, fixed
  *
  **********************************************************************
   }
  {********************************************************************
  *
  *       Types
  *
  **********************************************************************
   }
  { }
  { Description for a circular buffer (also called "ring buffer") }
  { which is used as up-buffer (T->H) }
  { }
(* Const before type ignored *)
  { Optional name. Standard names so far are: "Terminal", "SysView", "J-Scope_t4i4" }
  { Pointer to start of buffer }
  { Buffer size in bytes. Note that one byte is lost, as this implementation does not fill up the buffer in order to avoid the problem of being unable to distinguish between full and empty. }
  { Position of next item to be written by either target. }
(* error 
  volatile  unsigned RdOff;         // Position of next item to be read by host. Must be volatile since it may be modified by host.
 in declarator_list *)
  { Position of next item to be read by host. Must be volatile since it may be modified by host. }
  { Contains configuration flags }

  type
    SEGGER_RTT_BUFFER_UP = record
        sName : ^char;
        pBuffer : ^char;
        SizeOfBuffer : dword;
        WrOff : dword;
;
        Flags : dword;
      end;
  { }
  { Description for a circular buffer (also called "ring buffer") }
  { which is used as down-buffer (H->T) }
  { }
(* Const before type ignored *)
  { Optional name. Standard names so far are: "Terminal", "SysView", "J-Scope_t4i4" }
  { Pointer to start of buffer }
  { Buffer size in bytes. Note that one byte is lost, as this implementation does not fill up the buffer in order to avoid the problem of being unable to distinguish between full and empty. }
(* error 
  volatile  unsigned WrOff;         // Position of next item to be written by host. Must be volatile since it may be modified by host.
 in declarator_list *)
  { Position of next item to be written by host. Must be volatile since it may be modified by host. }
  { Position of next item to be read by target (down-buffer). }
  { Contains configuration flags }

    SEGGER_RTT_BUFFER_DOWN = record
        sName : ^char;
        pBuffer : ^char;
        SizeOfBuffer : dword;
;
        RdOff : dword;
        Flags : dword;
      end;
  { }
  { RTT control block which describes the number of buffers available }
  { as well as the configuration for each buffer }
  { }
  { }
  { Initialized to "SEGGER RTT" }
  { Initialized to SEGGER_RTT_MAX_NUM_UP_BUFFERS (type. 2) }
  { Initialized to SEGGER_RTT_MAX_NUM_DOWN_BUFFERS (type. 2) }
  { Up buffers, transferring information up from target via debug probe to host }
  { Down buffers, transferring information down from host via debug probe to target }

    SEGGER_RTT_CB = record
        acID : array[0..15] of char;
        MaxNumUpBuffers : longint;
        MaxNumDownBuffers : longint;
        aUp : array[0..(SEGGER_RTT_MAX_NUM_UP_BUFFERS)-1] of SEGGER_RTT_BUFFER_UP;
        aDown : array[0..(SEGGER_RTT_MAX_NUM_DOWN_BUFFERS)-1] of SEGGER_RTT_BUFFER_DOWN;
      end;
  {********************************************************************
  *
  *       Global data
  *
  **********************************************************************
   }

    var
      _SEGGER_RTT : SEGGER_RTT_CB;cvar;external;
  {********************************************************************
  *
  *       RTT API functions
  *
  **********************************************************************
   }
(* Const before type ignored *)

  function SEGGER_RTT_AllocDownBuffer(sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;

(* Const before type ignored *)
  function SEGGER_RTT_AllocUpBuffer(sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;

(* Const before type ignored *)
  function SEGGER_RTT_ConfigUpBuffer(BufferIndex:dword; sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;

(* Const before type ignored *)
  function SEGGER_RTT_ConfigDownBuffer(BufferIndex:dword; sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;

  function SEGGER_RTT_GetKey:longint;

  function SEGGER_RTT_HasData(BufferIndex:dword):dword;

  function SEGGER_RTT_HasKey:longint;

  function SEGGER_RTT_HasDataUp(BufferIndex:dword):dword;

  procedure SEGGER_RTT_Init;

  function SEGGER_RTT_Read(BufferIndex:dword; pBuffer:pointer; BufferSize:dword):dword;

  function SEGGER_RTT_ReadNoLock(BufferIndex:dword; pData:pointer; BufferSize:dword):dword;

(* Const before type ignored *)
  function SEGGER_RTT_SetNameDownBuffer(BufferIndex:dword; sName:Pchar):longint;

(* Const before type ignored *)
  function SEGGER_RTT_SetNameUpBuffer(BufferIndex:dword; sName:Pchar):longint;

  function SEGGER_RTT_SetFlagsDownBuffer(BufferIndex:dword; Flags:dword):longint;

  function SEGGER_RTT_SetFlagsUpBuffer(BufferIndex:dword; Flags:dword):longint;

  function SEGGER_RTT_WaitKey:longint;

(* Const before type ignored *)
  function SEGGER_RTT_Write(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;

(* Const before type ignored *)
  function SEGGER_RTT_WriteNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;

(* Const before type ignored *)
  function SEGGER_RTT_WriteSkipNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;

(* Const before type ignored *)
  function SEGGER_RTT_ASM_WriteSkipNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;

(* Const before type ignored *)
  function SEGGER_RTT_WriteString(BufferIndex:dword; s:Pchar):dword;

(* Const before type ignored *)
  procedure SEGGER_RTT_WriteWithOverwriteNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword);

  function SEGGER_RTT_PutChar(BufferIndex:dword; c:char):dword;

  function SEGGER_RTT_PutCharSkip(BufferIndex:dword; c:char):dword;

  function SEGGER_RTT_PutCharSkipNoLock(BufferIndex:dword; c:char):dword;

  function SEGGER_RTT_GetAvailWriteSpace(BufferIndex:dword):dword;

  function SEGGER_RTT_GetBytesInBuffer(BufferIndex:dword):dword;

  { }
  { Function macro for performance optimization }
  { }
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function SEGGER_RTT_HASDATA(n : longint) : longint;  

{$if RTT_USE_ASM}

  const
    SEGGER_RTT_WriteSkipNoLock = SEGGER_RTT_ASM_WriteSkipNoLock;    
{$endif}
  {********************************************************************
  *
  *       RTT transfer functions to send RTT data via other channels.
  *
  **********************************************************************
   }

  function SEGGER_RTT_ReadUpBuffer(BufferIndex:dword; pBuffer:pointer; BufferSize:dword):dword;

  function SEGGER_RTT_ReadUpBufferNoLock(BufferIndex:dword; pData:pointer; BufferSize:dword):dword;

(* Const before type ignored *)
  function SEGGER_RTT_WriteDownBuffer(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;

(* Const before type ignored *)
  function SEGGER_RTT_WriteDownBufferNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function SEGGER_RTT_HASDATA_UP(n : longint) : longint;  

  {********************************************************************
  *
  *       RTT "Terminal" API functions
  *
  **********************************************************************
   }
  function SEGGER_RTT_SetTerminal(TerminalId:byte):longint;

(* Const before type ignored *)
  function SEGGER_RTT_TerminalOut(TerminalId:byte; s:Pchar):longint;

  {********************************************************************
  *
  *       RTT printf functions (require SEGGER_RTT_printf.c)
  *
  **********************************************************************
   }
(* Const before type ignored *)
  function SEGGER_RTT_printf(BufferIndex:dword; sFormat:Pchar; args:array of const):longint;

(* Const before type ignored *)
  function SEGGER_RTT_vprintf(BufferIndex:dword; sFormat:Pchar; pParamList:Pva_list):longint;

{$endif}
  { ifndef(SEGGER_RTT_ASM) }
  {********************************************************************
  *
  *       Defines
  *
  **********************************************************************
   }
  { }
  { Operating modes. Define behavior if buffer is full (not enough space for entire message) }
  { }

  const
    SEGGER_RTT_MODE_NO_BLOCK_SKIP = 0;    { Skip. Do not block, output nothing. (Default) }
    SEGGER_RTT_MODE_NO_BLOCK_TRIM = 1;    { Trim: Do not block, output as much as fits. }
    SEGGER_RTT_MODE_BLOCK_IF_FIFO_FULL = 2;    { Block: Wait until there is space in the buffer. }
    SEGGER_RTT_MODE_MASK = 3;    
  { }
  { Control sequences, based on ANSI. }
  { Can be used to control color, and clear the screen }
  { }
    RTT_CTRL_RESET = '\x1B[0m';    { Reset to default colors }
    RTT_CTRL_CLEAR = '\x1B[2J';    { Clear screen, reposition cursor to top left }
    RTT_CTRL_TEXT_BLACK = '\x1B[2;30m';    
    RTT_CTRL_TEXT_RED = '\x1B[2;31m';    
    RTT_CTRL_TEXT_GREEN = '\x1B[2;32m';    
    RTT_CTRL_TEXT_YELLOW = '\x1B[2;33m';    
    RTT_CTRL_TEXT_BLUE = '\x1B[2;34m';    
    RTT_CTRL_TEXT_MAGENTA = '\x1B[2;35m';    
    RTT_CTRL_TEXT_CYAN = '\x1B[2;36m';    
    RTT_CTRL_TEXT_WHITE = '\x1B[2;37m';    
    RTT_CTRL_TEXT_BRIGHT_BLACK = '\x1B[1;30m';    
    RTT_CTRL_TEXT_BRIGHT_RED = '\x1B[1;31m';    
    RTT_CTRL_TEXT_BRIGHT_GREEN = '\x1B[1;32m';    
    RTT_CTRL_TEXT_BRIGHT_YELLOW = '\x1B[1;33m';    
    RTT_CTRL_TEXT_BRIGHT_BLUE = '\x1B[1;34m';    
    RTT_CTRL_TEXT_BRIGHT_MAGENTA = '\x1B[1;35m';    
    RTT_CTRL_TEXT_BRIGHT_CYAN = '\x1B[1;36m';    
    RTT_CTRL_TEXT_BRIGHT_WHITE = '\x1B[1;37m';    
    RTT_CTRL_BG_BLACK = '\x1B[24;40m';    
    RTT_CTRL_BG_RED = '\x1B[24;41m';    
    RTT_CTRL_BG_GREEN = '\x1B[24;42m';    
    RTT_CTRL_BG_YELLOW = '\x1B[24;43m';    
    RTT_CTRL_BG_BLUE = '\x1B[24;44m';    
    RTT_CTRL_BG_MAGENTA = '\x1B[24;45m';    
    RTT_CTRL_BG_CYAN = '\x1B[24;46m';    
    RTT_CTRL_BG_WHITE = '\x1B[24;47m';    
    RTT_CTRL_BG_BRIGHT_BLACK = '\x1B[4;40m';    
    RTT_CTRL_BG_BRIGHT_RED = '\x1B[4;41m';    
    RTT_CTRL_BG_BRIGHT_GREEN = '\x1B[4;42m';    
    RTT_CTRL_BG_BRIGHT_YELLOW = '\x1B[4;43m';    
    RTT_CTRL_BG_BRIGHT_BLUE = '\x1B[4;44m';    
    RTT_CTRL_BG_BRIGHT_MAGENTA = '\x1B[4;45m';    
    RTT_CTRL_BG_BRIGHT_CYAN = '\x1B[4;46m';    
    RTT_CTRL_BG_BRIGHT_WHITE = '\x1B[4;47m';    
{$endif}
  {************************** End of file *************************** }

implementation

  function SEGGER_RTT_AllocDownBuffer(sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_AllocUpBuffer(sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_ConfigUpBuffer(BufferIndex:dword; sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_ConfigDownBuffer(BufferIndex:dword; sName:Pchar; pBuffer:pointer; BufferSize:dword; Flags:dword):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_GetKey:longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_HasData(BufferIndex:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_HasKey:longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_HasDataUp(BufferIndex:dword):dword;
  begin
    { You must implement this function }
  end;
  procedure SEGGER_RTT_Init;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_Read(BufferIndex:dword; pBuffer:pointer; BufferSize:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_ReadNoLock(BufferIndex:dword; pData:pointer; BufferSize:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_SetNameDownBuffer(BufferIndex:dword; sName:Pchar):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_SetNameUpBuffer(BufferIndex:dword; sName:Pchar):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_SetFlagsDownBuffer(BufferIndex:dword; Flags:dword):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_SetFlagsUpBuffer(BufferIndex:dword; Flags:dword):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_WaitKey:longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_Write(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_WriteNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_WriteSkipNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_ASM_WriteSkipNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_WriteString(BufferIndex:dword; s:Pchar):dword;
  begin
    { You must implement this function }
  end;
  procedure SEGGER_RTT_WriteWithOverwriteNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword);
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_PutChar(BufferIndex:dword; c:char):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_PutCharSkip(BufferIndex:dword; c:char):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_PutCharSkipNoLock(BufferIndex:dword; c:char):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_GetAvailWriteSpace(BufferIndex:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_GetBytesInBuffer(BufferIndex:dword):dword;
  begin
    { You must implement this function }
  end;
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function SEGGER_RTT_HASDATA(n : longint) : longint;
  begin
    SEGGER_RTT_HASDATA:=(_SEGGER_RTT.((aDown[n]).WrOff))-(_SEGGER_RTT.((aDown[n]).RdOff));
  end;

  function SEGGER_RTT_ReadUpBuffer(BufferIndex:dword; pBuffer:pointer; BufferSize:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_ReadUpBufferNoLock(BufferIndex:dword; pData:pointer; BufferSize:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_WriteDownBuffer(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_WriteDownBufferNoLock(BufferIndex:dword; pBuffer:pointer; NumBytes:dword):dword;
  begin
    { You must implement this function }
  end;
  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function SEGGER_RTT_HASDATA_UP(n : longint) : longint;
  begin
    SEGGER_RTT_HASDATA_UP:=(_SEGGER_RTT.((aUp[n]).WrOff))-(_SEGGER_RTT.((aUp[n]).RdOff));
  end;

  function SEGGER_RTT_SetTerminal(TerminalId:byte):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_TerminalOut(TerminalId:byte; s:Pchar):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_printf(BufferIndex:dword; sFormat:Pchar):longint;
  begin
    { You must implement this function }
  end;
  function SEGGER_RTT_vprintf(BufferIndex:dword; sFormat:Pchar; pParamList:Pva_list):longint;
  begin
    { You must implement this function }
  end;

end.
