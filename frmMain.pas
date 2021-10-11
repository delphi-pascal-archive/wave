unit frmMain;
interface

uses
  Windows, Messages, Classes, Graphics, Forms, ExtCtrls, Controls, OpenGL,
  mmSystem, IniFiles, SysUtils;

type
  TfrmGL = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    
  public
    procedure DeactivateScrSaver(var Msg : TMsg; var Handled : Boolean);
  protected
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
  end;

var
  frmGL       : TfrmGL;
  crs         : TPoint;
  DC          : HDC;
  hrc         : HGLRC;
  uTimerId    : uint;

  IniOpt      : TIniFile;

  angle, zoom : GLFloat;
  ScoreAngle  : Real;
  ScoreZoom   : Real;
  Distance    : Integer;

  procedure PaintScrSaver(Handle: HWND);
  procedure SetDCPixelFormat;
  procedure FNTimeCallBack(uTimerID, uMessage: UINT;
                           dwUser, dw1, dw2: DWORD) stdcall;
  procedure ReadParams;

implementation

{$R *.DFM}

(*Отрисовка картинки*)
procedure PaintScrSaver(Handle: HWND);
var
  ps : TPaintStruct;
  r, t, x, y, z, x1, y1 : GLFloat;
begin
  BeginPaint(Handle, ps);

  glClear (GL_DEPTH_BUFFER_BIT or GL_COLOR_BUFFER_BIT);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(45,1.33333,0.1,1000.0);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  glPushMatrix;
  glTranslatef(0,0,-13);
  glRotatef(45,1,0,0);
  glRotatef(45,0,1,0);
  glRotatef(zoom,0,1,0);
  glBegin(GL_LINES);
  r := 0.1;
  While r <= 5.0 do
  begin
    r := r + 0.01;
    t := 0;
    While t < 360 do
    begin
      t := t + 1 + Distance;//**
      glRotatef(angle, 1, 1, 1);
      x := cos(t * PI / 180.0) * r;
      y := sin(t * PI / 180.0) * r;
      z := sin(1/r*(angle/30.00));      glColor4f(1.00, 0, 0, x/1.00);
      x1 := cos((t+1) * PI / 180.0) * r;
      y1 := sin((t+1) * PI / 180.0) * r;
      glVertex3f(x,y,z);
      glVertex3f(x1,y1,z);
    end;
  end;
  glEnd;
  glPopMatrix;  SwapBuffers(DC);
  EndPaint(Handle, ps);
end;

procedure TfrmGL.WMPaint(var Msg: TWMPaint);
begin
  PaintScrSaver(Handle);
end;

(*Обработка таймера*)
procedure FNTimeCallBack(uTimerID, uMessage: UINT;
                         dwUser, dw1, dw2: DWORD) stdcall;
begin
  With frmGL do
  begin
    angle := angle + ScoreAngle;
    zoom := zoom - ScoreZoom;
    InvalidateRect(Handle, nil, False);
  end;
end;

(*Чтение опций*)
procedure ReadParams;
begin
  try
    IniOpt := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Wave.ini');
    ScoreAngle := IniOpt.ReadFloat('Score', 'Angle', ScoreAngle)*0.1;
    ScoreZoom  := IniOpt.ReadFloat('Score', 'Zoom', ScoreZoom)*0.01;
    Distance   := IniOpt.ReadInteger('Dist', 'Distance', Distance);
  finally
    IniOpt.Free;
  end;
end;
(*Создание окна*)
procedure TfrmGL.FormCreate(Sender: TObject);
begin
  DC := GetDC(Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  angle := 0.0;
  zoom := 0.0;
  Distance := 2;

  ReadParams;

  uTimerID := timeSetEvent(2, 0, @FNTimeCallBack, 0, TIME_PERIODIC);
  (*позиция курсора*)
  GetCursorPos(crs); 
  Application.OnMessage := DeactivateScrSaver;
  (*скрыть курсор мыши*)
  ShowCursor(False);
end;

(*Формат пикселей*)
procedure SetDCPixelFormat;
var
  nPixelFormat : Integer;
  pfd : TPixelFormatDescriptor;

begin
  FillChar(pfd, SizeOf(pfd), 0);

  with pfd do
  begin
    nSize      := sizeof(pfd);
    nVersion   := 1;
    dwFlags    := PFD_DRAW_TO_WINDOW or
                 PFD_SUPPORT_OPENGL or
                 PFD_DOUBLEBUFFER;
    iPixelType := PFD_TYPE_RGBA;
    cColorBits := 24;
    cDepthBits := 16;
    iLayerType := PFD_MAIN_PLANE;
  end;

  nPixelFormat := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);

  DescribePixelFormat(DC, nPixelFormat, sizeof(TPixelFormatDescriptor), pfd);
end;

procedure TfrmGL.FormResize(Sender: TObject);
begin
  InvalidateRect(Handle, nil, False);
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

(*Обработка мыши/клавиатуры*)
procedure TfrmGL.DeactivateScrSaver(var Msg: TMsg; var Handled: Boolean);
var
  Done : Boolean;
begin    
  if Msg.message = WM_MOUSEMOVE then
  Done := (Abs(LOWORD(Msg.lParam) - crs.x) > 5) or
          (Abs(HIWORD(Msg.lParam) - crs.y) > 5)    
  else 
  Done := (Msg.message = WM_KEYDOWN)     or (Msg.message = WM_KEYUP)       or
          (Msg.message = WM_SYSKEYDOWN)  or (Msg.message = WM_SYSKEYUP)    or
          (Msg.message = WM_ACTIVATE)    or (Msg.message = WM_NCACTIVATE)  or
          (Msg.message = WM_ACTIVATEAPP) or (Msg.message = WM_LBUTTONDOWN) or
          (Msg.message = WM_RBUTTONDOWN) or (Msg.message = WM_MBUTTONDOWN);
  if Done then Close;
end;

(*Конец работы программы*)
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
  timeKillEvent(uTimerID);
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);

  Application.OnMessage := nil;
  ShowCursor(True);
end;

end.

