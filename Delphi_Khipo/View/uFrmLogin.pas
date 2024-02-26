unit uFrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmLogin = class(TForm)
    lblUsuario: TLabel;
    lblSenha: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnLogar: TButton;
    btnFechar: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnLogarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses udmConexao, uFrmPrincipal, System.UITypes;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TfrmLogin.btnLogarClick(Sender: TObject);
begin
   if not dmconexao.FVerificaUsuario( edtUsuario.text , edtSenha.Text ) then
   begin
     MessageDlg('Usuário ou senha incorretos.',mtInformation,[mbok],0);
     exit;
   end;

   Close;
end;

end.
