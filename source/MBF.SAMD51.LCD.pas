unit MBF.SAMD51.LCD;

{$WARN 4055 off : Conversion between ordinals and pointers is not portable}

interface

{$include MBF.Config.inc}

const
  //These enumerate the text plotting alignment (reference datum point)
  TL_DATUM       = 0;    // Top left (default)
  TC_DATUM       = 1;    // Top centre
  TR_DATUM       = 2;    // Top right
  ML_DATUM       = 3;    // Middle left
  CL_DATUM       = 3;    // Centre left, same as above
  MC_DATUM       = 4;    // Middle centre
  CC_DATUM       = 4;    // Centre centre, same as above
  MR_DATUM       = 5;    // Middle right
  CR_DATUM       = 5;    // Centre right, same as above
  BL_DATUM       = 6;    // Bottom left
  BC_DATUM       = 7;    // Bottom centre
  BR_DATUM       = 8;    // Bottom right
  L_BASELINE     = 9;    // Left character baseline (Line the 'A' character would sit on)
  C_BASELINE     = 10;   // Centre character baseline
  R_BASELINE     = 11;   // Right character baseline

  // New color definitions use for all my libraries
  TFT_BLACK             = $0000;       //   0,   0,   0
  TFT_NAVY              = $000F;       //   0,   0, 128
  TFT_DARKGREEN         = $03E0;       //   0, 128,   0
  TFT_DARKCYAN          = $03EF;       //   0, 128, 128
  TFT_MAROON            = $7800;       // 128,   0,   0
  TFT_PURPLE            = $780F;       // 128,   0, 128
  TFT_OLIVE             = $7BE0;       // 128, 128,   0
  TFT_LIGHTGREY         = $C618;       // 192, 192, 192
  TFT_DARKGREY          = $7BEF;       // 128, 128, 128
  TFT_BLUE              = $001F;       //   0,   0, 255
  TFT_GREEN             = $07E0;       //   0, 255,   0
  TFT_CYAN              = $07FF;       //   0, 255, 255
  TFT_RED               = $F800;       // 255,   0,   0
  TFT_MAGENTA           = $F81F;       // 255,   0, 255
  TFT_YELLOW            = $FFE0;       // 255, 255,   0
  TFT_WHITE             = $FFFF;       // 255, 255, 255
  TFT_ORANGE            = $FDA0;       // 255, 180,   0
  TFT_GREENYELLOW       = $B7E0;       // 180, 255,   0
  TFT_PINK              = $FC9F;
  TFT_LIGHTYELLOW       = $FFF3;       // 255, 255,   155

  // Next is a special 16 bit colour value that encodes to 8 bits
  // and will then decode back to the same 16 bit value.
  // Convenient for 8 bit and 16 bit transparent sprites.
  TFT_TRANSPARENT       = $0120;


type
  TTEXTFONT = (GLCD,GFXFF,FONT2,FONT3,FONT4,FONT5,FONT6,FONT7,FONT8);
  TGFXFONT  = (FF0,TT1,
               FF1,FF2,FF3,FF4,FF5,FF6,FF7,FF8,FF9,FF10,
               FF11,FF12,FF13,FF14,FF15,FF16,FF17,FF18,FF19,FF20,
               FF21,FF22,FF23,FF24,FF25,FF26,FF27,FF28,FF29,FF30,
               FF31,FF32,FF33,FF34,FF35,FF36,FF37,FF38,FF39,FF40,
               FF41,FF42,FF43,FF44,FF45,FF46,FF47,FF48
  );
