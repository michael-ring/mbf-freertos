unit MBF.SAMD51.USBHID;

{$WARN 4055 off : Conversion between ordinals and pointers is not portable}

interface

{$include MBF.Config.inc}

type
  THIDReport =  (HID_REPORT_TYPE_INVALID,HID_REPORT_TYPE_INPUT,HID_REPORT_TYPE_OUTPUT,HID_REPORT_TYPE_FEATURE);

procedure CoreUSBHardwareInit; cdecl; external name 'usb_hardware_init';
procedure CoreUSBInit; cdecl; external name 'tusb_init';
procedure CoreUSBTask; cdecl; external name 'tud_task';

function tud_hid_ready:boolean; cdecl; external name 'tud_hid_ready';
function tud_hid_boot_mode:boolean; cdecl; external name 'tud_hid_boot_mode';
function tud_hid_report(report_id:byte; report:pointer; len:byte):boolean; cdecl; external name 'tud_hid_report';

implementation

end.
