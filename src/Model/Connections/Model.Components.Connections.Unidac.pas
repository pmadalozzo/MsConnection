unit Model.Components.Connections.Unidac;

interface

uses
 Uni,
 PostgreSQLUniProvider,
 System.Classes,
 Data.DB,
 System.Generics.Collections,
 Model.Components.Connections.Interfaces;

type
  TModelComponentsConnectionUnidac = class(TInterfacedObject, iModelComponentsConnections)
   private
     FQuery : TUniQuery;
     FIndexConn : integer;
     FConnList : TObjectList<TUniConnection>;
   public
     constructor Create;
     destructor Destroy; override;
     class function New : iModelComponentsConnections;

     function AddParam(aParam : string; aValue : Variant) : iModelComponentsConnections; overload;
     function AddParam(aParam : string; aValue : TPersistent) : iModelComponentsConnections; overload;
     function Close : iModelComponentsConnections;
     function Clear : iModelComponentsConnections;
     function DataSet : TDataSet;
     function Disconnect (aIndexConn : integer) : iModelComponentsConnections;
     function Connected : integer;
     function ExecSQL : iModelComponentsConnections;
     function IndexConn : integer;
     function Open : iModelComponentsConnections;
     function SQL (aValue : string) : iModelComponentsConnections;
     function Isempty : boolean;

  end;

implementation

uses
  System.SysUtils, MsRegister;

{ TModelComponentsConnectionUnidac }

function TModelComponentsConnectionUnidac.AddParam(aParam: string; aValue: TPersistent): iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Assign(aValue);
end;

function TModelComponentsConnectionUnidac.AddParam(aParam: string; aValue: Variant): iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Value:= aValue;
end;

function TModelComponentsConnectionUnidac.Clear: iModelComponentsConnections;
begin
  result:= self;
  FQuery.Sql.Clear;
end;

function TModelComponentsConnectionUnidac.Close: iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.Close;
end;

function TModelComponentsConnectionUnidac.Connected: integer;
begin
  Result:= FIndexConn;
end;

constructor TModelComponentsConnectionUnidac.Create;
begin
  try
    if not Assigned(FConnList) then
      FConnList := TObjectList<TUniConnection>.Create;

    FConnList.Add(TUniConnection.Create(nil));
    FIndexConn := Pred(FConnList.Count);

    FConnList.Items[FIndexConn].Server      := aMsRegister.Host;
    FConnList.Items[FIndexConn].Port        := strtoint(aMsRegister.Port);
    FConnList.Items[FIndexConn].Database    := aMsRegister.Database;
    FConnList.Items[FIndexConn].Username    := aMsRegister.User;
    FConnList.Items[FIndexConn].Password    := aMsRegister.Pass;
    FConnList.Items[FIndexConn].ProviderName:= aMsRegister.Driver;
    FConnList.Items[FIndexConn].Connected;

  finally
    FQuery:= TUniQuery.Create(nil);
    FQuery.Connection:= FConnList.Items[FIndexConn];
  end;
end;

function TModelComponentsConnectionUnidac.DataSet: TDataSet;
begin
  Result:= FQuery;
end;

destructor TModelComponentsConnectionUnidac.Destroy;
begin
  FQuery.DisposeOf;
  inherited;
end;

function TModelComponentsConnectionUnidac.Disconnect(aIndexConn: integer): iModelComponentsConnections;
begin
  Result:= Self;
  FConnList.Items[aIndexConn].Connected := false;
  FConnList.Items[aIndexConn].Free;
  FConnList.TrimExcess;
end;

function TModelComponentsConnectionUnidac.ExecSQL: iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.ExecSQL;
end;

function TModelComponentsConnectionUnidac.IndexConn: integer;
begin
  Result:= FIndexConn;
end;

function TModelComponentsConnectionUnidac.Isempty: boolean;
begin
  Result:= FQuery.IsEmpty;
end;

class function TModelComponentsConnectionUnidac.New: iModelComponentsConnections;
begin
  Result:= Self.Create;
end;

function TModelComponentsConnectionUnidac.Open: iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.Open;
end;

function TModelComponentsConnectionUnidac.SQL(aValue: string): iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.SQL.Add(aValue);
end;

end.