const
  FONTNAMES:array[TGFXFONT] of string = (
  'GLCD', 'Tom Thumb',
  'Mono 9', 'Mono 12', 'Mono 18', 'Mono 24', 'Mono bold 9', 'Mono bold 12', 'Mono bold 18', 'Mono bold 24', 'Mono oblique 9', 'Mono oblique 12',
  'Mono oblique 18', 'Mono oblique 24', 'Mono bold oblique 9', 'Mono bold oblique 12', 'Mono bold oblique 18', 'Mono bold obl. 24', 'Sans 9', 'Sans 12', 'Sans 18', 'Sans 24',
  'Sans bold 9', 'Sans bold 12', 'Sans bold 18', 'Sans bold 24', 'Sans oblique 9', 'Sans oblique 12', 'Sans oblique 18', 'Sans oblique 24', 'Sans bold oblique 9', 'Sans bold oblique 12',
  'Sans bold oblique 18', 'Sans bold oblique 24', 'Serif 9', 'Serif 12', 'Serif 18', 'Serif 24', 'Serif italic 9', 'Serif italic 12', 'Serif italic 18', 'Serif italic 24',
  'Serif bold 9', 'Serif bold 12', 'Serif bold 18', 'Serif bold 24', 'Serif bold italic 9', 'Serif bold italic 12', 'Serif bold italic 18', 'Serif bold italic 24'
  );

type
  TFTHandle = THandle;
  SpriteHandle = THandle;

procedure TFTCreate;
procedure TFTFree;

procedure initTFT;

procedure setRotation(r:byte);
procedure invertDisplay(i:boolean);
procedure fillScreen(color:dword);

procedure drawPixel(x,y: integer; color:dword);
procedure drawLine(x0,y0,x1,y1: integer; color:dword);
procedure drawRect(x,y,w,h: integer; color:dword);
procedure fillRect(x,y,w,h: integer; color:dword);
procedure drawRoundRect(x,y,w,h,r: integer; color:dword);
procedure fillRoundRect(x,y,w,h,r: integer; color:dword);
procedure drawCircle(x0,y0,r: integer; color:dword);
procedure fillCircle(x0,y0,r: integer; color:dword);

function  color565(red,green,blue:byte):word;
procedure setTextColor(color:word);overload;
procedure setTextColor(fgcolor,bgcolor:word);overload;
procedure setTextSize(size:byte);

function  textWidth(line:pchar; font:TTEXTFONT=TTEXTFONT.GLCD):smallint;
function  fontHeight(font:TTEXTFONT=TTEXTFONT.GLCD):smallint;

procedure setGFXFont(font:TGFXFONT=TGFXFONT.FF0);
procedure setTextFont(font:TTEXTFONT=TTEXTFONT.FONT2);

function  drawChar(uniCode:word; x,y:integer; font:TTEXTFONT=TTEXTFONT.GLCD):smallint;
procedure drawCharEx(x,y:integer; c:word; color,bg:dword; size:byte);
function  drawString(line:pchar; x,y:integer; font:TTEXTFONT=TTEXTFONT.GLCD):smallint;
function  drawNumber(long_num:longint; poX,poY:integer; font:TTEXTFONT=TTEXTFONT.GLCD):smallint;
function  drawFloat(floatNumber:valreal;decimal:byte; poX,poY:integer; font:TTEXTFONT=TTEXTFONT.GLCD):smallint;

function  SpriteInit:SpriteHandle;
procedure SpriteDelete(Sprite:SpriteHandle);
procedure SpriteCreate(Sprite:SpriteHandle; w, h:smallint);
procedure SpriteFill(Sprite:SpriteHandle; color:dword);
procedure SpriteSetTextSize(Sprite:SpriteHandle; size:byte);
procedure SpriteSetTextColor(Sprite:SpriteHandle; color:word);
procedure SpriteDrawNumber(Sprite:SpriteHandle; long_num:longword; poX,poY:integer; font:TTEXTFONT=TTEXTFONT.GLCD);
function  SpriteDrawChar(Sprite:SpriteHandle; uniCode:word; x,y:integer; font:TTEXTFONT=TTEXTFONT.GLCD):smallint;
procedure SpriteDrawCharEx(Sprite:SpriteHandle; x,y:integer; c:word; color,bg:dword; size:byte);
function  SpriteDrawString(Sprite:SpriteHandle; line:pchar; x,y:integer; font:TTEXTFONT=TTEXTFONT.GLCD):smallint;
procedure SpritePushSprite(Sprite:SpriteHandle; x,y:integer);

var
  TFT:TFTHandle=THandle(-1);

