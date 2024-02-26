unit uProdutoController;

interface

uses
   uProdutoModel, uDmProduto, System.SysUtils;

type
  TProdutoController = class
  public
    constructor Create;
    destructor Destroy; override;
    function fncInserir( objPessoa : TProduto; var MsgErro : String ) : Boolean;
    procedure PrcBuscarProduto(objPessoa: TProduto; vCodigo: Integer);
    function fncAlterar(objPessoa: TProduto; out MsgErro: String): Boolean;
    function fncExcluir(vCodigo:Integer; out MsgErro: String): Boolean;
    function fncAtualizarEstoque( vCodigo:Integer; vQtde: Integer; out MsgErro: String):Boolean;
    function fncTemEstoque(vCodigo, vQtde: Integer): Boolean;
  end;

implementation

{ TProdutoController }

constructor TProdutoController.Create;
begin
   dmProduto := TdmProduto.Create(nil);
end;

destructor TProdutoController.Destroy;
begin
  FreeAndNil( dmProduto );
  inherited;
end;

function TProdutoController.fncAlterar(objPessoa: TProduto;
  out MsgErro: String): Boolean;
begin
   Result := dmProduto.fncAlterar(objPessoa, MsgErro);
end;

function TProdutoController.fncAtualizarEstoque(vCodigo: Integer; vQtde: Integer;
  out MsgErro: String): Boolean;
begin
  result := dmProduto.fncAtualizarEstoque(vCodigo, vQtde, MsgErro);
end;

function TProdutoController.fncExcluir(vCodigo: Integer;
  out MsgErro: String): Boolean;
begin
  Result := dmProduto.fncExcluir(vCodigo, MsgErro);
end;

function TProdutoController.fncInserir(objPessoa: TProduto;
  var MsgErro: String): Boolean;
begin
  Result := dmProduto.fncInserir(objPessoa, msgerro);
end;

function TProdutoController.fncTemEstoque(vCodigo, vQtde: Integer): Boolean;
begin
  Result := dmProduto.fncTemEstoque(vCodigo, vQtde);
end;

procedure TProdutoController.PrcBuscarProduto(objPessoa: TProduto;
  vCodigo: Integer);
begin
   dmProduto.PrcBuscarProduto(objPessoa,vCodigo);
end;

end.
