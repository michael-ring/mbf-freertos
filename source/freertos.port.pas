{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  {$OPTIMIZATION ON}
  unit freertos.port;
  {$mode objfpc}{$H+}
  interface
  {$I FreeRTOS.config.inc}
{$endif}

{$if not defined(IMPLEMENTATION)}
  procedure vPortEndScheduler; external name 'vPortEndScheduler';
  procedure vPortEnterCritical; external name 'vPortEnterCritical';
  procedure vPortExitCritical; external name 'vPortExitCritical';
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  implementation
{$endif}

{$if not defined(INTERFACE)}
  {$if defined(CPUARM)}
    procedure vPortFree; external name 'vPortFree';

    procedure vPortFreeStub; assembler; nostackframe;
    asm
      .long vPortFree
      .weak vPortFree
      .set  vPortFree,vPortFreeStub
      bkpt
    end;
  {$endif}
{$endif}

{$if not defined(INTERFACE) and not defined(IMPLEMENTATION)}
  begin
  end.
{$endif}

