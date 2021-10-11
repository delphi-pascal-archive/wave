unit frmOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles, frmMain;

type
  TfrmOpt = class(TForm)
    btnApply: TButton;
    btnEsc: TButton;
    btnOK: TButton;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    tbAngle: TTrackBar;
    tbZoom: TTrackBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    tbDistance: TTrackBar;
    Label8: TLabel;
    procedure btnEscClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbZoomChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOpt: TfrmOpt;

implementation

{$R *.dfm}

procedure TfrmOpt.btnOKClick(Sender: TObject);
begin
  btnApplyClick(Sender);
  Close;
end;

procedure TfrmOpt.btnEscClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOpt.btnApplyClick(Sender: TObject);
begin
  IniOpt.WriteInteger('Score', 'Angle', tbAngle.Position);
  IniOpt.WriteInteger('Score', 'Zoom', tbZoom.Position);
  IniOpt.WriteInteger('Dist', 'Distance', tbDistance.Position);
end;

procedure TfrmOpt.FormShow(Sender: TObject);
begin
  IniOpt := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Wave.ini');
  tbAngle.Position    := IniOpt.ReadInteger('Score', 'Angle', tbAngle.Position);
  tbZoom.Position     := IniOpt.ReadInteger('Score', 'Zoom', tbZoom.Position);
  tbDistance.Position := IniOpt.ReadInteger('Dist', 'Distance', tbDistance.Position);
end;

procedure TfrmOpt.tbZoomChange(Sender: TObject);
begin
  label5.Caption := IntToStr(tbAngle.Position);
  label6.Caption := IntToStr(tbZoom.Position);
  label8.Caption := IntToStr(tbDistance.Position);
end;

procedure TfrmOpt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IniOpt.Free;
end;

end.
