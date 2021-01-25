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
{$DEFINE MBF_BOARDS_SAMD51_CONFIG}

// first, convert user friendly controller names to the real controller used in the design

{$if defined(fpc_mcu_wio_terminal) }
  {$define samd51p19a}
{$endif}

{$if defined(fpc_mcu_feather_m4) }
  {$define has_featherpins}
  {$define samd51j19a}
{$endif}

{$if defined(fpc_mcu_itsybitsy_m4) }
  {$define has_featherpins}
  {$define samd51g19a}
{$endif}

{$if defined(fpc_mcu_metro_m4) }
  {$define has_arduinopins}
  {$define samd51g19a}
{$endif}

{$if defined(samd51j19a) }
  {$define SAMD51}
  {$define has_gpioa }  {$define has_gpiob }  
  {$define has_usart0 } {$define has_usart1 } {$define has_usart2 } {$define has_usart3 } {$define has_usart4 } {$define has_usart5 } 
  {$define has_spi0 }   {$define has_spi1 }   {$define has_spi2 }   {$define has_spi3 }   {$define has_spi4 }   {$define has_spi5 }   
  {$define has_i2c0 }   {$define has_i2c1 }   {$define has_i2c2 }   {$define has_i2c3 }   {$define has_i2c4 }   {$define has_i2c5 }   
  {$define has_adc0 }   {$define has_adc1 }   
  {$define has_dac }   
  {$define has_rtc }   
{$endif}
{$if defined(samd51p19a) }
  {$define SAMD51}
  {$define has_gpioa }  {$define has_gpiob }  {$define has_gpioc }  {$define has_gpiod }  
  {$define has_usart0 } {$define has_usart1 } {$define has_usart2 } {$define has_usart3 } {$define has_usart4 } {$define has_usart5 } {$define has_usart6 } {$define has_usart7 } 
  {$define has_spi0 }   {$define has_spi1 }   {$define has_spi2 }   {$define has_spi3 }   {$define has_spi4 }   {$define has_spi5 }   {$define has_spi6 }   {$define has_spi7 }   
  {$define has_i2c0 }   {$define has_i2c1 }   {$define has_i2c2 }   {$define has_i2c3 }   {$define has_i2c4 }   {$define has_i2c5 }   {$define has_i2c6 }   {$define has_i2c7 }   
  {$define has_adc0 }   {$define has_adc1 }   
  {$define has_dac }   
  {$define has_rtc }   
{$endif}
{$if defined(samd51g19a) }
  {$define SAMD51}
  {$define has_gpioa }  {$define has_gpiob }  
  {$define has_usart0 } {$define has_usart1 } {$define has_usart2 } {$define has_usart3 } {$define has_usart4 } {$define has_usart5 } 
  {$define has_spi0 }   {$define has_spi1 }   {$define has_spi2 }   {$define has_spi3 }   {$define has_spi4 }   {$define has_spi5 }   
  {$define has_i2c0 }   {$define has_i2c1 }   {$define has_i2c2 }   {$define has_i2c3 }   {$define has_i2c4 }   {$define has_i2c5 }   
  {$define has_adc0 }   {$define has_adc1 }   
  {$define has_dac }   
  {$define has_rtc }   
{$endif}

{$if defined(SAMD51) }
  {$define CortexM4}
  {$define __NVIC_PRIO_BITS3}
  {$define __CONTROLLERTYPE__:=SAMD51}
  {$define SAMD}
  {$define SAM}
  {$ALIGN 2}
{$endif}
