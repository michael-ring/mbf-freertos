unit OpenCM3.STM32F4;

interface
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

type
  TSize = uint32;

procedure adc_power_on(adc:uint32);cdecl;external;
procedure adc_power_off(adc:uint32);cdecl;external;
procedure adc_enable_analog_watchdog_regular(adc:uint32);cdecl;external;
procedure adc_disable_analog_watchdog_regular(adc:uint32);cdecl;external;
procedure adc_enable_analog_watchdog_injected(adc:uint32);cdecl;external;
procedure adc_disable_analog_watchdog_injected(adc:uint32);cdecl;external;
procedure adc_enable_discontinuous_mode_regular(adc:uint32; length:uint8);cdecl;external;
procedure adc_disable_discontinuous_mode_regular(adc:uint32);cdecl;external;
procedure adc_enable_discontinuous_mode_injected(adc:uint32);cdecl;external;
procedure adc_disable_discontinuous_mode_injected(adc:uint32);cdecl;external;
procedure adc_enable_automatic_injected_group_conversion(adc:uint32);cdecl;external;
procedure adc_disable_automatic_injected_group_conversion(adc:uint32);cdecl;external;
procedure adc_enable_analog_watchdog_on_all_channels(adc:uint32);cdecl;external;
procedure adc_enable_analog_watchdog_on_selected_channel(adc:uint32; channel:uint8);cdecl;external;
procedure adc_enable_scan_mode(adc:uint32);cdecl;external;
procedure adc_disable_scan_mode(adc:uint32);cdecl;external;
procedure adc_enable_eoc_interrupt_injected(adc:uint32);cdecl;external;
procedure adc_disable_eoc_interrupt_injected(adc:uint32);cdecl;external;
procedure adc_enable_awd_interrupt(adc:uint32);cdecl;external;
procedure adc_disable_awd_interrupt(adc:uint32);cdecl;external;
procedure adc_enable_eoc_interrupt(adc:uint32);cdecl;external;
procedure adc_disable_eoc_interrupt(adc:uint32);cdecl;external;
procedure adc_set_left_aligned(adc:uint32);cdecl;external;
procedure adc_set_right_aligned(adc:uint32);cdecl;external;
function  adc_eoc(adc:uint32):LongBool;cdecl;external;
function  adc_eoc_injected(adc:uint32):LongBool;cdecl;external;
function  adc_read_regular(adc:uint32):uint32;cdecl;external;
function  adc_read_injected(adc:uint32; reg:uint8):uint32;cdecl;external;
procedure adc_set_continuous_conversion_mode(adc:uint32);cdecl;external;
procedure adc_set_single_conversion_mode(adc:uint32);cdecl;external;
procedure adc_set_regular_sequence(adc:uint32; length:uint8; channel:puint8);cdecl;external;
procedure adc_set_injected_sequence(adc:uint32; length:uint8; channel:puint8);cdecl;external;
procedure adc_set_injected_offset(adc:uint32; reg:uint8; offset:uint32);cdecl;external;
procedure adc_set_watchdog_high_threshold(adc:uint32; threshold:uint16);cdecl;external;
procedure adc_set_watchdog_low_threshold(adc:uint32; threshold:uint16);cdecl;external;
procedure adc_start_conversion_regular(adc:uint32);cdecl;external;
procedure adc_start_conversion_injected(adc:uint32);cdecl;external;
procedure adc_enable_dma(adc:uint32);cdecl;external;
procedure adc_disable_dma(adc:uint32);cdecl;external;
function  adc_get_flag(adc:uint32; flag:uint32):LongBool;cdecl;external;
procedure adc_clear_flag(adc:uint32; flag:uint32);cdecl;external;
procedure adc_set_sample_time(adc:uint32; channel:uint8; time:uint8);cdecl;external;
procedure adc_set_sample_time_on_all_channels(adc:uint32; time:uint8);cdecl;external;
procedure adc_disable_external_trigger_regular(adc:uint32);cdecl;external;
procedure adc_disable_external_trigger_injected(adc:uint32);cdecl;external;
procedure adc_set_clk_prescale(prescaler:uint32);cdecl;external;
procedure adc_enable_external_trigger_regular(adc:uint32; trigger:uint32; polarity:uint32);cdecl;external;
procedure adc_enable_external_trigger_injected(adc:uint32; trigger:uint32; polarity:uint32);cdecl;external;
procedure adc_set_resolution(adc:uint32; resolution:uint32);cdecl;external;
procedure adc_enable_overrun_interrupt(adc:uint32);cdecl;external;
procedure adc_disable_overrun_interrupt(adc:uint32);cdecl;external;
function  adc_get_overrun_flag(adc:uint32):LongBool;cdecl;external;
procedure adc_clear_overrun_flag(adc:uint32);cdecl;external;
function  adc_awd(adc:uint32):LongBool;cdecl;external;
procedure adc_eoc_after_each(adc:uint32);cdecl;external;
procedure adc_eoc_after_group(adc:uint32);cdecl;external;
procedure adc_set_dma_continue(adc:uint32);cdecl;external;
procedure adc_set_dma_terminate(adc:uint32);cdecl;external;
procedure adc_enable_temperature_sensor;cdecl;external;
procedure adc_disable_temperature_sensor;cdecl;external;
procedure adc_set_multi_mode(mode:uint32);cdecl;external;
procedure adc_enable_vbat_sensor;cdecl;external;
procedure adc_disable_vbat_sensor;cdecl;external;

