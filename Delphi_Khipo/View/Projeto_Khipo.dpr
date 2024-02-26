program Projeto_Khipo;

uses
  Vcl.Forms,
  Vcl.Dialogs,
  system.UITypes,
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  udmConexao in '..\Dao\udmConexao.pas' {dmConexao: TDataModule},
  uFrmLogin in 'uFrmLogin.pas' {frmLogin},
  uFrmCadProduto in 'uFrmCadProduto.pas' {frmCadProduto},
  uDmProduto in '..\Dao\uDmProduto.pas' {dmProduto: TDataModule},
  uProdutoModel in '..\Model\uProdutoModel.pas',
  uProdutoController in '..\Controller\uProdutoController.pas' {,
  ufrmControleEstoque in 'ufrmControleEstoque.pas' {frmControleEstoque},
  ufrmControleEstoque in 'ufrmControleEstoque.pas' {frmControleEstoque},
  uCripTexto in '..\Controller\uCripTexto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  if dmconexao.Conexao.fncConectar then
  begin
    FrmLogin := TFrmLogin.Create(nil);
    Frmlogin.ShowModal;

    Frmlogin.Hide;
    Frmlogin.Free;

    Application.createForm( TFrmPrincipal, FrmPrincipal );

    Application.Run;
  end
  else
  begin
    MessageDlg('Falha ao conectar base de dados.',mtInformation,[mbok],0);
    Application.Terminate;
  end;
end.
