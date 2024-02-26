object dmProduto: TdmProduto
  Height = 480
  Width = 640
  object AdoProduto: TADOCommand
    Connection = dmConexao.ADOConexao
    Parameters = <
      item
        Value = Null
      end>
    Left = 72
    Top = 48
  end
end
