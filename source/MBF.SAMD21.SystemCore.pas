unit MBF.SAMD21.SystemCore;
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

interface

{$INCLUDE MBF.Config.inc}

{$DEFINE INTERFACE}
{$INCLUDE MBF.ARM.SystemCore.inc}
{$UNDEF INTERFACE}

{$if defined(SAMD21)}
const
  OSC8MFrequency=8000000;
  MaxCPUFrequency=48000000;
  GENERIC_CLOCK_GENERATOR_XOSC32K=1;
  GENERIC_CLOCK_GENERATOR_OSCULP32K=2;
  GENERIC_CLOCK_GENERATOR_OSC8M=3;
  GENERIC_CLOCK_GENERATOR_OSC48M=4;

{$else}
  {$error Unknown Chip series, please define maximum CPU Frequency}
{$endif}

type
  TClockType = (OSC8M,DFLL48M,DFLL48M_XOSC32,FDPLL96M_OSC32K,FDPLL96M_XOSC32);

type
  TSAMD21SystemCore = record helper for TSystemCore
  private
    procedure ConfigureSystem;
    function GetSysTickClockFrequency : longWord;
    procedure StartandMapOSC32K(TargetID : byte);
    procedure StartandMapXOSC32(TargetID : byte);
    procedure StartandMapOSC8M(TargetID : byte);
    procedure StartandMapDFLL48M(TargetID : byte);
  public
    procedure Initialize;
    //function GetSYSCLKFrequency: longWord;
    procedure SetCPUFrequency(Value: longWord; aClockType : TClockType = TClockType.DFLL48M);
    function GetCPUFrequency: longWord;
    function getMaxCPUFrequency : longWord;
  end;

var
  SystemCore : TSystemCore;
  //This var is needed to communicate CPU Speed to FreeRTOS
  SystemCoreClock : uint32; cvar;

implementation

uses
  FreeRTOS,
  MBF.BitHelpers;

{$DEFINE IMPLEMENTATION}
{$INCLUDE MBF.ARM.SystemCore.inc}
{$UNDEF IMPLEMENTATION}

{$REGION 'TSystemCore'}

function TSAMD21SystemCore.GetSysTickClockFrequency : longWord; [public, alias: 'MBF_GetSysTickClockFrequency'];
begin
  Result := GetCPUFrequency;
  if GetBit(SysTick.CTRL,2) = 0 then
    Result := Result div 8;
end;

procedure TSAMD21SystemCore.Initialize;
begin
  ConfigureSystem;
  ConfigureTimer;
end;

procedure TSAMD21SystemCore.ConfigureSystem;
begin
  // Preset clocks similar to Arduino
  // Set 8MHz Clock Speed
  StartAndMapOSC8M(0);
  // Set Generic Clock 1 to 32kHz
  StartAndMapOSC32K(GENERIC_CLOCK_GENERATOR_XOSC32K);
  // Set Generic Clock 2 to ulp 32kHz
  //StartandMapOSCULP32K(GENERIC_CLOCK_GENERATOR_OSCULP32K);
  // Set Generic clock 3 to 8MHz
  StartAndMapOSC8M(GENERIC_CLOCK_GENERATOR_OSC8M);
  // Set Generic clock 4 to 48MHz
  StartAndMapDFLL48M(GENERIC_CLOCK_GENERATOR_OSC48M);
end;

