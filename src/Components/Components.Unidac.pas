unit Components.Unidac;

interface

uses
  Uni,
  PostgreSQLUniProvider,
  System.Classes,
  Data.DB,
  System.Generics.Collections,
  MsConnection.Interfaces;

type
  TComponentsUnidac = class(TInterfacedObject, iComponentsConnections)
   private
     [weak]
     FParent : iMsConnection;
     FQuery : TUniQuery;
     FIndexConn : integer;
     FConnList : TObjectList<TUniConnection>;
   public
     constructor Create(Parent : iMsConnection);
     destructor Destroy; override;
     class function New(Parent : iMsConnection) : iComponentsConnections;

     function AddParam(aParam : string; aValue : Variant) : iComponentsConnections; overload;
     function AddParam(aParam : string; aValue : TPersistent) : iComponentsConnections; overload;
     function Close : iComponentsConnections;
     function Clear : iComponentsConnections;
     function DataSet : TDataSet;
     function DataSource(aDataSource : TDataSource) : iComponentsConnections;
     function Disconnect (aIndexConn : integer) : iComponentsConnections;
     function Connected : integer;
     function ExecSQL : iComponentsConnections;
     function IndexConn : integer;
     function Open : iComponentsConnections;
     function SQL (aValue : string) : iComponentsConnections;
     function Isempty : boolean;
     function &End : iMsConnection;

  end;

implementation

uses
  System.SysUtils;

{ TComponentsUnidac }

function TComponentsUnidac.&End: iMsConnection;
begin
  Result:= FParent;
end;

function TComponentsUnidac.AddParam(aParam: string; aValue: TPersistent): iComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Assign(aValue);
end;

function TComponentsUnidac.AddParam(aParam: string; aValue: Variant): iComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Value:= aValue;
end;

function TComponentsUnidac.Clear: iComponentsConnections;
begin
  result:= self;
  FQuery.Sql.Clear;
end;

function TComponentsUnidac.Close: iComponentsConnections;
begin
  Result:= Self;
  FQuery.Close;
end;

function TComponentsUnidac.Connected: integer;
begin
  Result:= FIndexConn;
end;

constructor TComponentsUnidac.Create(Parent : iMsConnection);
begin
  FParent:= Parent;
  try
    if not Assigned(FConnList) then
      FConnList := TObjectList<TUniConnection>.Create;

    FConnList.Add(TUniConnection.Create(nil));
    FIndexConn := Pred(FConnList.Count);

    FConnList.Items[FIndexConn].Server      := FParent.Credential.Host;
    FConnList.Items[FIndexConn].Port        := strtoint(FParent.Credential.Port);
    FConnList.Items[FIndexConn].Database    := FParent.Credential.Database;
    FConnList.Items[FIndexConn].Username    := FParent.Credential.User;
    FConnList.Items[FIndexConn].Password    := FParent.Credential.Pass;
    FConnList.Items[FIndexConn].ProviderName:= FParent.Credential.Driver;
    FConnList.Items[FIndexConn].Connected;

  finally
    FQuery:= TUniQuery.Create(nil);
    FQuery.Connection:= FConnList.Items[FIndexConn];
  end;
end;

function TComponentsUnidac.DataSet: TDataSet;
begin
  Result:= FQuery;
end;

function TComponentsUnidac.DataSource(
  aDataSource: TDataSource): iComponentsConnections;
begin
  result:= self;
  aDataSource.DataSet:= FQuery;
end;

destructor TComponentsUnidac.Destroy;
begin
  FQuery.DisposeOf;
  inherited;
end;

function TComponentsUnidac.Disconnect(aIndexConn: integer): iComponentsConnections;
begin
  Result:= Self;
  FConnList.Items[aIndexConn].Connected := false;
  FConnList.Items[aIndexConn].Free;
  FConnList.TrimExcess;
end;

function TComponentsUnidac.ExecSQL: iComponentsConnections;
begin
  Result:= Self;
  FQuery.ExecSQL;
end;

function TComponentsUnidac.IndexConn: integer;
begin
  Result:= FIndexConn;
end;

function TComponentsUnidac.Isempty: boolean;
begin
  Result:= FQuery.IsEmpty;
end;

class function TComponentsUnidac.New(Parent : iMsConnection) : iComponentsConnections;
begin
  Result:= Self.Create(Parent);
end;

function TComponentsUnidac.Open: iComponentsConnections;
begin
  Result:= Self;
  FQuery.Open;
end;

function TComponentsUnidac.SQL(aValue: string): iComponentsConnections;
begin
  Result:= Self;
  FQuery.SQL.Add(aValue);
end;

end.
