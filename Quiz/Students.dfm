object StudentsForm: TStudentsForm
  Left = 264
  Top = 171
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Quiz'
  ClientHeight = 453
  ClientWidth = 633
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
  object TextLbl: TLabel
    Left = 104
    Top = 24
    Width = 441
    Height = 73
    AutoSize = False
    Caption = 'What'#39's The Captial Of Scotland?'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object CountDownLbl: TLabel
    Left = 176
    Top = 288
    Width = 16
    Height = 14
    Caption = '30'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TimelefttextLbl: TLabel
    Left = 104
    Top = 288
    Width = 61
    Height = 14
    Caption = 'Time Left:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ScoretextLbl: TLabel
    Left = 232
    Top = 288
    Width = 42
    Height = 14
    Caption = 'Score :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ScoreLbl: TLabel
    Left = 280
    Top = 288
    Width = 12
    Height = 14
    Caption = ' 0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NextBtn: TButton
    Left = 472
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Next'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = NextQuestionBtn
  end
  object Answer1RBtn: TRadioButton
    Left = 104
    Top = 112
    Width = 441
    Height = 17
    Caption = 'Edinburgh'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Answer2RBtn: TRadioButton
    Left = 104
    Top = 152
    Width = 441
    Height = 17
    Caption = 'London'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Answer3RBtn: TRadioButton
    Left = 104
    Top = 192
    Width = 441
    Height = 17
    Caption = 'Dublin'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object Answer4RBtn: TRadioButton
    Left = 104
    Top = 232
    Width = 441
    Height = 17
    Caption = 'Belfast'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object PreviousAnswerGbox: TGroupBox
    Left = 0
    Top = 328
    Width = 633
    Height = 125
    Align = alBottom
    Caption = 'Correct Answer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    TabStop = True
    object PreviousAnswerLbl: TLabel
      Left = 24
      Top = 24
      Width = 593
      Height = 89
      Alignment = taCenter
      AutoSize = False
      Caption = 'Well Done!!'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object Counter: TTimer
    Enabled = False
    OnTimer = CounterTimer
    Left = 40
    Top = 24
  end
  object PauseTimer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = PauseTimerTimer
    Left = 40
    Top = 64
  end
end
