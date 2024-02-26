object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Login'
  ClientHeight = 188
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object lblUsuario: TLabel
    Left = 26
    Top = 13
    Width = 40
    Height = 15
    Caption = 'Usu'#225'rio'
  end
  object lblSenha: TLabel
    Left = 26
    Top = 71
    Width = 32
    Height = 15
    Caption = 'Senha'
  end
  object edtUsuario: TEdit
    Left = 26
    Top = 30
    Width = 233
    Height = 23
    BorderStyle = bsNone
    MaxLength = 100
    TabOrder = 0
    Text = 'MARCELO'
  end
  object edtSenha: TEdit
    Left = 26
    Top = 88
    Width = 233
    Height = 23
    BorderStyle = bsNone
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 1
    Text = '2024@mM'
  end
  object btnLogar: TButton
    Left = 80
    Top = 145
    Width = 75
    Height = 25
    Caption = 'Acessar'
    TabOrder = 2
    OnClick = btnLogarClick
  end
  object btnFechar: TButton
    Left = 184
    Top = 145
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnFecharClick
  end
end
