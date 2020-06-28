unit Segger.SysView;
{$if defined(CPUARM)}
  {$LINKLIB seggersysview,static}
  {$LINKLIB seggerrtt,static}
  {$LINKLIB libc_nano,static}
{$endif}

interface

{$INCLUDE MBF.Config.inc}

uses
  MBF.__CONTROLLERTYPE__.SystemCore;

type
  TSEGGER_SYSVIEW_Options = (
    LOG=0,
    WARNING=1,
    ERROR=2
  );

type
  TSEGGER_SYSVIEW_SEND_SYS_DESC_FUNC = procedure;
  TSEGGER_SYSVIEW_TASKINFO = record
      TaskID : uint32;
      sName : Pchar;
      Prio : uint32;
      StackBase : uint32;
      StackSize : uint32;
    end;
  pTSEGGER_SYSVIEW_TASKINFO = ^TSEGGER_SYSVIEW_TASKINFO;

  pTSEGGER_SYSVIEW_MODULE = ^TSEGGER_SYSVIEW_MODULE;
  TSEGGER_SYSVIEW_MODULE = record
      sModule : Pchar;
      NumEvents : uint32;
      EventOffset : uint32;
      pfSendModuleDesc : procedure ;cdecl;
      pNext : pTSEGGER_SYSVIEW_MODULE;
  end;


type
  TSEGGER_SYSVIEW_OS_API = record
    pfGetTime : function :int64;cdecl;
    pfSendTaskList : procedure ;cdecl;
  end;
  pTSEGGER_SYSVIEW_OS_API = ^TSEGGER_SYSVIEW_OS_API;

