object Form1: TForm1
  Left = 945
  Top = 400
  Width = 923
  Height = 541
  Caption = #1052#1077#1090#1086#1076' '#1087#1088#1086#1075#1086#1085#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 144
    Top = 264
    Width = 75
    Height = 25
    Caption = #1054#1073#1095#1080#1089#1083#1080#1090#1080
    TabOrder = 0
    OnClick = btn1Click
  end
  object strngrd1: TStringGrid
    Left = 24
    Top = 296
    Width = 825
    Height = 129
    FixedColor = clYellow
    RowCount = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object txt1: TStaticText
    Left = 56
    Top = 48
    Width = 47
    Height = 27
    Caption = 'y'#39#39' +'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object txt2: TStaticText
    Left = 160
    Top = 48
    Width = 48
    Height = 27
    Caption = 'y'#39' + '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object txt3: TStaticText
    Left = 272
    Top = 48
    Width = 43
    Height = 27
    Caption = 'y = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object edt1: TEdit
    Left = 104
    Top = 48
    Width = 49
    Height = 29
    Hint = 'p(x)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Text = '0'
  end
  object edt2: TEdit
    Left = 200
    Top = 48
    Width = 65
    Height = 33
    Hint = 'q(x)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = '-1'
  end
  object edt3: TEdit
    Left = 320
    Top = 48
    Width = 57
    Height = 33
    Hint = 'f(x)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    Text = 'x'
  end
  object edt4: TEdit
    Left = 80
    Top = 160
    Width = 41
    Height = 21
    Hint = 'Alpha(0)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    Text = '1'
  end
  object txt4: TStaticText
    Left = 128
    Top = 160
    Width = 72
    Height = 27
    Caption = 'y(a) + '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object edt5: TEdit
    Left = 192
    Top = 160
    Width = 41
    Height = 21
    Hint = 'Alpha(1)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    Text = '0'
  end
  object txt5: TStaticText
    Left = 240
    Top = 160
    Width = 83
    Height = 27
    Caption = 'y'#39'(a) =  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
  object edt6: TEdit
    Left = 320
    Top = 160
    Width = 41
    Height = 21
    Hint = 'A'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    Text = '0'
  end
  object edt7: TEdit
    Left = 80
    Top = 208
    Width = 41
    Height = 21
    Hint = 'Beta(0)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    Text = '1'
  end
  object txt6: TStaticText
    Left = 128
    Top = 208
    Width = 73
    Height = 27
    Caption = 'y(b) + '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
  end
  object edt8: TEdit
    Left = 192
    Top = 208
    Width = 41
    Height = 21
    Hint = 'Beta(1)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    Text = '0'
  end
  object txt7: TStaticText
    Left = 240
    Top = 208
    Width = 84
    Height = 27
    Caption = 'y'#39'(b) =  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
  end
  object edt9: TEdit
    Left = 320
    Top = 208
    Width = 41
    Height = 21
    Hint = 'B'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    Text = '0'
  end
  object txt8: TStaticText
    Left = 72
    Top = 96
    Width = 16
    Height = 37
    Caption = '['
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 18
  end
  object txt9: TStaticText
    Left = 200
    Top = 96
    Width = 16
    Height = 37
    Caption = ']'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
  end
  object edt10: TEdit
    Left = 88
    Top = 104
    Width = 41
    Height = 21
    Hint = 'a'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    Text = '0'
  end
  object edt11: TEdit
    Left = 152
    Top = 104
    Width = 41
    Height = 21
    Hint = 'b'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
    Text = '1'
  end
  object txt10: TStaticText
    Left = 136
    Top = 104
    Width = 10
    Height = 27
    Caption = ','
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 22
  end
  object txt11: TStaticText
    Left = 240
    Top = 104
    Width = 41
    Height = 27
    Caption = 'N= '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 23
  end
  object edt12: TEdit
    Left = 288
    Top = 104
    Width = 41
    Height = 21
    Hint = 'N'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 24
    Text = '10'
  end
end