implementation

function  tft_create:TFTHandle; cdecl; external name 'tft_create';
procedure tft_free(TFTSelf:TFTHandle); cdecl; external name 'tft_free';

procedure tft_init(TFTSelf:TFTHandle); cdecl; external name 'tft_init';

procedure tft_drawPixel(TFTSelf:TFTHandle; x,y: integer; color:dword); cdecl; external name 'tft_drawPixel';
procedure tft_drawLine(TFTSelf:TFTHandle; x0,y0,x1,y1: integer; color:dword); cdecl; external name 'tft_drawLine';
procedure tft_drawRect(TFTSelf:TFTHandle; x,y,w,h: integer; color:dword); cdecl; external name 'tft_drawRect';
procedure tft_fillRect(TFTSelf:TFTHandle; x,y,w,h: integer; color:dword); cdecl; external name 'tft_fillRect';
procedure tft_drawRoundRect(TFTSelf:TFTHandle; x,y,w,h,r: integer; color:dword); cdecl; external name 'tft_drawRoundRect';
procedure tft_fillRoundRect(TFTSelf:TFTHandle; x,y,w,h,r: integer; color:dword); cdecl; external name 'tft_fillRoundRect';

procedure tft_setRotation(TFTSelf:TFTHandle; r:byte); cdecl; external name 'tft_setRotation';
procedure tft_invertDisplay(TFTSelf:TFTHandle; i:boolean); cdecl; external name 'tft_invertDisplay';
procedure tft_fillScreen(TFTSelf:TFTHandle; color:word); cdecl; external name 'tft_fillScreen';

procedure tft_drawCircle(TFTSelf:TFTHandle; x0,y0,r: integer; color:dword); cdecl; external name 'tft_drawCircle';
procedure tft_fillCircle(TFTSelf:TFTHandle; x0,y0,r: integer; color:dword); cdecl; external name 'tft_fillCircle';

function  tft_color565(TFTSelf:TFTHandle; red,green,blue:byte):word; cdecl; external name 'tft_color565';
procedure tft_setTextColor(TFTSelf:TFTHandle; fgcolor,bgcolor:word); cdecl; external name 'tft_setTextColor';
procedure tft_setTextSize(TFTSelf:TFTHandle; size:byte); cdecl; external name 'tft_setTextSize';

function  tft_textWidth(TFTSelf:TFTHandle; line:pchar; font:byte):smallint; cdecl; external name 'tft_textWidth';
function  tft_fontHeight(TFTSelf:TFTHandle; font:byte):smallint; cdecl; external name 'tft_fontHeight';

procedure tft_setTextFont(TFTSelf:TFTHandle; font:byte); cdecl; external name 'tft_setTextFont';
procedure tft_setFreeFont(TFTSelf:TFTHandle; font:byte); cdecl; external name 'tft_setFreeFont';

function  tft_drawString(TFTSelf:TFTHandle; line:pchar; x,y:integer; font:byte):smallint; cdecl; external name 'tft_drawString';
function  tft_drawChar(TFTSelf:TFTHandle; uniCode:word; x,y:integer; font:byte):smallint; cdecl; external name 'tft_drawChar';
procedure tft_drawCharEx(TFTSelf:TFTHandle; x,y:integer; c:word; color,bg:dword; size:byte); cdecl; external name 'tft_drawCharEx';

function  tft_drawNumber(TFTSelf:TFTHandle;long_num:longint; poX,poY:integer; font:byte):smallint; cdecl; external name 'tft_drawNumber';
function  tft_drawFloat(TFTSelf:TFTHandle;floatNumber:valreal;decimal:byte; poX,poY:integer; font:byte):smallint; cdecl; external name 'tft_drawFloat';

