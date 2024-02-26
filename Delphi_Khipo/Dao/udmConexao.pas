unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TConexao = class
    private
      FConexao: TADOConnection;
    public
      constructor Create ( NomeConexao : TADOConnection );
      destructor Destroy ; override;
      function fncConectar : Boolean;

      property Conexao : TADOConnection read FConexao write FConexao;
  end;

  TdmConexao = class(TDataModule)
    ADOConexao: TADOConnection;
    ADOLogin: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function FLerConfigBD : String;
  public
    { Public declarations }
    Conexao : TConexao;

    function FVerificaUsuario( vUsuario , vSenha : String ) : Boolean;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uCripTexto;

{$R *.dfm}

{ TdmConexao }

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  ADOConexao.ConnectionString := FLerConfigBD;
  Conexao := TConexao.Create ( ADOConexao );
end;

procedure TdmConexao.DataModuleDestroy(Sender: TObject);
begin
  Conexao.Destroy;
end;

function TdmConexao.FLerConfigBD: String;
var tf : TextFile; sArq, slinha:String;
begin
  sArq := ExtractFilePath( ParamStr(0) ) + 'ConfigBD.txt';
  if fileexists( sArq ) then
  begin
    AssignFile( tf, sArq );
    Reset( tf );
    readln( tf, slinha );
    Result := slinha;
    CloseFile( tf );
  end;
end;

function TdmConexao.FVerificaUsuario(vUsuario, vSenha: String): Boolean;
begin
   Result := False;
   ADOLogin.Close;
   ADOlogin.Parameters[0].Value := vUsuario;
   ADOlogin.Parameters[1].Value := ucriptexto.Criptografa( vSenha);
   ADOlogin.Open;
   if not ADOlogin.IsEmpty then
      Result := True;
end;

{ TConexao }

constructor TConexao.Create(NomeConexao: TADOConnection);
begin
  FConexao := NomeConexao;
end;

destructor TConexao.Destroy;
begin
  FConexao.Connected := False;
  inherited;
end;

function TConexao.fncConectar: Boolean;
begin
  Result := False;
  try
    FConexao.Connected := True;
    Result := True;
  except on e : Exception do
    raise Exception.Create('Falha ao conectar base de dados' + e.Message);
  end;
end;

end.
