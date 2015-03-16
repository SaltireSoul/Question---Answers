object QandATransForm: TQandATransForm
  Left = 282
  Top = 233
  Width = 640
  Height = 487
  Caption = 'Questions & Answers Translator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pcTranslator: TPageControl
    Left = 0
    Top = 0
    Width = 632
    Height = 409
    ActivePage = tsQuiz
    Align = alTop
    TabOrder = 0
    object tsQuiz: TTabSheet
      Caption = 'Quiz'
      object edLang1: TEdit
        Left = 8
        Top = 8
        Width = 200
        Height = 21
        TabOrder = 0
        Text = 'You Must Select A File'
      end
      object edLang2: TEdit
        Left = 8
        Top = 32
        Width = 200
        Height = 21
        TabOrder = 1
        Text = 'File Not Found'
      end
      object edLang4: TEdit
        Left = 8
        Top = 80
        Width = 200
        Height = 21
        TabOrder = 3
        Text = 'Start'
      end
      object edLang3: TEdit
        Left = 8
        Top = 56
        Width = 200
        Height = 21
        TabOrder = 2
        Text = 'File'
      end
      object edLang8: TEdit
        Left = 8
        Top = 176
        Width = 200
        Height = 21
        TabOrder = 7
        Text = 'Use Custom Text'
      end
      object edLang7: TEdit
        Left = 8
        Top = 152
        Width = 200
        Height = 21
        TabOrder = 6
        Text = 'Register File Types'
      end
      object edLang6: TEdit
        Left = 8
        Top = 128
        Width = 200
        Height = 21
        TabOrder = 5
        Text = 'Tools'
      end
      object edLang5: TEdit
        Left = 8
        Top = 104
        Width = 200
        Height = 21
        TabOrder = 4
        Text = 'Exit'
      end
      object edLang9: TEdit
        Left = 8
        Top = 200
        Width = 200
        Height = 21
        TabOrder = 8
        Text = 'Use Custom Sounds'
      end
      object edLang10: TEdit
        Left = 8
        Top = 224
        Width = 200
        Height = 21
        TabOrder = 9
        Text = 'Help'
      end
      object edLang11: TEdit
        Left = 8
        Top = 248
        Width = 200
        Height = 21
        TabOrder = 10
        Text = 'Contents'
      end
      object edLang12: TEdit
        Left = 8
        Top = 272
        Width = 200
        Height = 21
        TabOrder = 11
        Text = 'Index'
      end
      object edLang13: TEdit
        Left = 8
        Top = 296
        Width = 200
        Height = 21
        TabOrder = 12
        Text = 'About'
      end
      object edLang14: TEdit
        Left = 8
        Top = 320
        Width = 200
        Height = 21
        TabOrder = 13
        Text = 'Select Topic'
      end
      object edLang15: TEdit
        Left = 8
        Top = 344
        Width = 200
        Height = 21
        TabOrder = 14
        Text = 'Timer'
      end
      object edLang16: TEdit
        Left = 216
        Top = 8
        Width = 200
        Height = 21
        TabOrder = 15
        Text = 'Set Time Limit'
      end
      object edLang17: TEdit
        Left = 216
        Top = 32
        Width = 200
        Height = 21
        TabOrder = 16
        Text = 'Topic Name'
      end
      object edLang18: TEdit
        Left = 216
        Top = 56
        Width = 200
        Height = 21
        TabOrder = 17
        Text = 'Time Left'
      end
      object edLang19: TEdit
        Left = 216
        Top = 80
        Width = 200
        Height = 21
        TabOrder = 18
        Text = 'Score'
      end
      object edLang20: TEdit
        Left = 216
        Top = 104
        Width = 200
        Height = 21
        TabOrder = 19
        Text = 'Correct Answer'
      end
      object edLang21: TEdit
        Left = 216
        Top = 128
        Width = 200
        Height = 21
        TabOrder = 20
        Text = 'Well Done!!'
      end
      object edLang22: TEdit
        Left = 216
        Top = 152
        Width = 200
        Height = 21
        TabOrder = 21
        Text = 'The correct answer was'
      end
      object edLang23: TEdit
        Left = 216
        Top = 176
        Width = 200
        Height = 21
        TabOrder = 22
        Text = 'Brilliant!'
      end
      object edLang24: TEdit
        Left = 216
        Top = 200
        Width = 200
        Height = 21
        TabOrder = 23
        Text = 'Good!'
      end
      object edLang25: TEdit
        Left = 216
        Top = 224
        Width = 200
        Height = 21
        TabOrder = 24
        Text = 'Fair!'
      end
      object edLang26: TEdit
        Left = 216
        Top = 248
        Width = 200
        Height = 21
        TabOrder = 25
        Text = 'Not too bad!'
      end
      object edLang27: TEdit
        Left = 216
        Top = 272
        Width = 200
        Height = 21
        TabOrder = 26
        Text = 'Read the book again'
      end
      object edLang28: TEdit
        Left = 216
        Top = 296
        Width = 200
        Height = 21
        TabOrder = 27
        Text = 'Next'
      end
      object edLang29: TEdit
        Left = 216
        Top = 320
        Width = 200
        Height = 21
        TabOrder = 28
        Text = 'Reset'
      end
      object edLang30: TEdit
        Left = 216
        Top = 344
        Width = 200
        Height = 21
        TabOrder = 29
        Text = 'New Quiz'
      end
      object edLang38: TEdit
        Left = 424
        Top = 176
        Width = 200
        Height = 21
        TabOrder = 37
        Text = 'Comments'
      end
      object edLang33: TEdit
        Left = 424
        Top = 56
        Width = 200
        Height = 21
        TabOrder = 32
        Text = 'You Got'
      end
      object edLang34: TEdit
        Left = 424
        Top = 80
        Width = 200
        Height = 21
        TabOrder = 33
        Text = 'out of'
      end
      object edLang35: TEdit
        Left = 424
        Top = 104
        Width = 200
        Height = 21
        TabOrder = 34
        Text = 'Product Name'
      end
      object edLang36: TEdit
        Left = 424
        Top = 128
        Width = 200
        Height = 21
        TabOrder = 35
        Text = 'Version'
      end
      object edLang37: TEdit
        Left = 424
        Top = 152
        Width = 200
        Height = 21
        TabOrder = 36
        Text = 'Copyright'
      end
      object edLang32: TEdit
        Left = 424
        Top = 32
        Width = 200
        Height = 21
        TabOrder = 31
        Text = 'You Scored'
      end
      object edLang31: TEdit
        Left = 424
        Top = 8
        Width = 200
        Height = 21
        TabOrder = 30
        Text = 'OK'
      end
    end
    object tsMaker: TTabSheet
      Caption = 'Maker'
      ImageIndex = 1
      object Edit1: TEdit
        Left = 8
        Top = 8
        Width = 300
        Height = 21
        TabOrder = 0
        Text = 'None of Your Possible Answer Match the Correct Answer'
      end
      object Edit2: TEdit
        Left = 8
        Top = 32
        Width = 300
        Height = 21
        TabOrder = 1
        Text = 'You can not Go back any further'
      end
      object Edit3: TEdit
        Left = 8
        Top = 56
        Width = 300
        Height = 21
        TabOrder = 2
        Text = 'Files Registered'
      end
      object Edit4: TEdit
        Left = 8
        Top = 80
        Width = 300
        Height = 21
        TabOrder = 3
        Text = 'You need to fill in all the fields before saving'
      end
      object Edit5: TEdit
        Left = 8
        Top = 104
        Width = 200
        Height = 21
        TabOrder = 4
        Text = 'File'
      end
      object Edit6: TEdit
        Left = 8
        Top = 128
        Width = 200
        Height = 21
        TabOrder = 5
        Text = 'New'
      end
      object Edit7: TEdit
        Left = 8
        Top = 152
        Width = 200
        Height = 21
        TabOrder = 6
        Text = 'Open'
      end
      object Edit8: TEdit
        Left = 8
        Top = 176
        Width = 200
        Height = 21
        TabOrder = 7
        Text = 'Save'
      end
      object Edit9: TEdit
        Left = 8
        Top = 200
        Width = 200
        Height = 21
        TabOrder = 8
        Text = 'Register File Types'
      end
      object Edit10: TEdit
        Left = 8
        Top = 224
        Width = 200
        Height = 21
        TabOrder = 9
        Text = 'Exit'
      end
      object Edit11: TEdit
        Left = 8
        Top = 248
        Width = 200
        Height = 21
        TabOrder = 10
        Text = 'Topic Name'
      end
      object Edit12: TEdit
        Left = 8
        Top = 272
        Width = 200
        Height = 21
        TabOrder = 11
        Text = 'Question Number'
      end
      object Edit13: TEdit
        Left = 8
        Top = 296
        Width = 200
        Height = 21
        TabOrder = 12
        Text = 'Question'
      end
      object Edit14: TEdit
        Left = 8
        Top = 320
        Width = 200
        Height = 21
        TabOrder = 13
        Text = 'Answer'
      end
      object Edit15: TEdit
        Left = 8
        Top = 344
        Width = 200
        Height = 21
        TabOrder = 14
        Text = 'Correct Answer'
      end
      object Edit16: TEdit
        Left = 320
        Top = 8
        Width = 200
        Height = 21
        TabOrder = 15
        Text = 'Back'
      end
      object Edit17: TEdit
        Left = 320
        Top = 32
        Width = 200
        Height = 21
        TabOrder = 16
        Text = 'Next'
      end
    end
  end
  object btnSave: TButton
    Left = 552
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object SaveTo: TSaveDialog
    DefaultExt = '.ini'
    Filter = 'Language File|*.ini'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 512
    Top = 416
  end
end