function  sprite_init(TFTOwner:TFTHandle):SpriteHandle; cdecl; external name 'sprite_init';
procedure sprite_delete(Sprite:SpriteHandle); cdecl; external name 'sprite_delete';
procedure sprite_createSprite(Sprite:SpriteHandle; w, h:smallint); cdecl; external name 'sprite_createSprite';
procedure sprite_fillSprite(Sprite:SpriteHandle; color:dword); cdecl; external name 'sprite_fillSprite';
procedure sprite_setTextSize(Sprite:SpriteHandle; size:byte); cdecl; external name 'sprite_setTextSize';
procedure sprite_setTextColor(Sprite:SpriteHandle; color:word); cdecl; external name 'sprite_setTextColor';
procedure sprite_drawNumber(Sprite:SpriteHandle; long_num:longword; poX,poY:integer; font:byte); cdecl; external name 'sprite_drawNumber';
function  sprite_drawChar(Sprite:SpriteHandle; uniCode:word; x,y:integer; font:byte):smallint; cdecl; external name 'sprite_drawChar';
procedure sprite_drawCharEx(Sprite:SpriteHandle; x,y:integer; c:word; color,bg:dword; size:byte); cdecl; external name 'sprite_drawCharEx';
function  sprite_drawString(Sprite:SpriteHandle; line:pchar; x,y:integer; font:byte):smallint; cdecl; external name 'sprite_drawString';
procedure sprite_pushSprite(Sprite:SpriteHandle; x,y:integer); cdecl; external name 'sprite_pushSprite';

procedure TFTCreate;
begin
  if (TFT=THandle(-1)) then
    TFT:=tft_create;
end;

procedure TFTFree;
begin
  if (TFT<>THandle(-1)) then
    tft_free(TFT);
end;

procedure initTFT;
begin
  if (TFT<>THandle(-1)) then
    tft_init(TFT);
end;