procedure dma_stream_reset(dma:uint32; stream:uint8);cdecl;external;
procedure dma_clear_interrupt_flags(dma:uint32; stream:uint8; interrupts:uint32);cdecl;external;
function  dma_get_interrupt_flag(dma:uint32; stream:uint8; interrupt:uint32):LongBool;cdecl;external;
procedure dma_set_transfer_mode(dma:uint32; stream:uint8; direction:uint32);cdecl;external;
procedure dma_set_priority(dma:uint32; stream:uint8; prio:uint32);cdecl;external;
procedure dma_set_memory_size(dma:uint32; stream:uint8; mem_size:uint32);cdecl;external;
procedure dma_set_peripheral_size(dma:uint32; stream:uint8; peripheral_size:uint32);cdecl;external;
procedure dma_enable_memory_increment_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_memory_increment_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_peripheral_increment_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_peripheral_increment_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_fixed_peripheral_increment_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_circular_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_channel_select(dma:uint32; stream:uint8; channel:uint32);cdecl;external;
procedure dma_set_memory_burst(dma:uint32; stream:uint8; burst:uint32);cdecl;external;
procedure dma_set_peripheral_burst(dma:uint32; stream:uint8; burst:uint32);cdecl;external;
procedure dma_set_initial_target(dma:uint32; stream:uint8; memory:uint8);cdecl;external;
function  dma_get_target(dma:uint32; stream:uint8):uint8;cdecl;external;
procedure dma_enable_double_buffer_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_double_buffer_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_set_peripheral_flow_control(dma:uint32; stream:uint8);cdecl;external;
procedure dma_set_dma_flow_control(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_transfer_error_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_transfer_error_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_half_transfer_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_half_transfer_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_transfer_complete_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_transfer_complete_interrupt(dma:uint32; stream:uint8);cdecl;external;
function  dma_fifo_status(dma:uint32; stream:uint8):uint32;cdecl;external;
procedure dma_enable_direct_mode_error_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_direct_mode_error_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_fifo_error_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_fifo_error_interrupt(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_direct_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_enable_fifo_mode(dma:uint32; stream:uint8);cdecl;external;
procedure dma_set_fifo_threshold(dma:uint32; stream:uint8; threshold:uint32);cdecl;external;
procedure dma_enable_stream(dma:uint32; stream:uint8);cdecl;external;
procedure dma_disable_stream(dma:uint32; stream:uint8);cdecl;external;
procedure dma_set_peripheral_address(dma:uint32; stream:uint8; address:uint32);cdecl;external;
procedure dma_set_memory_address(dma:uint32; stream:uint8; address:uint32);cdecl;external;
procedure dma_set_memory_address_1(dma:uint32; stream:uint8; address:uint32);cdecl;external;
function  dma_get_number_of_data(dma:uint32; stream:uint8):uint16;cdecl;external;
procedure dma_set_number_of_data(dma:uint32; stream:uint8; number:uint16);cdecl;external;

procedure gpio_set(gpioport:uint32; gpios:uint16);cdecl;external;
procedure gpio_clear(gpioport:uint32; gpios:uint16);cdecl;external;
function  gpio_get(gpioport:uint32; gpios:uint16):uint16;cdecl;external;
procedure gpio_toggle(gpioport:uint32; gpios:uint16);cdecl;external;
function  gpio_port_read(gpioport:uint32):uint16;cdecl;external;
procedure gpio_port_write(gpioport:uint32; data:uint16);cdecl;external;
procedure gpio_port_config_lock(gpioport:uint32; gpios:uint16);cdecl;external;
procedure gpio_mode_setup(gpioport:uint32; mode:uint8; pull_up_down:uint8; gpios:uint16);cdecl;external;
procedure gpio_set_output_options(gpioport:uint32; otype:uint8; speed:uint8; gpios:uint16);cdecl;external;
procedure gpio_set_af(gpioport:uint32; alt_func_num:uint8; gpios:uint16);cdecl;external;

type
  Ti2c_speeds = (
    i2c_speed_sm_100k,
    i2c_speed_fm_400k,
    i2c_speed_fmp_1m,
    i2c_speed_unknown
  );

procedure i2c_reset(i2c:uint32);cdecl;external;
procedure i2c_peripheral_enable(i2c:uint32);cdecl;external;
procedure i2c_peripheral_disable(i2c:uint32);cdecl;external;
procedure i2c_send_start(i2c:uint32);cdecl;external;
procedure i2c_send_stop(i2c:uint32);cdecl;external;
procedure i2c_clear_stop(i2c:uint32);cdecl;external;
procedure i2c_set_own_7bit_slave_address(i2c:uint32; slave:uint8);cdecl;external;
procedure i2c_set_own_10bit_slave_address(i2c:uint32; slave:uint16);cdecl;external;
procedure i2c_set_own_7bit_slave_address_two(i2c:uint32; slave:uint8);cdecl;external;
procedure i2c_enable_dual_addressing_mode(i2c:uint32);cdecl;external;
procedure i2c_disable_dual_addressing_mode(i2c:uint32);cdecl;external;
procedure i2c_set_clock_frequency(i2c:uint32; freq:uint8);cdecl;external;
procedure i2c_send_data(i2c:uint32; data:uint8);cdecl;external;
procedure i2c_set_fast_mode(i2c:uint32);cdecl;external;
procedure i2c_set_standard_mode(i2c:uint32);cdecl;external;
procedure i2c_set_ccr(i2c:uint32; freq:uint16);cdecl;external;
procedure i2c_set_trise(i2c:uint32; trise:uint16);cdecl;external;
procedure i2c_send_7bit_address(i2c:uint32; slave:uint8; readwrite:uint8);cdecl;external;
function  i2c_get_data(i2c:uint32):uint8;cdecl;external;
procedure i2c_enable_interrupt(i2c:uint32; interrupt:uint32);cdecl;external;
procedure i2c_disable_interrupt(i2c:uint32; interrupt:uint32);cdecl;external;
procedure i2c_enable_ack(i2c:uint32);cdecl;external;
procedure i2c_disable_ack(i2c:uint32);cdecl;external;
procedure i2c_nack_next(i2c:uint32);cdecl;external;
procedure i2c_nack_current(i2c:uint32);cdecl;external;
procedure i2c_set_dutycycle(i2c:uint32; dutycycle:uint32);cdecl;external;
procedure i2c_enable_dma(i2c:uint32);cdecl;external;
procedure i2c_disable_dma(i2c:uint32);cdecl;external;
procedure i2c_set_dma_last_transfer(i2c:uint32);cdecl;external;
procedure i2c_clear_dma_last_transfer(i2c:uint32);cdecl;external;
procedure i2c_transfer7(i2c:uint32; addr:uint8; w:puint8; wn:TSize; r:puint8; rn:TSize);cdecl;external;
procedure i2c_set_speed(i2c:uint32; speed:Ti2c_speeds; clock_megahz:uint32);cdecl;external;

procedure pwr_disable_backup_domain_write_protect;cdecl;external;
procedure pwr_enable_backup_domain_write_protect;cdecl;external;
procedure pwr_enable_power_voltage_detect(pvd_level:uint32);cdecl;external;
procedure pwr_disable_power_voltage_detect;cdecl;external;
procedure pwr_clear_standby_flag;cdecl;external;
procedure pwr_clear_wakeup_flag;cdecl;external;
procedure pwr_set_standby_mode;cdecl;external;
procedure pwr_set_stop_mode;cdecl;external;
procedure pwr_voltage_regulator_on_in_stop;cdecl;external;
procedure pwr_voltage_regulator_low_power_in_stop;cdecl;external;
procedure pwr_enable_wakeup_pin;cdecl;external;
procedure pwr_disable_wakeup_pin;cdecl;external;
function  pwr_voltage_high:LongBool;cdecl;external;
function  pwr_get_standby_flag:LongBool;cdecl;external;
function  pwr_get_wakeup_flag:LongBool;cdecl;external;
type
  Tpwr_vos_scale = (
    PWR_SCALE1 := $3,
    PWR_SCALE2 := $2,
    PWR_SCALE3 := $1
  );


procedure pwr_set_vos_scale(scale:Tpwr_vos_scale);cdecl;external;
var
  rcc_ahb_frequency : uint32;cvar;external;
  rcc_apb1_frequency : uint32;cvar;external;
  rcc_apb2_frequency : uint32;cvar;external;
type
  Trcc_clock_3v3 = (
    RCC_CLOCK_3V3_84MHZ,
    RCC_CLOCK_3V3_168MHZ,
    RCC_CLOCK_3V3_180MHZ,
    RCC_CLOCK_3V3_END
  );

  Prcc_clock_scale = ^Trcc_clock_scale;
  Trcc_clock_scale = record
      pllm : uint8;
      plln : uint16;
      pllp : uint8;
      pllq : uint8;
      pllr : uint8;
      pll_source : uint8;
      flash_config : uint32;
      hpre : uint8;
      ppre1 : uint8;
      ppre2 : uint8;
      voltage_scale : Tpwr_vos_scale;
      ahb_frequency : uint32;
      apb1_frequency : uint32;
      apb2_frequency : uint32;
    end;

(* Const before type ignored *)
  var
    rcc_hsi_configs : array[0..longInt(Trcc_clock_3v3.RCC_CLOCK_3V3_END)-1] of Trcc_clock_scale;cvar;external;
(* Const before type ignored *)
    rcc_hse_8mhz_3v3 : array[0..longInt(Trcc_clock_3v3.RCC_CLOCK_3V3_END)-1] of Trcc_clock_scale;cvar;external;
(* Const before type ignored *)
    rcc_hse_12mhz_3v3 : array[0..longInt(Trcc_clock_3v3.RCC_CLOCK_3V3_END)-1] of Trcc_clock_scale;cvar;external;
(* Const before type ignored *)
    rcc_hse_16mhz_3v3 : array[0..longInt(Trcc_clock_3v3.RCC_CLOCK_3V3_END)-1] of Trcc_clock_scale;cvar;external;
(* Const before type ignored *)
    rcc_hse_25mhz_3v3 : array[0..longInt(Trcc_clock_3v3.RCC_CLOCK_3V3_END)-1] of Trcc_clock_scale;cvar;external;
type
  Trcc_osc = (RCC_PLL,RCC_PLLSAI,RCC_PLLI2S,RCC_HSE,RCC_HSI,
    RCC_LSE,RCC_LSI);

  Trcc_periph_clken = (RCC_GPIOA := ($30 shl 5)+0,RCC_GPIOB := ($30 shl 5)+1,RCC_GPIOC := ($30 shl 5)+2,
    RCC_GPIOD := ($30 shl 5)+3,RCC_GPIOE := ($30 shl 5)+4,RCC_GPIOF := ($30 shl 5)+5,
    RCC_GPIOG := ($30 shl 5)+6,RCC_GPIOH := ($30 shl 5)+7,RCC_GPIOI := ($30 shl 5)+8,
    RCC_GPIOJ := ($30 shl 5)+9,RCC_GPIOK := ($30 shl 5)+10,RCC_CRC := ($30 shl 5)+12,
    RCC_BKPSRAM := ($30 shl 5)+18,RCC_CCMDATARAM := ($30 shl 5)+20,
    RCC_DMA1 := ($30 shl 5)+21,RCC_DMA2 := ($30 shl 5)+22,RCC_DMA2D := ($30 shl 5)+23,
    RCC_ETHMAC := ($30 shl 5)+25,RCC_ETHMACTX := ($30 shl 5)+26,RCC_ETHMACRX := ($30 shl 5)+27,
    RCC_ETHMACPTP := ($30 shl 5)+28,RCC_OTGHS := ($30 shl 5)+29,RCC_OTGHSULPI := ($30 shl 5)+30,
    RCC_DCMI := ($34 shl 5)+0,RCC_CRYP := ($34 shl 5)+4,RCC_HASH := ($34 shl 5)+5,
    RCC_RNG := ($34 shl 5)+6,RCC_OTGFS := ($34 shl 5)+7,RCC_FSMC := ($38 shl 5)+0,
    RCC_FMC := ($38 shl 5)+0,RCC_QUADSPI := ($38 shl 5)+1,RCC_TIM2 := ($40 shl 5)+0,
    RCC_TIM3 := ($40 shl 5)+1,RCC_TIM4 := ($40 shl 5)+2,RCC_TIM5 := ($40 shl 5)+3,
    RCC_TIM6 := ($40 shl 5)+4,RCC_TIM7 := ($40 shl 5)+5,RCC_TIM12 := ($40 shl 5)+6,
    RCC_TIM13 := ($40 shl 5)+7,RCC_TIM14 := ($40 shl 5)+8,RCC_WWDG := ($40 shl 5)+11,
    RCC_SPI2 := ($40 shl 5)+14,RCC_SPI3 := ($40 shl 5)+15,RCC_USART2 := ($40 shl 5)+17,
    RCC_USART3 := ($40 shl 5)+18,RCC_UART4 := ($40 shl 5)+19,RCC_UART5 := ($40 shl 5)+20,
    RCC_I2C1 := ($40 shl 5)+21,RCC_I2C2 := ($40 shl 5)+22,RCC_I2C3 := ($40 shl 5)+23,
    RCC_CAN1 := ($40 shl 5)+25,RCC_CAN2 := ($40 shl 5)+26,RCC_PWR := ($40 shl 5)+28,
    RCC_DAC := ($40 shl 5)+29,RCC_UART7 := ($40 shl 5)+30,RCC_UART8 := ($40 shl 5)+31,
    RCC_TIM1 := ($44 shl 5)+0,RCC_TIM8 := ($44 shl 5)+1,RCC_USART1 := ($44 shl 5)+4,
    RCC_USART6 := ($44 shl 5)+5,RCC_ADC1 := ($44 shl 5)+8,RCC_ADC2 := ($44 shl 5)+9,
    RCC_ADC3 := ($44 shl 5)+10,RCC_SDIO := ($44 shl 5)+11,RCC_SPI1 := ($44 shl 5)+12,
    RCC_SPI4 := ($44 shl 5)+13,RCC_SYSCFG := ($44 shl 5)+14,RCC_TIM9 := ($44 shl 5)+16,
    RCC_TIM10 := ($44 shl 5)+17,RCC_TIM11 := ($44 shl 5)+18,RCC_SPI5 := ($44 shl 5)+20,
    RCC_SPI6 := ($44 shl 5)+21,RCC_SAI1EN := ($44 shl 5)+22,RCC_LTDC := ($44 shl 5)+26,
    RCC_DSI := ($44 shl 5)+27,RCC_RTC := ($70 shl 5)+15,SCC_GPIOA := ($50 shl 5)+0,
    SCC_GPIOB := ($50 shl 5)+1,SCC_GPIOC := ($50 shl 5)+2,SCC_GPIOD := ($50 shl 5)+3,
    SCC_GPIOE := ($50 shl 5)+4,SCC_GPIOF := ($50 shl 5)+5,SCC_GPIOG := ($50 shl 5)+6,
    SCC_GPIOH := ($50 shl 5)+7,SCC_GPIOI := ($50 shl 5)+8,SCC_GPIOJ := ($50 shl 5)+9,
    SCC_GPIOK := ($50 shl 5)+10,SCC_CRC := ($50 shl 5)+12,SCC_FLTIF := ($50 shl 5)+15,
    SCC_SRAM1 := ($50 shl 5)+16,SCC_SRAM2 := ($50 shl 5)+17,SCC_BKPSRAM := ($50 shl 5)+18,
    SCC_SRAM3 := ($50 shl 5)+19,SCC_DMA1 := ($50 shl 5)+21,SCC_DMA2 := ($50 shl 5)+22,
    SCC_DMA2D := ($50 shl 5)+23,SCC_ETHMAC := ($50 shl 5)+25,SCC_ETHMACTX := ($50 shl 5)+26,
    SCC_ETHMACRX := ($50 shl 5)+27,SCC_ETHMACPTP := ($50 shl 5)+28,
    SCC_OTGHS := ($50 shl 5)+29,SCC_OTGHSULPI := ($50 shl 5)+30,SCC_DCMI := ($54 shl 5)+0,
    SCC_CRYP := ($54 shl 5)+4,SCC_HASH := ($54 shl 5)+5,SCC_RNG := ($54 shl 5)+6,
    SCC_OTGFS := ($54 shl 5)+7,SCC_QSPIC := ($58 shl 5)+1,SCC_FMC := ($58 shl 5)+0,
    SCC_FSMC := ($58 shl 5)+0,SCC_TIM2 := ($60 shl 5)+0,SCC_TIM3 := ($60 shl 5)+1,
    SCC_TIM4 := ($60 shl 5)+2,SCC_TIM5 := ($60 shl 5)+3,SCC_TIM6 := ($60 shl 5)+4,
    SCC_TIM7 := ($60 shl 5)+5,SCC_TIM12 := ($60 shl 5)+6,SCC_TIM13 := ($60 shl 5)+7,
    SCC_TIM14 := ($60 shl 5)+8,SCC_WWDG := ($60 shl 5)+11,SCC_SPI2 := ($60 shl 5)+14,
    SCC_SPI3 := ($60 shl 5)+15,SCC_USART2 := ($60 shl 5)+17,SCC_USART3 := ($60 shl 5)+18,
    SCC_UART4 := ($60 shl 5)+19,SCC_UART5 := ($60 shl 5)+20,SCC_I2C1 := ($60 shl 5)+21,
    SCC_I2C2 := ($60 shl 5)+22,SCC_I2C3 := ($60 shl 5)+23,SCC_CAN1 := ($60 shl 5)+25,
    SCC_CAN2 := ($60 shl 5)+26,SCC_PWR := ($60 shl 5)+28,SCC_DAC := ($60 shl 5)+29,
    SCC_UART7 := ($60 shl 5)+30,SCC_UART8 := ($60 shl 5)+31,SCC_TIM1 := ($64 shl 5)+0,
    SCC_TIM8 := ($64 shl 5)+1,SCC_USART1 := ($64 shl 5)+4,SCC_USART6 := ($64 shl 5)+5,
    SCC_ADC1 := ($64 shl 5)+8,SCC_ADC2 := ($64 shl 5)+9,SCC_ADC3 := ($64 shl 5)+10,
    SCC_SDIO := ($64 shl 5)+11,SCC_SPI1 := ($64 shl 5)+12,SCC_SPI4 := ($64 shl 5)+13,
    SCC_SYSCFG := ($64 shl 5)+14,SCC_TIM9 := ($64 shl 5)+16,SCC_TIM10 := ($64 shl 5)+17,
    SCC_TIM11 := ($64 shl 5)+18,SCC_SPI5 := ($64 shl 5)+20,SCC_SPI6 := ($64 shl 5)+21,
    SCC_SAI1 := ($64 shl 5)+22,SCC_LTDC := ($64 shl 5)+26,SCC_DSI := ($64 shl 5)+27
    );

  Trcc_periph_rst = (RST_GPIOA := ($10 shl 5)+0,RST_GPIOB := ($10 shl 5)+1,RST_GPIOC := ($10 shl 5)+2,
    RST_GPIOD := ($10 shl 5)+3,RST_GPIOE := ($10 shl 5)+4,RST_GPIOF := ($10 shl 5)+5,
    RST_GPIOG := ($10 shl 5)+6,RST_GPIOH := ($10 shl 5)+7,RST_GPIOI := ($10 shl 5)+8,
    RST_GPIOJ := ($10 shl 5)+9,RST_GPIOK := ($10 shl 5)+10,RST_CRC := ($10 shl 5)+12,
    RST_DMA1 := ($10 shl 5)+21,RST_DMA2 := ($10 shl 5)+22,RST_DMA2D := ($10 shl 5)+23,
    RST_ETHMAC := ($10 shl 5)+25,RST_OTGHS := ($10 shl 5)+29,RST_DCMI := ($14 shl 5)+0,
    RST_CRYP := ($14 shl 5)+4,RST_HASH := ($14 shl 5)+5,RST_RNG := ($14 shl 5)+6,
    RST_OTGFS := ($14 shl 5)+7,RST_QSPI := ($18 shl 5)+1,RST_FSMC := ($18 shl 5)+0,
    RST_FMC := ($18 shl 5)+0,RST_TIM2 := ($20 shl 5)+0,RST_TIM3 := ($20 shl 5)+1,
    RST_TIM4 := ($20 shl 5)+2,RST_TIM5 := ($20 shl 5)+3,RST_TIM6 := ($20 shl 5)+4,
    RST_TIM7 := ($20 shl 5)+5,RST_TIM12 := ($20 shl 5)+6,RST_TIM13 := ($20 shl 5)+7,
    RST_TIM14 := ($20 shl 5)+8,RST_WWDG := ($20 shl 5)+11,RST_SPI2 := ($20 shl 5)+14,
    RST_SPI3 := ($20 shl 5)+15,RST_USART2 := ($20 shl 5)+17,RST_USART3 := ($20 shl 5)+18,
    RST_UART4 := ($20 shl 5)+19,RST_UART5 := ($20 shl 5)+20,RST_I2C1 := ($20 shl 5)+21,
    RST_I2C2 := ($20 shl 5)+22,RST_I2C3 := ($20 shl 5)+23,RST_CAN1 := ($20 shl 5)+25,
    RST_CAN2 := ($20 shl 5)+26,RST_PWR := ($20 shl 5)+28,RST_DAC := ($20 shl 5)+29,
    RST_UART7 := ($20 shl 5)+30,RST_UART8 := ($20 shl 5)+31,RST_TIM1 := ($24 shl 5)+0,
    RST_TIM8 := ($24 shl 5)+1,RST_USART1 := ($24 shl 5)+4,RST_USART6 := ($24 shl 5)+5,
    RST_ADC := ($24 shl 5)+8,RST_SDIO := ($24 shl 5)+11,RST_SPI1 := ($24 shl 5)+12,
    RST_SPI4 := ($24 shl 5)+13,RST_SYSCFG := ($24 shl 5)+14,RST_TIM9 := ($24 shl 5)+16,
    RST_TIM10 := ($24 shl 5)+17,RST_TIM11 := ($24 shl 5)+18,RST_SPI5 := ($24 shl 5)+20,
    RST_SPI6 := ($24 shl 5)+21,RST_SAI1RST := ($24 shl 5)+22,RST_LTDC := ($24 shl 5)+26,
    RST_DSI := ($24 shl 5)+27);


procedure rcc_peripheral_enable_clock(reg:puint32; en:uint32);cdecl;external;
procedure rcc_peripheral_disable_clock(reg:puint32; en:uint32);cdecl;external;
procedure rcc_peripheral_reset(reg:puint32; reset:uint32);cdecl;external;
procedure rcc_peripheral_clear_reset(reg:puint32; clear_reset:uint32);cdecl;external;
procedure rcc_periph_clock_enable(clken:Trcc_periph_clken);cdecl;external;
procedure rcc_periph_clock_disable(clken:Trcc_periph_clken);cdecl;external;
procedure rcc_periph_reset_pulse(rst:Trcc_periph_rst);cdecl;external;
procedure rcc_periph_reset_hold(rst:Trcc_periph_rst);cdecl;external;
procedure rcc_periph_reset_release(rst:Trcc_periph_rst);cdecl;external;
procedure rcc_set_mco(mcosrc:uint32);cdecl;external;
procedure rcc_osc_bypass_enable(osc:Trcc_osc);cdecl;external;
procedure rcc_osc_bypass_disable(osc:Trcc_osc);cdecl;external;
function  rcc_is_osc_ready(osc:Trcc_osc):LongBool;cdecl;external;
procedure rcc_wait_for_osc_ready(osc:Trcc_osc);cdecl;external;
procedure rcc_osc_ready_int_clear(osc:Trcc_osc);cdecl;external;
procedure rcc_osc_ready_int_enable(osc:Trcc_osc);cdecl;external;
procedure rcc_osc_ready_int_disable(osc:Trcc_osc);cdecl;external;
function  rcc_osc_ready_int_flag(osc:Trcc_osc):longint;cdecl;external;
procedure rcc_css_int_clear;cdecl;external;
function  rcc_css_int_flag:longint;cdecl;external;
procedure rcc_wait_for_sysclk_status(osc:Trcc_osc);cdecl;external;
procedure rcc_osc_on(osc:Trcc_osc);cdecl;external;
procedure rcc_osc_off(osc:Trcc_osc);cdecl;external;
procedure rcc_css_enable;cdecl;external;
procedure rcc_css_disable;cdecl;external;
procedure rcc_plli2s_config(n:uint16; r:uint8);cdecl;external;
procedure rcc_pllsai_config(n:uint16; p:uint16; q:uint16; r:uint16);cdecl;external;
procedure rcc_pllsai_postscalers(q:uint8; r:uint8);cdecl;external;
procedure rcc_set_sysclk_source(clk:uint32);cdecl;external;
procedure rcc_set_pll_source(pllsrc:uint32);cdecl;external;
procedure rcc_set_ppre2(ppre2:uint32);cdecl;external;
procedure rcc_set_ppre1(ppre1:uint32);cdecl;external;
procedure rcc_set_hpre(hpre:uint32);cdecl;external;
procedure rcc_set_rtcpre(rtcpre:uint32);cdecl;external;
procedure rcc_set_main_pll_hsi(pllm:uint32; plln:uint32; pllp:uint32; pllq:uint32; pllr:uint32);cdecl;external;
procedure rcc_set_main_pll_hse(pllm:uint32; plln:uint32; pllp:uint32; pllq:uint32; pllr:uint32);cdecl;external;
function  rcc_system_clock_source:uint32;cdecl;external;
(* Const before type ignored *)
procedure rcc_clock_setup_pll(clock:Prcc_clock_scale);cdecl;external;

procedure spi_reset(spi_peripheral:uint32);cdecl;external;
procedure spi_enable(spi:uint32);cdecl;external;
procedure spi_disable(spi:uint32);cdecl;external;
function  spi_clean_disable(spi:uint32):uint16;cdecl;external;
procedure spi_write(spi:uint32; data:uint16);cdecl;external;
procedure spi_send(spi:uint32; data:uint16);cdecl;external;
function  spi_read(spi:uint32):uint16;cdecl;external;
function  spi_xfer(spi:uint32; data:uint16):uint16;cdecl;external;
procedure spi_set_bidirectional_mode(spi:uint32);cdecl;external;
procedure spi_set_unidirectional_mode(spi:uint32);cdecl;external;
procedure spi_set_bidirectional_receive_only_mode(spi:uint32);cdecl;external;
procedure spi_set_bidirectional_transmit_only_mode(spi:uint32);cdecl;external;
procedure spi_enable_crc(spi:uint32);cdecl;external;
procedure spi_disable_crc(spi:uint32);cdecl;external;
procedure spi_set_next_tx_from_buffer(spi:uint32);cdecl;external;
procedure spi_set_next_tx_from_crc(spi:uint32);cdecl;external;
procedure spi_set_full_duplex_mode(spi:uint32);cdecl;external;
procedure spi_set_receive_only_mode(spi:uint32);cdecl;external;
procedure spi_disable_software_slave_management(spi:uint32);cdecl;external;
procedure spi_enable_software_slave_management(spi:uint32);cdecl;external;
procedure spi_set_nss_high(spi:uint32);cdecl;external;
procedure spi_set_nss_low(spi:uint32);cdecl;external;
procedure spi_send_lsb_first(spi:uint32);cdecl;external;
procedure spi_send_msb_first(spi:uint32);cdecl;external;
procedure spi_set_baudrate_prescaler(spi:uint32; baudrate:uint8);cdecl;external;
procedure spi_set_master_mode(spi:uint32);cdecl;external;
procedure spi_set_slave_mode(spi:uint32);cdecl;external;
procedure spi_set_clock_polarity_1(spi:uint32);cdecl;external;
procedure spi_set_clock_polarity_0(spi:uint32);cdecl;external;
procedure spi_set_clock_phase_1(spi:uint32);cdecl;external;
procedure spi_set_clock_phase_0(spi:uint32);cdecl;external;
procedure spi_enable_tx_buffer_empty_interrupt(spi:uint32);cdecl;external;
procedure spi_disable_tx_buffer_empty_interrupt(spi:uint32);cdecl;external;
procedure spi_enable_rx_buffer_not_empty_interrupt(spi:uint32);cdecl;external;
procedure spi_disable_rx_buffer_not_empty_interrupt(spi:uint32);cdecl;external;
procedure spi_enable_error_interrupt(spi:uint32);cdecl;external;
procedure spi_disable_error_interrupt(spi:uint32);cdecl;external;
procedure spi_enable_ss_output(spi:uint32);cdecl;external;
procedure spi_disable_ss_output(spi:uint32);cdecl;external;
procedure spi_enable_tx_dma(spi:uint32);cdecl;external;
procedure spi_disable_tx_dma(spi:uint32);cdecl;external;
procedure spi_enable_rx_dma(spi:uint32);cdecl;external;
procedure spi_disable_rx_dma(spi:uint32);cdecl;external;
procedure spi_set_standard_mode(spi:uint32; mode:uint8);cdecl;external;
function  spi_init_master(spi:uint32; br:uint32; cpol:uint32; cpha:uint32; dff:uint32; lsbfirst:uint32):longint;cdecl;external;
procedure spi_set_dff_8bit(spi:uint32);cdecl;external;
procedure spi_set_dff_16bit(spi:uint32);cdecl;external;
procedure spi_set_frf_ti(spi:uint32);cdecl;external;
procedure spi_set_frf_motorola(spi:uint32);cdecl;external;

type
  Ttim_oc_id = (
    TIM_OC1 := 0,
    TIM_OC1N,
    TIM_OC2,
    TIM_OC2N,
    TIM_OC3,
    TIM_OC3N,
    TIM_OC4
  );

  Ttim_oc_mode = (
    TIM_OCM_FROZEN,
    TIM_OCM_ACTIVE,
    TIM_OCM_INACTIVE,
    TIM_OCM_TOGGLE,
    TIM_OCM_FORCE_LOW,
    TIM_OCM_FORCE_HIGH,
    TIM_OCM_PWM1,
    TIM_OCM_PWM2
  );

  Ttim_ic_id = (
    TIM_IC1,
    TIM_IC2,
    TIM_IC3,
    TIM_IC4
  );

  Ttim_ic_filter = (
    TIM_IC_OFF,
    TIM_IC_CK_INT_N_2,
    TIM_IC_CK_INT_N_4,
    TIM_IC_CK_INT_N_8,
    TIM_IC_DTF_DIV_2_N_6,
    TIM_IC_DTF_DIV_2_N_8,
    TIM_IC_DTF_DIV_4_N_6,
    TIM_IC_DTF_DIV_4_N_8,
    TIM_IC_DTF_DIV_8_N_6,
    TIM_IC_DTF_DIV_8_N_8,
    TIM_IC_DTF_DIV_16_N_5,
    TIM_IC_DTF_DIV_16_N_6,
    TIM_IC_DTF_DIV_16_N_8,
    TIM_IC_DTF_DIV_32_N_5,
    TIM_IC_DTF_DIV_32_N_6,
    TIM_IC_DTF_DIV_32_N_8
  );

  Ttim_ic_psc = (
    TIM_IC_PSC_OFF,
    TIM_IC_PSC_2,
    TIM_IC_PSC_4,
    TIM_IC_PSC_8
  );

  Ttim_ic_input = (
    TIM_IC_OUT := 0,
    TIM_IC_IN_TI1 := 1,
    TIM_IC_IN_TI2 := 2,
    TIM_IC_IN_TRC := 3,
    TIM_IC_IN_TI3 := 5,
    TIM_IC_IN_TI4 := 6
  );

  Ttim_et_pol = (
    TIM_ET_RISING,
    TIM_ET_FALLING
  );

  Ttim_ic_pol = (
    TIM_IC_RISING,
    TIM_IC_FALLING,
    TIM_IC_BOTH
  );

procedure timer_enable_irq(timer_peripheral:uint32; irq:uint32);cdecl;external;
procedure timer_disable_irq(timer_peripheral:uint32; irq:uint32);cdecl;external;
function  timer_interrupt_source(timer_peripheral:uint32; flag:uint32):LongBool;cdecl;external;
function  timer_get_flag(timer_peripheral:uint32; flag:uint32):LongBool;cdecl;external;
procedure timer_clear_flag(timer_peripheral:uint32; flag:uint32);cdecl;external;
procedure timer_set_mode(timer_peripheral:uint32; clock_div:uint32; alignment:uint32; direction:uint32);cdecl;external;
procedure timer_set_clock_division(timer_peripheral:uint32; clock_div:uint32);cdecl;external;
procedure timer_enable_preload(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_preload(timer_peripheral:uint32);cdecl;external;
procedure timer_set_alignment(timer_peripheral:uint32; alignment:uint32);cdecl;external;
procedure timer_direction_up(timer_peripheral:uint32);cdecl;external;
procedure timer_direction_down(timer_peripheral:uint32);cdecl;external;
procedure timer_one_shot_mode(timer_peripheral:uint32);cdecl;external;
procedure timer_continuous_mode(timer_peripheral:uint32);cdecl;external;
procedure timer_update_on_any(timer_peripheral:uint32);cdecl;external;
procedure timer_update_on_overflow(timer_peripheral:uint32);cdecl;external;
procedure timer_enable_update_event(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_update_event(timer_peripheral:uint32);cdecl;external;
procedure timer_enable_counter(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_counter(timer_peripheral:uint32);cdecl;external;
procedure timer_set_output_idle_state(timer_peripheral:uint32; outputs:uint32);cdecl;external;
procedure timer_reset_output_idle_state(timer_peripheral:uint32; outputs:uint32);cdecl;external;
procedure timer_set_ti1_ch123_xor(timer_peripheral:uint32);cdecl;external;
procedure timer_set_ti1_ch1(timer_peripheral:uint32);cdecl;external;
procedure timer_set_master_mode(timer_peripheral:uint32; mode:uint32);cdecl;external;
procedure timer_set_dma_on_compare_event(timer_peripheral:uint32);cdecl;external;
procedure timer_set_dma_on_update_event(timer_peripheral:uint32);cdecl;external;
procedure timer_enable_compare_control_update_on_trigger(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_compare_control_update_on_trigger(timer_peripheral:uint32);cdecl;external;
procedure timer_enable_preload_complementry_enable_bits(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_preload_complementry_enable_bits(timer_peripheral:uint32);cdecl;external;
procedure timer_set_prescaler(timer_peripheral:uint32; value:uint32);cdecl;external;
procedure timer_set_repetition_counter(timer_peripheral:uint32; value:uint32);cdecl;external;
procedure timer_set_period(timer_peripheral:uint32; period:uint32);cdecl;external;
procedure timer_enable_oc_clear(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_disable_oc_clear(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_fast_mode(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_slow_mode(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_mode(timer_peripheral:uint32; oc_id:Ttim_oc_id; oc_mode:Ttim_oc_mode);cdecl;external;
procedure timer_enable_oc_preload(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_disable_oc_preload(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_polarity_high(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_polarity_low(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_enable_oc_output(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_disable_oc_output(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_idle_state_set(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_idle_state_unset(timer_peripheral:uint32; oc_id:Ttim_oc_id);cdecl;external;
procedure timer_set_oc_value(timer_peripheral:uint32; oc_id:Ttim_oc_id; value:uint32);cdecl;external;
procedure timer_enable_break_main_output(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_break_main_output(timer_peripheral:uint32);cdecl;external;
procedure timer_enable_break_automatic_output(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_break_automatic_output(timer_peripheral:uint32);cdecl;external;
procedure timer_set_break_polarity_high(timer_peripheral:uint32);cdecl;external;
procedure timer_set_break_polarity_low(timer_peripheral:uint32);cdecl;external;
procedure timer_enable_break(timer_peripheral:uint32);cdecl;external;
procedure timer_disable_break(timer_peripheral:uint32);cdecl;external;
procedure timer_set_enabled_off_state_in_run_mode(timer_peripheral:uint32);cdecl;external;
procedure timer_set_disabled_off_state_in_run_mode(timer_peripheral:uint32);cdecl;external;
procedure timer_set_enabled_off_state_in_idle_mode(timer_peripheral:uint32);cdecl;external;
procedure timer_set_disabled_off_state_in_idle_mode(timer_peripheral:uint32);cdecl;external;
procedure timer_set_break_lock(timer_peripheral:uint32; lock:uint32);cdecl;external;
procedure timer_set_deadtime(timer_peripheral:uint32; deadtime:uint32);cdecl;external;
procedure timer_generate_event(timer_peripheral:uint32; event:uint32);cdecl;external;
function  timer_get_counter(timer_peripheral:uint32):uint32;cdecl;external;
procedure timer_set_counter(timer_peripheral:uint32; count:uint32);cdecl;external;
procedure timer_ic_set_filter(timer:uint32; ic:Ttim_ic_id; flt:Ttim_ic_filter);cdecl;external;
procedure timer_ic_set_prescaler(timer:uint32; ic:Ttim_ic_id; psc:Ttim_ic_psc);cdecl;external;
procedure timer_ic_set_input(timer:uint32; ic:Ttim_ic_id; &in:Ttim_ic_input);cdecl;external;
procedure timer_ic_enable(timer:uint32; ic:Ttim_ic_id);cdecl;external;
procedure timer_ic_disable(timer:uint32; ic:Ttim_ic_id);cdecl;external;
procedure timer_slave_set_filter(timer:uint32; flt:Ttim_ic_filter);cdecl;external;
procedure timer_slave_set_prescaler(timer:uint32; psc:Ttim_ic_psc);cdecl;external;
procedure timer_slave_set_polarity(timer:uint32; pol:Ttim_et_pol);cdecl;external;
procedure timer_slave_set_mode(timer:uint32; mode:uint8);cdecl;external;
procedure timer_slave_set_trigger(timer:uint32; trigger:uint8);cdecl;external;
procedure timer_set_option(timer_peripheral:uint32; option:uint32);cdecl;external;
procedure timer_ic_set_polarity(timer:uint32; ic:Ttim_ic_id; pol:Ttim_ic_pol);cdecl;external;

procedure usart_set_baudrate(usart:uint32; baud:uint32);cdecl;external;
procedure usart_set_databits(usart:uint32; bits:uint32);cdecl;external;
procedure usart_set_stopbits(usart:uint32; stopbits:uint32);cdecl;external;
procedure usart_set_parity(usart:uint32; parity:uint32);cdecl;external;
procedure usart_set_mode(usart:uint32; mode:uint32);cdecl;external;
procedure usart_set_flow_control(usart:uint32; flowcontrol:uint32);cdecl;external;
procedure usart_enable(usart:uint32);cdecl;external;
procedure usart_disable(usart:uint32);cdecl;external;
procedure usart_send(usart:uint32; data:uint16);cdecl;external;
function  usart_recv(usart:uint32):uint16;cdecl;external;
procedure usart_wait_send_ready(usart:uint32);cdecl;external;
procedure usart_wait_recv_ready(usart:uint32);cdecl;external;
procedure usart_send_blocking(usart:uint32; data:uint16);cdecl;external;
function  usart_recv_blocking(usart:uint32):uint16;cdecl;external;
procedure usart_enable_rx_dma(usart:uint32);cdecl;external;
procedure usart_disable_rx_dma(usart:uint32);cdecl;external;
procedure usart_enable_tx_dma(usart:uint32);cdecl;external;
procedure usart_disable_tx_dma(usart:uint32);cdecl;external;
procedure usart_enable_rx_interrupt(usart:uint32);cdecl;external;
procedure usart_disable_rx_interrupt(usart:uint32);cdecl;external;
procedure usart_enable_tx_interrupt(usart:uint32);cdecl;external;
procedure usart_disable_tx_interrupt(usart:uint32);cdecl;external;
procedure usart_enable_error_interrupt(usart:uint32);cdecl;external;
procedure usart_disable_error_interrupt(usart:uint32);cdecl;external;
function  usart_get_flag(usart:uint32; flag:uint32):LongBool;cdecl;external;

implementation

end.
