unit MsConnection;

interface

uses
  MsConnection.Interfaces,
  Model.Components.Interfaces;

type
  TMsConnection = class(TInterfacedObject, iMsConnection)
    private
      FComponent : iModelComponentsFactory;
      FRowsetSize : integer;
      FHost : string;
      FPort : string;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMsConnection;
      function Component : iModelComponentsFactory;
      function RowsetSize(aValue : integer = 50) : iMsConnection;
      function Host(aValue : string) : iMsConnection;
      function Port(aValue : string) : iMsConnection;
      function This : iRegister;
  end;

implementation

uses
  Model.Components.Factory, MsRegister;

{ TMsConnection }

function TMsConnection.Component: iModelComponentsFactory;
begin
  if not Assigned(FComponent) then
    FComponent:= TModelComponentsConnectionFactory.New.RowsetSize(FRowsetSize);

  Result:= FComponent;
end;

constructor TMsConnection.Create;
begin

end;

destructor TMsConnection.Destroy;
begin

  inherited;
end;

function TMsConnection.Host(aValue: string): iMsConnection;
begin
  Result:= Self;
  Fhost:= aValue;
end;

class function TMsConnection.New: iMsConnection;
begin
  Result:= Self.Create;
end;

function TMsConnection.Port(aValue: string): iMsConnection;
begin
  Result:= Self;
  FPort:= aValue;
end;

function TMsConnection.RowsetSize(aValue: integer): iMsConnection;
begin
  result:= Self;
  FRowsetSize:= aValue;
end;

function TMsConnection.This : iRegister;
begin
  Result:= TMsRegister.Create(Self);
end;

end.
