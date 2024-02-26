unit uFrmCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons,
  uProdutoController, uProdutoModel, Data.Win.ADODB, Vcl.DBCtrls;

type
  TfrmCadProduto = class(TForm)
    pgcCadastro: TPageControl;
    TabPesquisa: TTabSheet;
    TabCadastro: TTabSheet;
    lbledtPesquisar: TLabeledEdit;
    btnPesquisar: TButton;
    DBGridPesq: TDBGrid;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    lbledtCod: TLabeledEdit;
    lbledtNome: TLabeledEdit;
    lbledtPreco: TLabeledEdit;
    lbledtQtde: TLabeledEdit;
    btnGravar: TButton;
    btnVoltar: TButton;
    btnFechar_cad: TButton;
    dsPesquisar: TDataSource;
    QryPesquisar: TADOQuery;
    Label1: TLabel;
    qryCategoria: TADOQuery;
    dsCategoria: TDataSource;
    DBLCategoria: TDBLookupComboBox;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnFechar_cadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbledtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure lbledtPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure lbledtPrecoExit(Sender: TObject);
  private
    { Private declarations }
    vOpcao : String;
    MsgErro : String;
    procedure PrcHabTab( vFlag : Boolean );
    procedure PrcGravar( vOpcao : String );
    procedure PrcLimpaCampos;
    procedure PrcPesquisar( vExibirMsg : Boolean );
    function FncRegistrarProduto( vOpcao:String; vCodigo:Integer; vNome, vCategoria:String; vPreco:Double; vQtde :Integer; out MsgErro:String):Boolean;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

uses uDmProduto, system.UITypes, udmConexao;

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
var
  objPro : TProduto;
  objProContr : TProdutoController;
begin
  PrcHabTab( False );
  vOpcao := 'A';
  objPro := TProduto.Create;
  objProContr := TProdutoController.Create;
  try
    objProContr.PrcBuscarProduto(objPro, qryPesquisar.FieldByName('cdgproduto').AsInteger);
    lbledtCod.Text    := inttostr(objPro.cdgproduto);
    lbledtNome.Text   := objPro.nmeproduto;
    DBLCategoria.KeyValue := objPro.cdgcategoria;
    lbledtPreco.Text := FloatToStr( objPro.preco );
    lbledtQtde.Text := IntToStr( objPro.qtde );
  finally
     objPro.Free;
     objProContr.Free;
  end;
  lbledtNome.SetFocus;
end;

procedure TfrmCadProduto.btnExcluirClick(Sender: TObject);
var
  objProContr : TProdutoController;
begin
  if not qryPesquisar.Active then
    exit;

  if MessageDlg('Confirma a exclusão ?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  objProContr := TProdutoController.Create;
  try
    if not objProContr.fncExcluir( qryPesquisar.FieldByName('cdgproduto').AsInteger , MsgErro ) then
      raise Exception.Create( MsgErro );
  finally
     objProContr.Free;
  end;
  MessageDlg('Exclusão efetuada com sucesso.',mtInformation,[mbok],0);
  PrcPesquisar( False );
  lbledtPesquisar.SetFocus;
end;

procedure TfrmCadProduto.btnFechar_cadClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadProduto.btnGravarClick(Sender: TObject);
begin
   PrcGravar( vOpcao );
end;

procedure TfrmCadProduto.btnIncluirClick(Sender: TObject);
begin
  PrcHabTab( False );
  vOpcao := 'I';
  PrcLimpaCampos;
  lbledtNome.SetFocus;
end;

procedure TfrmCadProduto.btnPesquisarClick(Sender: TObject);
begin
  PrcPesquisar( True );
end;

procedure TfrmCadProduto.btnVoltarClick(Sender: TObject);
begin
  PrcHabTab( True );
end;

function TfrmCadProduto.FncRegistrarProduto(vOpcao:String; vCodigo:Integer; vNome,
  vCategoria: String; vPreco: Double; vQtde: Integer; out MsgErro:String): Boolean;
var
  objPro : TProduto;
  objProContr : TProdutoController;
begin
  objPro := TProduto.Create;
  objProContr := TProdutoController.Create;
  try
     objPro.cdgproduto := vCodigo;
     objPro.nmeproduto := vNome;
     objPro.cdgcategoria := vCategoria;
     objPro.preco := vPreco;
     objPro.qtde := vQtde;
     if vOpcao = 'I' then
       Result := objProContr.fncInserir( objPro, MsgErro )
     else
       Result := objProContr.fncAlterar( objPro, MsgErro);
  finally
     objPro.Free;
     objProContr.Free;
  end;
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryCategoria.Close;
  Action := caFree;
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  PrcHabTab( True );
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  qryCategoria.Open;
  lbledtPesquisar.SetFocus;
end;

procedure TfrmCadProduto.lbledtPrecoExit(Sender: TObject);
begin
   lbledtPreco.Text := FormatFloat('###,##0.00',StrToFloat(lbledtPreco.Text));
end;

procedure TfrmCadProduto.lbledtPrecoKeyPress(Sender: TObject; var Key: Char);
begin
    if not ( key in [ '0'..'9',',', #8 ] ) then
     key := #0;
end;

procedure TfrmCadProduto.lbledtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
   if not ( key in [ '0'..'9', #8 ] ) then
     key := #0;
end;

procedure TfrmCadProduto.PrcGravar(vOpcao: String);
begin
  if not FncRegistrarProduto( vOpcao, StrToInt( lbledtCod.Text ), lbledtNome.Text,
     DBLCategoria.KeyValue, strToFloat( lbledtPreco.Text ),StrToInt( lbledtQtde.Text ),
     MsgErro ) then
  begin
    MessageDlg(MsgErro,mtInformation,[mbok],0);
    exit;
  end;

  if vOpcao = 'I' then
  begin
    MessageDlg('Inclusão efetuada com sucesso.',mtInformation,[mbok],0);
    PrcLimpaCampos;
    lbledtNome.SetFocus;
  end
  else
  begin
    MessageDlg('Alteração efetuada com sucesso.',mtInformation,[mbok],0);
    PrcHabTab( True );
  end;
  PrcPesquisar( False );
end;

procedure TfrmCadProduto.PrcLimpaCampos;
begin
  lbledtCod.Text := '0';
  lbledtNome.Clear;
  DBLCategoria.KeyValue := 0;
  lbledtPreco.Clear;
  lbledtQtde.Clear;
end;

procedure TfrmCadProduto.PrcHabTab(vFlag: Boolean);
begin
  TabPesquisa.TabVisible := vFlag;
  TabCadastro.TabVisible := not vFlag;
end;

procedure TfrmCadProduto.PrcPesquisar( vExibirMsg : Boolean );
begin
  if ( lbledtPesquisar.Text = '' ) then
     exit;

  QryPesquisar.Close;
  QryPesquisar.Parameters[0].Value := '%'+uppercase( lbledtPesquisar.Text ) +'%';
  QryPesquisar.Open;
  TNumericField( QryPesquisar.FieldByName('preco') ).DisplayFormat := ',0.00;-,0.00';
  if vExibirMsg and QryPesquisar.IsEmpty then
  begin
    MessageDlg('Produto não encontrado.',mtInformation,[mbok],0);
    lbledtPesquisar.SetFocus;
  end;
end;

end.
