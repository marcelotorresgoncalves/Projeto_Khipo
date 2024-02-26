unit ufrmControleEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmControleEstoque = class(TForm)
    lbledtNome: TLabeledEdit;
    btnPesquisar: TBitBtn;
    QryPesquisar: TADOQuery;
    dsPesquisar: TDataSource;
    DBGridPesq: TDBGrid;
    lbledtQtde: TLabeledEdit;
    btnAtualizar: TBitBtn;
    btnFechar: TBitBtn;
    rdgOpcao: TRadioGroup;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure lbledtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure DBGridPesqKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function FOpcaoQtde( vQtde:String ):Integer;
    procedure PrcPesquisar( vExibirMsg : Boolean );
  public
    { Public declarations }
  end;

var
  frmControleEstoque: TfrmControleEstoque;

implementation

{$R *.dfm}

uses uProdutoController, System.UITypes;

procedure TfrmControleEstoque.btnAtualizarClick(Sender: TObject);
var
  MsgErro : String;
  objProContr : TProdutoController;
begin
  if not qryPesquisar.Active then
    exit;

  if ( StrToInt( lbledtQtde.text ) < 1 ) then
  begin
    MessageDlg('Quantidade deverá ser maior que zero.',mtInformation,[mbOk],0);
    exit;
  end;

  if MessageDlg('Confirma atualização ?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  objProContr := TProdutoController.Create;
  try
    if ( rdgOpcao.itemindex = 1 ) and not objProContr.fncTemEstoque( qryPesquisar.FieldByName('cdgproduto').AsInteger , StrToInt( lbledtQtde.text )) then
      raise Exception.Create( 'Produto sem estoque' );

    if not objProContr.fncAtualizarEstoque( qryPesquisar.FieldByName('cdgproduto').AsInteger ,FOpcaoQtde( lbledtQtde.text ), MsgErro ) then
      raise Exception.Create( MsgErro );
  finally
     objProContr.Free;
  end;
  MessageDlg('Atualização efetuada com sucesso.',mtInformation,[mbok],0);
  PrcPesquisar( False );
  lbledtQtde.Clear;
  lbledtNome.SetFocus;
end;

procedure TfrmControleEstoque.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmControleEstoque.btnPesquisarClick(Sender: TObject);
begin
  PrcPesquisar( True );
end;

procedure TfrmControleEstoque.DBGridPesqKeyPress(Sender: TObject;
  var Key: Char);
begin
   if key = #9  then //--VK_TAB
     rdgOpcao.SetFocus;
end;

function TfrmControleEstoque.FOpcaoQtde(vQtde: String): Integer;
begin
  Result := StrToInt( vQtde );

  if ( rdgOpcao.itemindex = 1 ) then
    Result := Result * -1;
end;

procedure TfrmControleEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmControleEstoque.lbledtQtdeKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not ( key in [ '0'..'9', #8 ] ) then
     key := #0;
end;

procedure TfrmControleEstoque.PrcPesquisar(vExibirMsg: Boolean);
begin
  if ( lbledtNome.Text = '' ) then
     exit;

  QryPesquisar.Close;
  QryPesquisar.Parameters[0].Value := '%'+uppercase( lbledtNome.Text ) +'%';
  QryPesquisar.Open;
  TNumericField( QryPesquisar.FieldByName('preco') ).DisplayFormat := ',0.00;-,0.00';
  if vExibirMsg and QryPesquisar.IsEmpty then
  begin
    MessageDlg('Nome não encontrado.',mtInformation,[mbok],0);
    lbledtNome.SetFocus;
  end;
end;

end.
