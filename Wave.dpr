program Wave;

uses
  Forms, Windows, mmSystem, Messages, Graphics,
  frmMain in 'frmMain.pas' {frmGL},
  frmOptions in 'frmOptions.pas' {frmOpt};

{$R *.RES}
{$R WindowsXP.RES}
{$E scr}
{$D SCRNSAVE MyScreenSaver}

var
  PrevWnd : HWND;
  Rect    : TRect;
  Canvas  : TCanvas;

function MyWndProc(Wnd: HWND; Msg: Integer;
                   wParam, lParam: Longint): Integer; stdcall;
begin
  case Msg of  
    WM_DESTROY :
    begin
      PostQuitMessage(0);
      result := 0;
    end;
    WM_PAINT :
    begin

      DC := GetDC(PrevWnd);
      SetDCPixelFormat;
      hrc := wglCreateContext(DC);
      wglMakeCurrent(DC, hrc);

      ReadParams;

      {PaintScrSaver(PrevWnd);}
      Result := DefWindowProc(Wnd, Msg, wParam, lParam);
    end;
  else
    Result := DefWindowProc(Wnd, Msg, wParam, lParam);
  end;
end;

(*Предпросмотр в окне "Свойства: Экран"*)
procedure Preview;
const
  ClassName = 'WaveScreenSaverClass'#0;   
var
  parent   : hWnd;
  WndClass : TWndClass;
  msg      : TMsg;
  code     : Integer;
begin
  val(ParamStr(2), parent, code);
  if (code <> 0) or (parent <= 0) then Exit;   
    
  with WndClass do begin  
    style := CS_PARENTDC;   
    lpfnWndProc := addr(MyWndProc);
    cbClsExtra := 0;   
    cbWndExtra := 0;
    hIcon := 0;   
    hCursor := 0;   
    hbrBackground := 0;   
    lpszMenuName := nil;   
    lpszClassName := ClassName;   
  end;
  
  WndClass.hInstance := hInstance;
  Windows.RegisterClass(WndClass);

  GetWindowRect(Parent, rect);
  PrevWnd := CreateWindow(ClassName,
                          'Wave',
                          WS_CHILDWINDOW or WS_VISIBLE,
                          0,
                          0,
                          rect.Right - rect.Left,
                          rect.Bottom - rect.Top,
                          Parent,
                          0,
                          hInstance,
                          nil);
  Canvas := TCanvas.Create;
  Canvas.Handle := GetDC(PrevWnd);

  ReadParams;

  repeat
    if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    begin
      if Msg.Message = WM_QUIT then break;
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end else
    begin
      (* активация таймера *)
      angle := angle + ScoreAngle;
      zoom := zoom - ScoreZoom;

      InvalidateRect(PrevWnd, nil, False);
      (* отрисовка *)
      PaintScrSaver(PrevWnd);
    end;
  until false;
  ReleaseDC(PrevWnd, Canvas.Handle);
  Canvas.Destroy;
end;

var
  S : String;
begin
  Application.Initialize;
  S := ParamStr(1);
  if (Pos('p', S)>0) or (Pos('P', S)>0) then Preview else
  if (Pos('s', S)>0) or (Pos('S', S)>0) then
  begin
    Application.CreateForm(TfrmGL, frmGL);
  end
  else
  if (Pos('c', S)>0) or (Pos('C', S)>0) then
  Application.CreateForm(TfrmOpt, frmOpt);
  Application.Run;
end.

