object frmCadProduto: TfrmCadProduto
  Left = 0
  Top = 0
  Caption = 'Cadastro Produto'
  ClientHeight = 425
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pgcCadastro: TPageControl
    Left = 0
    Top = 0
    Width = 761
    Height = 425
    ActivePage = TabPesquisa
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 757
    ExplicitHeight = 424
    object TabPesquisa: TTabSheet
      Caption = 'Pesquisa'
      object lbledtPesquisar: TLabeledEdit
        Left = 32
        Top = 24
        Width = 609
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 169
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome produto a ser pesquisado'
        MaxLength = 50
        TabOrder = 0
        Text = ''
      end
      object btnPesquisar: TButton
        Left = 662
        Top = 23
        Width = 75
        Height = 25
        Caption = '&Pesquisar'
        TabOrder = 1
        OnClick = btnPesquisarClick
      end
      object DBGridPesq: TDBGrid
        Left = 32
        Top = 64
        Width = 705
        Height = 265
        DataSource = dsPesquisar
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
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
            Width = 205
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO'
            Title.Caption = 'Pre'#231'o'
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QTDE'
            Title.Caption = 'Qtde'
            Visible = True
          end>
      end
      object btnIncluir: TButton
        Left = 376
        Top = 353
        Width = 75
        Height = 25
        Caption = '&Incluir'
        TabOrder = 3
        OnClick = btnIncluirClick
      end
      object btnAlterar: TButton
        Left = 472
        Top = 353
        Width = 75
        Height = 25
        Caption = '&Alterar'
        TabOrder = 4
        OnClick = btnAlterarClick
      end
      object btnExcluir: TButton
        Left = 566
        Top = 353
        Width = 75
        Height = 25
        Caption = '&Excluir'
        TabOrder = 5
        OnClick = btnExcluirClick
      end
      object btnFechar: TButton
        Left = 660
        Top = 353
        Width = 75
        Height = 25
        Caption = '&Fechar'
        TabOrder = 6
        OnClick = btnFechar_cadClick
      end
    end
    object TabCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 81
        Width = 51
        Height = 15
        Caption = 'Categoria'
      end
      object lbledtCod: TLabeledEdit
        Left = 16
        Top = 40
        Width = 55
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        Enabled = False
        TabOrder = 0
        Text = '0'
      end
      object lbledtNome: TLabeledEdit
        Left = 80
        Top = 40
        Width = 641
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome'
        TabOrder = 1
        Text = ''
      end
      object lbledtPreco: TLabeledEdit
        Left = 518
        Top = 98
        Width = 97
        Height = 23
        EditLabel.Width = 30
        EditLabel.Height = 15
        EditLabel.Caption = 'Pre'#231'o'
        MaxLength = 10
        TabOrder = 3
        Text = ''
        OnExit = lbledtPrecoExit
        OnKeyPress = lbledtPrecoKeyPress
      end
      object lbledtQtde: TLabeledEdit
        Left = 660
        Top = 98
        Width = 60
        Height = 23
        EditLabel.Width = 62
        EditLabel.Height = 15
        EditLabel.Caption = 'Quantidade'
        MaxLength = 4
        TabOrder = 4
        Text = ''
        OnKeyPress = lbledtQtdeKeyPress
      end
      object btnGravar: TButton
        Left = 457
        Top = 328
        Width = 75
        Height = 25
        Caption = '&Gravar'
        TabOrder = 5
        OnClick = btnGravarClick
      end
      object btnVoltar: TButton
        Left = 551
        Top = 328
        Width = 75
        Height = 25
        Caption = '&Pesquisar'
        TabOrder = 6
        OnClick = btnVoltarClick
      end
      object btnFechar_cad: TButton
        Left = 646
        Top = 328
        Width = 75
        Height = 25
        Caption = '&Fechar'
        TabOrder = 7
        OnClick = btnFechar_cadClick
      end
      object DBLCategoria: TDBLookupComboBox
        Left = 16
        Top = 98
        Width = 465
        Height = 23
        KeyField = 'cdgcategoria'
        ListField = 'nmecategoria'
        ListSource = dsCategoria
        TabOrder = 2
      end
    end
  end
  object dsPesquisar: TDataSource
    DataSet = QryPesquisar
    Left = 76
    Top = 178
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
  object qryCategoria: TADOQuery
    Connection = dmConexao.ADOConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select cdgcategoria,nmecategoria'
      'from categoria'
      'order by nmecategoria')
    Left = 196
    Top = 178
  end
  object dsCategoria: TDataSource
    DataSet = qryCategoria
    Left = 252
    Top = 178
  end
end
