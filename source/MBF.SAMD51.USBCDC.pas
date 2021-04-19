unit MBF.SAMD51.USBCDC;

{$WARN 4055 off : Conversion between ordinals and pointers is not portable}

interface

{$include MBF.Config.inc}

procedure CoreUSBHardwareInit; cdecl; external name 'usb_hardware_init';
procedure CoreUSBInit; cdecl; external name 'tusb_init';
procedure CoreUSBTask; cdecl; external name 'tud_task';

function tud_cdc_connected(itf:byte):boolean; cdecl; external name 'tud_cdc_n_connected';
function tud_cdc_get_line_state:byte; cdecl; external name 'tud_cdc_get_line_state';
function tud_cdc_available(itf:byte):dword; cdecl; external name 'tud_cdc_n_available';
function tud_cdc_read(itf:byte; buffer:pbyte; bufsize:dword):dword; cdecl; external name 'tud_cdc_n_read';

function tud_cdc_n_write(itf:byte;ch:pbyte;bufsize:dword):dword; cdecl; external name 'tud_cdc_n_write';
function tud_cdc_write_flush(itf:byte):dword; cdecl; external name 'tud_cdc_n_write_flush';
function tud_cdc_write(itf:byte; buffer:pbyte; bufsize:dword):dword; cdecl; external name 'tud_cdc_n_write';

implementation

procedure tud_cdc_line_state_cb(itf:byte;dtr,rts:boolean); [public, alias: 'tud_cdc_line_state_cb'];
const
  WELCOME:ansistring='TinyUSB CDC MSC device with FreeRTOS example'#13#10;
begin
  if tud_cdc_connected(0) then
  //if dtr then
  begin
    // print initial message when connected
    tud_cdc_write(0,PByte(WELCOME),Length(WELCOME));
    tud_cdc_write_flush(0);
  end;
end;

end.
