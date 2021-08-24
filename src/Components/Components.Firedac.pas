unit Components.Firedac;

interface

uses
  System.JSON,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Stan.Param,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.PG,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  System.Classes,
  MsLoading,
  MsConnection.Interfaces;

type
  TComponentsFiredac = class(TInterfacedObject, iComponentsConnections)
    private
      [weak]
      FParent : iMsConnection;
      FQuery : TFDQuery;
      FIndexConn : integer;
      FConnList : TObjectList<TFDConnection>;
      FDriver: TFDPhysPgDriverLink;

      FMessageLoading : string;
      FUseLoading : boolean;
    public
      constructor Create(Parent : iMsConnection);
      destructor Destroy; override;
      class function New (Parent : iMsConnection): iComponentsConnections;
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
      function LoadingMessage(aValue : string) : iComponentsConnections;
      function UseOpenLoading(aValue : boolean) : iComponentsConnections;
      function Open : iComponentsConnections;
      function SQL (aValue : string) : iComponentsConnections;
      function Isempty : boolean;
      function &End : iMsConnection;
  end;

implementation

uses
  System.AnsiStrings,
  System.SysUtils;

{ TComponentsFiredac }

function TComponentsFiredac.&End: iMsConnection;
begin
  Result:= FParent;
end;

function TComponentsFiredac.AddParam(aParam: string;
  aValue: TPersistent): iComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Assign(aValue);
end;

function TComponentsFiredac.AddParam(aParam: string;
  aValue: Variant): iComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Value:= aValue;
end;

function TComponentsFiredac.Clear: iComponentsConnections;
begin
  Result:= Self;
  FQuery.SQL.Clear;
end;

function TComponentsFiredac.Close: iComponentsConnections;
begin
  Result:= Self;
  FQuery.Close;
end;

function TComponentsFiredac.Connected: integer;
begin
  Result:= FIndexConn;
end;

constructor TComponentsFiredac.Create(Parent : iMsConnection);
begin
  FParent:= Parent;
  try
    FDriver:= TFDPhysPgDriverLink.create(nil);
    FDriver.VendorHome:= GetCurrentDir;
    fDriver.VendorLib:= FParent.Credential.Dll;

    if not Assigned(FConnList) then
      FConnList := TObjectList<TFDConnection>.Create;

    FConnList.Add(TFDConnection.Create(nil));
    FIndexConn := Pred(FConnList.Count);

    FConnList.Items[FIndexConn].Params.Add('Server='+FParent.Credential.Host+'');
    FConnList.Items[FIndexConn].Params.add('Port='+FParent.Credential.Port+'');
    FConnList.Items[FIndexConn].Params.Database:= FParent.Credential.Database;
    FConnList.Items[FIndexConn].Params.Username:= FParent.Credential.User;
    FConnList.Items[FIndexConn].Params.Password:= FParent.Credential.Pass;
    FConnList.Items[FIndexConn].Params.DriverID:= FParent.Credential.Driver;
    FConnList.Items[FIndexConn].Params.Add('LockingMode=Normal');
    if FParent.Credential.RowsetSize > 0 then
      FConnList.Items[FIndexConn].FetchOptions.RowsetSize:= FParent.Credential.RowsetSize;
    FConnList.Items[FIndexConn].Connected;

  finally
    FQuery:= TFDQuery.Create(nil);
    FQuery.Connection:= FConnList.Items[FIndexConn];
  end;
end;

function TComponentsFiredac.DataSet: TDataSet;
begin
  Result:= FQuery;
end;

function TComponentsFiredac.DataSource(
  aDataSource: TDataSource): iComponentsConnections;
begin
  result:= Self;
  aDataSource.DataSet:= FQuery;
end;

destructor TComponentsFiredac.Destroy;
begin
  FQuery.DisposeOf;
  FDriver.DisposeOf;
  inherited;
end;

function TComponentsFiredac.Disconnect(aIndexConn : integer) : iComponentsConnections;
begin
  Result:= Self;
  FConnList.Items[aIndexConn].Connected := false;
  FConnList.Items[aIndexConn].Free;
  FConnList.TrimExcess;
end;

function TComponentsFiredac.ExecSQL: iComponentsConnections;
begin
  Result:= Self;
  FQuery.ExecSQL;
end;

function TComponentsFiredac.IndexConn: integer;
begin
  Result:= FIndexConn;
end;

function TComponentsFiredac.Isempty: boolean;
begin
  result:= FQuery.IsEmpty;
end;

function TComponentsFiredac.LoadingMessage(
  aValue: string): iComponentsConnections;
begin
  Result:= Self;
  FMessageLoading:= aValue;
end;

class function TComponentsFiredac.New(Parent : iMsConnection): iComponentsConnections;
begin
  Result:= Self.Create(Parent);
end;

function TComponentsFiredac.Open: iComponentsConnections;
begin
  Result:= Self;
  if FUseLoading then
   begin
     if FMessageLoading <> '' then
       FQuery.OpenLoading(FMessageLoading)
     else
       FQuery.OpenLoading;
   end else
    FQuery.Open;
end;

function TComponentsFiredac.SQL(aValue: string): iComponentsConnections;
begin
  Result:= Self;
  FQuery.sql.Add(aValue);
end;

function TComponentsFiredac.UseOpenLoading(
  aValue: boolean): iComponentsConnections;
begin
  Result:= Self;
  FUseLoading:= aValue;
end;

end.
