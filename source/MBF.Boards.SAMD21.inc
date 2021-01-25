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
{$DEFINE MBF_BOARDS_SAMD21_CONFIG}

// first, convert user friendly controller names to the real controller used in the design

{$if defined(fpc_mcu_xiao) }
  {$define samd21g18a}
{$endif}

{$if defined(fpc_mcu_feather_m0) }
  {$define has_featherpins}
  {$define samd21g18a}
{$endif}

{$if defined(fpc_mcu_itsybitsy_m0) }
  {$define has_featherpins}
  {$define samd21g18a}
{$endif}

{$if defined(fpc_mcu_metro_m0) }
  {$define has_arduinopins}
  {$define samd21g18a}
{$endif}

{$if defined(fpc_mcu_trinket_m0) }
  {$define has_arduinopins}
  {$define samd21e18a}
{$endif}

{$if defined(samd21e18a) }
  {$define SAMD21}
  {$define has_gpioa }  
  {$define has_sercom0 } {$define has_sercom1 } {$define has_sercom2 } {$define has_sercom3 } 
  {$define has_usart0 }  {$define has_usart1 }  {$define has_usart2 }  {$define has_usart3 } 
  {$define has_spi0 }    {$define has_spi1 }    {$define has_spi2 }    {$define has_spi3 }   
  {$define has_i2c0 }    {$define has_i2c1 }    {$define has_i2c2 }    {$define has_i2c3 }   
  {$define has_adc }   
  {$define has_dac }   
  {$define has_rtc }   
{$endif}
{$if defined(samd21g18a) }
  {$define SAMD21}
  {$define has_gpioa }   {$define has_gpiob }  
  {$define has_sercom0 } {$define has_sercom1 } {$define has_sercom2 } {$define has_sercom3 } 
  {$define has_sercom4 } {$define has_sercom5 } 
  {$define has_usart0 }  {$define has_usart1 }  {$define has_usart2 }  {$define has_usart3 } {$define has_usart4 }  {$define has_usart5 } 
  {$define has_spi0 }    {$define has_spi1 }    {$define has_spi2 }    {$define has_spi3 }   {$define has_spi4 }    {$define has_spi5 }   
  {$define has_i2c0 }    {$define has_i2c1 }    {$define has_i2c2 }    {$define has_i2c3 }   {$define has_i2c4 }    {$define has_i2c5 }   
  {$define has_adc }   
  {$define has_dac }   
  {$define has_rtc }   
{$endif}
{$if defined(samd21j18a) }
  {$define SAMD21}
  {$define has_gpioa }   {$define has_gpiob }  
  {$define has_sercom0 } {$define has_sercom1 } {$define has_sercom2 } {$define has_sercom3 } 
  {$define has_sercom4 } {$define has_sercom5 } 
  {$define has_usart0 }  {$define has_usart1 }  {$define has_usart2 }  {$define has_usart3 } {$define has_usart4 }  {$define has_usart5 } 
  {$define has_spi0 }    {$define has_spi1 }    {$define has_spi2 }    {$define has_spi3 }   {$define has_spi4 }    {$define has_spi5 }   
  {$define has_i2c0 }    {$define has_i2c1 }    {$define has_i2c2 }    {$define has_i2c3 }   {$define has_i2c4 }    {$define has_i2c5 }   
  {$define has_adc }   
  {$define has_dac }   
  {$define has_rtc }   
{$endif}

{$if defined(SAMD21) }
  {$define CortexM0}
  {$define __NVIC_PRIO_BITS2}
  {$define __CONTROLLERTYPE__:=SAMD21}
  {$define SAMD}
  {$define SAM}
  {$ALIGN 2}
{$endif}
