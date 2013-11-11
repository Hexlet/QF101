object Form1: TForm1
  Left = 552
  Top = 146
  Width = 455
  Height = 411
  Caption = 'Сборка агрегированного стакана'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LogListBox: TListBox
    Left = 4
    Top = 324
    Width = 360
    Height = 56
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ItemHeight = 11
    ParentFont = False
    TabOrder = 0
  end
  object ConnectButton: TButton
    Left = 368
    Top = 4
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Соединиться'
    TabOrder = 1
    OnClick = ConnectButtonClick
  end
  object DisconnectButton: TButton
    Left = 368
    Top = 32
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Разорвать'
    TabOrder = 2
    OnClick = DisconnectButtonClick
  end
  object InstrumentComboBox: TComboBox
    Left = 4
    Top = 4
    Width = 360
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
    OnChange = InstrumentComboBoxChange
  end
  object OrderBookGrid: TStringGrid
    Tag = -1
    Left = 4
    Top = 28
    Width = 360
    Height = 293
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 3
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 4
  end
end
