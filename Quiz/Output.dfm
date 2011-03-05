object OutputForm: TOutputForm
  Left = 390
  Top = 226
  Width = 370
  Height = 277
  BorderIcons = [biSystemMenu]
  Caption = 'Quiz'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object YouScoredtextLbl: TLabel
    Left = 40
    Top = 32
    Width = 128
    Height = 29
    Caption = 'You Scored:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object OutOftextLbl: TLabel
    Left = 232
    Top = 32
    Width = 63
    Height = 29
    Caption = 'out of'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ScoreLbl: TLabel
    Left = 200
    Top = 32
    Width = 26
    Height = 29
    Caption = '10'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object NoOfQuestionsLbl: TLabel
    Left = 304
    Top = 32
    Width = 26
    Height = 29
    Caption = '10'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PercentageLbl: TLabel
    Left = 200
    Top = 80
    Width = 62
    Height = 29
    Caption = '100%'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object MessageLbl: TLabel
    Left = 40
    Top = 132
    Width = 297
    Height = 30
    Alignment = taCenter
    AutoSize = False
    Caption = 'Read The Book Again!'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object YouGottextLbl: TLabel
    Left = 40
    Top = 80
    Width = 93
    Height = 29
    Caption = 'You Got:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ResetBtn: TButton
    Left = 40
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Reset'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ResetButtonPress
  end
  object ExitBtn: TButton
    Left = 264
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Exit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ExitButtonPress
  end
  object NewBtn: TButton
    Left = 152
    Top = 184
    Width = 75
    Height = 25
    Caption = 'New Quiz'
    TabOrder = 2
    OnClick = NewBtnClick
  end
end
