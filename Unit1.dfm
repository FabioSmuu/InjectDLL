object Form1: TForm1
  Left = 845
  Top = 348
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'InjectDLL'
  ClientHeight = 183
  ClientWidth = 180
  Color = clWindow
  Ctl3D = False
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Modern No. 20'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 105
    Height = 22
    TabOrder = 0
    Text = 'exemplo.exe'
    OnClick = Edit1Click
  end
  object Button1: TButton
    Left = 111
    Top = 7
    Width = 65
    Height = 22
    Caption = 'Injetar'
    Enabled = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 111
    Top = 83
    Width = 65
    Height = 22
    Caption = 'Add'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 111
    Top = 111
    Width = 65
    Height = 22
    Caption = 'Remover'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 111
    Top = 139
    Width = 65
    Height = 21
    Caption = 'Limpar'
    TabOrder = 4
    OnClick = Button4Click
  end
  object ListBox1: TListBox
    Left = 0
    Top = 21
    Width = 105
    Height = 84
    ItemHeight = 13
    TabOrder = 5
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 164
    Width = 180
    Height = 19
    Panels = <
      item
        Text = 'Criado por Smuu'
        Width = 125
      end
      item
        Text = '0 DLLs'
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 111
    Width = 105
    Height = 49
    Caption = 'Apos Injetar DLL'
    TabOrder = 7
    object RadioButton2: TRadioButton
      Left = 7
      Top = 28
      Width = 91
      Height = 14
      Caption = 'Manter Aberto'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton1: TRadioButton
      Left = 7
      Top = 14
      Width = 91
      Height = 15
      Caption = 'Fechar Injetor'
      TabOrder = 1
      OnClick = RadioButton1Click
    end
  end
  object ListBox2: TListBox
    Left = 0
    Top = 0
    Width = 180
    Height = 164
    Align = alClient
    ItemHeight = 13
    TabOrder = 8
    OnDblClick = ListBox2DblClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 88
    Top = 72
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 48
  end
end
