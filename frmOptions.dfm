object frmOpt: TfrmOpt
  Left = 3
  Top = 113
  BorderStyle = bsDialog
  Caption = 'Wave'
  ClientHeight = 334
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 378
    Height = 57
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = #1042#1086#1083#1085#1086#1074#1099#1077' '#1082#1086#1083#1077#1073#1072#1085#1080#1103'. '#13#10#1055#1088#1080#1084#1077#1088' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1089#1082#1088#1080#1085#1089#1077#1081#1074#1077#1088#1072' '#1085#1072' Delphi 7.'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 10
    Top = 307
    Width = 94
    Height = 13
    Caption = 'Created by Alexei91'
  end
  object btnApply: TButton
    Left = 293
    Top = 301
    Width = 75
    Height = 24
    Caption = #1055#1088#1080'&'#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = btnApplyClick
  end
  object btnEsc: TButton
    Left = 213
    Top = 301
    Width = 75
    Height = 24
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnEscClick
  end
  object btnOK: TButton
    Left = 133
    Top = 301
    Width = 75
    Height = 24
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 71
    Width = 361
    Height = 218
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 3
    object Label3: TLabel
      Left = 16
      Top = 80
      Width = 105
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1074#1088#1072#1097#1077#1085#1080#1103':'
    end
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 108
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1082#1086#1083#1077#1073#1072#1085#1080#1081':'
    end
    object Label5: TLabel
      Left = 318
      Top = 41
      Width = 28
      Height = 13
      Caption = #1053#1080#1078#1077
    end
    object Label6: TLabel
      Left = 318
      Top = 95
      Width = 29
      Height = 13
      Caption = #1042#1099#1096#1077
    end
    object Label7: TLabel
      Left = 16
      Top = 128
      Width = 146
      Height = 13
      Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1083#1080#1085#1080#1103#1084#1080':'
    end
    object Label8: TLabel
      Left = 318
      Top = 143
      Width = 29
      Height = 13
      Caption = #1042#1099#1096#1077
    end
    object tbAngle: TTrackBar
      Left = 4
      Top = 40
      Width = 310
      Height = 35
      Ctl3D = True
      Min = 1
      ParentCtl3D = False
      Position = 1
      TabOrder = 0
      TickStyle = tsManual
      OnChange = tbZoomChange
    end
    object tbZoom: TTrackBar
      Left = 4
      Top = 94
      Width = 310
      Height = 35
      Ctl3D = True
      Min = 1
      ParentCtl3D = False
      Position = 1
      TabOrder = 1
      TickStyle = tsManual
      OnChange = tbZoomChange
    end
    object tbDistance: TTrackBar
      Left = 4
      Top = 142
      Width = 310
      Height = 35
      Ctl3D = True
      Max = 100
      Min = 2
      ParentCtl3D = False
      Position = 2
      TabOrder = 2
      TickStyle = tsManual
      OnChange = tbZoomChange
    end
  end
end
