object frmControleEstoque: TfrmControleEstoque
  Left = 0
  Top = 0
  Caption = 'Controle Estoque'
  ClientHeight = 336
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  TextHeight = 15
  object lbledtNome: TLabeledEdit
    Left = 11
    Top = 21
    Width = 558
    Height = 23
    CharCase = ecUpperCase
    EditLabel.Width = 123
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome a ser pesquisado'
    TabOrder = 0
    Text = ''
  end
  object btnPesquisar: TBitBtn
    Left = 600
    Top = 20
    Width = 75
    Height = 25
    Caption = '&Pesquisar'
    TabOrder = 1
    OnClick = btnPesquisarClick
  end
  object DBGridPesq: TDBGrid
    Left = 8
    Top = 71
    Width = 668
    Height = 196
    DataSource = dsPesquisar
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyPress = DBGridPesqKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'CDGPRODUTO'
        Title.Caption = 'C'#243'digo'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NMEPRODUTO'
        Title.Caption = 'Nome'
        Width = 253
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NMECATEGORIA'
        Title.Caption = 'Categoria'
        Width = 172
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRECO'
        Title.Caption = 'Pre'#231'o'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDE'
        Title.Caption = 'Qtde'
        Visible = True
      end>
  end
  object lbledtQtde: TLabeledEdit
    Left = 329
    Top = 289
    Width = 49
    Height = 23
    EditLabel.Width = 26
    EditLabel.Height = 23
    EditLabel.Caption = 'Qtde'
    LabelPosition = lpLeft
    MaxLength = 5
    TabOrder = 4
    Text = ''
    OnKeyPress = lbledtQtdeKeyPress
  end
  object btnAtualizar: TBitBtn
    Left = 504
    Top = 287
    Width = 75
    Height = 25
    Caption = '&Atualizar'
    TabOrder = 5
    OnClick = btnAtualizarClick
  end
  object btnFechar: TBitBtn
    Left = 600
    Top = 288
    Width = 75
    Height = 25
    Caption = '&Fechar'
    TabOrder = 6
    OnClick = btnFecharClick
  end
  object rdgOpcao: TRadioGroup
    Left = 8
    Top = 273
    Width = 193
    Height = 39
    Caption = 'Op'#231#227'o'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Entrada'
      'Sa'#237'da')
    TabOrder = 3
  end
  object QryPesquisar: TADOQuery
    Connection = dmConexao.ADOConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'nome'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end>
    SQL.Strings = (
      'select PRO.CDGPRODUTO, PRO.NMEPRODUTO, PRO.PRECO, PRO.QTDE, '
      '   CAT.NMECATEGORIA'
      
        'from PRODUTO PRO LEFT JOIN CATEGORIA CAT ON pro.cdgcategoria = c' +
        'at.cdgcategoria '
      'where upper( PRO.nmeproduto ) like :nome')
    Left = 20
    Top = 178
  end
  object dsPesquisar: TDataSource
    DataSet = QryPesquisar
    Left = 76
    Top = 178
  end
end