procedure TSAMD21SystemCore.StartandMapOSC32K(TargetID : byte);
begin
  //WRTLOCK = 0,     /* OSC32K configuration is not locked */
  //STARTUP = 0x2,   /* 3 cycle start-up time */
  //ONDEMAND = 0,    /* Osc. is always running when enabled */
  //RUNSTDBY = 0,    /* Osc. is disabled in standby sleep mode */
  //EN32K = 1,       /* 32kHz output is disabled */

  SYSCTRL.OSC32K := 2 shl 8 + 1 shl 2;

  // Load Calibration Values
  SetBitsMasked(SYSCTRL.OSC32K,OTP4_FUSES.OTP4_WORD_1 shr 6,%1111111 shl 16,16);

  //Enable the Oscillator
  SetBit(SYSCTRL.OSC32K,1);

  //Wait until Clock is stable
  WaitBitIsSet(SYSCTRL.PCLKSR,2);

  // Set the Generic Clock Generator output divider to 1
  GCLK.GENDIV := 1 shl 8 + TargetID;
  // RUNSTDBY = 0, /* Generic Clock Generator is stopped in stdby */
  // DIVSEL =  0,  /* Use GENDIV.DIV value to divide the generator */
  // OE = 0,       /* Disable generator output to GCLK_IO[1] */
  // OOV = 0,      /* GCLK_IO[1] output value when generator is off */
  // IDC = 1,      /* Generator duty cycle is 50/50 */
  // GENEN = 1,    /* Enable the generator */
  // SRC = 0x04,   /* Generator source: OSC32K output */
  // ID = GENERIC_CLOCK_GENERATOR_OSC32K     /* Generator ID: 1 */
  GCLK.GENCTRL := 1 shl 17 + 1 shl 16 + 5 shl 8 + TargetID;  
  WaitBitIsCleared(GCLK.STATUS,7);
end;

procedure TSAMD21SystemCore.StartandMapXOSC32(TargetID : byte);
begin
  //WRTLOCK = 0,     /* XOSC32K configuration is not locked */
  //STARTUP = 0x2,   /* 3 cycle start-up time */
  //ONDEMAND = 0,    /* Osc. is always running when enabled */
  //RUNSTDBY = 0,    /* Osc. is disabled in standby sleep mode */
  //AAMPEN = 0,      /* Disable automatic amplitude control */
  //EN32K = 1,       /* 32kHz output is disabled */
  //XTALEN = 1       /* Crystal connected to XIN32/XOUT32 */
  SYSCTRL.XOSC32K := 4 shl 8 + 1 shl 3 + 1 shl 2;
  //Enable the Oscillator
  SetBit(SYSCTRL.XOSC32K,1);
  //Wait until Clock is stable
  WaitBitIsSet(SYSCTRL.PCLKSR,1);
  // Set the Generic Clock Generator output divider to 1
  GCLK.GENDIV := 1 shl 8 + TargetID;
  // RUNSTDBY = 0, /* Generic Clock Generator is stopped in stdby */
  // DIVSEL =  0,  /* Use GENDIV.DIV value to divide the generator */
  // OE = 0,       /* Disable generator output to GCLK_IO[1] */
  // OOV = 0,      /* GCLK_IO[1] output value when generator is off */
  // IDC = 1,      /* Generator duty cycle is 50/50 */
  // GENEN = 1,    /* Enable the generator */
  // SRC = 0x05,   /* Generator source: XOSC32K output */
  // ID = GENERIC_CLOCK_GENERATOR_XOSC32K     /* Generator ID: 1 */
  GCLK.GENCTRL := 1 shl 17 + 1 shl 16 + 5 shl 8 + TargetID;  
  WaitBitIsCleared(GCLK.STATUS,7);
end;

procedure TSAMD21SystemCore.StartandMapOSC8M(TargetID : byte);
begin
  //Set Prescaler to 1
  SetCrumb(SYSCTRL.OSC8M,0,8);

  // Oscillator is always on
  ClearBit(SYSCTRL.OSC8M,7);

  // Oscillator is off in Standby
  ClearBit(SYSCTRL.OSC8M,6); 

  // Enable Oscillator
  SetBit(SYSCTRL.OSC8M,1); 
  
  // Set the Generic Clock Generator output divider to 1
  // DIV = 1,               /* Set output division factor = 1 */
  // ID = GENERIC_CLOCK_GENERATOR_OSC8M   /* Apply division factor to Generator 3 */
  GCLK.GENDIV := 1 shl 16 + TargetID;
  
  // Configure Generic Clock Generator with OSC8M as source
  // RUNSTDBY = 0, /* Generic Clock Generator is stopped in stdby */
  // DIVSEL =  0,  /* Use GENDIV.DIV value to divide the generator */
  // OE = 0,       /* Disable generator output to GCLK_IO[1] */
  // OOV = 0,      /* GCLK_IO[2] output value when generator is off */
  // IDC = 1,      /* Generator duty cycle is 50/50 */
  // GENEN = 1,    /* Enable the generator */
  // SRC = 0x06,   /* Generator source: OSC8M output */
  // ID = GENERIC_CLOCK_GENERATOR_OSC8M     /* Generator ID: 3 */
  GCLK.GENCTRL := 1 shl 17 + 1 shl 16 + 6 shl 8 + TargetID;

  // GENCTRL is Write-Synchronized...so wait for write to complete
  WaitBitIsCleared(GCLK.STATUS,7);
