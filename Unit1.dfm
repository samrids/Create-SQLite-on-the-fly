object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 500
  ClientWidth = 925
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 217
    Height = 25
    Caption = 'Create database'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 909
    Height = 434
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 703
    Top = 8
    Width = 104
    Height = 25
    Caption = 'Set password'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 813
    Top = 8
    Width = 104
    Height = 25
    Caption = 'Remove password'
    TabOrder = 3
    OnClick = Button3Click
  end
  object DataSource1: TDataSource
    Left = 304
    Top = 264
  end
  object FDConnection1: TFDConnection
    Left = 456
    Top = 256
  end
end
