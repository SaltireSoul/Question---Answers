object StudentsForm: TStudentsForm
  Left = 286
  Top = 121
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Quiz'
  ClientHeight = 572
  ClientWidth = 792
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
    Left = 32
    Top = 24
    Width = 737
    Height = 105
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
    Left = 120
    Top = 424
    Width = 20
    Height = 19
    Caption = '30'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TimelefttextLbl: TLabel
    Left = 24
    Top = 424
    Width = 84
    Height = 19
    Caption = 'Time Left:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ScoretextLbl: TLabel
    Left = 176
    Top = 424
    Width = 56
    Height = 19
    Caption = 'Score :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ScoreLbl: TLabel
    Left = 240
    Top = 424
    Width = 15
    Height = 19
    Caption = ' 0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NextBtn: TButton
    Left = 704
    Top = 416
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
    Left = 32
    Top = 144
    Width = 737
    Height = 57
    Caption = 'Edinburgh'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    WordWrap = True
  end
  object Answer2RBtn: TRadioButton
    Left = 32
    Top = 216
    Width = 737
    Height = 57
    Caption = 'London'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    WordWrap = True
  end
  object Answer3RBtn: TRadioButton
    Left = 32
    Top = 288
    Width = 737
    Height = 57
    Caption = 'Dublin'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    WordWrap = True
  end
  object Answer4RBtn: TRadioButton
    Left = 32
    Top = 360
    Width = 737
    Height = 57
    Caption = 'Belfast'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    WordWrap = True
  end
  object PreviousAnswerGbox: TGroupBox
    Left = 0
    Top = 447
    Width = 792
    Height = 125
    Align = alBottom
    Caption = 'Correct Answer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    TabStop = True
    object PreviousAnswerLbl: TLabel
      Left = 24
      Top = 24
      Width = 745
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
    Left = 648
    Top = 416
  end
  object PauseTimer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = PauseTimerTimer
    Left = 616
    Top = 416
  end
end
