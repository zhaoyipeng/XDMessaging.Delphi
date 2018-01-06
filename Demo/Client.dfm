object MessagingDemoForm: TMessagingDemoForm
  Left = 0
  Top = 0
  Caption = 'Delphi Messaging Demo'
  ClientHeight = 405
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 256
    Width = 330
    Height = 149
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object edtInput: TEdit
      Left = 8
      Top = 8
      Width = 233
      Height = 21
      TabOrder = 0
      OnKeyPress = edtInputKeyPress
    end
    object btnSend: TButton
      Left = 247
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 1
      OnClick = btnSendClick
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 37
      Width = 314
      Height = 105
      Caption = 'Channels'
      TabOrder = 2
      object chkChannel1: TCheckBox
        Left = 16
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Channel1'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chkChannel1Click
      end
      object chkChannel2: TCheckBox
        Left = 16
        Top = 47
        Width = 97
        Height = 17
        Caption = 'Channel2'
        TabOrder = 1
        OnClick = chkChannel2Click
      end
      object chkStatus: TCheckBox
        Left = 16
        Top = 70
        Width = 97
        Height = 17
        Caption = 'Status'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object displayTextBox: TRichEdit
    Left = 0
    Top = 0
    Width = 330
    Height = 256
    Align = alClient
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
end
