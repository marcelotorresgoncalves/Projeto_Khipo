unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Data.Win.ADODB;

type
  TfrmPrincipal = class(TForm)
    mmePrincipal: TMainMenu;
    CadastroProduto1: TMenuItem;
    Fechar1: TMenuItem;
    Estoque1: TMenuItem;
    procedure Fechar1Click(Sender: TObject);
    procedure CadastroProduto1Click(Sender: TObject);
    procedure Estoque(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uFrmCadProduto, ufrmControleEstoque;

procedure TfrmPrincipal.CadastroProduto1Click(Sender: TObject);
begin
  Application.createForm( TfrmCadProduto, frmCadProduto );
  frmCadProduto.Show;
end;

procedure TfrmPrincipal.Estoque(Sender: TObject);
begin
  Application.createForm( TfrmControleEstoque, frmControleEstoque );
  frmControleEstoque.Show;
end;

procedure TfrmPrincipal.Fechar1Click(Sender: TObject);
begin
   Application.Terminate;
end;

end.
