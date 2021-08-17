unit Model.Components.Connections.Firedac;

interface

uses
  IniFiles,
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
  Model.Components.Connections.Interfaces;

type
  TModelComponentsConnectionsFiredac = class(TInterfacedObject, iModelComponentsConnections)
    private
      FQuery : TFDQuery;
      FIndexConn : integer;
      FConnList : TObjectList<TFDConnection>;
      FDriver: TFDPhysPgDriverLink;
    public
      constructor Create(aRowsetSize : integer = 50);
      destructor Destroy; override;
      class function New (aRowsetSize : integer = 50): iModelComponentsConnections;
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
  System.AnsiStrings, System.SysUtils, MsRegister;

{ TModelComponentsConnectionsFiredac }

function TModelComponentsConnectionsFiredac.AddParam(aParam: string;
  aValue: TPersistent): iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Assign(aValue);
end;

function TModelComponentsConnectionsFiredac.AddParam(aParam: string;
  aValue: Variant): iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.ParamByName(aParam).Value:= aValue;
end;

function TModelComponentsConnectionsFiredac.Clear: iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.SQL.Clear;
end;

function TModelComponentsConnectionsFiredac.Close: iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.Close;
end;

function TModelComponentsConnectionsFiredac.Connected: integer;
begin
  Result:= FIndexConn;
end;

constructor TModelComponentsConnectionsFiredac.Create(aRowsetSize : integer = 50);
begin

  try
    FDriver:= TFDPhysPgDriverLink.create(nil);
    FDriver.VendorHome:= GetCurrentDir;
    fDriver.VendorLib:= aMsRegister.Dll;

    if not Assigned(FConnList) then
      FConnList := TObjectList<TFDConnection>.Create;

    FConnList.Add(TFDConnection.Create(nil));
    FIndexConn := Pred(FConnList.Count);

    FConnList.Items[FIndexConn].Params.Add('Server='+aMsRegister.Host+'');
    FConnList.Items[FIndexConn].Params.add('Port='+aMsRegister.Port+'');
    FConnList.Items[FIndexConn].Params.Database:= aMsRegister.Database;
    FConnList.Items[FIndexConn].Params.Username:= aMsRegister.User;
    FConnList.Items[FIndexConn].Params.Password:= aMsRegister.Pass;
    FConnList.Items[FIndexConn].Params.DriverID:= aMsRegister.Driver;
    FConnList.Items[FIndexConn].Params.Add('LockingMode=Normal');
    if aRowsetSize > 0 then
      FConnList.Items[FIndexConn].FetchOptions.RowsetSize:= aRowsetSize;
    FConnList.Items[FIndexConn].Connected;

  finally
    FQuery:= TFDQuery.Create(nil);
    FQuery.Connection:= FConnList.Items[FIndexConn];
  end;
end;

function TModelComponentsConnectionsFiredac.DataSet: TDataSet;
begin
  Result:= FQuery;
end;

destructor TModelComponentsConnectionsFiredac.Destroy;
begin
  FQuery.DisposeOf;
  FDriver.DisposeOf;
  inherited;
end;

function TModelComponentsConnectionsFiredac.Disconnect(aIndexConn : integer) : iModelComponentsConnections;
begin
  Result:= Self;
  FConnList.Items[aIndexConn].Connected := false;
  FConnList.Items[aIndexConn].Free;
  FConnList.TrimExcess;
end;

function TModelComponentsConnectionsFiredac.ExecSQL: iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.ExecSQL;
end;

function TModelComponentsConnectionsFiredac.IndexConn: integer;
begin
  Result:= FIndexConn;
end;

function TModelComponentsConnectionsFiredac.Isempty: boolean;
begin
  result:= FQuery.IsEmpty;
end;

class function TModelComponentsConnectionsFiredac.New(aRowsetSize : integer = 50): iModelComponentsConnections;
begin
  Result:= Self.Create(aRowsetSize);
end;

function TModelComponentsConnectionsFiredac.Open: iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.OpenLoading;
end;

function TModelComponentsConnectionsFiredac.SQL(aValue: string): iModelComponentsConnections;
begin
  Result:= Self;
  FQuery.sql.Add(aValue);
end;

end.
