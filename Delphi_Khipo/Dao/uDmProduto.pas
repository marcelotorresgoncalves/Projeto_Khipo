unit uDmProduto;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DBClient, Datasnap.Provider,
  Data.DB, Data.Win.ADODB, uProdutoModel;

type
  TdmProduto = class(TDataModule)
    AdoProduto: TADOCommand;
  private
    { Private declarations }
  public
    { Public declarations }
    function fncInserir(objProduto: TProduto; out MsgErro: String): Boolean;
    procedure PrcBuscarProduto( objProduto: TProduto; vCodigo : Integer);
    function fncAlterar(objProduto: TProduto; out MsgErro: String): Boolean;
    function fncExcluir(vcodigo:Integer; out MsgErro: String): Boolean;
    function fncAtualizarEstoque(vCodigo: Integer; vQtde: Integer; out MsgErro: String): Boolean;
    function fncTemEstoque(vCodigo: Integer; vQtde: Integer):Boolean;
  end;

var
  dmProduto: TdmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses udmConexao;

{$R *.dfm}

{ TdmProduto }

function TdmProduto.fncAlterar(objProduto: TProduto; out MsgErro: String): Boolean;
begin
  AdoProduto.CommandText := 'UPDATE PRODUTO SET' +
                            '   NMEPRODUTO = :NMEPRODUTO' +
                            ' , CDGCATEGORIA = :CDGCATEGORIA'+
                            ' , PRECO = :PRECO '+
                            ' ,	QTDE = :QTDE' +
                            ' WHERE CDGPRODUTO = :CGDPRODUTO';
  AdoProduto.Parameters[0].Value := objProduto.nmeproduto;
  AdoProduto.Parameters[1].Value := objProduto.cdgcategoria;
  AdoProduto.Parameters[2].Value := objProduto.preco;
  AdoProduto.Parameters[3].Value := objProduto.qtde;
  AdoProduto.Parameters[4].Value := objProduto.cdgproduto;

  Result := False;
  try
     dmconexao.ADOConexao.BeginTrans;
     AdoProduto.Execute;
     dmconexao.ADOConexao.CommitTrans;
     Result := True;
  except on e : Exception do
    begin
      dmconexao.ADOConexao.RollbackTrans;
      MsgErro := 'Falha ao alterar produto. Motivo:'+e.Message;
    end;
  end;
end;

function TdmProduto.fncAtualizarEstoque(vCodigo: Integer; vQtde: Integer;
  out MsgErro: String): Boolean;
begin
{  AdoProduto.CommandText := 'UPDATE PRODUTO SET QTDE = QTDE + :QTDE' +
                            ' WHERE CDGPRODUTO = :CGDPRODUTO';
  AdoProduto.Parameters[0].DataType := ftFloat;
  AdoProduto.Parameters[1].DataType := ftString;

  AdoProduto.Parameters[0].Value := vCodigo;
  AdoProduto.Parameters[1].Value := vQtde;
 }
  AdoProduto.CommandText := 'UPDATE PRODUTO SET QTDE = QTDE + ' + IntToStr( vQtde ) +
                            ' WHERE CDGPRODUTO = ' + IntToStr( vCodigo );
  Result := False;
  try
     dmconexao.ADOConexao.BeginTrans;
     AdoProduto.Execute;
     dmconexao.ADOConexao.CommitTrans;
     Result := True;
  except on e : Exception do
    begin
      dmconexao.ADOConexao.RollbackTrans;
      MsgErro := 'Falha ao atualizar produto. Motivo:'+e.Message;
    end;
  end;
end;

function TdmProduto.fncExcluir(vCodigo: Integer; out MsgErro: String): Boolean;
begin
  AdoProduto.CommandText := 'DELETE FROM PRODUTO WHERE CDGPRODUTO = :CDGPRODUTO';
  AdoProduto.Parameters[0].Value := vCodigo;
  Result := False;
  try
     dmconexao.ADOConexao.BeginTrans;
     AdoProduto.Execute;
     dmconexao.ADOConexao.CommitTrans;
     Result := True;
  except on e : Exception do
    begin
      dmconexao.ADOConexao.RollbackTrans;
      MsgErro := 'Falha ao excluir produto. Motivo:'+e.Message;
    end;
  end;
end;

function TdmProduto.fncInserir(objProduto: TProduto; out MsgErro: String): Boolean;
begin
   AdoProduto.CommandText := 'INSERT INTO PRODUTO ( NMEPRODUTO, CDGCATEGORIA, PRECO, QTDE ) '+
              ' VALUES ( :NMEPRODUTO, :CDGCATEGORIA, :PRECO, :QTDE )';

  AdoProduto.Parameters[0].Value := objProduto.nmeproduto;
  AdoProduto.Parameters[1].Value := objProduto.cdgcategoria;
  AdoProduto.Parameters[2].Value := objProduto.preco;
  AdoProduto.Parameters[3].Value := objProduto.qtde;

  Result := False;
  try
     dmconexao.ADOConexao.BeginTrans;
     AdoProduto.Execute;
     dmconexao.ADOConexao.CommitTrans;
     Result := True;
  except on e : Exception do
    begin
      dmconexao.ADOConexao.RollbackTrans;
      MsgErro := 'Falha ao incluir produto. Motivo:'+e.Message;
    end;
  end;
end;

function TdmProduto.fncTemEstoque(vCodigo, vQtde: Integer): Boolean;
var Qry : TADOQuery;
begin
   Qry := TADOQuery.Create(nil);
   qry.Connection := dmconexao.ADOConexao;
   try
     qry.SQL.Text := 'select CDGPRODUTO'+
                     ' from PRODUTO '+
                     ' where CDGPRODUTO = ' + IntToStr( vCodigo ) +
                     '   and ( QTDE - '+IntToStr( vQtde ) + ' ) >= 0';
     qry.Open;
     Result := not qry.IsEmpty;
   finally
     qry.Free;
   end;
end;

procedure TdmProduto.PrcBuscarProduto(objProduto: TProduto; vCodigo: Integer);
var Qry : TADOQuery;
begin
   Qry := TADOQuery.Create(nil);
   qry.Connection := dmconexao.ADOConexao;
   try
     qry.SQL.Text := 'select CDGPRODUTO, NMEPRODUTO, CDGCATEGORIA,'+
                     '	PRECO, QTDE'+
                     ' from PRODUTO '+
                     ' where CDGPRODUTO = ' + IntToStr( vCodigo );
     qry.Open;
     objProduto.cdgproduto := qry.FieldByName('CDGPRODUTO').AsInteger;
     objProduto.nmeproduto := qry.FieldByName('NMEPRODUTO').AsString;
     objProduto.cdgcategoria := qry.FieldByName('CDGCATEGORIA').AsString;
     objProduto.preco := qry.FieldByName('PRECO').AsFloat;
     objProduto.qtde  := qry.FieldByName('QTDE').AsInteger;
   finally
     qry.Free;
   end;
end;

end.
