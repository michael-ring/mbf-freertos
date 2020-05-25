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
procedure SEGGER_SYSVIEW_Conf;
function  SEGGER_SYSVIEW_X_GetTimestamp:uint32;cdecl;external;
function  SEGGER_SYSVIEW_X_GetInterruptId:uint32;cdecl;external;
procedure SEGGER_SYSVIEW_X_StartComm;cdecl;external;
procedure SEGGER_SYSVIEW_X_OnEventRecorded(NumBytes:dword);cdecl;external;

implementation

procedure _cbSendSystemDesc;
begin
  SEGGER_SYSVIEW_SendSysDesc('N=dummy');
  {$IF defined(CPUARMV6)}
  SEGGER_SYSVIEW_SendSysDesc('D=Cortex-M0');
  {$ELSEIF defined(CPUARMV7M)}
  SEGGER_SYSVIEW_SendSysDesc('D=Cortex-M3');
  {$ELSEIF defined(CPUARMV7EM)}
  SEGGER_SYSVIEW_SendSysDesc('D=Cortex-M4/7');
  {$ELSE}
  SEGGER_SYSVIEW_SendSysDesc('D=unknown');
  {$ENDIF}
  SEGGER_SYSVIEW_SendSysDesc('I#15=SysTick');
end;

procedure SEGGER_SYSVIEW_Conf;
begin
  SEGGER_SYSVIEW_Init(SystemCoreClock,SystemCoreClock,nil,@_cbSendSystemDesc);
  SEGGER_SYSVIEW_SetRAMBase($20000000);
end;

end.