end;

procedure TSAMD21SystemCore.StartandMapDFLL48M(TargetID : byte);
begin
  // Start OSC
  SYSCTRL.DFLLCTRL := 1 shl 1;
  WaitBitIsSet(SYSCTRL.PCLKSR,4);
  // Load factory calibrated values into DFLLVAL (cf. Data Sheet 17.6.7.1)
  SYSCTRL.DFLLVAL := (OTP4_FUSES.OTP4_WORD_1 shr 26 and %111111) shl 10 + (OTP4_FUSES.OTP4_WORD_2 and %1111111111);
  WaitBitIsSet(SYSCTRL.PCLKSR,4);
  // Set the Generic Clock Generator output divider to 1
  // DIV = 1,               /* Set output division factor = 1 */
  // ID = GENERIC_CLOCK_GENERATOR_OSC8M   /* Apply division factor to Generator 3 */
  GCLK.GENDIV := 1 shl 16 + TargetID;
  
  // Switch Generic Clock Generator 0 to DFLL48M. CPU will run at 48MHz.
  // RUNSTDBY = 0,    /* Generic Clock Generator is stopped in stdby */
  // DIVSEL =  0,   /* Use GENDIV.DIV value to divide the generator */
  // OE = 1,      /* Enable generator output to GCLK_IO[0] */
  // OOV = 0,     /* GCLK_IO[0] output value when generator is off */
  // IDC = 1,     /* Generator duty cycle is 50/50 */
  // GENEN = 1,     /* Enable the generator */
  // SRC = 0x07,    /* Generator source: DFLL48M output */
  // ID = GENERIC_CLOCK_GENERATOR_MAIN      /* Generator ID: 0 */
  GCLK.GENCTRL := 1 shl 17 + 1 shl 16 + 7 shl 8 + TargetID;

  // Wait for synchronization
  WaitBitIsCleared(GCLK.STATUS,7);
end;

procedure TSAMD21SystemCore.SetCPUFrequency(Value: longWord; aClockType : TClockType = TClockType.DFLL48M);
var
  i : integer;
  DIVFACTOR,TARGETRATIO : word;
