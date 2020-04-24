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

{ Indicates that this config file has been processed (to avoid redeclaring or redefining of parameters in other
  configuration files). }
{$DEFINE MBF_CONFIG}

{$HINTS ON}
{$WARNINGS ON}

// Scoped Enums are a good thing
{$SCOPEDENUMS ON}

// Full Boolean Evaluation off
{$BOOLEVAL OFF}

// No IO Checks
{$IOCHECKS OFF}

{$STACKFRAMES OFF}

{$IMPLICITEXCEPTIONS OFF}

{$OPTIMIZATION FORCENOSTACKFRAME}

//Disable AnsiStrings, they require HEAP
{$LONGSTRINGS OFF}

// FreePascal compiler directives.

{$MODE OBJFPC}

{$INLINE ON}

{$MACRO ON}

{$MODESWITCH TYPEHELPERS}

{$MODESWITCH ADVANCEDRECORDS}

{$WRITEABLECONST OFF}

//{$STATIC ON}

{$INCLUDE MBF.Boards.STM32F4.inc}

{$IFNDEF __CONTROLLERTYPE__}
  {$ERROR Unfortunately MBF has not yet been ported to your Embedded Controller}
{$ENDIF}
