object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Projeto Khipo'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mmePrincipal
  Position = poMainFormCenter
  WindowState = wsMaximized
  TextHeight = 15
  object mmePrincipal: TMainMenu
    Left = 80
    Top = 80
    object CadastroProduto1: TMenuItem
      Caption = 'Cadastro Produto'
      OnClick = CadastroProduto1Click
    end
    object Estoque1: TMenuItem
      Caption = 'Estoque'
      OnClick = Estoque
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
end