procedure SEGGER_SYSVIEW_Init(SysFreq:uint32; CPUFreq:uint32; pOSAPI:pTSEGGER_SYSVIEW_OS_API; pfSendSysDesc:TSEGGER_SYSVIEW_SEND_SYS_DESC_FUNC);cdecl;external;
procedure SEGGER_SYSVIEW_SetRAMBase(RAMBaseAddress:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_Start;cdecl;external;
procedure SEGGER_SYSVIEW_Stop;cdecl;external;
procedure SEGGER_SYSVIEW_GetSysDesc;cdecl;external;
procedure SEGGER_SYSVIEW_SendTaskList;cdecl;external;
procedure SEGGER_SYSVIEW_SendTaskInfo(pInfo:pTSEGGER_SYSVIEW_TASKINFO);cdecl;external;
procedure SEGGER_SYSVIEW_SendSysDesc(sSysDesc:Pchar);cdecl;external;
function  SEGGER_SYSVIEW_IsStarted:longint;cdecl;external;
function  SEGGER_SYSVIEW_GetChannelID:longint;cdecl;external;
procedure SEGGER_SYSVIEW_RecordVoid(EventId:dword);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32(EventId:dword; Para0:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x2(EventId:dword; Para0:uint32; Para1:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x3(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x4(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32; Para3:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x5(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32; Para3:uint32;
            Para4:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x6(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32; Para3:uint32;
            Para4:uint32; Para5:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x7(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32; Para3:uint32;
            Para4:uint32; Para5:uint32; Para6:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x8(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32; Para3:uint32;
            Para4:uint32; Para5:uint32; Para6:uint32; Para7:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x9(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32; Para3:uint32;
            Para4:uint32; Para5:uint32; Para6:uint32; Para7:uint32; Para8:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordU32x10(EventId:dword; Para0:uint32; Para1:uint32; Para2:uint32; Para3:uint32;
            Para4:uint32; Para5:uint32; Para6:uint32; Para7:uint32; Para8:uint32;
            Para9:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordString(EventId:dword; pString:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_RecordSystime;cdecl;external;
procedure SEGGER_SYSVIEW_RecordEnterISR;cdecl;external;
procedure SEGGER_SYSVIEW_RecordExitISR;cdecl;external;
procedure SEGGER_SYSVIEW_RecordExitISRToScheduler;cdecl;external;
procedure SEGGER_SYSVIEW_RecordEnterTimer(TimerId:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_RecordExitTimer;cdecl;external;
procedure SEGGER_SYSVIEW_RecordEndCall(EventID:dword);cdecl;external;
procedure SEGGER_SYSVIEW_RecordEndCallU32(EventID:dword; Para0:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_OnIdle;cdecl;external;
procedure SEGGER_SYSVIEW_OnTaskCreate(TaskId:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_OnTaskTerminate(TaskId:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_OnTaskStartExec(TaskId:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_OnTaskStopExec;cdecl;external;
procedure SEGGER_SYSVIEW_OnTaskStartReady(TaskId:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_OnTaskStopReady(TaskId:uint32; Cause:dword);cdecl;external;
procedure SEGGER_SYSVIEW_MarkStart(MarkerId:dword);cdecl;external;
procedure SEGGER_SYSVIEW_MarkStop(MarkerId:dword);cdecl;external;
procedure SEGGER_SYSVIEW_Mark(MarkerId:dword);cdecl;external;
procedure SEGGER_SYSVIEW_NameMarker(MarkerId:dword; sName:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_NameResource(ResourceId:uint32; sName:Pchar);cdecl;external;
function  SEGGER_SYSVIEW_SendPacket(pPacket:puint8; pPayloadEnd:puint8; EventId:dword):longint;cdecl;external;
function  SEGGER_SYSVIEW_EncodeU32(pPayload:puint8; Value:uint32):puint8;cdecl;external;
function  SEGGER_SYSVIEW_EncodeData(pPayload:puint8; pSrc:Pchar; Len:dword):puint8;cdecl;external;
function  SEGGER_SYSVIEW_EncodeString(pPayload:puint8; s:Pchar; MaxLen:dword):puint8;cdecl;external;
function  SEGGER_SYSVIEW_EncodeId(pPayload:puint8; Id:uint32):puint8;cdecl;external;
function  SEGGER_SYSVIEW_ShrinkId(Id:uint32):uint32;cdecl;external;
procedure SEGGER_SYSVIEW_RegisterModule(pModule:pTSEGGER_SYSVIEW_MODULE);cdecl;external;
procedure SEGGER_SYSVIEW_RecordModuleDescription(pModule:pTSEGGER_SYSVIEW_MODULE; sDescription:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_SendModule(ModuleId:uint8);cdecl;external;
procedure SEGGER_SYSVIEW_SendModuleDescription;cdecl;external;
procedure SEGGER_SYSVIEW_SendNumModules;cdecl;external;
procedure SEGGER_SYSVIEW_PrintfHostEx(s:Pchar; Options:uint32; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_PrintfHostEx(s:Pchar; Options:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_PrintfTargetEx(s:Pchar; Options:uint32; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_PrintfTargetEx(s:Pchar; Options:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_PrintfHost(s:Pchar; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_PrintfHost(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_PrintfTarget(s:Pchar; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_PrintfTarget(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_WarnfHost(s:Pchar; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_WarnfHost(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_WarnfTarget(s:Pchar; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_WarnfTarget(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_ErrorfHost(s:Pchar; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_ErrorfHost(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_ErrorfTarget(s:Pchar; args:array of const);cdecl;external;
procedure SEGGER_SYSVIEW_ErrorfTarget(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_Print(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_Warn(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_Error(s:Pchar);cdecl;external;
procedure SEGGER_SYSVIEW_EnableEvents(EnableMask:uint32);cdecl;external;
procedure SEGGER_SYSVIEW_DisableEvents(DisableMask:uint32);cdecl;external;
//procedure SEGGER_SYSVIEW_Conf;cdecl;external;
procedure SEGGER_SYSVIEW_Conf(ExtraConfig : String = '');
function  SEGGER_SYSVIEW_X_GetTimestamp:uint32;cdecl;external;
function  SEGGER_SYSVIEW_X_GetInterruptId:uint32;cdecl;external;
procedure SEGGER_SYSVIEW_X_StartComm;cdecl;external;
procedure SEGGER_SYSVIEW_X_OnEventRecorded(NumBytes:dword);cdecl;external;

procedure traceISR_EXIT_TO_SCHEDULER; external name 'SEGGER_SYSVIEW_RecordExitISRToScheduler';
procedure traceISR_EXIT; external name 'SEGGER_SYSVIEW_RecordExitISR';
procedure traceISR_ENTER; external name 'SEGGER_SYSVIEW_RecordEnterISR';


implementation
var
  SYSVIEW_X_OS_TraceAPI: TSEGGER_SYSVIEW_OS_API; external name 'SYSVIEW_X_OS_TraceAPI';
  SYSVIEW_EXTRA_CONFIG : String;
function _cbGetTime : int64; cdecl; external name '_cbGetTime';
procedure _cbSendTaskList; cdecl; external name '_cbSendTaskList';

procedure _cbSendSystemDesc;
var
  CPUID : longword absolute $E000ED00;
  SYSVIEW_CONFIG : string;
begin
  {$IF DEFINED(CPUARM)}
  SYSVIEW_CONFIG := 'C="Cortex-M';
  case (CPUID shr 4) and $fff of
    $C20 : SYSVIEW_CONFIG:=SYSVIEW_CONFIG+'0 (r';
    $C60 : SYSVIEW_CONFIG:=SYSVIEW_CONFIG+'0+ (r';
    $C23 : SYSVIEW_CONFIG:=SYSVIEW_CONFIG+'3 (r';
    $C24 : SYSVIEW_CONFIG:=SYSVIEW_CONFIG+'4 (r';
    $C27 : SYSVIEW_CONFIG:=SYSVIEW_CONFIG+'7 (r';
    $D20 : SYSVIEW_CONFIG:=SYSVIEW_CONFIG+'23 (r';
    $D21 : SYSVIEW_CONFIG:=SYSVIEW_CONFIG+'33 (r';
  end;
  SYSVIEW_CONFIG:=SYSVIEW_CONFIG+char(((CPUID shr 20) and $0f)+ord('0'))+'.';
  SYSVIEW_CONFIG:=SYSVIEW_CONFIG+char((CPUID  and $0f)+ord('0'))+')"';
  {$ELSEIF DEFINED(CPURISCV32)}
  SYSVIEW_CONFIG := 'C=RiscV32';
  {$ELSEIF DEFINED(CPURISCV64)}
  SYSVIEW_CONFIG := 'C=RiscV64';
  {$ELSE}
  SYSVIEW_CONFIG := 'C=Unknown';
  {$ERROR Unknown Architecture}
  {$ENDIF}
  {$IF DEFINED(EMBEDDED)}
  SYSVIEW_CONFIG:=SYSVIEW_CONFIG+',O=NoOS'+#0;
  {$ELSEIF DEFINED(FREERTOS)}
  SYSVIEW_CONFIG:=SYSVIEW_CONFIG+',O=FreeRTOS'+#0;
  {$ELSE}
  SYSVIEW_CONFIG:=SYSVIEW_CONFIG+',O=Unknown'+#0;
  {$ERROR Unknown Target}
  {$ENDIF}
  SEGGER_SYSVIEW_SendSysDesc(@SYSVIEW_CONFIG[1]);
  SEGGER_SYSVIEW_SendSysDesc('I#15=SysTick');
  if length(SYSVIEW_EXTRA_CONFIG) > 1 then
    SEGGER_SYSVIEW_SendSysDesc(@SYSVIEW_EXTRA_CONFIG[1]);
end;

procedure SEGGER_SYSVIEW_Conf(ExtraConfig : String = '');
begin
  SYSVIEW_EXTRA_CONFIG:=ExtraConfig+#0;
  SEGGER_SYSVIEW_Init(SystemCoreClock,SystemCoreClock,@SYSVIEW_X_OS_TraceAPI,@_cbSendSystemDesc);
  SEGGER_SYSVIEW_SetRAMBase($20000000);
end;

begin
end.

