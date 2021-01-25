{
  This file is part of Micro Board Framework Library (MBF)
  Copyright (c) 2000 - 2015  Yuriy Kotsarenko
  Copyright (c) 2015         Michael Ring

  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General
  Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
  details.
}

{ Indicates that this config file has been processed (to avoid redeclaring or redefining of parameters in other
  configuration files). }
{$DEFINE MBF_BOARDS_ESP32_CONFIG}

// first, convert user friendly controller names to the real controller used in the design

{$if defined(fpc_mcu_nodemcuesp32) }
  {$define ESP32}
{$endif}

{$if defined(fpc_mcu_bpiuno32) }
  {$define ESP32}
  {$define has_arduinopins}
{$endif}

{$if defined(fpc_mcu_ESP32) }
  {$define ESP32}
  {$define has_gpioa } {$define has_gpiob } {$define has_gpioc } {$define has_gpioh }
  {$define has_usart1 } {$define has_usart2 }
  {$define has_spi1 }
  {$define has_i2c1 }
  {$define has_rtc }
{$endif}

{$if defined(ESP32) }
  {$define XTENSALX6}
  {$define __CONTROLLERTYPE__:=ESP32}
{$endif}
