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
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iMsConnection;
      function Component : iModelComponentsFactory;
      function RowsetSize(aValue : integer = 50) : iMsConnection;
  end;

implementation

uses
  Model.Components.Factory;

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

class function TMsConnection.New: iMsConnection;
begin
  Result:= Self.Create;
end;

function TMsConnection.RowsetSize(aValue: integer): iMsConnection;
begin
  result:= Self;
  FRowsetSize:= aValue;
end;

end.