begin
  //Set Waitstates for worst Case
  SetNibble(NVMCTRL.CTRLB,3,1);

  case aClockType of
    TClockType.OSC8M: begin
                      Value := 8000000;
                      StartandMapOSC8M(0);
                    end;
    TClockType.DFLL48M: begin
                      Value := 48000000;
                      StartandMapDFLL48M(0);
                    end;
    TClockType.DFLL48M_XOSC32: begin
                      Value := 48000000;
                      StartAndMapXOSC32(GENERIC_CLOCK_GENERATOR_XOSC32K);
                      //Put Generic Clock Generator 1 as source for Generic Clock Multiplexer 0 (DFLL48M reference)
                      // WRTLOCK = 0,   /* Generic Clock is not locked from subsequent writes */
                      // CLKEN = 1,     /* Enable the Generic Clock */
                      // GEN = GENERIC_CLOCK_GENERATOR_XOSC32K,   /* Generic Clock Generator 1 is the source */
                      // ID = 0x00      /* Generic Clock Multiplexer 0 (DFLL48M Reference) */
                      GCLK.CLKCTRL := 1 shl 14 + 1 shl 8 + 0;

                      // Enable the DFLL48M in open loop mode.
                      WaitBitIsSet(SYSCTRL.PCLKSR,4);
                      SYSCTRL.DFLLCTRL := 1 shl 1;
                      WaitBitIsSet(SYSCTRL.PCLKSR,4);

                      // Set up the Multiplier, Coarse and Fine steps
                      // CSTEP = 31,    /* Coarse step - use half of the max value (63) */
                      // FSTEP = 511,   /* Fine step - use half of the max value (1023) */
                      // MUL = 1465     /* Multiplier = MAIN_CLK_FREQ (48MHz) / EXT_32K_CLK_FREQ (32768 Hz) */
                      SYSCTRL.DFLLMUL := 31 shl 26 + 511 shl 16 + 1465;
                      // Wait for synchronization
                      WaitBitIsSet(SYSCTRL.PCLKSR,4);
                      // To reduce lock time, load factory calibrated values into DFLLVAL (cf. Data Sheet 17.6.7.1)
                      SetBitsMasked(SYSCTRL.DFLLVAL,OTP4_FUSES.OTP4_WORD_1 shr 26,%111111 shl 10,10);
                      // Wait for synchronization
                      WaitBitIsSet(SYSCTRL.PCLKSR,4);
                      // Switch DFLL48M to Closed Loop mode and enable WAITLOCK
                      SYSCTRL.DFLLCTRL := SYSCTRL.DFLLCTRL or (1 shl 11 + 1 shl 2);

                      // Switch Generic Clock Generator 0 to DFLL48M. CPU will run at 48MHz.
                      // RUNSTDBY = 0,    /* Generic Clock Generator is stopped in stdby */
                      // DIVSEL =  0,   /* Use GENDIV.DIV value to divide the generator */
                      // OE = 1,      /* Enable generator output to GCLK_IO[0] */
                      // OOV = 0,     /* GCLK_IO[0] output value when generator is off */
                      // IDC = 1,     /* Generator duty cycle is 50/50 */
                      // GENEN = 1,     /* Enable the generator */
                      // SRC = 0x07,    /* Generator source: DFLL48M output */
                      // ID = GENERIC_CLOCK_GENERATOR_MAIN      /* Generator ID: 0 */
                      GCLK.GENCTRL := 1 shl 17 + 1 shl 16 + 7 shl 8 + 0;
                      // Wait for synchronization
                      WaitBitIsCleared(GCLK.STATUS,7);
                    end;
    TClockType.FDPLL96M_OSC32K,
    TClockType.FDPLL96M_XOSC32: begin
                      if aClockType = TClockType.FDPLL96M_OSC32K then
                        StartAndMapOSC32K(GENERIC_CLOCK_GENERATOR_XOSC32K)
                      else
                        StartAndMapXOSC32(GENERIC_CLOCK_GENERATOR_XOSC32K);

                      // Put Generic Clock Generator 1 as source for (FDPLL96M reference)
                      // WRTLOCK = 0,   /* Generic Clock is not locked from subsequent writes */
                      // CLKEN = 1,     /* Enable the Generic Clock */
                      // GEN = GENERIC_CLOCK_GENERATOR_XOSC32K,   /* Generic Clock Generator 1 is the source */
                      // ID = 0x01      /* Generic Clock Multiplexer 1 (FDPLL96M Reference) */
                      GCLK.CLKCTRL := 1 shl 14 + 1 shl 8 + GENERIC_CLOCK_GENERATOR_XOSC32K;
                      WaitBitIsCleared(GCLK.STATUS,7);

                      if Value * 256 < 48000000 then
                        Value := 48000000 div 256;
                      if Value > 48000000 then
                        Value := 48000000; 
                      for i := 1 to 256 do
                        if (Value * i >= 48000000) and (Value * i <= 96000000) then
                        begin
                          DIVFACTOR := i;
                          TARGETRATIO := Value*i div 32768 - 1;
                          break;
                        end;
                      SYSCTRL.DPLLRATIO := TARGETRATIO;
                      // DIV = 0;
                      // LBYPASS = 0;
                      // LTIME = 0;    //select the DPLL lock time-out
                      // REFCLK = 0;   //select the DPLL clock reference
                      // WUF = 0;     // select if output is gated during lock time
                      // LPEN = 0;    // Low-Power Enable
                      // FILTER = 0;
                      SYSCTRL.DPLLCTRLB := 0;

                      // ONDEMAND = 0
                      // RUNSTDBY = 0
                      // ENABLE = 1
                      SYSCTRL.DPLLCTRLA := 1 shl 1;

                      // Wait For Enable
                      WaitBitIsSet(SYSCTRL.DPLLSTATUS,2);
                      //Wait for Lock
                      WaitBitIsSet(SYSCTRL.DPLLSTATUS,0);
                      //Set Divisor for Clock
                      GCLK.GENDIV := DIVFACTOR shl 8 + 0;
                      // Switch Generic Clock Generator 0 to FDPLL96M.
                      // RUNSTDBY = 0,    /* Generic Clock Generator is stopped in stdby */
                      // DIVSEL =  DIVFACTOR,   /* Use GENDIV.DIV value to divide the generator */
                      // OE = 1,      /* Enable generator output to GCLK_IO[0] */
                      // OOV = 0,     /* GCLK_IO[0] output value when generator is off */
                      // IDC = 1,     /* Generator duty cycle is 50/50 */
                      // GENEN = 1,     /* Enable the generator */
                      // SRC = 0x08,    /* Generator source: FDPLL96M output */
                      // ID = GENERIC_CLOCK_GENERATOR_MAIN      /* Generator ID: 0 */
                      GCLK.GENCTRL := 1 shl 17 + 1 shl 16 + 8 shl 8 + 0;
                      // Wait for synchronization
                      WaitBitIsCleared(GCLK.STATUS,7);
                    end;
  end;

  //Set Waitstates for new Clock Speed
  if Value >= 24000000 then
    SetNibble(NVMCTRL.CTRLB,1,1)
  else
    SetNibble(NVMCTRL.CTRLB,0,1);


  PM.CPUSEL := 0;
  PM.APBASEL := 0;
  PM.APBBSEL := 0;
  PM.APBCSEL := 0;
  SystemCoreClock := GetCPUFrequency;
  ConfigureTimer;
