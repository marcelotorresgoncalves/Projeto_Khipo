unit uProdutoModel;

interface

type
   TProduto = class
     private
       Fcdgproduto: Integer;
       Fnmeproduto: String;
       Fcategoria: String;
       Fpreco: double;
       Fqtde: Integer;
     public
       property cdgproduto    : Integer read Fcdgproduto write Fcdgproduto;
       property nmeproduto    : String read Fnmeproduto write Fnmeproduto;
       property cdgcategoria  : String read Fcategoria write Fcategoria;
       property preco         : Double read Fpreco write Fpreco;
       property qtde          : Integer read Fqtde write Fqtde;
   end;

implementation

end.