procedure drawPixel(x,y: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
    tft_drawPixel(TFT,x,y,color);
end;

procedure drawLine(x0,y0,x1,y1: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
    tft_drawLine(TFT,x0,y0,x1,y1,color);
end;

procedure drawRect(x,y,w,h: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
    tft_drawRect(TFT,x,y,w,h,color);
end;

procedure fillRect(x,y,w,h: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
    tft_fillRect(TFT,x,y,w,h,color);
end;

procedure drawRoundRect(x,y,w,h,r: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
    tft_drawRoundRect(TFT,x,y,w,h,r,color);
end;

procedure fillRoundRect(x,y,w,h,r: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
    tft_fillRoundRect(TFT,x,y,w,h,r,color);
end;


procedure setRotation(r:byte);
begin
  if (TFT<>THandle(-1)) then
     tft_setRotation(TFT,r);
end;

procedure invertDisplay(i:boolean);
begin
  if (TFT<>THandle(-1)) then
     tft_invertDisplay(TFT,i);
end;

procedure fillScreen(color:dword);
begin
  if (TFT<>THandle(-1)) then
     tft_fillScreen(TFT,color);
end;


procedure drawCircle(x0,y0,r: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
     tft_drawCircle(TFT,x0,y0,r,color);
end;

procedure fillCircle(x0,y0,r: integer; color:dword);
begin
  if (TFT<>THandle(-1)) then
     tft_fillCircle(TFT,x0,y0,r,color);
end;

function color565(red,green,blue:byte):word;
begin
  result:=0;
  if (TFT<>THandle(-1)) then
    result:=tft_color565(TFT,red,green,blue);
end;

procedure setTextColor(color:word);
begin
  if (TFT<>THandle(-1)) then
    tft_setTextColor(TFT,color,color);
end;

procedure setTextColor(fgcolor,bgcolor:word);
begin
  if (TFT<>THandle(-1)) then
    tft_setTextColor(TFT,fgcolor,bgcolor);
end;

procedure setTextSize(size:byte);
begin
  if (TFT<>THandle(-1)) then
    tft_setTextSize(TFT,size);
end;

function textWidth(line:pchar; font:TTEXTFONT):smallint;
begin
  result:=0;
  if (TFT<>THandle(-1)) then
    result:=tft_textWidth(TFT,line,Ord(font));
end;

function fontHeight(font:TTEXTFONT):smallint;
begin
  result:=0;
  if (TFT<>THandle(-1)) then
    result:=tft_fontHeight(TFT,Ord(font));
end;

procedure setGFXFont(font:TGFXFONT);
begin
  if (TFT<>THandle(-1)) then
    tft_setFreeFont(TFT,Ord(font));
end;

procedure setTextFont(font:TTEXTFONT);
begin
  if (TFT<>THandle(-1)) then
    tft_setTextFont(TFT,Ord(font));
end;

function drawChar(uniCode:word; x,y:integer; font:TTEXTFONT):smallint;
begin
  result:=0;
  if (TFT<>THandle(-1)) then
    result:=tft_drawChar(TFT,uniCode,x,y,Ord(font));
end;

procedure drawCharEx(x,y:integer; c:word; color,bg:dword; size:byte);
begin
  if (TFT<>THandle(-1)) then
    tft_drawCharEx(TFT,x,y,c,color,bg,size);
end;

function drawString(line:pchar; x,y:integer; font:TTEXTFONT):smallint;
begin
  result:=0;
  if (TFT<>THandle(-1)) then
  result:=tft_drawString(TFT,line,x,y,Ord(font));
end;

function drawNumber(long_num:longint; poX,poY:integer; font:TTEXTFONT):smallint;
begin
  result:=0;
  if (TFT<>THandle(-1)) then
     result:=tft_drawNumber(TFT,long_num,poX,poY,Ord(font));
end;

function drawFloat(floatNumber:valreal;decimal:byte; poX,poY:integer; font:TTEXTFONT):smallint;
begin
  result:=0;
  if (TFT<>THandle(-1)) then
     result:=tft_drawFloat(TFT,floatNumber,decimal,poX,poY,Ord(font));
end;

function SpriteInit:SpriteHandle;
begin
  result:=THandle(-1);
  if (TFT<>THandle(-1)) then
    result:=sprite_init(TFT);
end;

procedure SpriteDelete(Sprite:SpriteHandle);
begin
  if (Sprite<>THandle(-1)) then
    sprite_delete(Sprite)
end;

procedure SpriteCreate(Sprite:SpriteHandle; w, h:smallint);
begin
  if (Sprite<>THandle(-1)) then
     sprite_createSprite(Sprite,w,h);
end;

procedure SpriteFill(Sprite:SpriteHandle; color:dword);
begin
  if (Sprite<>THandle(-1)) then
    sprite_fillSprite(Sprite,color);
end;

procedure SpriteSetTextSize(Sprite:SpriteHandle; size:byte);
begin
  if (Sprite<>THandle(-1)) then
    sprite_setTextSize(Sprite,size);
end;

procedure SpriteSetTextColor(Sprite:SpriteHandle; color:word);
begin
  if (Sprite<>THandle(-1)) then
    sprite_setTextColor(Sprite,color);
end;

procedure SpriteDrawNumber(Sprite:SpriteHandle; long_num:longword; poX,poY:integer; font:TTEXTFONT);
begin
  if (Sprite<>THandle(-1)) then
    sprite_drawNumber(Sprite,long_num,poX,poY,Ord(font));
end;

function SpriteDrawChar(Sprite:SpriteHandle; uniCode:word; x,y:integer; font:TTEXTFONT):smallint;
begin
  result:=0;
  if (Sprite<>THandle(-1)) then
    result:=sprite_drawChar(Sprite,uniCode,x,y,Ord(font));
end;

procedure SpriteDrawCharEx(Sprite:SpriteHandle; x,y:integer; c:word; color,bg:dword; size:byte);
begin
  if (Sprite<>THandle(-1)) then
    sprite_drawCharEx(Sprite,x,y,c,color,bg,size);
end;

function SpriteDrawString(Sprite:SpriteHandle; line:pchar; x,y:integer; font:TTEXTFONT):smallint;
begin
  result:=0;
  if (Sprite<>THandle(-1)) then
    result:=sprite_drawString(Sprite,line,x,y,Ord(font));
end;

procedure SpritePushSprite(Sprite:SpriteHandle; x,y:integer);
begin
  if (Sprite<>THandle(-1)) then
    sprite_pushSprite(Sprite,x,y);
end;



end.