end;

//function TSAMD21SystemCore.GetSysClockFrequency : longWord;
//begin
//  Result := OSC8MFrequency;
//end;

function TSAMD21SystemCore.GetCPUFrequency : longWord;
var
  ClockSource : byte;
  DivideClock : TBitValue;
  DivideFactor : word;
begin
  //Wait for SYNCBUSY cleared 
  waitBitIsCleared(GCLK.STATUS,7);
  //Select Clock0 as it feeds the CPU
  pByte(@GCLK.GENCTRL)^ := 0;
  ClockSource := getBitsMasked(GCLK.GENCTRL,%11111 shl 8,8);
  DivideClock := getBit(GCLK.GENCTRL,20);

  case ClockSource of
  0: begin
       //XOSC
       asm
         .Lloop:
         bkpt
         b .Lloop
        end;
     end;
  1: begin
       //GCLKIN
       asm
         .Lloop:
         bkpt
         b .Lloop
        end;
     end;
  2: begin
       //GCLKGEN1
       asm
         .Lloop:
         bkpt
         b .Lloop
        end;
     end;
  3: begin
       //OSCULP32K
       Result := 32768;
     end;
  4: begin
       //OSC32K
       Result := 32768;
     end;
  5: begin
       //XOSC32K
       Result := 32768;
     end;
  6: begin
       //OSC8M
       Result := OSC8MFrequency;
     end;
  7: begin
       //DFLL48M
       Result := 48000000;
     end;
  8: begin
       Result := 32768 * (SYSCTRL.DPLLRATIO and %111111111111);
     end;
  end;

  //Wait for SYNCBUSY cleared 
  waitBitIsCleared(GCLK.STATUS,7);
  //Select Clock0 as it feeds the CPU
  pByte(@GCLK.GENDIV)^ := 0;
  DivideFactor := getBitsMasked(GCLK.GENDIV,%1111111111111111 shl 8,8);
  if DivideClock = 0 then
  begin
    if DivideFactor > 1 then
      Result := Result div DivideFactor;
  end
  else
    Result := Result shr (DivideFactor+1)
end;


function TSAMD21SystemCore.GetMaxCPUFrequency : longWord;
begin
  Result := MaxCPUFrequency;
end;

{$ENDREGION}

begin
  SystemCoreClock := SystemCore.GetCPUFrequency;
end.
