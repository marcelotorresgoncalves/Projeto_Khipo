unit uCripTexto;

interface

function Criptografa(texto:string):String;
function DesCriptografa(texto:string):String;

implementation

uses System.SysUtils;

function AsciiToInt(Caracter: Char): Integer;
var
  i: Integer;
begin
  i := 32;
  while i < 255 do begin
    if Chr(i) = Caracter then
      Break;
    i := i + 1;
  end;
  Result := i;
end;

Function Criptografa(texto:string):String;
var
  cont:integer;
  retorno:string;
  chave:integer;
begin
  chave := 128;
  if (trim(texto)=EmptyStr) or (chave=0) then begin
    result:=texto;
  end else begin
    retorno:='';
    for cont:=1 to length(texto) do begin
      retorno:=retorno+chr(asciitoint(texto[cont])+chave);
    end;
    result:=retorno;
  end;
end;

Function DesCriptografa(texto:string):String;
var
  cont:integer;
  retorno:string;
  chave:integer;
begin
  chave:= 128;
  if (trim(texto)=EmptyStr) or (chave=0) then begin
    result:=texto;
  end else begin
    retorno:='';
    for cont:=1 to length(texto) do begin
      retorno:=retorno+chr(asciitoint(texto[cont])-chave);
    end;
    result:=retorno;
  end;
end;

end.
